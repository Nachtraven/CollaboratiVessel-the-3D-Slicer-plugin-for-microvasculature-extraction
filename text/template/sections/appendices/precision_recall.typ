#let xy-curve(
  curves,
  x-label: "Recall",
  y-label: "Precision",
  chart-width:200pt,
  chart-height:200pt,
  pad-left: 36pt,
  pad-bottom: 30pt,
  legend-width: 120pt,
  show-legend: true
) = {
  // let chart-width  = 300pt
  // let chart-height = 300pt
  // let pad-left     = 36pt
  // let pad-bottom   = 30pt
  // let legend-width = 120pt
  let axis-colour  = rgb("#555")
  let tick-size    = 7pt
  let n-ticks      = 5

  let col-index(hdrs, name) = hdrs.position(h => h == name)

  // Resolve an axis descriptor against a row.
  // (col: "name")              → direct float value
  // (num: "a", den: "b")       → ratio, 0 if denominator is 0
  let resolve(hdrs, row, axis) = {
    if "col" in axis {
      float(row.at(col-index(hdrs, axis.col)))
    } else {
      let n = float(row.at(col-index(hdrs, axis.num)))
      let d = float(row.at(col-index(hdrs, axis.den)))
      if d == 0.0 { 0.0 } else { n / d }
    }
  }

  // Default axis descriptors matching classic PR curve behaviour.
  let default-x = (col: "pred_gt_recall")
  let default-y = (col: "pred_gt_precision")

  let load-curve(c) = {
    let data = csv(c.csv)
    let hdrs = data.at(0)
    let rows = data.slice(1)
    let x-axis = c.at("x", default: default-x)
    let y-axis = c.at("y", default: default-y)
    let pts = rows.map(r => (resolve(hdrs, r, x-axis), resolve(hdrs, r, y-axis)))
    pts.sorted(key: pt => pt.at(0))
  }

  let datasets = curves.map(c => (
    label:  c.label,
    colour: c.colour,
    dashed: c.at("dashed", default: false),
    points: load-curve(c),
  ))

  let to-x(v) = pad-left + v * chart-width
  let to-y(v) = chart-height * (1 - v)

  block(width: chart-width + pad-left + 10pt,
        height: chart-height + pad-bottom + 20pt)[
    #set align(left)

    // Grid and ticks
    #for i in range(n-ticks + 1) {
      let v     = i / n-ticks
      let xp    = to-x(v)
      let yp    = to-y(v)
      place(left + top, dx: xp, dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, chart-height),
             stroke: 0.4pt + rgb("#ddd"))
      )
      place(left + top, dx: xp - 6pt, dy: chart-height + 4pt,
        text(size: tick-size, fill: axis-colour)[#str(calc.round(v, digits: 1))]
      )
      place(left + top, dx: pad-left, dy: yp,
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd"))
      )
      place(left + top, dx: 0pt, dy: yp - 5pt,
        text(size: tick-size, fill: axis-colour)[#str(calc.round(v, digits: 1))]
      )
    }

    // Curves
    #for ds in datasets {
      let st = if ds.dashed {
        stroke(paint: ds.colour, thickness: 1.2pt, dash: "dashed")
      } else {
        stroke(paint: ds.colour, thickness: 1.2pt)
      }
      for i in range(ds.points.len() - 1) {
        let (x0, y0) = ds.points.at(i)
        let (x1, y1) = ds.points.at(i + 1)
        place(left + top,
          dx: to-x(x0), dy: to-y(y0),
          line(start: (0pt, 0pt),
               end: (to-x(x1) - to-x(x0), to-y(y1) - to-y(y0)),
               stroke: st)
        )
      }
    }

    // Axes
    #place(left + top, dx: pad-left, dy: 0pt,
      line(start: (0pt, 0pt), end: (0pt, chart-height), stroke: 0.8pt + axis-colour)
    )
    #place(left + top, dx: pad-left, dy: chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour)
    )

    // Axis labels
    #place(left + top,
      dx: pad-left + chart-width / 2 - 15pt,
      dy: chart-height + pad-bottom + 15pt,
      text(size: 8pt, fill: axis-colour)[#x-label]
    )
    #place(left + top,
      dx: -24pt, dy: chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 8pt, fill: axis-colour)[#y-label])
    )

    #if show-legend {
    // Legend
      place(left + top,
        dx: 35pt + chart-width - legend-width - 8pt,
        dy: 15pt,
        box(
          width: legend-width,
          fill: rgb(255, 255, 255, 200),
          inset: (x: 0.4em, y: 0.3em),
          radius: 2pt,
          stroke: 0.4pt + rgb("#ccc"),
          stack(dir: ttb, spacing: 0.4em,
            ..datasets.map(ds =>
              stack(dir: ltr, spacing: 0.4em,
                if ds.dashed {
                  line(length: 12pt, stroke: stroke(
                    paint: ds.colour, thickness: 1.5pt, dash: "dashed"))
                } else {
                  line(length: 12pt, stroke: 1.5pt + ds.colour)
                },
                text(size: 8pt)[#ds.label]
              )
            )
          )
        )
      )
    }
  ]
}
