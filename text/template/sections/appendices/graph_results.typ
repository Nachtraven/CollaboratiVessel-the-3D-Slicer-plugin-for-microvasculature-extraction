#let results-chart(
  samples,           // list of (label, series-rows) tuples — see below
  series-defs,       // list of (key, label, colour) — the colour key per series-type
  maximum,
  y-label,
) = {
  // Each sample contains entries keyed by series-defs.key. Resolve each
  // sample × series into a single bar value.
  let load-cell-val(csv-path, row-idx, col-name) = {
    let data = csv(csv-path)
    let hdrs = data.at(0)
    let rows = data.slice(1)
    let i = hdrs.position(h => h == col-name)
    float(rows.at(row-idx).at(i))
  }
  let load-cell-ratio(csv-path, row-idx, num, den) = {
    let d = load-cell-val(csv-path, row-idx, den)
    if d == 0.0 { 0.0 } else { load-cell-val(csv-path, row-idx, num) / d }
  }

  // Resolve every bar value up front so layout maths can use them
  let resolved = samples.map(sample => (
    label: sample.label,
    bars:  series-defs.map(sdef => {
      let entry = sample.series.at(sdef.key)
      let value = if "col" in entry {
        load-cell-val(entry.csv, entry.row, entry.col)
      } else {
        load-cell-ratio(entry.csv, entry.row, entry.num, entry.den)
      }
      (value: value, colour: sdef.colour, label: sdef.label)
    }),
  ))

  // Layout constants
  let chart-width    = 400pt
  let chart-height   = 180pt
  let pad-left       = 36pt
  let bar-gap        = 1.5pt   // gap between bars within a sample
  let sample-gap     = 14pt    // gap between samples
  let n-ticks        = 5
  let legend-width   = 160pt
  let axis-colour    = rgb("#555")
  let tick-size      = 9pt
  let sample-label-size = 8pt

  let y-tick-step = maximum / (n-ticks - 1)
  let y-ticks     = range(n-ticks).map(i => i * y-tick-step)

  let n-samples = resolved.len()
  let n-bars-per-sample = series-defs.len()

  // Compute bar width given fixed gaps
  let total-inner-gaps = (
  sample-gap * (n-samples - 1)
  + bar-gap * (n-bars-per-sample - 1) * n-samples
  )

  let bar-width = (chart-width - total-inner-gaps) / (n-samples * n-bars-per-sample)

  let sample-width = (
    n-bars-per-sample * bar-width
    + bar-gap * (n-bars-per-sample - 1)
  )

  block(width: chart-width + pad-left + 20pt,
        height: chart-height + 36pt)[
    #set align(left)

    // Y-axis title
    #place(left + top,
      dx: -68pt, dy: chart-height / 2 - 24pt,
      rotate(-90deg, text(size: 9pt, fill: axis-colour)[#y-label])
    )

    // Y gridlines + ticks
    #for tick in y-ticks {
      let y-pos = chart-height * (1 - tick / maximum)
      place(left + top, dx: pad-left, dy: y-pos,
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: 15pt, dy: y-pos - 5pt,
        text(size: tick-size, fill: axis-colour)[#str(calc.round(tick, digits: 2))])
    }

    // Bars + sample labels
    #for (si, sample) in resolved.enumerate() {
      let sample-x = pad-left + si * (sample-width + sample-gap)
      // Bars within the sample
      for (bi, b) in sample.bars.enumerate() {
        let bar-h = chart-height * (b.value / maximum)
        let bar-x = sample-x + bi * (bar-width + bar-gap)
        place(left + top,
          dx: bar-x, dy: chart-height - bar-h,
          rect(width: bar-width, height: bar-h, fill: b.colour, stroke: none))
      }
      // Sample label, centred under the cluster
      place(left + top,
        dx: sample-x + sample-width / 2 - 24pt,
        dy: chart-height + 4pt,
        box(width: 48pt, align(center,
          text(size: sample-label-size, fill: axis-colour)[#sample.label])))
    }

    // Plot-area axes
    #place(left + top, dx: pad-left, dy: 0pt,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour))
    #place(left + top, dx: pad-left, dy: chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour))

    // Legend — one row per series type, not per (sample × series)
    #place(left + top,
      dx: pad-left + chart-width - legend-width - 4pt,
      dy: -65pt,
      box(
        width: legend-width,
        fill: rgb(255, 255, 255, 200),
        inset: (x: 0.4em, y: 0.3em),
        radius: 2pt,
        stroke: 0.4pt + rgb("#ccc"),
        stack(dir: ttb, spacing: 0.4em,
          ..series-defs.map(sdef =>
            stack(dir: ltr, spacing: 0.4em,
              rect(width: 10pt, height: 10pt, fill: sdef.colour, stroke: none),
              text(size: 8pt)[#sdef.label]
            )
          )
        )
      )
    )
  ]
}



// #let results-chart(series, maximum, y-label, derived-series: ()) = {

//   // Load CSV per series — each series specifies its own csv path and row index
//   let load-cell-val(csv-path, row-idx, col-name) = {
//     let data = csv(csv-path)
//     let hdrs = data.at(0)
//     let rows = data.slice(1)
//     let i = hdrs.position(h => h == col-name)
//     float(rows.at(row-idx).at(i))
//   }

//   let load-cell-ratio(csv-path, row-idx, num, den) = {
//     let d = load-cell-val(csv-path, row-idx, den)
//     if d == 0.0 { 0.0 } else { load-cell-val(csv-path, row-idx, num) / d }
//   }

//   let all-series = (
//     ..series.map(s => (
//       value: load-cell-val(s.at("csv"), s.at("row"), s.col),
//       colour: s.colour,
//       label:  s.label,
//     )),
//     ..derived-series.map(s => (
//       value:  load-cell-ratio(s.csv, s.row, s.num, s.den),
//       colour: s.colour,
//       label:  s.label,
//     )),
//   )


//   let chart-width   = 420pt
//   let chart-height  = 180pt
//   let bar-group-gap = 18pt
//   let bar-gap       = 2pt
//   let n-ticks       = 5
//   let legend-width  = 110pt
//   let axis-colour   = rgb("555")
//   let label-size    = 9pt
//   let tick-size     = 9pt

//   let y-max       = maximum
//   let y-tick-step = y-max / (n-ticks - 1)
//   let y-ticks     = range(n-ticks).map(i => i * y-tick-step)

//   // let n-groups    = rows.len()
//   let group-width = chart-width - bar-group-gap * 2
//   let n-bars      = all-series.len()
//   let bar-width   = (group-width - bar-gap * (n-bars - 1)) / n-bars


//   block(width: chart-width + 40pt, height: chart-height + 25pt)[
//     #set align(left)

//     #place(left + top,
//       dx: -20pt, dy: chart-height / 2 - 6pt,
//       rotate(-90deg, text(size: 10pt, fill: axis-colour)[#y-label])
//     )

//     #for tick in y-ticks {
//       let y-pos = chart-height * (1 - tick / y-max)
//       place(left + top, dx: 30pt, dy: y-pos,
//         line(length: chart-width, stroke: 0.4pt + rgb("#ddd"))
//       )
//       place(left + top, dx: 0pt, dy: y-pos - 5pt,
//         text(size: tick-size, fill: axis-colour)[#str(tick)]
//       )
//     }

//     // Single group of bars — no row iteration since each series has its own CSV/row
//     #for (bi, s) in all-series.enumerate() {
//       let bar-h = chart-height * (s.value / y-max)
//       let bar-x = 30pt + bar-group-gap + bi * (bar-width + bar-gap)
//       place(left + top,
//         dx: bar-x, dy: chart-height - bar-h,
//         rect(width: bar-width, height: bar-h, fill: s.colour, stroke: none)
//       )
//     }

//     #place(left + top, dx: 30pt, dy: 0pt,
//       line(start: (0pt, 0pt), end: (0pt, chart-height), stroke: 0.8pt + axis-colour)
//     )
//     #place(left + top, dx: 30pt, dy: chart-height,
//       line(length: chart-width, stroke: 0.8pt + axis-colour)
//     )

//     #place(left + top,
//       dx: 35pt + chart-width - legend-width - 8pt,
//       dy: -5pt,
//       box(
//         width: legend-width,
//         fill: rgb(255, 255, 255, 200),
//         inset: (x: 0.4em, y: 0.3em),
//         radius: 2pt,
//         stroke: 0.4pt + rgb("#ccc"),
//         stack(dir: ttb, spacing: 0.4em,
//           ..all-series.map(s =>
//             stack(dir: ltr, spacing: 0.4em,
//               rect(width: 10pt, height: 10pt, fill: s.colour, stroke: none),
//               text(size: 8pt)[#(s.label)]
//             )
//           )
//         )
//       )
//     )
//   ]
// }
















// // Choose columns to plot and their display colours
// #let series = (
//   (col: "pred_gt_dice",   colour: rgb("#e63946"), label: "Pred/GT Dice"),
//   (col: "thr_gt_dice",    colour: rgb("#457b9d"), label: "Thr/GT Dice"),
//   (col: "pred_thr_dice",  colour: rgb("#2a9d8f"), label: "Pred/Thr Dice"),
// )


// #let results-chart(series, maximum, y-label) = {

//   // Group along the samples
//   let x-col = "chunk_name"

//   // --- Helpers ---
//   let col-index(name) = headers.position(h => h == name)

//   let cell-val(row, name) = {
//     let i = col-index(name)
//     float(row.at(i))
//   }

//   // --- Layout constants ---
//   let chart-width  = 420pt
//   let chart-height = 180pt
//   let bar-group-gap = 18pt
//   let bar-gap       = 2pt
  
//   let n-ticks       = 5
//   let legend-width  = 80pt
//   let y-max = maximum

//   let y-tick-step = y-max / (n-ticks - 1)
//   let y-ticks = range(n-ticks).map(i => i * y-tick-step)

//   let axis-colour   = rgb("555")
//   let label-size    = 9pt
//   let tick-size     = 9pt

//   let n-groups = rows.len()
//   let n-bars   = series.len()

//   let group-width = (chart-width - bar-group-gap * (n-groups + 1)) / n-groups
//   let bar-width   = (group-width - bar-gap * (n-bars - 1)) / n-bars

//   // --- Chart ---
//   block(width: chart-width + 40pt, height: chart-height + 25pt)[
//     #set align(left)
//     // Y-axis label (rotated, centred on axis)
//     #place(left + top,
//       dx: -20pt,
//       dy: chart-height / 2 - 6pt,
//       rotate(-90deg, text(size: 10pt, fill: axis-colour)[#y-label])
//     )

//     // Y-axis ticks and grid
//     #for tick in y-ticks {
//       let y-pos = chart-height * (1 - tick / y-max)
//       place(left + top,
//         dx: 30pt,
//         dy: y-pos,
//         line(length: chart-width, stroke: 0.4pt + rgb("#ddd"))
//       )
//       place(left + top,
//         dx: 0pt,
//         dy: y-pos - 5pt,
//         text(size: tick-size, fill: axis-colour)[#str(tick)]
//       )
//     }

//     // Bars and x-axis labels
//     #for (gi, row) in rows.enumerate() {
//       let group-x = 30pt + bar-group-gap + gi * (group-width + bar-group-gap)
//       let x-label = row.at(col-index(x-col))

//       // X label
//       place(left + top,
//         dx: group-x + group-width / 2 - 20pt,
//         dy: chart-height + 6pt,
//         box(width: 40pt, align(center,
//           text(size: label-size, fill: axis-colour)[#x-label]
//         ))
//       )

//       // Bars
//       for (bi, s) in series.enumerate() {
//         let val     = cell-val(row, s.col)
//         let bar-h   = chart-height * (val / y-max)
//         let bar-x   = group-x + bi * (bar-width + bar-gap)
//         let bar-y   = chart-height - bar-h

//         place(left + top,
//           dx: bar-x,
//           dy: bar-y,
//           rect(width: bar-width, height: bar-h, fill: s.colour, stroke: none)
//         )
//       }
//     }

//       // Axes
//     #place(left + top,
//       dx: 30pt, dy: 0pt,
//       line(start: (0pt, 0pt), end: (0pt, chart-height), stroke: 0.8pt + axis-colour)
//     )
//     #place(left + top,
//       dx: 30pt, dy: chart-height,
//       line(length: chart-width, stroke: 0.8pt + axis-colour)
//     )

//     // Legend — placed inside the chart box, upper right
//     #place(left + top,
//       dx: 35pt + chart-width - legend-width - 8pt,
//       dy: -5pt,
//       box(
//         width: legend-width,
//         fill: rgb(255, 255, 255, 200),
//         inset: (x: 0.4em, y: 0.3em),
//         radius: 2pt,
//         stroke: 0.4pt + rgb("#ccc"),
//         stack(dir: ttb, spacing: 0.4em,
//           ..series.map(s =>
//             stack(dir: ltr, spacing: 0.4em,
//               rect(width: 10pt, height: 10pt, fill: s.colour, stroke: none),
//               text(size: 8pt)[#s.label]
//             )
//           )
//         )
//       )
//     )
//   ]
// }
//   // // Legend
//   // stack(dir: ltr, spacing: 1em,
//   //   ..series.map(s =>
//   //     stack(dir: ltr, spacing: 0.4em,
//   //       rect(width: 10pt, height: 10pt, fill: s.colour, stroke: none),
//   //       text(size: 9pt)[#s.label]
//   //     )
//   //   )
//   // )



// Resolve a curve's line style to a stroke dash pattern usable by line().
#let _stroke-for(style, weight, colour) = {
  if style == "dashed" {
    (paint: colour, thickness: weight, dash: "dashed")
  } else if style == "dotted" {
    (paint: colour, thickness: weight, dash: "dotted")
  } else {
    weight + colour
  }
}

// Resolve a group definition that may be either a colour or a dict
// (colour: ..., shape: ...). Returns (colour, shape).
#let _group-style(entry, default-shape) = {
  if type(entry) == dictionary {
    (entry.at("colour", default: black), entry.at("shape", default: default-shape))
  } else {
    (entry, default-shape)
  }
}


#let results-chart-lines(
  curves,
  // --- Column selection ---
  // x-col is a single column read raw; the y value is a ratio of two columns
  x-col:   "threshold_value",
  y-num:   "vessel_seeds_correct",
  y-den:   "vessel_seeds_total",
  // --- Axis labels ---
  x-label: "Threshold value",
  y-label: "Fraction correctly classified",
  // --- Axis range ---
  x-min: none,
  x-max: none,
  y-min: 0.0,
  y-max: 1.0,
  // --- Sorting ---
  sort-by-x: true,
  // --- Curve styling ---
  line-weight: 1.2pt,
  // --- Layout ---
  chart-width:  320pt,
  chart-height: 110pt,
  pad-left:     36pt,
  pad-bottom:   30pt,
  legend-width: 152pt,
  axis-colour:  rgb("#353535"),
  tick-size:    7pt,
  n-ticks:      10,
) = {
  let col-index(headers, name) = headers.position(h => h == name)

  // Load one CSV and emit (x, y) points where y = num / den.
  // Per-row safety: if den is zero, the point is skipped (we can't plot it).
  let load-curve(path) = {
    let data    = csv(path)
    let headers = data.at(0)
    let rows    = data.slice(1)
    let xi = col-index(headers, x-col)
    let ni = col-index(headers, y-num)
    let di = col-index(headers, y-den)
    if xi == none or ni == none or di == none {
      panic("results-chart-lines: required column not found in " + path)
    }
    let pts = ()
    for r in rows {
      let den = float(r.at(di))
      if den != 0.0 {
        let num = float(r.at(ni))
        pts.push((float(r.at(xi)), num / den))
      }
    }
    if sort-by-x { pts.sorted(key: pt => pt.at(0)) } else { pts }
  }

  let datasets = curves.map(c => (
    label:  c.label,
    colour: c.colour,
    style:  c.at("style", default: "solid"),
    points: load-curve(c.csv),
  ))

  // X bounds from data if not overridden; Y is fixed [0, 1] by default
  let all-x = datasets.map(d => d.points.map(p => p.at(0))).flatten()
  let ax-xmin = if x-min != none { x-min } else { calc.min(..all-x) }
  let ax-xmax = if x-max != none { x-max } else { calc.max(..all-x) }
  let ax-ymin = y-min
  let ax-ymax = y-max

  let to-x(v) = pad-left + (v - ax-xmin) / (ax-xmax - ax-xmin) * chart-width
  let to-y(v) = chart-height * (1 - (v - ax-ymin) / (ax-ymax - ax-ymin))

  let total-height = chart-height + pad-bottom + 5pt

  block(width: chart-width + pad-left + 10pt, height: total-height)[
    #set align(left)

    // ====== Grid and ticks ==================================================
    #for i in range(n-ticks + 1) {
      let tx = ax-xmin + i * (ax-xmax - ax-xmin) / n-ticks
      let ty = ax-ymin + i * (ax-ymax - ax-ymin) / n-ticks

      place(left + top, dx: to-x(tx), dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, chart-height),
             stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: to-x(tx) - 10pt, dy: chart-height + 4pt,
        box(width: 20pt, align(center,
          text(size: tick-size, fill: axis-colour)[
            #str(calc.round(tx, digits: if (ax-xmax - ax-xmin) > 10 { 0 } else { 1 }))
          ])))

      place(left + top, dx: pad-left, dy: to-y(ty),
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: 20pt, dy: to-y(ty) - 5pt,
        text(size: tick-size, fill: axis-colour)[
          #str(calc.round(ty, digits: 2))
        ])
    }

    // ====== Curves ==========================================================
    #for ds in datasets {
      let pts = ds.points
      let stroke-spec = _stroke-for(ds.style, line-weight, ds.colour)
      for i in range(pts.len() - 1) {
        let (x0, y0) = pts.at(i)
        let (x1, y1) = pts.at(i + 1)
        place(left + top,
          dx: to-x(x0), dy: to-y(y0),
          line(
            start: (0pt, 0pt),
            end:   (to-x(x1) - to-x(x0), to-y(y1) - to-y(y0)),
            stroke: stroke-spec
          ))
      }
    }

    // ====== Plot-area axes ==================================================
    #place(left + top, dx: pad-left, dy: 0pt,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour))
    #place(left + top, dx: pad-left, dy: chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour))

    // ====== Axis labels =====================================================
    #place(left + top,
      dx: pad-left + chart-width / 2 - 60pt,
      dy: chart-height + pad-bottom - 8pt,
      box(width: 120pt, align(center,
        text(size: 8pt, fill: axis-colour)[#x-label])))
    #place(left + top,
      dx: -90pt, dy: chart-height / 2,// - 24pt,
      rotate(-90deg, box(width: 200pt, align(center,
        text(size: 8pt, fill: axis-colour)[#y-label]))))

    // ====== Legend ==========================================================
    #place(left + top,
      dx: pad-left + chart-width - legend-width - 8pt,
      dy: 8pt,
      box(
        width: legend-width,
        fill: rgb(255, 255, 255, 200),
        inset: (x: 0.4em, y: 0.3em),
        radius: 2pt,
        stroke: 0.4pt + rgb("#ccc"),
        stack(dir: ttb, spacing: 0.4em,
          ..datasets.map(ds =>
            stack(dir: ltr, spacing: 0.4em,
              line(length: 14pt, stroke: _stroke-for(ds.style, 1.5pt, ds.colour)),
              text(size: 8pt)[#ds.label]
            )
          )
        )
      )
    )
  ]
}