// draw-pr-or-recall.typ
// Shows precision and/or recall per sample for tool vs threshold.
// Optional annotation above each bar for a complementary metric.

#let draw-pr-or-recall(samples, maximum: 1.0, y-label: "Score",
               metrics: (
                 (key: "tool_precision", colour: rgb("#003f5c"), label: "Tool Precision"),
                 (key: "thr_precision",  colour: rgb("#78529b"), label: "Thr Precision"),
                 (key: "tool_recall",    colour: rgb("#ef537d"), label: "Tool Recall"),
                 (key: "thr_recall",     colour: rgb("#ffa600"), label: "Thr Recall"),
               ),
               annotate-col: none,
               annotate-label: none,
               annotate-digits: 2,
               ) = {

  // Helpers -----------------------------------------------------------------
  let load-cell-val(csv-path, row-idx, col-name) = {
    let data = csv(csv-path)
    let hdrs = data.at(0)
    let rows = data.slice(1)
    let i = hdrs.position(h => h == col-name)
    float(rows.at(row-idx).at(i))
  }

  // Per-sample metric values. The four bars per sample read precision and
  // recall from each of the two CSVs (tool and threshold).
  let sample-values = samples.map(s => (
    name: s.name,
    values: (
      tool_precision: load-cell-val(s.tool_csv, s.tool_row, "pred_gt_precision"),
      thr_precision:  load-cell-val(s.thr_csv,  s.thr_row,  "pred_gt_precision"),
      tool_recall:    load-cell-val(s.tool_csv, s.tool_row, "pred_gt_recall"),
      thr_recall:     load-cell-val(s.thr_csv,  s.thr_row,  "pred_gt_recall"),
    ),
    annot: if annotate-col == none { none } else {(
      tool_precision: load-cell-val(s.tool_csv, s.tool_row, annotate-col),
      thr_precision:  load-cell-val(s.thr_csv,  s.thr_row,  annotate-col),
      tool_recall:    load-cell-val(s.tool_csv, s.tool_row, annotate-col),
      thr_recall:     load-cell-val(s.thr_csv,  s.thr_row,  annotate-col),
    )},
  ))

  // Layout ------------------------------------------------------------------
  let chart-width    = 460pt
  let chart-height   = 200pt
  let chart-pad-left = 36pt
  let legend-height  = 22pt
  let group-gap      = 14pt
  let bar-gap        = 2pt
  let n-ticks        = 5
  let axis-colour    = rgb("#555")
  let annot-colour   = rgb("#222")
  let tick-size      = 8pt
  let label-size     = 8pt
  let annot-size     = 6pt

  let annot-headroom = if annotate-col != none { 12pt } else { 0pt }

  let y-max       = maximum
  let y-tick-step = y-max / (n-ticks - 1)
  let y-ticks     = range(n-ticks).map(i => i * y-tick-step)

  let n-groups    = samples.len()
  let n-bars      = metrics.len()
  let plot-width  = chart-width - chart-pad-left
  let group-width = (plot-width - group-gap * (n-groups + 1)) / n-groups
  let bar-width   = (group-width - bar-gap * (n-bars - 1)) / n-bars

  // Chart -------------------------------------------------------------------
  block(width: chart-width + 20pt,
        height: chart-height + legend-height + 40pt + annot-headroom)[
    #set align(left)

    // Top legend
    #place(left + top,
      dx: chart-pad-left, dy: 0pt,
      stack(dir: ltr, spacing: 1.2em,
        ..metrics.map(m =>
          stack(dir: ltr, spacing: 0.4em,
            rect(width: 10pt, height: 10pt, fill: m.colour, stroke: none),
            text(size: label-size, fill: axis-colour)[#m.label]
          )
        )
      )
    )

    // Annotation key label
    #if annotate-col != none and annotate-label != none {
      place(left + top,
        dx: chart-pad-left + plot-width - 140pt, dy: 4pt,
        align(right, text(size: 7pt, fill: annot-colour,
          style: "italic")[Number above bar: #annotate-label])
      )
    }

    // Y-axis label
    #place(left + top,
      dx: -16pt, dy: legend-height + annot-headroom + chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 9pt, fill: axis-colour)[#y-label])
    )

    // Y-axis ticks and gridlines
    #for tick in y-ticks {
      let y-pos = legend-height + annot-headroom + chart-height * (1 - tick / y-max)
      place(left + top, dx: chart-pad-left, dy: y-pos,
        line(length: plot-width, stroke: 0.4pt + rgb("#ddd"))
      )
      place(left + top, dx: 0pt, dy: y-pos - 5pt,
        text(size: tick-size, fill: axis-colour)[#str(calc.round(tick, digits: 2))]
      )
    }

    // Bars and per-group sample labels
    #for (gi, sample) in sample-values.enumerate() {
      let group-x = chart-pad-left + group-gap + gi * (group-width + group-gap)

      place(left + top,
        dx: group-x + group-width / 2 - 40pt,
        dy: legend-height + annot-headroom + chart-height + 6pt,
        box(width: 80pt, align(center,
          text(size: label-size, fill: axis-colour)[#sample.name]
        ))
      )

      for (bi, m) in metrics.enumerate() {
        let val   = sample.values.at(m.key)
        let bar-h = chart-height * (val / y-max)
        let bar-x = group-x + bi * (bar-width + bar-gap)
        let bar-y = legend-height + annot-headroom + chart-height - bar-h

        place(left + top,
          dx: bar-x, dy: bar-y,
          rect(width: bar-width, height: bar-h, fill: m.colour, stroke: none)
        )

        if sample.annot != none {
          let annot-val = sample.annot.at(m.key)
          place(left + top,
            dx: bar-x + bar-width / 2 - 14pt,
            dy: bar-y - 10pt,
            box(width: 28pt, align(center,
              text(size: annot-size, fill: annot-colour, weight: "bold")[
                #calc.round(annot-val, digits: annotate-digits)
              ]
            ))
          )
        }
      }
    }

    // Axes
    #place(left + top, dx: chart-pad-left, dy: legend-height + annot-headroom,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour)
    )
    #place(left + top, dx: chart-pad-left,
                       dy: legend-height + annot-headroom + chart-height,
      line(length: plot-width, stroke: 0.8pt + axis-colour)
    )
  ]
}