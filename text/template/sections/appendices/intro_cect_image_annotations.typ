#let image-with-line(path, colour, label, number, numcolour, dashing) = block(width: 100%, height: auto)[
  #set align(center + horizon)
  #image(path, width: 100%)
  #place(center + horizon, line(length: 100%, stroke: (thickness: 1.8pt, paint: colour, dash: dashing)))
  #place(
    bottom + right,
    dx: -0.4em, dy: -0.4em,
    box(
      fill: rgb(0, 0, 0, 160),
      inset: (x: 0.4em, y: 0.2em),
      radius: 2pt,
      text(fill: white, size: 9pt, weight: "bold")[#label]
    )
  )
  #place(
    top + left,
    dx: 0.4em, dy: 0.4em,
    box(
      fill: numcolour,
      inset: (x: 0.4em, y: 0.2em),
      radius: 2pt,
      text(fill: white, size: 12pt, weight: "bold")[#number]
    )
  )
]


#let image-with-circles(path, circles: (), corner-label: none, label: none, label-colour: red, width: 100%) = block(
  breakable: false,
)[
  #set align(center + horizon)
  #image(path, width:width)
  #for c in circles {
    let cx = c.at("x")
    let cy = c.at("y")
    let cr = c.at("r")
    let col = c.at("colour", default: red)
    let th = c.at("thickness", default: 1.5pt)
    place(
      top + left,
      dx: cx,
      dy: cy,
      box(
        width: 0pt,
        height: 0pt,
        place(
          center + horizon,
          circle(
            radius: cr,
            stroke: col + th,
            fill: none,
          ),
        ),
      ),
    )
  }
  // Top-left corner badge (e.g. "a", "b", "c"): black box, white bold letter.
  #if corner-label != none {
    place(
      top + left,
      dx: 0.4em, dy: 0.4em,
      box(
        fill: rgb(0, 0, 0, 200),
        inset: (x: 0.45em, y: 0.2em),
        radius: 2pt,
        text(fill: white, size: 12pt, weight: "bold")[#corner-label],
      ),
    )
  }
  // Optional bottom-right caption-style label (unchanged behaviour).
  #if label != none {
    place(
      bottom + right,
      dx: -0.4em, dy: -0.4em,
      box(
        fill: rgb(0, 0, 0, 160),
        inset: (x: 0.4em, y: 0.2em),
        radius: 2pt,
        text(fill: white, size: 9pt, weight: "bold")[#label],
      ),
    )
  }
]


// Data showcase figure: representative CECT slices illustrating
// the principal challenges of micro-CT vasculature data.

#let img-path = "../../../resources/images/vessel_intro_examples/with_scalebars/scalebars/"

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 2,
    column-gutter: 0.4em,
    row-gutter: 0.6em,

    // (a) Large vessel — ~14 voxels across
    image-with-circles(
      img-path + "ca-ll-l1_1084.jpg",
      circles: (
        (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
      ),
      corner-label: "a",
    ),

    // (b) Staining artifact — large high-valued region
    image-with-circles(
      img-path + "ca-ll-l1_0655.jpg",
      circles: (
        (x: 35%, y: 48%, r: 7mm, colour: red, thickness: 0.8pt),
      ),
      corner-label: "b",
    ),

    // (c) Many small vessels in cross-section, 2-8 voxels across
    image-with-circles(
      img-path + "ca-ll-r_2297_crop.jpg",
      corner-label: "c",
    ),

    // (d) Shell effect — high-valued boundary shell
    image-with-circles(
      img-path + "ca-lu-r_1458_crop.jpg",
      corner-label: "d",
    ),

    // (e) and (f) — paired slices showing 3D continuity
    image-with-circles(
      img-path + "ca-lu-r_1651_crop.jpg",
      corner-label: "e",
    ),
    image-with-circles(
      img-path + "ca-lu-r_1656_crop.jpg",
      corner-label: "f",
    ),
  ),
  caption: [Slices illustrating the principal challenges: *(a)* A large high contrast vessel of approximately 14 voxels (indicated by the circle). *(b)* A large high-intensity non vessel-like structure resulting from hemorrhage. *(c)* Upper, left: many small vessels in cross-section, ranging from 2 to 8 voxels in diameter, where the partial-volume effect is present, as well as compression artifacts. *(d)* Outer surface: the "shell effect", a high-intensity boundary surrounding the tumor caused by the limited diffusion of the contrast agent - also visible: a strong gradient between outside and center *(e, f)* Two slices from the same volume, separated by 5 voxels along the z-axis. The vessel indicated appears discontinuous in (e) but continuous in (f), highlighting the relevance of 3D methods.
  ],
) <fig:cect-data-examples>