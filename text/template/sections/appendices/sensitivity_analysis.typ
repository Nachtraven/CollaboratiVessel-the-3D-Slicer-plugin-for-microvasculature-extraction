
#let _marker(shape, radius, colour, dx, dy) = {
  if shape == "dot" {
    place(top + left,
      dx: dx - radius, dy: dy - radius,
      circle(radius: radius, fill: colour, stroke: none))
  } else if shape == "cross" {
    // Two short line segments forming an X. Use a slightly thicker stroke so
    // the cross reads at small sizes.
    let r  = radius * 1.15
    let th = 1.1pt
    place(top + left, dx: dx - r, dy: dy - r,
      line(start: (0pt, 0pt), end: (2 * r, 2 * r), stroke: th + colour))
    place(top + left, dx: dx - r, dy: dy + r,
      line(start: (0pt, 0pt), end: (2 * r, -2 * r), stroke: th + colour))
  } else if shape == "square" {
    let s = radius * 1.7
    place(top + left, dx: dx - s / 2, dy: dy - s / 2,
      rect(width: s, height: s, fill: colour, stroke: none))
  } else if shape == "triangle" {
    let s = radius * 1.9
    place(top + left, dx: dx - s / 2, dy: dy - s / 2,
      polygon(fill: colour, stroke: none,
        (s / 2, 0pt), (s, s), (0pt, s)))
  } else {
    // Unknown shape -> fall back to dot
    place(top + left,
      dx: dx - radius, dy: dy - radius,
      circle(radius: radius, fill: colour, stroke: none))
  }
}

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


#let sensitivity-xy-curve(
  curves,
  // --- Column selection (PR curve defaults) ---
  x-col:  "pred_gt_recall",
  y-col:  "pred_gt_precision",
  // --- Axis labels ---
  x-label: "Recall",
  y-label: "Precision",
  // --- Axis range (none = auto from data) ---
  x-min: none,
  x-max: none,
  y-min: none,
  y-max: none,
  // --- Sorting ---
  sort-by-x: true,
  // --- Manual annotation points ---
  points:      (),
  // Groups: a dict mapping group name -> either a colour OR a dict
  // (colour: ..., shape: "dot" | "cross" | "square" | "triangle")
  groups:      (:),
  default-shape: "dot",
  // Marker styling for manual points
  marker-radius:   2.6pt,
  show-point-labels: true,
  point-label-size:  6.5pt,
  point-label-offset: (5pt, -4pt),
  // --- Curve styling ---
  // Default line weight; each curve may also carry a style: "solid"/"dashed"/"dotted"
  line-weight: 1.2pt,
  // --- Secondary (top) x-axis ---
  top-axis-ticks: (),
  top-axis-label: none,
  top-axis-pad:   28pt,
  top-tick-size:  7pt,
  // --- Layout ---
  chart-width:  320pt,
  chart-height: 180pt,
  pad-left:     36pt,
  pad-bottom:   30pt,
  legend-width: 152pt,
  axis-colour:  rgb("#353535"),
  tick-size:    7pt,
  n-ticks:      10,
) = {
  let col-index(headers, name) = headers.position(h => h == name)

  let load-curve(path) = {
    let data    = csv(path)
    let headers = data.at(0)
    let rows    = data.slice(1)
    let xi = col-index(headers, x-col)
    let yi = col-index(headers, y-col)
    let pts = rows.map(r => (float(r.at(xi)), float(r.at(yi))))
    if sort-by-x { pts.sorted(key: pt => pt.at(0)) } else { pts }
  }

  // Pre-load curve data and carry forward each curve's style (default solid)
  let datasets = curves.map(c => (
    label:  c.label,
    colour: c.colour,
    style:  c.at("style", default: "solid"),
    points: load-curve(c.csv),
  ))

  // Axis bounds (curves + manual points)
  let all-x = datasets.map(d => d.points.map(p => p.at(0))).flatten()
  let all-y = datasets.map(d => d.points.map(p => p.at(1))).flatten()
  if points.len() > 0 {
    all-x = all-x + points.map(p => p.x)
    all-y = all-y + points.map(p => p.y)
  }

  let ax-xmin = if x-min != none { x-min } else { calc.min(..all-x) }
  let ax-xmax = if x-max != none { x-max } else { calc.max(..all-x) }
  let ax-ymin = if y-min != none { y-min } else { calc.min(..all-y) }
  let ax-ymax = if y-max != none { y-max } else { calc.max(..all-y) }

  let has-top-axis = top-axis-ticks.len() > 0
  let chart-top = if has-top-axis { top-axis-pad } else { 0pt }

  let to-x(v) = pad-left + (v - ax-xmin) / (ax-xmax - ax-xmin) * chart-width
  let to-y(v) = chart-top + chart-height * (1 - (v - ax-ymin) / (ax-ymax - ax-ymin))

  let total-height = chart-top + chart-height + pad-bottom + 5pt

  block(width: chart-width + pad-left + 10pt, height: total-height)[
    #set align(left)

    // ====== Primary grid and ticks ==========================================
    #for i in range(n-ticks + 1) {
      let tx = ax-xmin + i * (ax-xmax - ax-xmin) / n-ticks
      let ty = ax-ymin + i * (ax-ymax - ax-ymin) / n-ticks

      place(left + top, dx: to-x(tx), dy: chart-top,
        line(start: (0pt, 0pt), end: (0pt, chart-height),
             stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: to-x(tx) - 10pt, dy: chart-top + chart-height + 4pt,
        box(width: 20pt, align(center,
          text(size: tick-size, fill: axis-colour)[
            #str(calc.round(tx, digits: if (ax-xmax - ax-xmin) > 10 { 0 } else { 1 }))
          ])))

      place(left + top, dx: pad-left, dy: to-y(ty),
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: 0pt, dy: to-y(ty) - 5pt,
        text(size: tick-size, fill: axis-colour)[
          #str(calc.round(ty, digits: 2))
        ])
    }

    // ====== Secondary (top) x-axis ==========================================
    #if has-top-axis {
      place(left + top, dx: pad-left, dy: chart-top,
        line(length: chart-width, stroke: 0.8pt + axis-colour))

      for entry in top-axis-ticks {
        let pos = entry.at(0)
        let lab = entry.at(1)
        if pos >= ax-xmin and pos <= ax-xmax {
          place(left + top, dx: to-x(pos), dy: chart-top - 3pt,
            line(start: (0pt, 0pt), end: (0pt, 3pt),
                 stroke: 0.6pt + axis-colour))
          place(left + top,
            dx: to-x(pos) - 20pt,
            dy: chart-top - top-tick-size - 12pt,
            box(width: 40pt, align(center,
              text(size: top-tick-size, fill: axis-colour)[#lab])))
        }
      }

      if top-axis-label != none {
        place(left + top,
          dx: pad-left + chart-width / 2 - 60pt,
          dy: 0pt,
          box(width: 120pt, align(center,
            text(size: 8pt, fill: axis-colour, weight: "bold")[#top-axis-label])))
      }
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

    // ====== Manual annotation points ========================================
    #for p in points {
      let g = p.at("group", default: none)
      let (col, shape) = if g != none and g in groups {
        _group-style(groups.at(g), default-shape)
      } else {
        (axis-colour, default-shape)
      }

      // Marker (dispatch by shape)
      _marker(shape, marker-radius, col, to-x(p.x), to-y(p.y))

      // Label
      if show-point-labels {
        place(left + top,
          dx: to-x(p.x) + point-label-offset.at(0),
          dy: to-y(p.y) + point-label-offset.at(1),
          text(size: point-label-size, fill: col)[#p.name])
      }
    }

    // ====== Plot-area axes (left + bottom) ==================================
    #place(left + top, dx: pad-left, dy: chart-top,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour))
    #place(left + top, dx: pad-left, dy: chart-top + chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour))

    // ====== Axis labels =====================================================
    #place(left + top,
      dx: pad-left + chart-width / 2 - 30pt,
      dy: chart-top + chart-height + pad-bottom - 8pt,
      box(width: 60pt, align(center,
        text(size: 8pt, fill: axis-colour)[#x-label])))
    #place(left + top,
      dx: -18pt, dy: chart-top + chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 8pt, fill: axis-colour)[#y-label]))

    // ====== Legend ==========================================================
    // Curves first; then one row per declared group with its actual marker
    // shape rendered as the swatch.
    #place(left + top,
      dx: pad-left + chart-width - legend-width - 8pt,
      dy: chart-top + 8pt,
      box(
        width: legend-width,
        fill: rgb(255, 255, 255, 200),
        inset: (x: 0.4em, y: 0.3em),
        radius: 2pt,
        stroke: 0.4pt + rgb("#ccc"),
        stack(dir: ttb, spacing: 0.4em,
          // Curve legend rows: line in its actual style
          ..datasets.map(ds =>
            stack(dir: ltr, spacing: 0.4em,
              line(length: 14pt, stroke: _stroke-for(ds.style, 1.5pt, ds.colour)),
              text(size: 8pt)[#ds.label]
            )
          ),
          // Group legend rows: marker in its actual shape
          ..groups.keys().map(g => {
            let (col, shape) = _group-style(groups.at(g), default-shape)
            // Render the swatch in a tiny fixed-size box so different shapes
            // line up vertically with each other.
            stack(dir: ltr, spacing: 0.4em,
              box(width: 14pt, height: 8pt)[
                #_marker(shape, marker-radius, col, 7pt, 4pt)
              ],
              text(size: 8pt)[#g]
            )
          })
        )
      )
    )
  ]
}


// #let sensitivity-xy-curve(
//   curves,
//   // --- Column selection (PR curve defaults) ---
//   x-col:  "pred_gt_recall",
//   y-col:  "pred_gt_precision",
//   // --- Axis labels ---
//   x-label: "Recall",
//   y-label: "Precision",
//   // --- Axis range (none = auto from data) ---
//   x-min: none,
//   x-max: none,
//   y-min: none,
//   y-max: none,
//   // --- Sorting ---
//   sort-by-x: true,
//   // --- Manual annotation points ---
//   // Each point: (name: "...", x: 130.0, y: 0.65, group: "shell")
//   points:      (),
//   // Map group name -> colour, e.g. ("shell": rgb("#ff3b4b"), "central": rgb("#008aac"))
//   groups:      (:),
//   // Marker styling for manual points
//   marker-radius:   2.2pt,
//   show-point-labels: true,
//   point-label-size:  6.5pt,
//   point-label-offset: (5pt, -4pt),  // dx, dy from marker centre
//   // --- Secondary (top) x-axis ---
//   // List of (position, label) tuples in the same units as the curve's x-axis.
//   // If empty, no secondary axis is drawn.
//   top-axis-ticks: (),
//   top-axis-label: none,
//   top-axis-pad:   28pt,             // vertical space reserved above the chart
//   top-tick-size:  7pt,
//   // --- Layout ---
//   chart-width:  320pt,
//   chart-height: 180pt,
//   pad-left:     36pt,
//   pad-bottom:   30pt,
//   legend-width: 140pt,
//   axis-colour:  rgb("#353535"),
//   tick-size:    7pt,
//   n-ticks:      10,
// ) = {
//   let col-index(headers, name) = headers.position(h => h == name)

//   let load-curve(path) = {
//     let data    = csv(path)
//     let headers = data.at(0)
//     let rows    = data.slice(1)
//     let xi = col-index(headers, x-col)
//     let yi = col-index(headers, y-col)
//     let pts = rows.map(r => (float(r.at(xi)), float(r.at(yi))))
//     if sort-by-x { pts.sorted(key: pt => pt.at(0)) } else { pts }
//   }

//   let datasets = curves.map(c => (
//     label:  c.label,
//     colour: c.colour,
//     points: load-curve(c.csv),
//   ))

//   // Compute axis bounds from all data (curves + manual points)
//   let all-x = datasets.map(d => d.points.map(p => p.at(0))).flatten()
//   let all-y = datasets.map(d => d.points.map(p => p.at(1))).flatten()
//   if points.len() > 0 {
//     all-x = all-x + points.map(p => p.x)
//     all-y = all-y + points.map(p => p.y)
//   }

//   let ax-xmin = if x-min != none { x-min } else { calc.min(..all-x) }
//   let ax-xmax = if x-max != none { x-max } else { calc.max(..all-x) }
//   let ax-ymin = if y-min != none { y-min } else { calc.min(..all-y) }
//   let ax-ymax = if y-max != none { y-max } else { calc.max(..all-y) }

//   // Whether the secondary axis is drawn dictates the top offset of the chart.
//   let has-top-axis = top-axis-ticks.len() > 0
//   let chart-top = if has-top-axis { top-axis-pad } else { 0pt }

//   // Map data values to canvas coordinates (chart top = chart-top)
//   let to-x(v) = pad-left + (v - ax-xmin) / (ax-xmax - ax-xmin) * chart-width
//   let to-y(v) = chart-top + chart-height * (1 - (v - ax-ymin) / (ax-ymax - ax-ymin))

//   let total-height = chart-top + chart-height + pad-bottom + 5pt

//   block(width: chart-width + pad-left + 10pt, height: total-height)[
//     #set align(left)

//     // ====== Primary grid and ticks ==========================================
//     #for i in range(n-ticks + 1) {
//       let tx = ax-xmin + i * (ax-xmax - ax-xmin) / n-ticks
//       let ty = ax-ymin + i * (ax-ymax - ax-ymin) / n-ticks

//       // Vertical gridline + bottom x tick
//       place(left + top, dx: to-x(tx), dy: chart-top,
//         line(start: (0pt, 0pt), end: (0pt, chart-height),
//              stroke: 0.4pt + rgb("#ddd")))
//       place(left + top, dx: to-x(tx) - 10pt, dy: chart-top + chart-height + 4pt,
//         box(width: 20pt, align(center,
//           text(size: tick-size, fill: axis-colour)[
//             #str(calc.round(tx, digits: if (ax-xmax - ax-xmin) > 10 { 0 } else { 1 }))
//           ])))

//       // Horizontal gridline + y tick
//       place(left + top, dx: pad-left, dy: to-y(ty),
//         line(length: chart-width, stroke: 0.4pt + rgb("#ddd")))
//       place(left + top, dx: 0pt, dy: to-y(ty) - 5pt,
//         text(size: tick-size, fill: axis-colour)[
//           #str(calc.round(ty, digits: 2))
//         ])
//     }

//     // ====== Secondary (top) x-axis ==========================================
//     #if has-top-axis {
//       // Top axis line, drawn just above the plot area
//       place(left + top, dx: pad-left, dy: chart-top,
//         line(length: chart-width, stroke: 0.8pt + axis-colour))

//       // User-supplied ticks: each is (position, label)
//       for entry in top-axis-ticks {
//         let pos = entry.at(0)
//         let lab = entry.at(1)
//         // Skip ticks outside the visible x range
//         if pos >= ax-xmin and pos <= ax-xmax {
//           // Short tick mark on the top axis
//           place(left + top, dx: to-x(pos), dy: chart-top - 3pt,
//             line(start: (0pt, 0pt), end: (0pt, 3pt),
//                  stroke: 0.6pt + axis-colour))
//           // Label above the tick
//           place(left + top,
//             dx: to-x(pos) - 20pt,
//             dy: chart-top - top-tick-size - 12pt,
//             box(width: 40pt, align(center,
//               text(size: top-tick-size, fill: axis-colour)[#lab])))
//         }
//       }

//       // Top axis label (above all the ticks)
//       if top-axis-label != none {
//         place(left + top,
//           dx: pad-left + chart-width / 2 - 60pt,
//           dy: 0pt,
//           box(width: 120pt, align(center,
//             text(size: 8pt, fill: axis-colour, weight: "bold")[#top-axis-label])))
//       }
//     }

//     // ====== Curves ==========================================================
//     #for ds in datasets {
//       let pts = ds.points
//       for i in range(pts.len() - 1) {
//         let (x0, y0) = pts.at(i)
//         let (x1, y1) = pts.at(i + 1)
//         place(left + top,
//           dx: to-x(x0), dy: to-y(y0),
//           line(
//             start: (0pt, 0pt),
//             end:   (to-x(x1) - to-x(x0), to-y(y1) - to-y(y0)),
//             stroke: 1.2pt + ds.colour
//           ))
//       }
//     }

//     // ====== Manual annotation points ========================================
//     #for p in points {
//       let g = p.at("group", default: none)
//       let col = if g != none and g in groups { groups.at(g) }
//                 else { axis-colour }

//       // Marker
//       place(top, //left + top,
//         dx: to-x(p.x),// - marker-radius,
//         dy: to-y(p.y),// - marker-radius,
//         circle(radius: marker-radius, fill: col, stroke: none))

//       // Label
//       if show-point-labels {
//         place(top, //left + top,
//           dx: to-x(p.x) - 10pt,// point-label-offset.at(0),
//           dy: to-y(p.y) - 6pt,//point-label-offset.at(1),
//           text(size: point-label-size, fill: col)[#p.name])
//       }
//     }

//     // ====== Plot-area axes (left + bottom) ==================================
//     #place(left + top, dx: pad-left, dy: chart-top,
//       line(start: (0pt, 0pt), end: (0pt, chart-height),
//            stroke: 0.8pt + axis-colour))
//     #place(left + top, dx: pad-left, dy: chart-top + chart-height,
//       line(length: chart-width, stroke: 0.8pt + axis-colour))

//     // ====== Axis labels =====================================================
//     #place(left + top,
//       dx: pad-left + chart-width / 2 - 30pt,
//       dy: chart-top + chart-height + pad-bottom - 8pt,
//       box(width: 60pt, align(center,
//         text(size: 8pt, fill: axis-colour)[#x-label])))
//     #place(left + top,
//       dx: -18pt, dy: chart-top + chart-height / 2 - 6pt,
//       rotate(-90deg, text(size: 8pt, fill: axis-colour)[#y-label]))

//     // ====== Legend ==========================================================
//     // Curves first; then one entry per declared group (with a filled marker
//     // swatch) so the reader can tell the manual points apart from the curves.
//     #place(left + top,
//       dx: pad-left + chart-width - legend-width - 8pt,
//       dy: chart-top + 8pt,
//       box(
//         width: legend-width,
//         fill: rgb(255, 255, 255, 200),
//         inset: (x: 0.4em, y: 0.3em),
//         radius: 2pt,
//         stroke: 0.4pt + rgb("#ccc"),
//         stack(dir: ttb, spacing: 0.4em,
//           ..datasets.map(ds =>
//             stack(dir: ltr, spacing: 0.4em,
//               line(length: 12pt, stroke: 1.5pt + ds.colour),
//               text(size: 8pt)[#ds.label]
//             )
//           ),
//           ..groups.keys().map(g =>
//             stack(dir: ltr, spacing: 0.4em,
//               circle(radius: 2.5pt, fill: groups.at(g), stroke: none),
//               text(size: 8pt)[#g]
//             )
//           )
//         )
//       )
//     )
//   ]
// }



// // #let sensitivity-xy-curve(
// //   curves,
// //   // --- Column selection (PR curve defaults) ---
// //   x-col:  "pred_gt_recall",
// //   y-col:  "pred_gt_precision",
// //   // --- Axis labels ---
// //   x-label: "Recall",
// //   y-label: "Precision",
// //   // --- Axis range (none = auto from data) ---
// //   x-min: none,
// //   x-max: none,
// //   y-min: none,
// //   y-max: none,
// //   // --- Sorting ---
// //   sort-by-x: true,        // set false if x is not monotone (e.g. threshold value)
// //   // --- Layout ---
// //   chart-width:  320pt,
// //   chart-height: 180pt,
// //   pad-left:     36pt,
// //   pad-bottom:   30pt,
// //   legend-width: 140pt,
// //   axis-colour:  rgb("#353535"),
// //   tick-size:    7pt,
// //   n-ticks:      10,
// // ) = {
// //   let col-index(headers, name) = headers.position(h => h == name)

// //   let load-curve(path) = {
// //     let data    = csv(path)
// //     let headers = data.at(0)
// //     let rows    = data.slice(1)
// //     let xi = col-index(headers, x-col)
// //     let yi = col-index(headers, y-col)
// //     let pts = rows.map(r => {
// //       let xv = float(r.at(xi))
// //       let yv = float(r.at(yi))
// //       (xv, yv)
// //     })
// //     if sort-by-x { pts.sorted(key: pt => pt.at(0)) }
// //     else { pts }
// //   }

// //   let datasets = curves.map(c => (
// //     label:  c.label,
// //     colour: c.colour,
// //     points: load-curve(c.csv),
// //   ))

// //   // Compute axis bounds from data if not specified
// //   let all-x = datasets.map(d => d.points.map(p => p.at(0))).flatten()
// //   let all-y = datasets.map(d => d.points.map(p => p.at(1))).flatten()

// //   let ax-xmin = if x-min != none { x-min } else { calc.min(..all-x) }
// //   let ax-xmax = if x-max != none { x-max } else { calc.max(..all-x) }
// //   let ax-ymin = if y-min != none { y-min } else { calc.min(..all-y) }
// //   let ax-ymax = if y-max != none { y-max } else { calc.max(..all-y) }

// //   // Map data values to canvas coordinates
// //   let to-x(v) = pad-left + (v - ax-xmin) / (ax-xmax - ax-xmin) * chart-width
// //   let to-y(v) = chart-height * (1 - (v - ax-ymin) / (ax-ymax - ax-ymin))

// //   block(width: chart-width + pad-left + 10pt,
// //         height: chart-height + pad-bottom + 5pt)[
// //     #set align(left)

// //     // Grid and ticks
// //     #for i in range(n-ticks + 1) {
// //       let tx = ax-xmin + i * (ax-xmax - ax-xmin) / n-ticks
// //       let ty = ax-ymin + i * (ax-ymax - ax-ymin) / n-ticks

// //       // Vertical gridline + x tick
// //       place(left + top, dx: to-x(tx), dy: 0pt,
// //         line(start: (0pt, 0pt), end: (0pt, chart-height),
// //              stroke: 0.4pt + rgb("#ddd")))
// //       place(left + top, dx: to-x(tx) - 10pt, dy: chart-height + 4pt,
// //         box(width: 20pt, align(center,
// //           text(size: tick-size, fill: axis-colour)[
// //             #str(calc.round(tx, digits: if (ax-xmax - ax-xmin) > 10 { 0 } else { 1 }))
// //           ])))

// //       // Horizontal gridline + y tick
// //       place(left + top, dx: pad-left, dy: to-y(ty),
// //         line(length: chart-width, stroke: 0.4pt + rgb("#ddd")))
// //       place(left + top, dx: 0pt, dy: to-y(ty) - 5pt,
// //         text(size: tick-size, fill: axis-colour)[
// //           #str(calc.round(ty, digits: 2))
// //         ])
// //     }

// //     // Curves
// //     #for ds in datasets {
// //       let pts = ds.points
// //       for i in range(pts.len() - 1) {
// //         let (x0, y0) = pts.at(i)
// //         let (x1, y1) = pts.at(i + 1)
// //         place(left + top,
// //           dx: to-x(x0), dy: to-y(y0),
// //           line(
// //             start: (0pt, 0pt),
// //             end:   (to-x(x1) - to-x(x0), to-y(y1) - to-y(y0)),
// //             stroke: 1.2pt + ds.colour
// //           ))
// //       }
// //     }

// //     // Axes
// //     #place(left + top, dx: pad-left, dy: 0pt,
// //       line(start: (0pt, 0pt), end: (0pt, chart-height),
// //            stroke: 0.8pt + axis-colour))
// //     #place(left + top, dx: pad-left, dy: chart-height,
// //       line(length: chart-width, stroke: 0.8pt + axis-colour))

// //     // Axis labels
// //     #place(left + top,
// //       dx: pad-left + chart-width / 2 - 15pt,
// //       dy: chart-height + pad-bottom - 8pt,
// //       text(size: 8pt, fill: axis-colour)[#x-label])
// //     #place(left + top,
// //       dx: -18pt, dy: chart-height / 2 - 6pt,
// //       rotate(-90deg, text(size: 8pt, fill: axis-colour)[#y-label]))

// //     // Legend
// //     #place(left + top,
// //       dx: pad-left + chart-width - legend-width - 8pt,
// //       dy: 8pt,
// //       box(
// //         width: legend-width,
// //         fill: rgb(255, 255, 255, 200),
// //         inset: (x: 0.4em, y: 0.3em),
// //         radius: 2pt,
// //         stroke: 0.4pt + rgb("#ccc"),
// //         stack(dir: ttb, spacing: 0.4em,
// //           ..datasets.map(ds =>
// //             stack(dir: ltr, spacing: 0.4em,
// //               line(length: 12pt, stroke: 1.5pt + ds.colour),
// //               text(size: 8pt)[#ds.label]
// //             )
// //           )
// //         )
// //       )
// //     )
// //   ]
// // }