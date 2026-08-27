// vessel-seed-chart.typ
// Bar chart showing correctly vs missed vessel and background seed points.
// Each sample has one group of bars: vessel-correct, vessel-missed,
// bg-correct, bg-missed — stacked pairs side by side.
// Green = correct, transparent red = missed.

#let vessel-seed-chart(
  samples,               // list of (name, csv, row)
  // --- Layout ---
  chart-width:    460pt,
  chart-height:   180pt,
  chart-pad-left: 36pt,
  group-gap:      16pt,
  bar-gap:        3pt,
  legend-height:  22pt,
  bottom-height:  32pt,
  // --- Colours ---
  col-correct:    rgb("#2a9d8f"),           // teal green — correctly predicted
  col-missed:     rgb("#e63946").transparentize(55%), // translucent red — missed
  col-vessel-bg:  rgb("#eaf3ff"),           // subtle fill behind vessel bars
  col-bg-bg:      rgb("#fff8ee"),           // subtle fill behind background bars
  axis-colour:    rgb("#555"),
  label-size:     8pt,
  tick-size:      7pt,
  n-ticks:        5,
) = {

  let load-row(csv-path, row-idx) = {
    let data = csv(csv-path)
    let hdrs = data.at(0)
    let rows = data.slice(1)
    let ci(name) = hdrs.position(h => h == name)
    let row = rows.at(row-idx)
    (
      vc: int(float(row.at(ci("vessel_seeds_correct")))),
      vt: int(float(row.at(ci("vessel_seeds_total")))),
      bc: int(float(row.at(ci("bg_seeds_correct")))),
      bt: int(float(row.at(ci("bg_seeds_total")))),
    )
  }

  let sample-data = samples.map(s => {
    let r = load-row(s.csv, s.row)
    (
      name: s.name,
      vc: r.vc, vm: r.vt - r.vc,   // vessel correct / missed
      bc: r.bc, bm: r.bt - r.bc,   // bg correct / missed
      vt: r.vt, bt: r.bt,
    )
  })

  // Y-axis max = highest total seed count across all samples
  let y-max = calc.max(
    ..sample-data.map(s => calc.max(s.vt, s.bt))
  )

  let y-tick-step = y-max / (n-ticks - 1)
  let y-ticks = range(n-ticks).map(i => i * y-tick-step)

  let n-groups  = samples.len()
  let plot-width = chart-width - chart-pad-left
  // Each group has 2 stacked bars (vessel pair + bg pair), each pair is 2 bars wide
  let n-bar-pairs = 2
  let pair-width  = (plot-width - group-gap * (n-groups + 1)) / n-groups / n-bar-pairs
  let bar-width   = (pair-width - bar-gap) / 2

  let total-height = chart-height + legend-height + bottom-height

  block(width: chart-width + 20pt, height: total-height)[
    #set align(left)

    // Legend
    #place(left + top, dx: chart-pad-left, dy: 0pt,
      stack(dir: ltr, spacing: 1.4em,
        stack(dir: ltr, spacing: 0.4em,
          rect(width: 10pt, height: 10pt, fill: col-correct, stroke: none),
          text(size: label-size, fill: axis-colour)[Correct]),
        stack(dir: ltr, spacing: 0.4em,
          rect(width: 10pt, height: 10pt, fill: col-missed, stroke: none),
          text(size: label-size, fill: axis-colour)[Missed]),
        stack(dir: ltr, spacing: 0.4em,
          rect(width: 10pt, height: 8pt, fill: col-vessel-bg,
               stroke: 0.4pt + col-correct.transparentize(40%)),
          text(size: label-size, fill: axis-colour)[Vessel seeds]),
        stack(dir: ltr, spacing: 0.4em,
          rect(width: 10pt, height: 8pt, fill: col-bg-bg,
               stroke: 0.4pt + orange.transparentize(40%)),
          text(size: label-size, fill: axis-colour)[Background seeds]),
      )
    )

    // Y-axis label
    #place(left + top,
      dx: -14pt, dy: legend-height + chart-height / 2 - 6pt,
      rotate(-90deg, text(size: 9pt, fill: axis-colour)[Seed count]))

    // Y-axis ticks and gridlines
    #for tick in y-ticks {
      let y-pos = legend-height + chart-height * (1 - tick / y-max)
      place(left + top, dx: chart-pad-left, dy: y-pos,
        line(length: plot-width, stroke: 0.4pt + rgb("#ddd")))
      place(left + top, dx: 0pt, dy: y-pos - 5pt,
        box(width: chart-pad-left - 2pt, align(right,
          text(size: tick-size, fill: axis-colour)[
            #str(int(calc.round(tick, digits: 0)))
          ])))
    }

    // Bars
    #for (gi, s) in sample-data.enumerate() {
      let group-x = chart-pad-left + group-gap + gi * (plot-width / n-groups)

      // Vessel pair: correct stacked on missed (from bottom)
      let vx = group-x
      // Background tint behind vessel pair
      place(left + top,
        dx: vx - 1pt,
        dy: legend-height,
        rect(width: pair-width + 2pt, height: chart-height,
             fill: col-vessel-bg, stroke: none))

      // Vessel missed (bottom, transparent red)
      let vm-h = chart-height * (s.vm / y-max)
      let vc-h = chart-height * (s.vc / y-max)
      place(left + top,
        dx: vx, dy: legend-height + chart-height - vm-h - vc-h,
        rect(width: pair-width - bar-gap, height: vc-h,
             fill: col-correct, stroke: none))
      place(left + top,
        dx: vx, dy: legend-height + chart-height - vm-h,
        rect(width: pair-width - bar-gap, height: vm-h,
             fill: col-missed, stroke: none))

      // Background pair
      let bx = group-x + pair-width + bar-gap
      place(left + top,
        dx: bx - 1pt,
        dy: legend-height,
        rect(width: pair-width + 2pt, height: chart-height,
             fill: col-bg-bg, stroke: none))

      let bm-h = chart-height * (s.bm / y-max)
      let bc-h = chart-height * (s.bc / y-max)
      place(left + top,
        dx: bx, dy: legend-height + chart-height - bm-h - bc-h,
        rect(width: pair-width - bar-gap, height: bc-h,
             fill: col-correct, stroke: none))
      place(left + top,
        dx: bx, dy: legend-height + chart-height - bm-h,
        rect(width: pair-width - bar-gap, height: bm-h,
             fill: col-missed, stroke: none))

      // Sample label below bars
      place(left + top,
        dx: group-x + (pair-width * 2 + bar-gap) / 2 - 36pt,
        dy: legend-height + chart-height + 6pt,
        box(width: 72pt, align(center,
          text(size: label-size, fill: axis-colour)[#s.name])))

      // V / BG sub-labels
      place(left + top,
        dx: vx + pair-width / 2 - 8pt,
        dy: legend-height + chart-height + 18pt,
        text(size: 6pt, fill: axis-colour.lighten(20%))[V])
      place(left + top,
        dx: bx + pair-width / 2 - 8pt,
        dy: legend-height + chart-height + 18pt,
        text(size: 6pt, fill: axis-colour.lighten(20%))[BG])
    }

    // Axes
    #place(left + top, dx: chart-pad-left, dy: legend-height,
      line(start: (0pt, 0pt), end: (0pt, chart-height),
           stroke: 0.8pt + axis-colour))
    #place(left + top, dx: chart-pad-left, dy: legend-height + chart-height,
      line(length: plot-width, stroke: 0.8pt + axis-colour))
  ]
}