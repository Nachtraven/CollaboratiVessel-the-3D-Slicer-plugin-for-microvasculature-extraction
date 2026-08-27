
// For each GT vessel, counts how many predictions point to it.
// Values: 0 = missed, 1 = clean match, 2+ = fragmented.
// One column per scan, two sub-strips per scan (pipeline + threshold).
// Each dot = one GT vessel.

#let gt-coverage-strip(
  // List of (label, csv-path) per scan
  scans,
  // Methods: (method, variant, label, colour)
  methods: (
    ("pipeline",  "default",   "Pipeline",  rgb("#003f5c")),
    ("threshold", "best_dice", "Threshold", rgb("#e63946")),
  ),
  gt-method:  "ground_truth",
  gt-variant: "",
  // Column names
  method-col: "method",
  variant-col: "variant",
  id-col:      "vessel_id",
  corr-col:    "corresponding_ids",
  // Y-axis
  y-label:    "Predictions per GT vessel",
  y-max:      none,         // auto if none; set manually to cap outliers
  y-cap:      none,         // cap individual values at this for display
  // Layout
  chart-width:  500pt,
  chart-height: 200pt,
  pad-left:     36pt,
  pad-bottom:   40pt,
  legend-height: 22pt,
  scan-gap:     24pt,       // gap between scan groups
  strip-gap:    10pt,       // gap between two method strips within a scan
  dot-r:        3pt,
  jitter-step:  5pt,        // horizontal spacing between stacked dots
  n-ticks:      5,
  axis-colour:  rgb("#555"),
  tick-size:    7pt,
  label-size:   8pt,
) = {

  let parse-ids(s) = {
    if s == none or s == "" { () }
    else { s.split(";").map(x => int(x.trim())).filter(x => x >= 0) }
  }

  // For one scan + method, compute per-GT-vessel prediction count
  let compute-counts(rows, hdrs, meth, vari) = {
    let mi  = hdrs.position(h => h == method-col)
    let vi  = hdrs.position(h => h == variant-col)
    let ii  = hdrs.position(h => h == id-col)
    let ci  = hdrs.position(h => h == corr-col)

    // GT vessel IDs for this scan
    let gt-ids = rows
      .filter(r => r.at(mi) == gt-method and
        (if gt-variant == "" { true } else { r.at(vi) == gt-variant }))
      .map(r => int(r.at(ii)))

    // Build GT-id → prediction count map
    let gt-count = (:)
    for r in rows.filter(r => r.at(mi) == meth and r.at(vi) == vari) {
      for gid in parse-ids(r.at(ci)) {
        let k = str(gid)
        gt-count.insert(k, gt-count.at(k, default: 0) + 1)
      }
    }

    // Return count for every GT vessel (0 if no prediction points to it)
    gt-ids.map(id => gt-count.at(str(id), default: 0))
  }

  // Load all data
  let scan-data = scans.map(s => {
    let (lbl, path) = s
    let raw  = csv(path)
    let hdrs = raw.at(0)
    let rows = raw.slice(1)
    let method-counts = methods.map(m => {
      let (meth, vari, _, _) = m
      compute-counts(rows, hdrs, meth, vari)
    })
    (label: lbl, counts: method-counts)
  })

  // Y-axis max
  let all-vals = scan-data
    .map(s => s.counts.map(c => c).flatten())
    .flatten()
  let raw-max  = if all-vals.len() > 0 { calc.max(..all-vals) } else { 5 }
  let disp-max = if y-max != none { y-max }
                 else if y-cap != none { y-cap }
                 else { raw-max }
  let cap-val  = if y-cap != none { y-cap } else { raw-max }

  let to-y(v) = {
    let cv = calc.min(v, cap-val)  // cap outliers
    chart-height * (1 - cv / disp-max)
  }

  // Strip width: divide chart evenly among scan groups
  let n-scans    = scans.len()
  let n-methods  = methods.len()
  let scan-width = (chart-width - scan-gap * (n-scans - 1)) / n-scans
  let strip-w    = (scan-width - strip-gap * (n-methods - 1)) / n-methods

  let total-h = legend-height + chart-height + pad-bottom

  block(width: chart-width + pad-left + 10pt, height: total-h)[
    #set align(left)

    // Legend
    #place(left + top, dx: pad-left, dy: 0pt,
      stack(dir: ltr, spacing: 1.4em,
        ..methods.map(m => {
          let (_, _, lbl, col) = m
          stack(dir: ltr, spacing: 0.4em,
            circle(radius: 5pt, fill: col),
            text(size: label-size, fill: axis-colour)[#lbl])
        })
      )
    )

    // Y-axis ticks and gridlines
    #for i in range(n-ticks + 1) {
      let v     = disp-max * i / n-ticks
      let y-pos = legend-height + to-y(v)
      place(left + top, dx: pad-left, dy: y-pos,
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: 0pt, dy: y-pos - 5pt,
        box(width: pad-left - 2pt, align(right,
          text(size: tick-size, fill: axis-colour)[
            #str(int(calc.round(v, digits: 0)))
          ])))
    }

    // Reference line at y=1 (clean 1:1)
    #if disp-max >= 1 {
      let ref-y = legend-height + to-y(1)
      place(left + top, dx: pad-left, dy: ref-y,
        line(length: chart-width,
             stroke: (paint: rgb("#aaa"), thickness: 0.5pt, dash: "dashed")))
    }

    // Dots per scan per method
    #for (si, scan) in scan-data.enumerate() {
      let scan-x = pad-left + si * (scan-width + scan-gap)

      for (mi, m) in methods.enumerate() {
        let (_, _, _, col) = m
        let vals  = scan.counts.at(mi)
        let sx    = scan-x + mi * (strip-w + strip-gap)

        // Stack dots at the same y value horizontally (beeswarm-lite)
        let y-buckets = (:)
        for v in vals {
          let k = str(int(calc.min(v, cap-val) * 10))
          y-buckets.insert(k, y-buckets.at(k, default: ()) + (v,))
        }

        for (_, bucket) in y-buckets.pairs() {
          let n = bucket.len()
          for (di, v) in bucket.enumerate() {
            let dy-pos = legend-height + to-y(v)
            // Centre the horizontal stack within the strip
            let jx = (di - (n - 1) / 2) * jitter-step
            let dot-col = if v == 0 { col.transparentize(30%) }
                          else if v == 1 { col }
                          else { col.lighten(20%) }
            place(left + top,
              dx: sx + strip-w / 2 + jx - dot-r,
              dy: dy-pos - dot-r,
              circle(radius: dot-r,
                     fill: dot-col,
                     stroke: col.darken(10%) + 0.4pt))
          }
        }
      }

      // Scan label
      place(left + top,
        dx: scan-x + scan-width / 2 - 30pt,
        dy: legend-height + chart-height + 6pt,
        box(width: 60pt, align(center,
          text(size: label-size, fill: axis-colour)[#scan.label])))

      // Vertical separator between scans
      if si < n-scans - 1 {
        place(left + top,
          dx: scan-x + scan-width + scan-gap / 2,
          dy: legend-height,
          line(start: (0pt, 0pt), end: (0pt, chart-height),
               stroke: 0.3pt + rgb("#ddd")))
      }
    }

    // Axes
    #place(left + top, dx: pad-left, dy: legend-height,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour))
    #place(left + top, dx: pad-left, dy: legend-height + chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour))

    // Y-axis label
    #place(left + top,
      dx: -18pt, dy: legend-height + chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 8pt, fill: axis-colour)[#y-label]))
  ]
}