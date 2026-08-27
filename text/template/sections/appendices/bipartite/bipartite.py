"""
Generate a bipartite vessel correspondence SVG.

Left column  = one method (e.g. pipeline/default)
Centre       = ground truth vessels
Right column = another method (e.g. threshold/best_dice)

Nodes are sized by vessel volume (or length, or fixed).
Cubic Bézier curves connect predictions to their GT vessels.
Unmatched nodes are pushed outward and rendered at low opacity.

Requires: svgwrite, pandas
    pip install svgwrite pandas
"""


"""
    
python template/sections/appendices/bipartite/bipartite.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv \
  template/sections/appendices/bipartite/bipartite_ca_ll_l1.svg \
  --left-method pipeline --left-variant default --left-label "Pipeline" \
  --right-method threshold --right-variant best_dice --right-label "Threshold" \
  --node-size volume \
  --col-gap 190 \
  --line-opacity 0.35
  
  
python template/sections/appendices/bipartite/bipartite.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv \
  template/sections/appendices/bipartite/bipartite_ca-ll-r.svg \
  --left-method pipeline --left-variant default --left-label "Pipeline" \
  --right-method threshold --right-variant best_dice --right-label "Threshold" \
  --node-size volume \
  --col-gap 190 \
  --line-opacity 0.35
  
  
python template/sections/appendices/bipartite/bipartite.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv \
  template/sections/appendices/bipartite/bipartite_ca-ru-r_666.svg \
  --left-method pipeline --left-variant default --left-label "Pipeline" \
  --right-method threshold --right-variant best_dice --right-label "Threshold" \
  --node-size volume \
  --col-gap 190 \
  --line-opacity 0.35
  
  
python template/sections/appendices/bipartite/bipartite.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv \
  template/sections/appendices/bipartite/bipartite_ca-ru-r_222.svg \
  --left-method pipeline --left-variant default --left-label "Pipeline" \
  --right-method threshold --right-variant best_dice --right-label "Threshold" \
  --node-size volume \
  --col-gap 190 \
  --line-opacity 0.35
  
  
  
  
python template/sections/appendices/bipartite/bipartite.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv \
  template/sections/appendices/bipartite/bipartite_ca_nm_l_1.svg \
  --left-method pipeline --left-variant default --left-label "Pipeline" \
  --right-method threshold --right-variant best_dice --right-label "Threshold" \
  --node-size volume \
  --col-gap 190 \
  --line-opacity 0.35
  
python template/sections/appendices/bipartite/bipartite.py \
  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv \
  template/sections/appendices/bipartite/bipartite_ca_nm_l_2.svg \
  --left-method pipeline --left-variant default --left-label "Pipeline" \
  --right-method threshold --right-variant best_dice --right-label "Threshold" \
  --node-size volume \
  --col-gap 190 \
  --line-opacity 0.35
  
"""

# Rolled using claude because NetworkX was challenging
# Very relevant: https://en.wikipedia.org/wiki/Graph_drawing#Layout_methods

import argparse, math
import pandas as pd
import svgwrite

PALETTE = {
    "gt":           "#2a9d8f",
    "gt_unmatched": "#b0b0b0",
    "left":         "#457b9d",
    "right":        "#e63946",
    "bg":           "#ffffff",
    "label":        "#444444",
}

# ── helpers ───────────────────────────────────────────────────────────────────

def parse_ids(s):
    if not s or (isinstance(s, float) and math.isnan(s)):
        return []
    return [int(x.strip()) for x in str(s).split(";") if x.strip()]

def size_to_radius(val, vmin, vmax, r_min=4, r_max=20):
    if vmax == vmin:
        return (r_min + r_max) / 2
    t = (val - vmin) / (vmax - vmin)
    return r_min + t * (r_max - r_min)

def place_no_overlap(rows_iter, cx, top_margin, col_height,
                     radius_fn, x_offset=0):
    """Pack nodes top-to-bottom with a 2-px gap, starting at top_margin."""
    nodes, prev_bottom = [], top_margin
    n = sum(1 for _ in rows_iter)
    rows_iter_2 = list(rows_iter)          # consume twice

    for i, row in enumerate(rows_iter_2):
        r       = radius_fn(row)
        y_ideal = (top_margin + col_height * i / max(n - 1, 1)
                   if n > 1 else top_margin + col_height / 2)
        y       = max(y_ideal, prev_bottom + r + 2)
        nodes.append(dict(row=row, x=cx + x_offset, y=y, r=r))
        prev_bottom = y + r
    return nodes

def order_by_gt_proximity(pred_rows, gt_y_map):
    """
    Sort predicted vessels so those matching the topmost GT come first,
    minimising total Bézier line length.  Unmatched rows keep their
    original order at the end.
    """
    matched   = [r for _, r in pred_rows.iterrows()
                 if int(r["n_corresponding"]) > 0]
    unmatched = [r for _, r in pred_rows.iterrows()
                 if int(r["n_corresponding"]) == 0]

    # For each matched prediction, find the mean y of its GT targets
    def mean_gt_y(row):
        ids = parse_ids(row["corresponding_ids"])
        ys  = [gt_y_map[gid] for gid in ids if gid in gt_y_map]
        return sum(ys) / len(ys) if ys else 0.0

    matched.sort(key=mean_gt_y)
    return matched, unmatched

def wrap_into_columns(nodes, top_margin, col_height, col_width,
                      base_cx, direction, gap=8):
    """
    If nodes overflow col_height, wrap excess into an extra column
    placed to the left (direction=-1) or right (direction=+1).
    Returns a list of (x, y, node) tuples.
    """
    placed, col_idx, prev_bottom = [], 0, top_margin
    for node in nodes:
        r = node["r"]
        y = max(prev_bottom + r + gap, top_margin + r)

        if y + r > top_margin + col_height and prev_bottom > top_margin:
            col_idx   += 1
            prev_bottom = top_margin
            y           = top_margin + r

        x = base_cx + direction * col_idx * (col_width + 10)
        node = dict(node, x=x, y=y)
        placed.append(node)
        prev_bottom = y + r
    return placed

# ── render ────────────────────────────────────────────────────────────────────

def render(
    csv_path:       str,
    output_svg:     str,
    left_method:    str   = "pipeline",
    left_variant:   str   = "default",
    left_label:     str   = "Pipeline",
    right_method:   str   = "threshold",
    right_variant:  str   = "best_dice",
    right_label:    str   = "Threshold",
    gt_method:      str   = "ground_truth",
    gt_variant:     str   = "",
    node_size:      str   = "volume",
    node_r_min:     float = 4,
    node_r_max:     float = 20,
    svg_width:      int   = 760,
    col_height:     int   = 480,
    col_gap:        int   = 200,
    line_opacity:   float = 0.35,
    top_margin:     int   = 54,
    bottom_margin:  int   = 400,
    gt_max_nodes:   int   = 60,
):
    df = pd.read_csv(csv_path, dtype={"corresponding_ids": str, "variant": str})
    df["variant"]          = df["variant"].fillna("")
    df["corresponding_ids"] = df["corresponding_ids"].fillna("")

    def filt(meth, vari):
        return df[(df["method"] == meth) & (df["variant"] == vari)].copy()

    gt    = filt(gt_method,    gt_variant)
    left  = filt(left_method,  left_variant)
    right = filt(right_method, right_variant)

    def sz(row):
        if node_size == "volume": return float(row["volume_voxels"])
        if node_size == "length": return float(row["length_mm"])
        return 1.0

    all_vals = [sz(r) for _, r in pd.concat([gt, left, right]).iterrows()]
    vmin, vmax = min(all_vals), max(all_vals)

    def radius(row):
        return size_to_radius(sz(row), vmin, vmax, node_r_min, node_r_max)

    cx_gt    = svg_width // 2
    cx_left  = cx_gt - col_gap
    cx_right = cx_gt + col_gap
    total_h  = top_margin + col_height + bottom_margin

    # ── GT nodes: matched (sorted large→small = largest at bottom) then unmatched ──
    matched_by_left  = set(id for _, r in left.iterrows()
                           for id in parse_ids(r["corresponding_ids"]))
    matched_by_right = set(id for _, r in right.iterrows()
                           for id in parse_ids(r["corresponding_ids"]))
    any_matched_gt   = matched_by_left | matched_by_right

    gt_matched   = gt[gt["vessel_id"].isin(any_matched_gt)].copy()
    gt_unmatched = gt[~gt["vessel_id"].isin(any_matched_gt)].copy()

    # Sort matched: largest at bottom → sort ascending so index 0 = smallest → topmost
    gt_matched["_sz"] = gt_matched.apply(sz, axis=1)
    gt_matched = gt_matched.sort_values("_sz", ascending=False)   # top=small, bottom=large


    if gt_max_nodes > 0:
        # Keep the top-N GT vessels by size.
        # Matched vessels are prioritised over unmatched so we don't waste
        # slots on GT vessels that neither method finds anyway.
        gt_matched["_sz"]   = gt_matched.apply(sz, axis=1)
        gt_unmatched["_sz"] = gt_unmatched.apply(sz, axis=1)

        n_matched_keep   = min(len(gt_matched),   gt_max_nodes)
        n_unmatched_keep = min(len(gt_unmatched), gt_max_nodes - n_matched_keep)

        gt_matched   = gt_matched.nlargest(n_matched_keep,   "_sz")
        gt_unmatched = gt_unmatched.nlargest(n_unmatched_keep, "_sz") \
                       if n_unmatched_keep > 0 else gt_unmatched.iloc[:0]

        # Restrict the prediction nodes to only those that connect to
        # a GT vessel we're actually drawing — avoids dangling lines.
        kept_gt_ids = (
            set(gt_matched["vessel_id"].astype(int)) |
            set(gt_unmatched["vessel_id"].astype(int))
        )

        def drop_out_of_scope(pred_df):
            """Zero out corresponding_ids that point to dropped GT vessels."""
            def _filter_ids(s):
                ids = parse_ids(s)
                kept = [i for i in ids if i in kept_gt_ids]
                return ";".join(str(i) for i in kept)
            pred_df = pred_df.copy()
            pred_df["corresponding_ids"] = pred_df["corresponding_ids"].apply(_filter_ids)
            pred_df["n_corresponding"]   = pred_df["corresponding_ids"].apply(
                lambda s: len(parse_ids(s)))
            return pred_df

        left  = drop_out_of_scope(left)
        right = drop_out_of_scope(right)

        # Recompute matched sets after filtering
        matched_by_left  = set(id for _, r in left.iterrows()
                               for id in parse_ids(r["corresponding_ids"]))
        matched_by_right = set(id for _, r in right.iterrows()
                               for id in parse_ids(r["corresponding_ids"]))
        any_matched_gt   = matched_by_left | matched_by_right


    def make_gt_nodes():
        nodes, prev_bottom = [], top_margin
        all_rows = list(gt_matched.iterrows()) + list(gt_unmatched.iterrows())
        n = len(all_rows)
        for i, (_, row) in enumerate(all_rows):
            r       = radius(row)
            y_ideal = (top_margin + col_height * i / max(n - 1, 1)
                       if n > 1 else top_margin + col_height / 2)
            y       = max(y_ideal, prev_bottom + r + 2)
            matched = int(row["vessel_id"]) in any_matched_gt
            nodes.append(dict(
                id=int(row["vessel_id"]), row=row,
                x=cx_gt, y=y, r=r, matched=matched,
            ))
            prev_bottom = y + r
        return nodes

    gt_nodes = make_gt_nodes()
    gt_y_map = {n["id"]: n["y"] for n in gt_nodes}

    # ── Prediction nodes: ordered by GT proximity, then unmatched below ──
    def make_pred_nodes(pred_df, cx, unmatched_direction):
        matched_rows, unmatched_rows = order_by_gt_proximity(pred_df, gt_y_map)

        # Place matched with no-overlap
        matched_placed, prev_bottom = [], top_margin
        for row in matched_rows:
            r       = radius(row)
            # Aim for the mean GT y of this prediction's targets
            ids     = parse_ids(row["corresponding_ids"])
            gt_ys   = [gt_y_map[i] for i in ids if i in gt_y_map]
            y_ideal = sum(gt_ys) / len(gt_ys) if gt_ys else top_margin + col_height / 2
            y       = max(y_ideal, prev_bottom + r + 2)
            matched_placed.append(dict(row=row, x=cx, y=y, r=r, matched=True))
            prev_bottom = y + r

        # Place unmatched below matched in same column, wrapping into extra col if needed
        unmatched_raw = []
        u_prev = prev_bottom
        for row in unmatched_rows:
            r  = radius(row)
            y  = u_prev + r + 2
            unmatched_raw.append(dict(row=row, x=cx, y=y, r=r, matched=False))
            u_prev = y + r

        # Wrap overflow into extra columns
        col_w = node_r_max * 2 + 4
        unmatched_placed = wrap_into_columns(
            unmatched_raw, top_margin, top_margin + col_height,
            col_w, cx + unmatched_direction*col_w, unmatched_direction)

        return matched_placed + unmatched_placed

    left_nodes  = make_pred_nodes(left,  cx_left,  unmatched_direction=-1)
    right_nodes = make_pred_nodes(right, cx_right, unmatched_direction=+1)

    # ── Draw ──────────────────────────────────────────────────────────────────
    dwg = svgwrite.Drawing(output_svg, size=(svg_width, total_h), profile="full")
    dwg.add(dwg.rect((0, 0), (svg_width, total_h), fill=PALETTE["bg"]))

    def draw_lines(nodes, line_col):
        for node in nodes:
            if not node["matched"]:
                continue
            for gid in parse_ids(node["row"]["corresponding_ids"]):
                gy = gt_y_map.get(gid)
                if gy is None:
                    continue
                x1, y1 = node["x"], node["y"]
                x2, y2 = cx_gt, gy
                mx = (x1 + x2) / 2
                dwg.add(dwg.path(
                    d=f"M{x1},{y1} C{mx},{y1} {mx},{y2} {x2},{y2}",
                    fill="none", stroke=line_col,
                    stroke_width=1.2, stroke_opacity=line_opacity,
                ))

    def draw_nodes(nodes, default_col, is_gt=False):
        for node in nodes:
            fill    = (PALETTE["gt"] if node["matched"] else PALETTE["gt_unmatched"]
                       ) if is_gt else default_col
            opacity = 1.0 if node["matched"] else 0.3
            dwg.add(dwg.circle(
                center=(node["x"], node["y"]), r=node["r"],
                fill=fill, fill_opacity=opacity,
                stroke=fill, stroke_width=0.8, stroke_opacity=0.7,
            ))

    draw_lines(left_nodes,  PALETTE["left"])
    draw_lines(right_nodes, PALETTE["right"])
    draw_nodes(gt_nodes,    PALETTE["gt"],   is_gt=True)
    draw_nodes(left_nodes,  PALETTE["left"])
    draw_nodes(right_nodes, PALETTE["right"])

    # Column labels
    # label_y = top_margin/2 -5 # + col_height# + 24
    # for cx_, lbl, col in (
    #     (cx_left,  left_label,    PALETTE["left"]),
    #     (cx_gt,    "Ground truth", PALETTE["gt"]),
    #     (cx_right, right_label,   PALETTE["right"]),
    # ):
    #     dwg.add(dwg.text(
    #         lbl, insert=(cx_, label_y),
    #         text_anchor="middle", dominant_baseline="hanging",
    #         font_family="Helvetica Neue, Arial, sans-serif",
    #         font_size=12, fill=col, font_weight="bold",
    #     ))
    
    label_y = top_margin / 2

    left_unmatched  = sum(1 for n in left_nodes  if not n["matched"])
    right_unmatched = sum(1 for n in right_nodes if not n["matched"])

    left_ratio  = f"{len(matched_by_left)}/{len(gt_unmatched) + len(gt_matched)}"
    right_ratio = f"{len(matched_by_right)}/{len(gt_unmatched) + len(gt_matched)}"
    
    for cx_, lbl, col, unmatched in (
        (cx_left,  left_label,     PALETTE["left"],  f"{left_unmatched} unmatched"),
        ((cx_left+cx_gt)/2,  "Matched",     PALETTE["left"],  left_ratio),
        (cx_gt,    "Ground truth", PALETTE["gt"],     len(gt_unmatched)),
        ((cx_right+cx_gt)/2,  "Matched",     PALETTE["right"],  right_ratio),
        (cx_right, right_label,    PALETTE["right"], f"{right_unmatched} unmatched"),
    ):
        dwg.add(dwg.text(
            lbl, insert=(cx_, label_y),
            text_anchor="middle", dominant_baseline="hanging",
            font_family="Helvetica Neue, Arial, sans-serif",
            font_size=13, fill=col, font_weight="bold",
        ))
        if unmatched is not None:
            dwg.add(dwg.text(
                f"{unmatched}",
                insert=(cx_, label_y + 16),
                text_anchor="middle", dominant_baseline="hanging",
                font_family="Helvetica Neue, Arial, sans-serif",
                font_size=11, fill=col, font_weight="normal",
                font_style="italic",
            ))


    dwg.save()
    print(f"Saved → {output_svg}  ({len(gt_nodes)} GT, "
          f"{len(left_nodes)} {left_label}, {len(right_nodes)} {right_label})")


# ── CLI ───────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("csv",                           help="VESSELS_*.csv path")
    p.add_argument("output",                        help="output .svg path")
    p.add_argument("--left-method",   default="pipeline")
    p.add_argument("--left-variant",  default="default")
    p.add_argument("--left-label",    default="Pipeline")
    p.add_argument("--right-method",  default="threshold")
    p.add_argument("--right-variant", default="best_dice")
    p.add_argument("--right-label",   default="Threshold")
    p.add_argument("--node-size",     default="volume",
                   choices=["volume", "length", "fixed"])
    p.add_argument("--col-gap",       type=int,   default=200)
    p.add_argument("--line-opacity",  type=float, default=0.35)
    p.add_argument("--col-height",    type=int,   default=480)
    a = p.parse_args()
    render(csv_path=a.csv, output_svg=a.output,
           left_method=a.left_method, left_variant=a.left_variant,
           left_label=a.left_label,
           right_method=a.right_method, right_variant=a.right_variant,
           right_label=a.right_label,
           node_size=a.node_size, col_gap=a.col_gap,
           line_opacity=a.line_opacity, col_height=a.col_height)
    
    
    
    