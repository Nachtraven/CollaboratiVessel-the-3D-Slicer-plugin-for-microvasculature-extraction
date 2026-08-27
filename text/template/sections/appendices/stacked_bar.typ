#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot, chart

// Vessel match stacked bar chart.
//
// Each bar represents one (method, variant) combo and shows:
//   Prediction bars (option A — GT-side fragmentation):
//     - No support  : predicted vessels with n_corresponding == 0
//     - Matched     : predicted vessels with n_corresponding == 1
//     - Expanded    : predicted vessels with n_corresponding > 1
//     - GT Merged   : GT vessels covered by > 1 prediction (option A)
//   OR
//     - GT Merged   : predicted vessels sharing their GT match (option B)
//
//   GT bar: shows total GT vessel count, coloured uniformly.
//
// combos: list of (method, variant, label)
// gt-method / gt-variant: which rows are the ground truth

#let vessel-match-bars(
  csv-path,
  combos,                            // ((method, variant, label), ...)
  gt-method:  "ground_truth",
  gt-variant: "",
  merge-mode: "A",                   // "A" = GT-side, "B" = prediction-side
  // colours
  col-no-support: rgb("#e63946"),    // red    — FP, no GT overlap
  col-matched:    rgb("#2a9d8f"),    // teal   — clean 1:1 match
  col-expanded:   rgb("#ffa600"),    // amber  — one pred covers many GT
  col-merged:     rgb("#78529b"),    // purple — fragmented GT (option A/B)
  col-gt:         rgb("#aaa"),       // grey   — GT reference bar
  // layout
  chart-width:  400pt,
  chart-height: 200pt,
  bar-width:    32pt,
  bar-gap:      18pt,
  pad-left:     36pt,
  pad-bottom:   40pt,
  label-size:   8pt,
  tick-size:    7pt,
  n-ticks:      5,
  axis-colour:  rgb("#555"),
) = {
  let data = csv(csv-path)
  let hdrs = data.at(0)
  let rows = data.slice(1)

  let col(name) = hdrs.position(h => h == name)
  let mi   = col("method")
  let vi   = col("variant")
  let ii   = col("vessel_id")
  let nci  = col("n_corresponding")
  let cidi = col("corresponding_ids")

  // ---- Parse corresponding_ids list from "1;6;2" → (1, 6, 2) ----
  let parse-ids(s) = {
    if s == "" or s == none { () }
    else { s.split(";").map(x => int(x.trim())) }
  }

  // ---- Count GT vessels ----
  let gt-rows = rows.filter(r =>
    r.at(mi) == gt-method and
    (gt-variant == "" or r.at(vi) == gt-variant))
  let gt-count = gt-rows.len()

  // ---- Build per-combo stats ----
  let combo-stats = combos.map(c => {
    let (meth, vari, lbl) = c
    let pred-rows = rows.filter(r =>
      r.at(mi) == meth and r.at(vi) == vari)
    let n = pred-rows.len()
    if n == 0 { return (label: lbl, n: 0, no-support: 0, matched: 0,
                        expanded: 0, merged: 0) }

    // Build GT-id → prediction count map (needed for both modes)
    let gt-pred-count = (:)
    for r in pred-rows {
      for gid in parse-ids(r.at(cidi)) {
        let k = str(gid)
        gt-pred-count.insert(k, gt-pred-count.at(k, default: 0) + 1)
      }
    }

    // Mutually exclusive categories — each vessel counted exactly once:
    // 1. no-support : n_corresponding == 0
    // 2. expanded   : n_corresponding > 1  (one pred merges many GT)
    // 3. merged (B) : n_corresponding == 1 but GT match shared with other preds
    // 4. matched    : n_corresponding == 1 and GT match is unique
    // Mode A overrides: merged = GT vessels with >1 pred (reported separately,
    // not drawn from pred budget — shown as an annotation, not a bar segment)
    let no-support = 0
    let expanded   = 0
    let merged-b   = 0
    let matched    = 0

    for r in pred-rows {
      let nc = int(r.at(nci))
      if nc == 0 {
        no-support = no-support + 1
      } else if nc > 1 {
        expanded = expanded + 1
      } else {
        // nc == 1: check if GT match is shared
        let ids = parse-ids(r.at(cidi))
        let shared = ids.any(gid =>
          gt-pred-count.at(str(gid), default: 0) > 1)
        if shared { merged-b = merged-b + 1 }
        else      { matched  = matched  + 1 }
      }
    }

    // Mode A: count of GT vessels fragmented (informational, fits in n=gt-count)
    let merged-a = gt-pred-count.values().filter(v => v > 1).len()

    let merged = if merge-mode == "A" { merged-a } else { merged-b }

    // For mode A, merged is a GT-side count so we normalise against gt-count
    // For mode B, all four categories sum exactly to n (pred count)
    (label: lbl, n: n, gt-count-local: gt-count,
     no-support: no-support, matched: matched,
     expanded: expanded, merged: merged,
     merge-mode-local: merge-mode)
  })

  // ---- Layout ----
  let n-bars    = combos.len() + 1    // +1 for GT
  let total-w   = n-bars * (bar-width + bar-gap) + bar-gap
  let w         = calc.max(chart-width, total-w + pad-left)
  let axis-colour-val = axis-colour

  let pct(n, total) = if total == 0 { 0.0 } else { n / total }
  let bar-h(p) = chart-height * p

  // Legend entries
  let legend-items = (
    (col-no-support, "No support"),
    (col-matched,    "Matched (1:1)"),
    (col-expanded,   "Expanded (pred→many GT)"),
    (col-merged,     if merge-mode == "A" {
      "GT fragmented (>1 pred/GT)" } else {
      "Shared GT match" }),
    (col-gt, "Ground truth"),
  )

  block(width: w + 20pt, height: chart-height + pad-bottom + 30pt)[
    #set align(left)

    // Y-axis ticks and gridlines
    #for i in range(n-ticks + 1) {
      let p   = i / n-ticks
      let y   = chart-height * (1 - p)
      let lbl = str(calc.round(p * 100, digits: 0)) + "%"
      place(left + top, dx: pad-left, dy: y,
        line(length: w - pad-left, stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: 0pt, dy: y - 5pt,
        box(width: pad-left - 2pt, align(right,
          text(size: tick-size, fill: axis-colour)[#lbl])))
    }

    // Y-axis label
    #place(left + top,
      dx: -14pt, dy: chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 9pt, fill: axis-colour)[% of vessels]))

    // GT bar
    #let gt-x = pad-left + bar-gap
    #place(left + top, dx: gt-x, dy: 0pt,
      rect(width: bar-width, height: chart-height,
           fill: col-gt, stroke: none))
    // GT count label above bar
    #place(left + top, dx: gt-x, dy: -14pt,
      box(width: bar-width, align(center,
        text(size: label-size, weight: "bold",
             fill: axis-colour)[#gt-count])))
    // GT x-label
    #place(left + top,
      dx: gt-x + bar-width / 2 - 18pt,
      dy: chart-height + 6pt,
      box(width: 36pt, align(center,
        text(size: label-size, fill: axis-colour)[GT])))

    // Combo bars
    #for (ci, s) in combo-stats.enumerate() {
      let bx = pad-left + bar-gap + (bar-width + bar-gap) * (ci + 1)

      // Stacked segments — mutually exclusive, sum to exactly n (mode B)
      // or to n with merged drawn against gt-count (mode A)
      let denom-merged = if s.merge-mode-local == "A" {
        s.gt-count-local } else { s.n }

      let segs = (
        (pct(s.no-support, s.n),          col-no-support),
        (pct(s.merged,     denom-merged),  col-merged),
        (pct(s.expanded,   s.n),           col-expanded),
        (pct(s.matched,    s.n),           col-matched),
      )

      let y-cursor = chart-height   // start from bottom
      for (p, col) in segs {
        let h = bar-h(p)
        y-cursor = y-cursor - h
        if h > 0pt {
          place(left + top, dx: bx, dy: y-cursor,
            rect(width: bar-width, height: h, fill: col, stroke: none))
        }
      }

      // Total count above bar
      place(left + top, dx: bx, dy: -14pt,
        box(width: bar-width, align(center,
          text(size: label-size, weight: "bold",
               fill: axis-colour)[#s.n])))

      // X-axis label
      place(left + top,
        dx: bx + bar-width / 2 - 30pt,
        dy: chart-height + 6pt,
        box(width: 60pt, align(center,
          text(size: label-size, fill: axis-colour)[#s.label])))
    }

    // Axes
    #place(left + top, dx: pad-left, dy: 0pt,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour))
    #place(left + top, dx: pad-left, dy: chart-height,
      line(length: w - pad-left, stroke: 0.8pt + axis-colour))

    // Legend (horizontal, below x-axis labels)
    #place(left + top,
      dx: pad-left, dy: chart-height + 24pt,
      stack(dir: ltr, spacing: 1em,
        ..legend-items.map(item =>
          stack(dir: ltr, spacing: 0.3em,
            rect(width: 9pt, height: 9pt,
                 fill: item.at(0), stroke: none),
            text(size: 7pt, fill: axis-colour)[#item.at(1)]
          )
        )
      )
    )
  ]
}