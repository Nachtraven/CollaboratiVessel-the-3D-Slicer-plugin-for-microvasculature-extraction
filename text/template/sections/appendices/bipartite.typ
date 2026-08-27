#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot, chart

// vessel-bipartite.typ
// Bipartite vessel matching diagram.
// Center column = GT vessels, left = one method, right = another.
// Lines connect predictions to their corresponding GT vessels.
// Unmatched nodes on each side are pushed to the outside.

#let vessel-bipartite(
  csv-path,
  // Left panel
  left-method:  "pipeline",
  left-variant: "default",
  left-label:   "Pipeline",
  left-colour:  rgb("#457b9d"),
  // Right panel
  right-method:  "threshold",
  right-variant: "best_dice",
  right-label:   "Threshold",
  right-colour:  rgb("#e63946"),
  // GT
  gt-method:    "ground_truth",
  gt-variant:   "",
  gt-colour:    rgb("#2a9d8f"),
  gt-unmatched-colour: rgb("#bbb"),
  // Node sizing
  node-size:    "volume",   // "volume" | "length" | "fixed"
  node-min:     4pt,
  node-max:     18pt,
  // Lines
  line-colour-left:  rgb("#457b9d"),
  line-colour-right: rgb("#e63946"),
  line-opacity: 60,         // 0–255
  // Layout
  svg-width:    680pt,
  col-height:   400pt,
  col-gap:      160pt,
) = {
  let data = csv(csv-path)
  let hdrs = data.at(0)
  let rows = data.slice(1)

  let ci(name) = hdrs.position(h => h == name)
  let mi   = ci("method")
  let vi   = ci("variant")
  let idi  = ci("vessel_id")
  let voli = ci("volume_voxels")
  let lei  = ci("length_mm")
  let nci  = ci("n_corresponding")
  let cidi = ci("corresponding_ids")

  let parse-ids(s) = {
    if s == "" or s == none { () }
    else { s.split(";").map(x => int(x.trim())) }
  }

  // Filter rows per method/variant
  let filter-rows(meth, vari) = rows.filter(r =>
    r.at(mi) == meth and
    (if vari == "" or vari == none {
      r.at(vi) == "" or r.at(vi) == none
    } else { r.at(vi) == vari })
  )

  let gt-rows    = filter-rows(gt-method,    gt-variant)
  let left-rows  = filter-rows(left-method,  left-variant)
  let right-rows = filter-rows(right-method, right-variant)

  // Node size from metric
  let node-size-val(row) = {
    if node-size == "volume" { float(row.at(voli)) }
    else if node-size == "length" { float(row.at(lei)) }
    else { 1.0 }
  }

  // Map metric to radius in pt
  let all-sizes = (gt-rows + left-rows + right-rows).map(r => node-size-val(r))
  let s-min = if all-sizes.len() > 0 { calc.min(..all-sizes) } else { 1.0 }
  let s-max = if all-sizes.len() > 0 { calc.max(..all-sizes) } else { 1.0 }
  let radius(row) = {
    let v = node-size-val(row)
    let t = if s-max > s-min { (v - s-min) / (s-max - s-min) } else { 0.5 }
    node-min + t * (node-max - node-min)
  }

  // Identify which GT ids are matched by each side
  let matched-gt-ids(pred-rows) = {
    let ids = ()
    for r in pred-rows {
      for id in parse-ids(r.at(cidi)) {
        ids.push(id)
      }
    }
    ids
  }
  let left-matched-gt  = matched-gt-ids(left-rows)
  let right-matched-gt = matched-gt-ids(right-rows)

  // Layout: column x-centres
  let col-w   = svg-width
  let cx-gt   = col-w / 2
  let cx-left = cx-gt - col-gap
  let cx-right= cx-gt + col-gap

  // Y position for node i out of n in column
  let node-y(i, n) = {
    if n <= 1 { col-height / 2 + 40pt }
    else { 40pt + i * (col-height - 40pt) / (n - 1) }
  }

  // Build positioned GT nodes (matched first, then unmatched)
  let gt-matched   = gt-rows.filter(r =>
    left-matched-gt.contains(int(r.at(idi))) or
    right-matched-gt.contains(int(r.at(idi))))
  let gt-unmatched = gt-rows.filter(r =>
    not (left-matched-gt.contains(int(r.at(idi))) or
         right-matched-gt.contains(int(r.at(idi)))))

  let gt-positioned = gt-matched.enumerate().map(((i, r)) => (
    id: int(r.at(idi)), row: r,
    x: cx-gt,
    y: node-y(i, gt-matched.len()),
    matched: true,
  )) + gt-unmatched.enumerate().map(((i, r)) => (
    id: int(r.at(idi)), row: r,
    x: cx-gt + 25pt,   // slight offset for unmatched GT
    y: node-y(i + gt-matched.len(), gt-rows.len()),
    matched: false,
  ))

  // Build positioned prediction nodes (matched first, then unmatched)
  let pred-positioned(pred-rows, matched-gt, cx, side) = {
    let matched   = pred-rows.filter(r => int(r.at(nci)) > 0)
    let unmatched = pred-rows.filter(r => int(r.at(nci)) == 0)
    matched.enumerate().map(((i, r)) => (
      id: int(r.at(idi)), row: r,
      x: cx,
      y: node-y(i, matched.len()),
      matched: true,
    )) + unmatched.enumerate().map(((i, r)) => (
      id: int(r.at(idi)), row: r,
      x: if side == "left" { cx - 22pt } else { cx + 22pt },
      y: node-y(i + matched.len(), pred-rows.len()),
      matched: false,
    ))
  }

  let left-pos  = pred-positioned(left-rows,  left-matched-gt,  cx-left,  "left")
  let right-pos = pred-positioned(right-rows, right-matched-gt, cx-right, "right")

  // Build GT id → y lookup
  let gt-lookup = (:)
  for node in gt-positioned {
    gt-lookup.insert(str(node.id), node.y)
  }

  let svg-height = col-height + 80pt

  // Convert pt to float for SVG coordinate math
  let f(v) = float(v / 1pt)

  // Draw lines for one side
  let draw-lines(pred-pos, col, line-col) = {
    let lc-hex = line-col.to-hex()
    let alpha   = calc.round(line-opacity / 255 * 100) / 100
    for node in pred-pos {
      if not node.matched { continue }
      for gid in parse-ids(node.row.at(cidi)) {
        let gy = gt-lookup.at(str(gid), default: none)
        if gy == none { continue }
        let x1 = f(node.x)
        let x2 = f(cx-gt)
        let y1 = f(node.y)
        let y2 = f(gy)
        let mx = (x1 + x2) / 2
        [<path d="M#(x1) #(y1) C#(mx) #(y1) #(mx) #(y2) #(x2) #(y2)"
           fill="none" stroke="#lc-hex" stroke-width="1"
           stroke-opacity="#alpha"/>]
      }
    }
  }

  // Draw nodes for one column
  let draw-nodes(pos-list, col, label) = {
    for node in pos-list {
      let r   = f(radius(node.row))
      let cx  = f(node.x)
      let cy  = f(node.y)
      let hex = if node.matched { col.to-hex() }
                else if pos-list == gt-positioned { gt-unmatched-colour.to-hex() }
                else { col.to-hex() }
      let op  = if node.matched { "1" } else { "0.35" }
      [<circle cx="#cx" cy="#cy" r="#r"
         fill="#hex" fill-opacity="#op"
         stroke="#hex" stroke-width="0.5" stroke-opacity="0.6"/>]
    }
  }

  // Column labels
  let label-y = f(svg-height - 18pt)

  box(width: svg-width, height: svg-height)[
    #[<svg width="#(f(svg-width))" height="#(f(svg-height))"
         viewBox="0 0 #(f(svg-width)) #(f(svg-height))"
         xmlns="http://www.w3.org/2000/svg">
      #draw-lines(left-pos,  left-colour,  line-colour-left)
      #draw-lines(right-pos, right-colour, line-colour-right)
      #draw-nodes(gt-positioned, gt-colour, "GT")
      #draw-nodes(left-pos,  left-colour,  left-label)
      #draw-nodes(right-pos, right-colour, right-label)
      <text x="#(f(cx-left))" y="#label-y" text-anchor="middle"
            font-size="11" fill="#(left-colour.to-hex())"
            font-family="sans-serif">#left-label</text>
      <text x="#(f(cx-gt))" y="#label-y" text-anchor="middle"
            font-size="11" fill="#(gt-colour.to-hex())"
            font-family="sans-serif">Ground truth</text>
      <text x="#(f(cx-right))" y="#label-y" text-anchor="middle"
            font-size="11" fill="#(right-colour.to-hex())"
            font-family="sans-serif">#right-label</text>
    </svg>]
  ]
}