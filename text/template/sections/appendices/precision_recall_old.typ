#let pr-curve(
  curves,                               // array of (csv-path, label, colour)
  precision-col: "pred_gt_precision",
  recall-col:    "pred_gt_recall",
) = {

  let chart-width  = 300pt
  let chart-height = 300pt
  let pad-left     = 36pt
  let pad-bottom   = 30pt
  let legend-width = 110pt
  let axis-colour  = rgb("#555")
  let tick-size    = 7pt
  let n-ticks      = 5

  let col-index(headers, name) = headers.position(h => h == name)

  let load-curve(path) = {
    let data    = csv(path)
    let headers = data.at(0)
    let rows    = data.slice(1)
    let pi = col-index(headers, precision-col)
    let ri = col-index(headers, recall-col)
    let pts = rows.map(r => (float(r.at(ri)), float(r.at(pi))))
    pts.sorted(key: pt => pt.at(0))  // sort by recall (x)
  }

  let datasets = curves.map(c => (
    label:  c.at(1),
    colour: c.at(2),
    points: load-curve(c.at(0)),
  ))

  let to-x(r) = pad-left + r * chart-width
  let to-y(p) = chart-height * (1 - p)  // y=0 is top in Typst

  block(width: chart-width + pad-left + 10pt,
        height: chart-height + pad-bottom + 20pt)[
    #set align(left)

    // Grid and ticks
    #for i in range(n-ticks + 1) {
      let v     = i / n-ticks
      let x-pos = to-x(v)
      let y-pos = to-y(v)

      // Vertical gridline + x tick
      place(left + top, dx: x-pos, dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, chart-height),
             stroke: 0.4pt + rgb("#ddd"))
      )
      place(left + top, dx: x-pos - 6pt, dy: chart-height + 4pt,
        text(size: tick-size, fill: axis-colour)[#str(calc.round(v, digits: 1))]
      )

      // Horizontal gridline + y tick
      place(left + top, dx: pad-left, dy: y-pos,
        line(length: chart-width, stroke: 0.4pt + rgb("#ddd"))
      )
      place(left + top, dx: 0pt, dy: y-pos - 5pt,
        text(size: tick-size, fill: axis-colour)[#str(calc.round(v, digits: 1))]
      )
    }

    // Curve lines
    #for ds in datasets {
      let pts = ds.points
      for i in range(pts.len() - 1) {
        let (r0, p0) = pts.at(i)
        let (r1, p1) = pts.at(i + 1)
        place(left + top,
          dx: to-x(r0), dy: to-y(p0),
          line(
            start: (0pt, 0pt),
            end:   (to-x(r1) - to-x(r0), to-y(p1) - to-y(p0)),
            stroke: 1.2pt + ds.colour
          )
        )
      }
    }

    // Axes
    #place(left + top, dx: pad-left, dy: 0pt,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour)
    )
    #place(left + top, dx: pad-left, dy: chart-height,
      line(length: chart-width, stroke: 0.8pt + axis-colour)
    )

    // Axis labels
    #place(left + top,
      dx: pad-left + chart-width / 2 - 15pt,
      dy: chart-height + pad-bottom - 8pt,
      text(size: 8pt, fill: axis-colour)[Recall]
    )
    #place(left + top,
      dx: -14pt,
      dy: chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 8pt, fill: axis-colour)[Precision])
    )

    // Legend
    #place(left + top,
      // dx: pad-left + chart-width - legend-width - 8pt,
      // dy: chart-height - datasets.len() * 18pt - 8pt,
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
              line(length: 12pt, stroke: 1.5pt + ds.colour),
              text(size: 8pt)[#ds.label]
            )
          )
        )
      )
    )
  ]
}