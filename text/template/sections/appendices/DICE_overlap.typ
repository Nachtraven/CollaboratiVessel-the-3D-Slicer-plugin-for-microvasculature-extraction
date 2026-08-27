#let vessel(x, y, r-out, r-in, dual: true) = {
  // Draws a GT circle (orange) optionally with a prediction circle (green) inside
  place(left + top,
    dx: x - r-out, dy: y - r-out,
    circle(radius: r-out, stroke: 1.5pt + orange))
  if dual {
    place(left + top,
      dx: x - r-in, dy: y - r-in,
      circle(radius: r-in, stroke: 1.5pt + green))
  }
}

#let panel(content-body, caption-text) = {
  box(width: 180pt, height: 140pt)[
    #box(width: 100%, height: 100%, stroke: 0.8pt + black)[
      #content-body
    ]
    #align(center, text(size: 9pt, style: "italic")[#caption-text])
  ]
}

#let dice_diagram() = {
  stack(dir: ltr, spacing: 1em,
    panel(
      {
        vessel(60pt,  60pt, 28pt, 16pt)   // big vessel
        vessel(140pt, 90pt, 16pt, 10pt)   // medium
        vessel(110pt, 30pt, 12pt, 7pt)    // small top right
        vessel(160pt, 115pt, 9pt, 5pt)    // tiny bottom
      },
      [Regions detected but under segmented],
    ),
    align(horizon, text(size: 24pt, weight: "bold")[=]),
    panel(
      {
        place(left + top,
          dx: 40pt - 22pt, dy: 60pt - 42pt,
          circle(radius: 42pt, stroke: 1.5pt + orange))
        place(left + top,
          dx: 62pt - 38pt, dy: 62pt - 38pt,
          circle(radius: 38pt, stroke: 1.5pt + green))
        vessel(160pt, 90pt, 14pt, 0pt, dual: false)
        vessel(115pt, 30pt, 10pt, 0pt, dual: false)
        vessel(125pt, 115pt, 8pt,  0pt, dual: false)
      },
      [Missing small regions but high overlap on large region],
    ), 
  )
  v(1.5em)
}