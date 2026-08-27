// Matching quality illustration.
// Three columns: good matching (left), reference/GT (center), poor matching (right).

#let matching-illustration(
  gt-nodes:   (3, 2, 2, 1, 1, 2, 1, 1),
  good-nodes: (
    (3, (0,)),
    (2, (1, 2)),
    (1, (3,)),
    (1, (4,)),
    (2, (5,)),
    (1, (6,)),
    (1, (7, 2)),
    (1, ()),
  ),
  poor-nodes: (
    (1, (0,)),
    (1, (0,)),
    (1, (0,)),
    (1, (1,)),
    (1, (1,)),
    (1, (2,)),
    (1, (2,)),
    (1, (3,)),
    (1, (5,)),
    (1, ()),
    (1, ()),
    (1, ()),
    (1, ()),
  ),
  col-gt:        rgb("#2a9d8f"),
  col-good:      rgb("#457b9d"),
  col-poor:      rgb("#e63946"),
  col-unmatched: rgb("#656565"),
  col-line-good: rgb("#457b9d"),
  col-line-poor: rgb("#e63946"),
  line-opacity:  0.45,
  width:         420pt,
  height:        260pt,
  node-scale:    5pt,
  label-size:    8pt,
) = {
  let cx-gt   = width / 2
  let cx-good = width / 2 - width / 3
  let cx-poor = width / 2 + width / 3

  let col-y(i, n) = {
    let margin = 20pt
    if n <= 1 { height / 2 }
    else { margin + i * (height - 2 * margin) / (n - 1) }
  }

  let pos-gt = gt-nodes.enumerate().map(((i, sz)) => (
    x: cx-gt, y: col-y(i, gt-nodes.len()), sz: sz, matched: true,
  ))

  let pos-good = good-nodes.enumerate().map(((i, node)) => {
    let (sz, ids) = node
    (x: cx-good, y: col-y(i, good-nodes.len()),
     sz: sz, ids: ids, matched: ids.len() > 0)
  })

  let pos-poor = poor-nodes.enumerate().map(((i, node)) => {
    let (sz, ids) = node
    let x-off = if ids.len() == 0 { -16pt } else { 0pt }
    (x: cx-poor + x-off, y: col-y(i, poor-nodes.len()),
     sz: sz, ids: ids, matched: ids.len() > 0)
  })

  // Compute stats for column headers
  let n-gt = gt-nodes.len()
  let good-matched-gt = pos-good.fold((), (acc, n) => acc + n.ids).dedup().len()
  let poor-matched-gt = pos-poor.fold((), (acc, n) => acc + n.ids).dedup().len()
  let good-unmatched  = pos-good.filter(n => not n.matched).len()
  let poor-unmatched  = pos-poor.filter(n => not n.matched).len()

  // Mean correspondence: for each matched GT vessel, how many predictions point to it?
  let mean-corr(pos) = {
    let gt-counts = (:)
    for n in pos {
      for gid in n.ids {
        let k = str(gid)
        gt-counts.insert(k, gt-counts.at(k, default: 0) + 1)
      }
    }
    let vals = gt-counts.values()
    if vals.len() == 0 { 0.0 }
    else { vals.fold(0, (a, b) => a + b) / vals.len() }
  }
  let good-mean-corr = calc.round(mean-corr(pos-good), digits: 2)
  let poor-mean-corr = calc.round(mean-corr(pos-poor), digits: 2)

  block(width: width, height: height + 52pt)[
    #set align(left)

    // Column header stats
    #for (cx, matched-gt, unmatched, mean-corr, col) in (
      (cx-good, good-matched-gt, good-unmatched, good-mean-corr, col-good),
      (cx-poor, poor-matched-gt, poor-unmatched, poor-mean-corr, col-poor),
    ) {
      place(left + top,
        dx: cx - 50pt, dy: 0pt,
        box(width: 100pt, align(center, stack(dir: ttb, spacing: 2pt,
          text(size: label-size, weight: "bold", fill: col)[
            #matched-gt/#n-gt GT matched
          ],
          text(size: label-size, fill: col, style: "italic")[
            #mean-corr pred/GT avg
          ],
          text(size: label-size, fill: col-unmatched, style: "italic")[
            #unmatched unmatched
          ],
        )))
      )
    }

    // Offset content below headers
    #let top-offset = 42pt

    // Lines — good side
    #for node in pos-good {
      if node.ids.len() == 0 { continue }
      for gid in node.ids {
        let gt = pos-gt.at(gid)
        let x1 = node.x
        let y1 = node.y + top-offset
        let x2 = gt.x
        let y2 = gt.y + top-offset
        let mx = (float(x1 / 1pt) + float(x2 / 1pt)) / 2 * 1pt
        place(left + top, dx: 0pt, dy: 0pt,
          curve(
            stroke: col-line-good.transparentize(45%) + 0.7pt,
            fill: none,
            curve.move((x1, y1)),
            curve.cubic((mx, y1), (mx, y2), (x2, y2)),
          )
        )
      }
    }

    // Lines — poor side
    #for node in pos-poor {
      if node.ids.len() == 0 { continue }
      for gid in node.ids {
        let gt = pos-gt.at(gid)
        let x1 = node.x
        let y1 = node.y + top-offset
        let x2 = gt.x
        let y2 = gt.y + top-offset
        let mx = (float(x1 / 1pt) + float(x2 / 1pt)) / 2 * 1pt
        place(left + top, dx: 0pt, dy: 0pt,
          curve(
            stroke: col-line-poor.transparentize(45%) + 0.7pt,
            fill: none,
            curve.move((x1, y1)),
            curve.cubic((mx, y1), (mx, y2), (x2, y2)),
          )
        )
      }
    }

    // GT nodes
    #for node in pos-gt {
      let r = node.sz * node-scale
      place(left + top, dx: node.x - r, dy: node.y + top-offset - r,
        circle(radius: r, fill: col-gt,
               stroke: col-gt.darken(20%) + 0.5pt))
    }

    // Good nodes
    #for node in pos-good {
      let r = node.sz * node-scale
      let col = if node.matched { col-good } else { col-unmatched }
      place(left + top, dx: node.x - r, dy: node.y + top-offset - r,
        circle(radius: r, fill: col.transparentize(if node.matched { 0% } else { 50% }),
               stroke: col.darken(20%) + 0.5pt))
    }

    // Poor nodes
    #for node in pos-poor {
      let r = node.sz * node-scale
      let col = if node.matched { col-poor } else { col-unmatched }
      place(left + top, dx: node.x - r, dy: node.y + top-offset - r,
        circle(radius: r, fill: col.transparentize(if node.matched { 0% } else { 50% }),
               stroke: col.darken(20%) + 0.5pt))
    }

    // Column labels at bottom
    #for (cx, lbl, col) in (
      (cx-good, "Good matching", col-good),
      (cx-gt,   "Reference (GT)", col-gt),
      (cx-poor, "Poor matching",  col-poor),
    ) {
      place(left + top,
        dx: cx - 44pt, dy: height + top-offset + 4pt,
        box(width: 88pt, align(center,
          text(size: label-size, weight: "bold", fill: col)[#lbl]
        ))
      )
    }
  ]
}
