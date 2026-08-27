// --- Configuration ---
#let csv-data = csv("./results.csv")
#let headers = csv-data.at(0)
#let rows = csv-data.slice(1)



#let results-chart(series, maximum, y-label, derived-series: ()) = {
  let x-col = "chunk_name"

  let col-index(name) = headers.position(h => h == name)
  let cell-val(row, name) = float(row.at(col-index(name)))
  let cell-ratio(row, num, den) = {
    let d = cell-val(row, den)
    if d == 0.0 { 0.0 } else { cell-val(row, num) / d }
  }

  // Merge direct and derived series into a unified list for rendering.
  // Direct series: (col, colour, label)
  // Derived series: (num-col, den-col, colour, label)
  // Normalised to (value-fn, colour, label) for the bar loop.
  let all-series = (
    ..series.map(s => (
      val:    row => cell-val(row, s.col),
      colour: s.colour,
      label:  s.label,
    )),
    ..derived-series.map(s => (
      val:    row => cell-ratio(row, s.num, s.den),
      colour: s.colour,
      label:  s.label,
    )),
  )

  let chart-width   = 420pt
  let chart-height  = 180pt
  let bar-group-gap = 18pt
  let bar-gap       = 2pt
  let n-ticks       = 5
  let legend-width  = 110pt
  let axis-colour   = rgb("555")
  let label-size    = 9pt
  let tick-size     = 9pt

  let y-max       = maximum
  let y-tick-step = y-max / (n-ticks - 1)
  let y-ticks     = range(n-ticks).map(i => i * y-tick-step)

  let n-groups    = rows.len()
  let n-bars      = all-series.len()
  let group-width = (chart-width - bar-group-gap * (n-groups + 1)) / n-groups
  let bar-width   = (group-width - bar-gap * (n-bars - 1)) / n-bars

  block(width: chart-width + 40pt, height: chart-height + 25pt)[
    #set align(left)

    #place(left + top,
      dx: -20pt, dy: chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 10pt, fill: axis-colour)[#y-label])
    )

    #for tick in y-ticks {
      let y-pos = chart-height * (1 - tick / y-max)
      place(left + top, dx: 30pt, dy: y-pos,
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd"))
      )
      place(left + top, dx: 0pt, dy: y-pos - 5pt,
        text(size: tick-size, fill: axis-colour)[#str(tick)]
      )
    }

    #for (gi, row) in rows.enumerate() {
      let group-x = 30pt + bar-group-gap + gi * (group-width + bar-group-gap)
      let x-label = row.at(col-index(x-col))

      place(left + top,
        dx: group-x + group-width / 2 - 20pt,
        dy: chart-height + 6pt,
        box(width: 40pt, align(center,
          text(size: label-size, fill: axis-colour)[#x-label]
        ))
      )

      for (bi, s) in all-series.enumerate() {
        let val   = (s.val)(row)
        let bar-h = chart-height * (val / y-max)
        let bar-x = group-x + bi * (bar-width + bar-gap)
        place(left + top,
          dx: bar-x, dy: chart-height - bar-h,
          rect(width: bar-width, height: bar-h, fill: s.colour, stroke: none)
        )
      }
    }

    #place(left + top, dx: 30pt, dy: 0pt,
      line(start: (0pt, 0pt), end: (0pt, chart-height), stroke: 0.8pt + axis-colour)
    )
    #place(left + top, dx: 30pt, dy: chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour)
    )

    #place(left + top,
      dx: 35pt + chart-width - legend-width - 8pt,
      dy: -5pt,
      box(
        width: legend-width,
        fill: rgb(255, 255, 255, 200),
        inset: (x: 0.4em, y: 0.3em),
        radius: 2pt,
        stroke: 0.4pt + rgb("#ccc"),
        stack(dir: ttb, spacing: 0.4em,
          ..all-series.map(s =>
            stack(dir: ltr, spacing: 0.4em,
              rect(width: 10pt, height: 10pt, fill: s.colour, stroke: none),
              text(size: 8pt)[#(s.label)]
            )
          )
        )
      )
    )
  ]
}
















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
