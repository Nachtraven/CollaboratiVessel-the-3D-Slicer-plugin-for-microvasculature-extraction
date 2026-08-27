#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot, chart


// #let scatterplot-chart(csv-path, group-by, x-label, y-label) = {

//   // let file = sys.inputs.file
//   let data = csv(csv-path)
//   let hdrs = data.at(0)

//   let points = data.map(row => (float(row.x), float(row.y)))

//   align(center + horizon)[
//     #canvas({
//       import draw: *

//       plot.plot(
//         // The size of the plot. The page is set to auto so it will automatically
//         // scale the page to fit the plot.
//         size: (6.5, 6.5),
//         x-label: none,
//         y-label: none,
//         x-min: -0.2,
//         x-max: 1.2,
//         y-min: -0.2,
//         y-max: 1.2,
//         x-tick-step: 1,
//         y-tick-step: 1,
//         {
//             plot.add(
//                 points,
//                 style: (stroke: none),
//                 mark: "o",
//             )
//         }
//       )
//     })
//   ]
// }


// #import "@preview/cetz:0.3.2": canvas, draw
// #import "@preview/cetz-plot:0.1.1": plot



#let scatterplot-chart(
  csv-path,
  x-col: "volume_voxels",
  y-col: "length_mm",
  group-col: "method",
  x-label: "X",
  y-label: "Y",
) = {
  let data = csv(csv-path)
  let hdrs = data.at(0)
  let rows = data.slice(1)

  let xi = hdrs.position(h => h == x-col)
  let yi = hdrs.position(h => h == y-col)
  let gi = hdrs.position(h => h == group-col)

  // Group rows by the group-col, building one list of points per group
  let groups = (:)
  for row in rows {
    let g = row.at(gi)
    let pt = (float(row.at(xi)), float(row.at(yi)))
    if g in groups {
      groups.at(g).push(pt)
    } else {
      groups.insert(g, (pt,))
    }
  }

  // Compute axis limits from data
  let all-x = rows.map(r => float(r.at(xi)))
  let all-y = rows.map(r => float(r.at(yi)))
  let x-max = calc.max(..all-x) * 1.1
  let y-max = calc.max(..all-y) * 1.1

  // Colour palette per group
  // let palette = (rgb("#003f5c"), rgb("#ef537d"), rgb("#ffa600"),
  //                rgb("#78529b"), rgb("#2a9d8f"))
  let palette = (
    rgb(0, 63, 92, 40),      // alpha 40 / 255 ≈ 15%
    rgb(239, 83, 125, 40),
    rgb(255, 166, 0, 40),
    rgb(120, 82, 155, 40),
    rgb(42, 157, 143, 40),
  )

  align(center + horizon)[
    #canvas({
      import draw: *
      plot.plot(
        size: (7, 5),
        x-label: x-label,
        y-label: y-label,
        x-mode: "log",
        x-min: 1.0,           // log scale needs positive min — start at 1 voxel
        x-max: x-max,
        y-mode: "log",
        y-min: 0.01,
        y-max: y-max,
        {
          let i = 0
          for (name, pts) in groups.pairs() {
            plot.add(
              pts,
              style: (stroke: none),
              mark: "o",
              mark-size: 0.15,
              mark-style: (fill: palette.at(calc.rem(i, palette.len())),
                          stroke: none),
              label: name,
            )
            i = i + 1
          }
        }
      )
    })
  ]
}
