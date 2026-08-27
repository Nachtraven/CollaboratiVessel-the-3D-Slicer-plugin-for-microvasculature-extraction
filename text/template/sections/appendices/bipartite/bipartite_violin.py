"""
Violin plot: per-GT-vessel prediction count (pipeline vs threshold) per scan.

For each GT vessel, counts how many predictions point to it.
  0 = missed, 1 = clean match, 2+ = fragmented.

Produces an SVG suitable for embedding in Typst via image().

Requires: matplotlib, pandas, numpy
    pip install matplotlib pandas numpy
"""

import argparse
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyArrowPatch
matplotlib.use("Agg")  # no display needed

# ── Palette (matches thesis charts) ──────────────────────────────────────────
PALETTE = {
    "pipeline":  "#003f5c",
    "threshold": "#e63946",
    "grid":      "#dddddd",
    "ref":       "#aaaaaa",
    "text":      "#444444",
}


def parse_ids(s):
    if not s or (isinstance(s, float) and np.isnan(s)):
        return []
    return [int(x.strip()) for x in str(s).split(";") if x.strip()]


def compute_gt_counts(df, meth, vari, gt_method="ground_truth", gt_variant=""):
    """For each GT vessel, count how many predictions point to it."""
    gt_mask = df["method"] == gt_method
    if gt_variant:
        gt_mask &= df["variant"] == gt_variant
    gt_ids = df[gt_mask]["vessel_id"].astype(int).tolist()

    pred_mask = (df["method"] == meth) & (df["variant"] == vari)
    pred_rows = df[pred_mask]

    gt_count = {}
    for _, row in pred_rows.iterrows():
        for gid in parse_ids(row["corresponding_ids"]):
            gt_count[gid] = gt_count.get(gid, 0) + 1

    return [gt_count.get(gid, 0) for gid in gt_ids]


def render(
    scan_csvs: list,           # list of (label, csv_path)
    output_svg: str,
    left_method:   str = "pipeline",
    left_variant:  str = "default",
    left_label:    str = "CollaboratiVessel",
    right_method:  str = "threshold",
    right_variant: str = "best_dice",
    right_label:   str = "Threshold",
    gt_method:     str = "ground_truth",
    gt_variant:    str = "",
    y_cap:         int = None,   # cap y-axis to hide extreme outliers
    figsize: tuple = (11, 4.5),
):
    n_scans = len(scan_csvs)
    fig, ax = plt.subplots(figsize=figsize)

    col_left  = PALETTE["pipeline"]
    col_right = PALETTE["threshold"]

    positions_left  = []
    positions_right = []
    data_left       = []
    data_right      = []
    x_ticks         = []
    x_labels        = []

    spacing = 3.0   # distance between scan group centres
    half    = 0.55  # half-width between the two violins in a group

    for i, (label, path) in enumerate(scan_csvs):
        df = pd.read_csv(path, dtype={"corresponding_ids": str, "variant": str})
        df["variant"]           = df["variant"].fillna("")
        df["corresponding_ids"] = df["corresponding_ids"].fillna("")

        cl = compute_gt_counts(df, left_method,  left_variant,  gt_method, gt_variant)
        cr = compute_gt_counts(df, right_method, right_variant, gt_method, gt_variant)

        cx = i * spacing
        positions_left.append(cx - half)
        positions_right.append(cx + half)
        data_left.append(cl)
        data_right.append(cr)
        x_ticks.append(cx)
        x_labels.append(label)

    # ── Draw violins ──────────────────────────────────────────────────────────
    def draw_violin(ax, pos_list, data_list, colour):
        for pos, vals in zip(pos_list, data_list):
            if len(vals) < 3:
                # Too few points for KDE — draw a strip instead
                jitter = np.random.uniform(-0.15, 0.15, len(vals))
                ax.scatter(
                    [pos + j for j in jitter], vals,
                    color=colour, s=18, alpha=0.7, zorder=4,
                )
                continue

            parts = ax.violinplot(
                [vals],
                positions=[pos],
                widths=0.9,
                showmeans=True,
                showmedians=False,
                showextrema=False,
            )
            for pc in parts["bodies"]:
                pc.set_facecolor(colour)
                pc.set_edgecolor(colour)
                pc.set_alpha(0.55)
            parts["cmeans"].set_color("#f6ff00")
            parts["cmeans"].set_linewidth(1.5)

            # Overlay individual dots
            jitter = np.random.uniform(-0.08, 0.08, len(vals))
            ax.scatter(
                [pos + j for j in jitter], vals,
                color=colour, s=12, alpha=0.8, zorder=4,
            )

    draw_violin(ax, positions_left,  data_left,  col_left)
    draw_violin(ax, positions_right, data_right, col_right)

    # ── Reference line at y=1 ─────────────────────────────────────────────────
    ax.axhline(1, color=PALETTE["ref"], linewidth=0.8,
               linestyle="--", zorder=1)
    ax.text(
        n_scans * spacing - spacing * 0.05, 1.08,
        "1:1", fontsize=11, color=PALETTE["ref"], va="bottom",
    )

    # ── Y-axis cap ────────────────────────────────────────────────────────────
    all_vals = [v for d in data_left + data_right for v in d]
    y_top = y_cap if y_cap is not None else (max(all_vals) + 0.5 if all_vals else 5)
    ax.set_ylim(-0.4, y_top)

    # ── Grid, ticks, labels ───────────────────────────────────────────────────
    ax.set_xticks(x_ticks)
    ax.set_xticklabels(x_labels, fontsize=9, color=PALETTE["text"])
    ax.set_ylabel("Number of predicted vessels per GT vessel", fontsize=13, color=PALETTE["text"])
    ax.yaxis.set_tick_params(labelsize=8)
    ax.tick_params(colors=PALETTE["text"])
    ax.spines[["top", "right"]].set_visible(False)
    ax.spines[["left", "bottom"]].set_color("#bbbbbb")
    ax.yaxis.grid(True, color=PALETTE["grid"], linewidth=0.5, zorder=0)
    ax.set_axisbelow(True)

    # ── Scan separators ───────────────────────────────────────────────────────
    for i in range(1, n_scans):
        ax.axvline(i * spacing - spacing / 2, color=PALETTE["grid"],
                   linewidth=0.6, linestyle="-", zorder=0)

    # ── Legend ────────────────────────────────────────────────────────────────
    legend_patches = [
        mpatches.Patch(facecolor=col_left,  alpha=0.7, label=left_label),
        mpatches.Patch(facecolor=col_right, alpha=0.7, label=right_label),
    ]
    ax.legend(handles=legend_patches, fontsize=13, framealpha=0.9,
              loc="upper right", edgecolor="#cccccc")

    fig.tight_layout()
    fig.savefig(output_svg, format="svg", bbox_inches="tight",
                metadata={"Creator": ""})
    plt.close(fig)
    print(f"Saved → {output_svg}")


# ── CLI ───────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("output",  help="output .svg path")
    p.add_argument("--scans", nargs="+",
                   help="alternating label csv pairs: CA-LL-L1 path1.csv CA-LL-R path2.csv ...")
    p.add_argument("--left-method",   default="pipeline")
    p.add_argument("--left-variant",  default="default")
    p.add_argument("--left-label",    default="CollaboratiVessel")
    p.add_argument("--right-method",  default="threshold")
    p.add_argument("--right-variant", default="best_dice")
    p.add_argument("--right-label",   default="Threshold")
    p.add_argument("--y-cap",         type=int, default=None)
    a = p.parse_args()

    # Parse alternating label/path pairs
    pairs = list(zip(a.scans[0::2], a.scans[1::2]))

    render(
        scan_csvs=pairs,
        output_svg=a.output,
        left_method=a.left_method,   left_variant=a.left_variant,
        left_label=a.left_label,
        right_method=a.right_method, right_variant=a.right_variant,
        right_label=a.right_label,
        y_cap=a.y_cap,
    )
    
"""
python template/sections/appendices/bipartite/bipartite_violin.py \
  template/sections/appendices/bipartite/violin_gt_coverage.svg \
  --scans \
    "Sample 1" resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv \
    "Sample 2" resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv \
    "Sample 3"  resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv \
    "Sample 4" resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv \
    "Sample 5" resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv \
    "Sample 6" resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv \
  --y-cap 15
  
  """
  
"""
  CA-RU-R (1)
  CA-RU-R (2)
  CA-LL-R
  CA-NM-L (1)
  CA-NM-L (2)
  CA-LL-L1
"""
  