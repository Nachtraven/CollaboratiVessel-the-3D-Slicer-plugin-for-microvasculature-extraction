#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot, chart

#let vessel-length-distribution(
  csv-path,
  method-col: "method",
  length-col: "length_mm",
  variant-filter: none,
  bins: 30,
  log-scale: true,
) = {
  let data = csv(csv-path)
  let hdrs = data.at(0)
  let rows = data.slice(1)
  let mi = hdrs.position(h => h == method-col)
  let vi = hdrs.position(h => h == "variant")
  let li = hdrs.position(h => h == length-col)


  let display-name(method, variant) = {
    if variant == "" or variant == none { method }
    else if method == "pipeline" { variant }    // drop "pipeline_" prefix
    else if method == "threshold" { "threshold" }
    else { method + ":" + variant }
  }

  // Group lengths by (method, variant)
  let groups = (:)
  let group-labels = (:)

  for row in rows {
    let m = row.at(mi)
    let v = row.at(vi)              // variant column
    let l = float(row.at(li))
    if l <= 0 { continue }
    if variant-filter != none and m == "pipeline" and v not in variant-filter {
      continue
    }

    // Composite key: "pipeline_default", "pipeline_vsize_-1", "threshold_best_dice"
    let key = if v == "" or v == none { m } else { m + "_" + v }
    if key in groups {
      groups.at(key).push(l)
    } else {
      groups.insert(key, (l,))
      group-labels.insert(key, display-name(m, v))

    }
  }

  // Compute shared log-spaced bins from all data
  let all-lengths = rows.map(r => float(r.at(li))).filter(l => l > 0)
  let l-min = calc.max(0.001, calc.min(..all-lengths))
  let l-max = calc.max(..all-lengths) * 1.1

  // Build a histogram for one group: returns list of (bin-center, count)
  let make-hist(values) = {
    let log-min = calc.log(l-min)
    let log-max = calc.log(l-max)
    let step    = (log-max - log-min) / bins
    let counts  = range(bins).map(_ => 0)
    for v in values {
      let bi = calc.min(bins - 1,
                  calc.max(0, int((calc.log(v) - log-min) / step)))
      counts.at(bi) = counts.at(bi) + 1
    }
    range(bins).map(i => (
      calc.pow(10.0, log-min + (i + 0.5) * step),
      counts.at(i)
    ))
  }

  let palette-base = (
    "ground_truth":      rgb("#2a9d8f"),
    "threshold":         rgb("#e63946"),
    "pipeline_default":  rgb("#003f5c"),
  )
  let variant-palette = (
    rgb("#457b9d"), rgb("#78529b"), rgb("#ef537d"),
    rgb("#ffa600"), rgb("#1d3557"), rgb("#06a77d"),
    rgb("#bc4749"), rgb("#7c9885"), rgb("#d4a373"),
  )


  let max-count = calc.max(..groups.values().map(vs => make-hist(vs).map(p => p.at(1))).flatten())

  align(center)[
    #canvas({
      import draw: *
      plot.plot(
        size: (10, 5),
        x-label: "Vessel length (mm)",
        y-label: "Vessel count",
        x-mode: "log",
        x-min: l-min,
        x-max: l-max,
        y-min: 0.01,
        y-max: max-count * 1.1,
        // y-mode:"log",
        {
          let i = 0
          for (name, _) in groups.pairs() {
            let col = if name in palette-base {
              palette-base.at(name)
            } else {
              variant-palette.at(calc.rem(i, variant-palette.len()))
            }
            plot.add(
              make-hist(groups.at(name)),
              style: (stroke: 1.5pt + col),
              mark: "o",
              mark-size: 0.08,
              mark-style: (fill: col, stroke: none),
              label: group-labels.at(name), //label: name,    // ← consider replacing with shorter display label
            )
            i = i + 1
          }
        }
      )
    })
  ]
}
