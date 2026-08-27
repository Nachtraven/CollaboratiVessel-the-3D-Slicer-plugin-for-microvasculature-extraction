// PR curves;
// #figure(
//   grid(
//     columns: 2,
//     rows: 3,
//     xy-curve(
//     (
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         label: "Thresholding",      colour: rgb("#e63946")),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         label: "CollaboratiVessel", colour: rgb("#457b9d")),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/FRANGI_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         label: "Frangi", colour: rgb("#459d6b")),
//     ),
//     x-label: "Recall",
//     y-label: "Precision",
//   ),

//   xy-curve(
//     (
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         label: "Thresholding",      colour: rgb("#e63946")),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         label: "CollaboratiVessel", colour: rgb("#457b9d")),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/FRANGI_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         label: "Frangi", colour: rgb("#459d6b")),
//     ),
//     x-label: "Recall",
//     y-label: "Precision",
//   ),

//   xy-curve(
//     (
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         label: "Thresholding",      colour: rgb("#e63946")),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         label: "CollaboratiVessel", colour: rgb("#457b9d")),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/FRANGI_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         label: "Frangi", colour: rgb("#459d6b")),
//     ),
//     x-label: "Recall",
//     y-label: "Precision",
//   ),
//   ),
//   caption:[CA-RU-R 222, CA-RU-R 666, CA-LL-R 427 CA-NM-L 319 CA-NM-L 957]
// )

// // #figure(
// //     xy-curve(
// //     (
// //       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
// //         label: "Thresholding",      colour: rgb("#e63946")),
// //       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
// //         label: "CollaboratiVessel", colour: rgb("#457b9d")),
// //       (csv: "../../../resources/images/results/new_pipeline_may_15/FRANGI_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
// //         label: "Frangi", colour: rgb("#459d6b")),
// //     ),
// //     x-label: "Recall",
// //     y-label: "Precision",
// //   ),
// //   caption:[CA-NM-L 319]
// // )

// // #figure(
// //     xy-curve(
// //     (
// //       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
// //         label: "Thresholding",      colour: rgb("#e63946")),
// //       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
// //         label: "CollaboratiVessel", colour: rgb("#457b9d")),
// //       (csv: "../../../resources/images/results/new_pipeline_may_15/FRANGI_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
// //         label: "Frangi", colour: rgb("#459d6b")),
// //     ),
// //     x-label: "Recall",
// //     y-label: "Precision",
// //   ),
// //   caption:[CA-NM-L 957]
// // )

// #figure(
//     xy-curve(
//     (
//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         label: "Thresholding",      colour: rgb("#e63946")),
//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         label: "CollaboratiVessel", colour: rgb("#457b9d")),
//       (csv: "../../../resources/images/results/vessel_exps_15_may/FRANGI_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         label: "Frangi", colour: rgb("#459d6b")),
//     ),
//     x-label: "Recall",
//     y-label: "Precision",
//   ),
//   caption:[CA-LL-L1 498]
// )



// Re-write:
// CECT aims to make structures visible with CE agent that increases brightness. alternatives to CECT exist that use different "wavelengths" and different CE agents.
// Most basic Segmentation uses this prior: intensity based, but this is not sufficient because it is global
// After that, local gradients don't work because they don't integrate tubularity. You also get blobs, noise and artefacts
// -> derived from gradients you get shape based methods: frangi
// this enables detection of vessels with contrast wrt bakground 
// But this does not solve the gaps issue
// -> derived from shape based methods, you get reconnecting methods that use the previous steps
// Shape based fill the "intensity" gap, and disconnection based fill the "disconnection" gap
// 

// https://www.learnui.design/tools/data-color-picker.html
// Colour scale:
// #00876c
// #9bb290
// #e4e2df
// #d89e78
// #d43d51

// Palette:
// #003f5c
// #78529b
// #ef537d
// #ffa600

// Palette 5:
// #003f5c
// #575092
// #bb4e99
// #ff5f68
// #ffa600



// #let image-with-circles(path, circles, label: none, label-colour: red) = block(
//   width: 100%,
//   breakable: false,
// )[
//   #set align(center + horizon)
//   #image(path, width: 100%)
//   #for c in circles {
//     let cx = c.at("x")
//     let cy = c.at("y")
//     let cr = c.at("r")
//     let col = c.at("colour", default: red)
//     let th = c.at("thickness", default: 1.5pt)
//     place(
//       top + left,
//       dx: cx,
//       dy: cy,
//       // The circle is drawn centred on (cx, cy), so we offset
//       // by -r in both directions to centre it on the anchor.
//       box(
//         width: 0pt,
//         height: 0pt,
//         place(
//           center + horizon,
//           circle(
//             radius: cr,
//             stroke: col + th,
//             fill: none,
//           ),
//         ),
//       ),
//     )
//   }
//   #if label != none {
//     place(
//       bottom + right,
//       dx: -0.4em, dy: -0.4em,
//       box(
//         fill: rgb(0, 0, 0, 160),
//         inset: (x: 0.4em, y: 0.2em),
//         radius: 2pt,
//         text(fill: white, size: 9pt, weight: "bold")[#label],
//       ),
//     )
//   }
// ]


#import "./appendices/graph_results.typ": results-chart, results-chart-lines
#import "./appendices/DICE_results_graph.typ": draw-dice
#import "./appendices/precision_recall.typ" : xy-curve
#import "./appendices/scatterplot.typ" : scatterplot-chart
#import "./appendices/heatmaps.typ":vessel-heatmap
#import "./appendices/precision-recall_results_graph.typ":draw-pr-or-recall
#import "./appendices/vessel_stats.typ": vessel-length-distribution

#import "./appendices/intro_cect_image_annotations.typ": image-with-circles
#import "./appendices/stacked_bar.typ": vessel-match-bars

#import "./appendices/vessel_seed_chart.typ": vessel-seed-chart

#import "./appendices/bipartite/gt_coverage.typ": gt-coverage-strip
#import "appendices/sensitivity_analysis.typ" : sensitivity-xy-curve

// #import "./appendices/bipartite.typ": vessel-bipartite // Non working atm

// Order:
// CA-RU-R 222
// CA-RU-R 666
// CA-LL-R 427
// CA-NM-L 319
// CA-NM-L 957
// CA-LL-L1 498

= Results and discussion

Vessel extraction performance of CollaboratiVessel is evaluated both _quantitatively_ and _qualitatively_ against intensity thresholding on the subvolumes previously laid out in @fig:annotation_grid and their ground truths. //Despite their limited size, the subvolumes capture the key challenges of the dataset: shell effects, intensity gradients, vessel discontinuities and non vascular high valued areas, and enable controlled evaluation of both methods under identical conditions.

CollaboratiVessel is evaluated as it would be used in practice: the default parameters are used, which were obtained following hyperparameter sweep on the training data. These hyperparameters are only adjusted when qualitative inspection, done before collecting the quantitative results, reveals a clear failure in the form of a segmentation failing to identify more than half the user annotated vessel points. In order to evaluate thresholding, the value yielding the peak clDice was selected after running a sweep across all possible intensity values. This value is used as it represents the best achievable performance on a key evaluation metric relevant to users, holding CollaboratiVessel to a high bar: other values such as the mean value of the user placed vessel points introduced a bias towards the placement of points.  

// Qualitative results allow highlighting the structural improvements of the pipeline to vessel shape and connectivity and are visually compared to the ground truth on small samples and thresholding on larger ones. 

// Vessel metrics are quantitatively examined first that aim to highlight the advantages that clDICE struggel to capture:
// 1. Vessel length and size distrubution
// 2. Vessel positive coverage

// Following this clDICE, prediction ratio, iou, and precision/recall are analyzed.

//quantative numbers as they are evaluated here can fail to properly weigh the negative impact of vessels with variable sizes, or disconnections, and the ground truths as mentioned above are imperfect and conservative which impacts the performance of an algorithm designed to extrapolate. 




== Hyperparameter sensitivity analysis

// This highlights pipeline stability

A key disadvantage of thresholding is its sensitivity towards the selection of the exact right threshold: if incorrectly configured, the resulting 3D map is unusable, and optimal thresholds vary by location within a scan as well as between scans. To highlight a key advantage of the pipeline based approach, we analyze the clDice result sensitivity of the parameter of vessel size and deviation against thresholding on subsamples 1 and 2, representing a sample from the edge and one from the center of a volume. Frangi intensity, the third relevant parameter set by reference implementations to 5 and controlling the intensity difference used to identify tubular shapes was evaluated separately due to its narrow useful range of 2-6: values were evaluated at 2, 3, 4, 5 and 6 with clDice performance of .3081, .3086, .2984, .3085, .2984, resulting in our default of 3.


#v(0.25cm)
#figure(
  sensitivity-xy-curve(
    (
      (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
        label: "Thresholding - subsample 1: shell",
        colour: rgb("#ff3b4b"),
        style: "solid"),
      (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        label: "Thresholding - subsample 2: central",
        colour: rgb("#008aac"),
        style: "dashed"),
    ),
    x-col: "threshold_value",
    y-col: "pred_gt_cldice",
    x-label: "Threshold value",
    y-label: "clDice",
    sort-by-x: false,
    y-min: 0.0, y-max: 1.0,
    points: (
          (name: "",    x: 120.0, y: 0.4315, group: "Pipeline - subsample 1: shell"), //vsize 4, std 3
          (name: "",    x: 080.0, y: 0.4198, group: "Pipeline - subsample 1: shell"), //vsize 3, std 3
          (name: "",    x: 040.0, y: 0.4355, group: "Pipeline - subsample 1: shell"), //vsize 2, std 2
          (name: "",    x: 160.0, y: 0.4209, group: "Pipeline - subsample 1: shell"), //vsize 5, std 3
          (name: "",    x: 180.0, y: 0.4385, group: "Pipeline - subsample 1: shell"), //vsize 6, std 4
          (name: "",    x: 220.0, y: 0.3675, group: "Pipeline - subsample 1: shell"), //vsize 8, std 6
          (name: "",   x: 250.0, y: 0.3538, group: "Pipeline - subsample 1: shell"), //vsize 10, std 7

          (name: "",    x: 120.0, y: 0.3086, group: "Pipeline - subsample 2: central"),
          (name: "",    x: 080.0, y: 0.3795, group: "Pipeline - subsample 2: central"),
          (name: "",    x: 040.0, y: 0.2491, group: "Pipeline - subsample 2: central"),
          (name: "",    x: 160.0, y: 0.2633, group: "Pipeline - subsample 2: central"),
          (name: "",    x: 180.0, y: 0.2152, group: "Pipeline - subsample 2: central"),
          (name: "",    x: 220.0, y: 0.2383, group: "Pipeline - subsample 2: central"),
          (name: "",   x: 250.0, y: 0.2234, group: "Pipeline - subsample 2: central"),
        ),
        
      groups: (
      "Pipeline - subsample 1: shell":   (colour: rgb("#ff3b4b"), shape: "dot"),
      "Pipeline - subsample 2: central": (colour: rgb("#008aac"), shape: "cross"),
    ),
    
    top-axis-ticks: (
      (40.0, "vsize 2\n+/-2"),
      (80.0, "vsize 3\n+/-3"),
      (120.0, "vsize 4\n+/-3"),
      (160.0, "vsize 5\n+/-3"),
      (180.0, "vsize 6\n+/-4"),
      (220.0, "vsize 8\n+/-6"),
      (250.0, "vsize 10\n+/-7"),
    ),    
    top-axis-label: "CollaboratiVessel hyperparameters",
  ),
  caption:[Sensitivity analysis of CollaboratiVessel vessel size and standard deviation when compared to thresholding values, showing: (1) dashed blue, thresholding on a central subsample, with a narrow peak indicative of a narrow distribution of vessel intensities, (2) continuous red, performance on a subsample that contains the outer edge of a dataset, with a much wider spread of vessel intensities, and (3) the stability of CollaboratiVessel when adjusting the vessel size and standard deviation.]
)<fig:sensitivity_anal>
#v(0.25cm)

From our sensitivity analysis, we can observe that there may potentially exist parameters that further optimize the performance of CollaboratiVessel for these two samples, but also that CollaboratiVessel performance is relatively flat: the quantitative metrics extracted next, done using default parameters, are thus likely close to the local optima for each run.


== Qualitative comparisons

To obtain an understanding of the outputs of CollaboratiVessel when compared to thresholding, we can observe the segmentation output from the 2D and 3D perspectives: 2D enables the visualization of the slice and its intensities, with the segmentation method overlaid. 3D provides an understanding of the structure of the ouputs and how they relate to eachother, without giving a good sense of scale due to depth reprojection. Sample 1 @fig:CA-RU-R_222_3d is a challenging outer boundary example, and 5 @fig:CA-NM-L_957_3d a cleaner central sample with large, high contrast vessels, the only example that required vessel size adjustment to 12 vox +/- 6.

// TODO: 3D analysis
#let img-path = "../../../resources/images/qualitative_evaluation/CA-RU-R_x_916_y_901_z_222/p1/"
#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 2,
    column-gutter: 0.1em,
    row-gutter: 0.1em,

    // grid.cell(
    //     rowspan: 2,
      image-with-circles(
        "../../../resources/images/qualitative_evaluation/CA-RU-R_x_916_y_901_z_222/p2/vessels_w_bar2.png",
        // circles: (
        //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
        // ),
        corner-label: "1",
        ), 
    // ),

    image-with-circles(
      img-path + "3d_vessels_only.png",
      // circles: (
      //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
      // ),
      corner-label: "a",
      ),
      
    image-with-circles(
      img-path + "3d_vessels_thresh.png",
      // circles: (
      //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
      // ),
      corner-label: "b",
      ), 

    image-with-circles(
      img-path + "thr_only.png",
      // circles: (
      //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
      // ),
      corner-label: "2",
      ),

    image-with-circles(
      img-path + "3d_thresh_only.png",
      circles: (
        (x: 35%, y: 50%, r: 8.5mm, colour: black, thickness: 1.0pt),
      ),
      corner-label: "c",
      ),

    image-with-circles(
      img-path + "3d_gt.png",
      // circles: (
      //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
      // ),
      corner-label: "d",
      ),

  ), //CA-RU-R (1)
  caption: [*Sample 1*, (1) (2) slice views: in red CollaboratiVessel, in yellow: thresholding, highlighting a large false positive. (a-d) Comparison of 3D Views: (a) CollaboratiVessel output, (b) CollaboratiVessel overlaid with thresholding, (c) thresholding alone, with black circle highlighting a large area of false negatives, (d) ground truth.], //Circled in black in figures b, d, e: a gap not identified by any method
) <fig:CA-RU-R_222_3d>
#v(0.5cm)

In @fig:CA-RU-R_222_3d, thresholding captures large false positive plates, has gaps and holes, and entirely misses the vessels towards the central region (black circle). CollaboratiVessel output is more continuous, although conservative on vessel size as can be seen in the overlapped visualization. Ground truth shows the variance introduced by non expert manual annotations using the 3D Slicer tools, highlighting its limitations as a comparison point: vessels are larger, size is somewhat inconsistent and some blob-like shapes are captured. //, and some small thin _smears_ are visible: areas during annotation that may have appeared on one slice to be a vessel, but weren't vessel like in subsequent slices and were not removed.



#let img-path = "../../../resources/images/qualitative_evaluation/SLICES CA-NM-L_x_900_y_900_z_957/"
#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 2,
    column-gutter: 0.1em,
    row-gutter: 0.1em,

    // grid.cell(
    //     rowspan: 2,
      image-with-circles(
        img-path + "p1/slice_vessel.png",
        // circles: (
        //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
        // ),
        corner-label: "1",
        ), 
    // ),

    image-with-circles(
      img-path + "vessels.png",
      // circles: (
      //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
      // ),
      corner-label: "a",
      ),
      
    image-with-circles(
      img-path + "vessels_thresh.png",
      circles: (
        (x: 88%, y: 40%, r: 6.5mm, colour: black, thickness: 1.0pt),
      ),
      corner-label: "b",
      ), 

    image-with-circles(
      img-path + "p1/slice_thresh.png",
      // circles: (
      //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
      // ),
      corner-label: "2",
      ),

    image-with-circles(
      img-path + "thresh.png",
      circles: (
        (x: 68%, y: 50%, r: 8.5mm, colour: black, thickness: 1.0pt),
      ),
      corner-label: "c",
      ),

    image-with-circles(
      img-path + "gt.png",
      // circles: (
      //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
      // ),
      corner-label: "d",
      ),

  ), //CA-RU-R (1)
  caption: [*Sample 5*: (1) (2) Slice views, in red CollaboratiVessel, in yellow thresholding, showing the under segmentation of CollaboratiVessel (a-d) Comparison of 3D Views: (a) CollaboratiVessel output, (b) CollaboratiVessel overlaid with thresholding, black circle highlighting a region with a successful reconnection (c) thresholding alone, black circle highlighting a missed vessel (d) ground truth.],
) <fig:CA-NM-L_957_3d>
#v(0.5cm)

In @fig:CA-NM-L_957_3d, a high contrast scenario with large vessels, thresholding misses low contrast vessels and fails to fully connect the large main vessel. The ground truth also shows that CollaboratiVessel is extending vessels beyond where they stop being annotated.




// #figure(
//   vessel-seed-chart(),
//   caption: [Vessel and background prediction accuracy, thresholding vs pipeline.],
// )


// Supplemental visualizations of the other tumors, and full comparisons with ground truth may be found in @appendix:results_visuals. // TODO: Visualizations on larger volumes can be found in @appendix:results_large

#pagebreak()
== Quantitative comparison

// From initial observation, we can see what appears to be longer vessels being predicted than the ground truth, with more extensive vessel networks. This is corroborated by our clDice score analysis 

The three qunantitative metrics laid out in @sec:evaluation_criteria evaluation criteria are examined bellow on the 6 subvolumes: user placed annotation points, voxel level metrics and connectivity metrics.

=== User placed points


// Order:
// CA-RU-R 222
// CA-RU-R 666
// CA-LL-R 427
// CA-NM-L 319
// CA-NM-L 957
// CA-LL-L1 498


// #figure(
//   results-chart(
//     (),  // no raw-column series; everything is a ratio
//     1.0,
//     "Fraction of correctly\n  classified points",
//     derived-series: (
//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#003f5c"), label: "Sample 1: CollaboratiVessel - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#78529b"), label: "Sample 1: CollaboratiVessel - background seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#ef537d"), label: "Sample 1: Threshold - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#ffa600"), label: "Sample 1: Threshold - background seeds"),



//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 19, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#003f5c"), label: "Sample 2: CollaboratiVessel - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 19, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#78529b"), label: "Sample 2: CollaboratiVessel - background seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         row: 73, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#ef537d"), label: "Sample 2: Threshold - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         row: 73, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#ffa600"), label: "Sample 2: Threshold - background seeds"),



//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 36, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#003f5c"), label: "Sample 3: CollaboratiVessel - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 36, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#78529b"), label: "Sample 3: CollaboratiVessel - background seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 64, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#ef537d"), label: "Sample 3: Threshold - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 64, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#ffa600"), label: "Sample 3: Threshold - background seeds"),



//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
//         row: 19, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#003f5c"), label: "Sample 4: CollaboratiVessel - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-NM-L_x+1800_y+1800_z+319_experimentcsv",
//         row: 19, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#78529b"), label: "Sample 4: CollaboratiVessel - background seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
//         row: 103, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#ef537d"), label: "Sample 4: Threshold - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
//         row: 103, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#ffa600"), label: "Sample 4: Threshold - background seeds"),



//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
//         row: 19, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#003f5c"), label: "Sample 5: CollaboratiVessel - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
//         row: 19, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#78529b"), label: "Sample 5: CollaboratiVessel - background seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
//         row: 90, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#ef537d"), label: "Sample 5: Threshold - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
//         row: 90, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#ffa600"), label: "Sample 5: Threshold - background seeds"),



//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         row: 219, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#003f5c"), label: "Sample 6: CollaboratiVessel - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/PIPE_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         row: 219, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#78529b"), label: "Sample 6: CollaboratiVessel - background seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         row: 94, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//         colour: rgb("#ef537d"), label: "Sample 6: Threshold - vessel seeds"),

//       (csv: "../../../resources/images/results/vessel_exps_15_may/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//         row: 94, num: "bg_seeds_correct",     den: "bg_seeds_total",
//         colour: rgb("#ffa600"), label: "Sample 6: Threshold - background seeds"),

//     )
//   ),
//   caption: [Fraction of user-placed vessel and background seed points correctly classified by CollaboratiVessel and thresholding.],
// )



#v(2cm)
#let exp-dir = "../../../resources/images/results/vessel_exps_15_may/"

#figure(
  results-chart(
    // ----- samples: each sample has a label and four CSV/row references -----
    (
      (
        label: "Sample 1",
        series: (
          pipe-vessel:   (csv: exp-dir + "PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
                          row: 8,  num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          pipe-bg:       (csv: exp-dir + "PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
                          row: 8,  num: "bg_seeds_correct",     den: "bg_seeds_total"),
          thresh-vessel: (csv: exp-dir + "THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
                          row: 89, num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          thresh-bg:     (csv: exp-dir + "THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
                          row: 89, num: "bg_seeds_correct",     den: "bg_seeds_total"),
        ),
      ),
      (
        label: "Sample 2",
        series: (
          pipe-vessel:   (csv: exp-dir + "PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
                          row: 19,  num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          pipe-bg:       (csv: exp-dir + "PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
                          row: 19,  num: "bg_seeds_correct",     den: "bg_seeds_total"),
          thresh-vessel: (csv: exp-dir + "THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
                          row: 73, num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          thresh-bg:     (csv: exp-dir + "THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
                          row: 73, num: "bg_seeds_correct",     den: "bg_seeds_total"),
        ),
      ),
      (
        label: "Sample 3",
        series: (
          pipe-vessel:   (csv: exp-dir + "PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
                          row: 36,  num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          pipe-bg:       (csv: exp-dir + "PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
                          row: 36,  num: "bg_seeds_correct",     den: "bg_seeds_total"),
          thresh-vessel: (csv: exp-dir + "THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
                          row: 64, num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          thresh-bg:     (csv: exp-dir + "THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
                          row: 64, num: "bg_seeds_correct",     den: "bg_seeds_total"),
        ),
      ),
      (
        label: "Sample 4",
        series: (
          pipe-vessel:   (csv: exp-dir + "PIPE_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
                          row: 19,  num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          pipe-bg:       (csv: exp-dir + "PIPE_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
                          row: 19,  num: "bg_seeds_correct",     den: "bg_seeds_total"),
          thresh-vessel: (csv: exp-dir + "THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
                          row: 103, num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          thresh-bg:     (csv: exp-dir + "THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
                          row: 103, num: "bg_seeds_correct",     den: "bg_seeds_total"),
        ),
      ),
      (
        label: "Sample 5",
        series: (
          pipe-vessel:   (csv: exp-dir + "PIPE_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
                          row: 19,  num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          pipe-bg:       (csv: exp-dir + "PIPE_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
                          row: 19,  num: "bg_seeds_correct",     den: "bg_seeds_total"),
          thresh-vessel: (csv: exp-dir + "THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
                          row: 90, num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          thresh-bg:     (csv: exp-dir + "THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
                          row: 90, num: "bg_seeds_correct",     den: "bg_seeds_total"),
        ),
      ),
      (
        label: "Sample 6",
        series: (
          pipe-vessel:   (csv: exp-dir + "PIPE_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
                          row: 219,  num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          pipe-bg:       (csv: exp-dir + "PIPE_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
                          row: 219,  num: "bg_seeds_correct",     den: "bg_seeds_total"),
          thresh-vessel: (csv: exp-dir + "THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
                          row: 94, num: "vessel_seeds_correct", den: "vessel_seeds_total"),
          thresh-bg:     (csv: exp-dir + "THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
                          row: 94, num: "bg_seeds_correct",     den: "bg_seeds_total"),
        ),
      ),
    ),
    // ----- series-defs: one entry per bar within a sample -----
    (
      (key: "pipe-vessel",   label: "CollaboratiVessel: vessel seeds",    colour: rgb("#003f5c")),
      (key: "pipe-bg",       label: "CollaboratiVessel: background seeds", colour: rgb("#78529b")),
      (key: "thresh-vessel", label: "Threshold: vessel seeds",   colour: rgb("#ef537d")),
      (key: "thresh-bg",     label: "Threshold: background seeds", colour: rgb("#ffa600")),
    ),
    1.0,
    "Fraction of correctly classified points",
  ),
  caption: [Fraction of user-placed vessel and background seed points correctly classified by CollaboratiVessel and intensity thresholding.],
)
#v(0.25cm)

As can be seen, background points are always fully classified correctly. Vessel points are more variable: with CollaboratiVessel higher in most cases, however always missing some predictions. By observing the data on a more granular level, we can learn an interesting first fact that encourages our move from low representative power user placed points towards clDice: the threshold value giving the highest proportion of correctly classified vessel points does not correspond to that with the highest clDice.


#let exp-dir = "../../../resources/images/results/vessel_exps_15_may/"
#figure(
  results-chart-lines(
    (
      (csv: exp-dir + "THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
        label: "Sample 1",   colour: rgb("#ef537d"), style: "solid"),
      (csv: exp-dir + "THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        label: "Sample 2", colour: rgb("#003f5c"), style: "dashed"),
    ),
    x-col: "threshold_value",
    y-num: "vessel_seeds_correct",
    y-den: "vessel_seeds_total",
    x-label: "Threshold value",
    y-label: "Fraction of vessel seeds correctly classified",
  ),
  caption: [Fraction of user-placed vessel seed points classified as vessel by intensity thresholding, as a function of the threshold value, on two subsamples.],
)

This is obciously a tradeoff between false-positives and false negatives, difficult to balance in a useful way at such a low level.



=== clDice
To analyze performance quantitatively, we explore clDice, the voxel level metric chosen for its better representation of connectivity and the ratio of correctly classified vessel points (annotation points placed by the user).

#v(0.15cm)
#let RES = "../../../resources/images/results/new_pipeline_may_15"
#figure(
  draw-dice(
    (
      (name: "Sample 1", //"CA-RU-R (1)", //\n916/901/222
       tool_csv: "./results.csv", tool_row: 0,
       thr_csv:  RES + "/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv", thr_row: 89),
      (name: "Sample 2", //"CA-RU-R (2)",
       tool_csv: "./results.csv", tool_row: 1,
       thr_csv:  RES + "/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv", thr_row: 73),
      (name: "Sample 3", //"CA-LL-R", //\n298/233/427
       tool_csv: "./results.csv", tool_row: 2,
       thr_csv:  RES + "/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv", thr_row: 64),
      (name: "Sample 4", //"CA-NM-L (1)", //\n1800/1800/319
       tool_csv: "./results.csv", tool_row: 3,
       thr_csv:  "../../../resources/images/sweep_experiment/THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv", thr_row: 103),
      (name: "Sample 5", //"CA-NM-L (2)", //\n900/900/957
       tool_csv: "./results.csv", tool_row: 4,
       thr_csv:  "../../../resources/images/sweep_experiment/THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv", thr_row: 90),
      (name: "Sample 6", //"CA-LL-L1", //\n559/604/498
       tool_csv: "./results.csv", tool_row: 5,
       thr_csv:  RES + "/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", thr_row: 94),
    ),
    // Uncomment to add pred_gt_volume
    annotate-col: "pred_gt_vol",
    annotate-label: "vol ratio (pred/gt)",
    annotate-digits: 2,
  ),
  caption: [clDice comparison of CollaboratiVessel against thresholding, using the optimal threshold for the highest clDice. Volume ratio (prediction/ground truth) presented numerically underneath. The results highlight two volumes for which thresholding substantially outperforms the model: these volumes have marked oversegmentation with regard to the ground truth, predicting 1.92 and 4.82 times more voxels respectively. These highlight two volumes for which there is substantial extrapolation, @fig:CA-RU-R_666_2d and @fig:CA-LL-R_2d. Other volumes show closely matched clDice values, and under segment.]
)
#v(0.15cm)


These clDice scores reveal are interesting from a segmentation perspective, but fail to inform us about the vessels themselves. In order to better understand the vessels predicted by both techniques when compared to the ground truth, we analyze the distributions of vessel length and size, initially visualizing all predictions (false positives and true positives) in @fig:collated_heatmaps, then fousing only on true positives in @fig:collated_heatmaps_only_true. //#footnote[Detailed results visible in @appendix:vessel_heatmaps]:


#v(0.2cm)
#figure(
  grid(
    columns: (auto, auto),
    rows:(auto, auto),
    column-gutter: 2.8em,

    vessel-heatmap(
      csv-paths: (
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
      ),
      method: "ground_truth", variant: "",
      title: "Ground truth",
      x-min: 0.005, x-max: 2.0,
      y-min: 1,     y-max: 5000,
      colour-max: 30,           // fix scale so all panels are comparable
      x-log: true, y-log: true,
    ),

    vessel-heatmap(
      csv-paths: (
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
      ),
      method: "threshold", variant: "best_dice",
      title: "Threshold",
      x-min: 0.005, x-max: 2.0,
      y-min: 1,     y-max: 5000,
      colour-max: 30,
      x-log: true, y-log: true,
    ),

    vessel-heatmap(
      csv-paths: (
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
      ),
      method: "pipeline", variant: "default",
      title: "CollaboratiVessel",
      x-min: 0.005, x-max: 2.0,
      y-min: 1,     y-max: 5000,
      colour-max: 30,
      x-log: true, y-log: true,
    ),

    pad(top:18pt,
    box[
      #image-with-circles(
        "../../../resources/images/qualitative_evaluation/SLICES CA-RU-R_x_687_y_451_z_666/p2/zoom/optimal_thresh_only.png",
        circles: (
          (x: 32%, y: 50%, r: 12mm, colour: red, thickness: 0.8pt),
        ),
      ),

      // Arrow 1
      #place(left + top,
        dx: 51pt, dy: 50pt,
        line(
          start: (0pt, 20pt),
          end: (-15pt, -120pt),
          stroke: 2pt + black,
          // marker-end: "stealth",
        )
      )
      #place(
        top + left,
        dx: 30pt,
        dy: -80pt,
        box(
          width: 0pt,
          height: 0pt,
          place(
            center + horizon,
            circle(
              radius: 12mm,
              stroke: red + 0.8pt,
              fill: none,
            ),
          ),
        ),
      )

      // #place(left + top,
      //   dx: 35pt, dy: 25pt,
      //   text(size: 8pt)[_(1) structural gap_]
      // )

      // // Arrow 2 — points down-right
      // #place(left + top,
      //   dx: 110pt, dy: 130pt,
      //   line(
      //     start: (0pt, 0pt),
      //     end: (40pt, 30pt),
      //     stroke: 1pt + black,
      //     // marker-end: "stealth",
      //   )
      // )
      // #place(left + top,
      //   dx: 130pt, dy: 130pt,
      //   text(size: 8pt)[_(2) challenging extraction_]
      // )
    ]
    ),

  ),
  // TODO: add an image here of the overall stats?
  caption: [*Relationship between vessel volume - vessel length*: all predictions (incl false positives).  A tubular vessel lays on the diagonal, as can be seen in the ground truth and CollaboratiVessel. Thresholding shows a high density of low volume predictions with short lengths, indicating blobs, and a generally smaller distribution of vessel sizes. CollaboratiVessel shows a tendency of predicting thinner vessels than the ground truth (a lower volume for a given vessel length). In *3D*: Sample 2 thresholding (Yellow) showcasing the small disconnected predictions]
) <fig:collated_heatmaps>
// #v(0.25cm)




// #v(0.2cm)
#figure(
  grid(
    columns: (auto, auto),
    rows:(auto, auto),
    column-gutter: 2.8em,

    vessel-heatmap(
      csv-paths: (
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
      ),

      method: "ground_truth", variant: "",
      title: "Ground Truth",
      x-min: 0.005, x-max: 2.0,
      y-min: 1,     y-max: 5000,
      colour-max: 15,           // fix scale so all panels are comparable
      x-log: true, y-log: true,
    ),

    vessel-heatmap(
      csv-paths: (
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
      ),
      method: "threshold", variant: "best_dice",
      title: "Thresholding",
      matched-only: true,
      x-min: 0.005, x-max: 2.0,
      y-min: 1,     y-max: 5000,
      colour-max: 15,
      x-log: true, y-log: true,
    ),

    vessel-heatmap(
      csv-paths: (
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
        "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
      ),
      method: "pipeline", variant: "default",
      matched-only: true,
      title: "CollaboratiVessel",
      x-min: 0.005, x-max: 2.0,
      y-min: 1,     y-max: 5000,
      colour-max: 15,
      x-log: true, y-log: true,
    ),

    pad(top:18pt,
    box[
      #image-with-circles(
        "../../../resources/images/qualitative_evaluation/SLICES CA-RU-R_x_687_y_451_z_666/p2/zoom/optimal_thresh_vessel.png",
        circles: (
          (x: 32%, y: 50%, r: 12mm, colour: red, thickness: 0.8pt),
        ),
      ),

      // Arrow
      #place(left + top,
        dx: 51pt, dy: 150pt,
        line(
          start: (-20pt, -45pt),
          end: (-105pt, -70pt),
          stroke: 2pt + black,
          // marker-end: "stealth",
        )
      )
      #place(
        top + left,
        dx: -80pt,
        dy: 60pt,
        box(
          width: 0pt,
          height: 0pt,
          place(
            center + horizon,
            circle(
              radius: 12mm,
              stroke: red + 0.8pt,
              fill: none,
            ),
          ),
        ),
      )

      // #place(left + top,
      //   dx: 35pt, dy: 25pt,
      //   text(size: 8pt)[_(1) structural gap_]
      // )

      // // Arrow 2 — points down-right
      // #place(left + top,
      //   dx: 110pt, dy: 130pt,
      //   line(
      //     start: (0pt, 0pt),
      //     end: (40pt, 30pt),
      //     stroke: 1pt + black,
      //     // marker-end: "stealth",
      //   )
      // )
      // #place(left + top,
      //   dx: 130pt, dy: 130pt,
      //   text(size: 8pt)[_(2) challenging extraction_]
      // )
    ]
    ),
  ),
  // TODO: add an image here of the overall stats?
  caption: [*Heatmaps of vessel volume/vessel length - only true predictions*: vessels for thresholding and CollaboratiVessel are only plotted if they correspond to at least one GT vessel, showing that many of the small predictions in thresholding and CollaboratiVessel are outside of the ground truth. In *3D: Sample 2* thresholding (Green) and CollaboratiVessel (Red) showcasing the connection of regions that are also captured by thresholding into longer vessels.]
) <fig:collated_heatmaps_only_true>
#v(0.25cm)

@fig:collated_heatmaps_only_true highlights that CollaboratiVessel is effectively connecting many small vessels into longer continuous ones. Sample 2 is shown, which had a higher thresholding clDice than CollaboratiVessel, and where many false positives were present. //Per sample analysis available in @appendix:vessel_heatmaps

=== Quantifying connectivity 


Beyond vessel size and length, it is interesting to investigate the known issue of voxel level metrics laid out in Error calculation Fig 2.4: vessels are not considered unitary, meaning that it is possible to miss vessels entirely without it being evident in the results, and reconstruction is not captured. To paliate this, a vessel level comparison is done using a bipartite analysis: for each predicted contiguous vessel, the corresponding contiguous ground truth vessel(s) are during metric calculation. This 0 to N matching allows us to identify, for each predicted vessel, how many ground truth vessels it touches. @fig:violin  // how many predicted vessels have no ground truth support, and inversely how many vessels are being connected: to obtain an overview, we analyze the matching ratio: the average amount of predicted vessels per ground truth vessels. 


#v(0.5cm)
#figure(
  image("./appendices/bipartite/violin_gt_coverage.svg", width: 100%),
  caption: [The distribution of number of predictions to each ground truth vessel: each violin shows how many predictions corresponded to each ground truth vessel. *0* = missed, the segmentation method did not identify the vessel, *1* = match, segmentation overlaps with one ground truth vessel *2+* = fragmented. Dashed line at 1.0 indicates 1:1 correspondence. Dots show individual GT vessels. Yellow horizontal bar marks the mean.]
)<fig:violin>
#v(0.5cm)

@fig:violin shows thresholding generally results in a higher amount of predictions per GT vessel, with a wider spread, and more outlier values, indicating a worse matching. Individual runs as seen in as seen in @fig:bipartite_balls_lines and @fig:bipartite_ca-ru-r_222 enable a more granular understanding by thanks to the ability to visualize the amount of predictions:


// #v(1.2cm)
// #figure(
//   vessel-match-bars(
//     "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//     (
//       ("threshold", "best_dice", "Threshold"),
//       ("pipeline",  "default",   "Pipeline"),
//       ("pipeline",  "vsize_-1",  "Pipeline\nvsize-1"),
//     ),
//     merge-mode: "A",   // "B" for prediction-side fragmentation
//   ),
//   caption: [CA-LL-L1 Vessel match quality per method. Numbers above bars show total
//             vessel count. GT bar shows reference vessel count.]
// )<fig:matching_rate>
// #v(0.2cm)

#v(0.5cm)
#let img-path = "../../../resources/images/results/ca-ll-l1 testing/"
#figure(
  
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 2,
    column-gutter: 0.1em,
    row-gutter: 0.1em,

    grid.cell(
        colspan: 3,
        image("./appendices/bipartite/bipartite_ca_ll_l1.svg", width: 100%),
    ),

    // image-with-circles(
    //   img-path + "base.png",
    //   width:60%,
    //   // circles: (
    //   //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
    //   // ),
    //   corner-label: "a",
    //   ),
    // image-with-circles(
    //   img-path + "vessels.png",
    //   width:60%,
    //   // circles: (
    //   //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
    //   // ),
    //   corner-label: "b",
    //   ),
    //   image-with-circles(
    //   img-path + "vessels_thresh.png",
    //   width:60%,
    //   // circles: (
    //   //   (x: 59%, y: 62%, r: 2.5mm, colour: black, thickness: 1.0pt),
    //   // ),
    //   corner-label: "c",
    //   ),

  ),
  caption: [*Sample 6* correspondence between unitary contiguous CollaboratiVessel predictions (blue), ground truth (green) and thresholding (red). Unmatched vessels are partially transparent.] // Images (a-c): visualization of slices from the source volume, ]
)<fig:bipartite_balls_lines>
#v(0.5cm)

@fig:bipartite_balls_lines highlights that CollaboratiVessel succeeds in matching more of the ground truth vessels: 28/35 vessels are matchedagainst 20/35 for the ground truth. This indicates CollaboratiVessel has better vessel sensitivity. Additionally, the ground truth contains many vessels that are detected as individual smaller vessels by CollaboratiVessel or thresholding, visible as many lines exiting a single ground truth vessel: predictions are still fragmented, although CollaboratiVessel is less so. // 3D views in @appendix:ca-ll-l1_visualizations

#v(0.5cm)
#figure(
  image("./appendices/bipartite/bipartite_ca-ru-r_222.svg", width: 100%),
  caption: [*Sample 1*, correspondence between unitary contiguous CollaboratiVessel predictions (blue), ground truth (green) and thresholding (red). Unmatched vessels are partially transparent. Thresholding here shows many small predictions matching to few ground truth vessels: thresholding has many disconnections]
)<fig:bipartite_ca-ru-r_222>

In @fig:bipartite_ca-ru-r_222 to comparative advantage of CollaboratiVessel is particularly visible: vessel sensitivity is much higher, identifying 51 of 60 ground truth vessels, and vessels are much less fragmented, as can be seen when compared to thresholding: for each ground truth vessel there are few CollaboratiVessel predictions, against many in thresholding. This was previously visible qualitatively in @fig:CA-RU-R_222_3d and revisited in @fig:CA-RU-R_222_3d_quant to highlight further the benefits of the implemented reconnection step.


#v(0.5cm)
#let img-path = "../../../resources/images/qualitative_evaluation/CA-RU-R_x_916_y_901_z_222/p1/"
#figure(
  grid(
    columns: (1fr, 1fr),
    rows: 2,
    column-gutter: 0.1em,
    row-gutter: 0.1em,

    // grid.cell(
    //     rowspan: 2,
    //   image-with-circles(
    //     "../../../resources/images/qualitative_evaluation/CA-RU-R_x_916_y_901_z_222/p2/vessels_w_bar2.png",
    //     // circles: (
    //     //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
    //     // ),
    //     corner-label: "1",
    //     ), 
    // // ),

    image-with-circles(
      img-path + "3d_vessels_only.png",
      circles: (
        (x: 22%, y: 12%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 50%, y: 92%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 12%, y: 80%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 31%, y: 85%, r: 6mm, colour: black, thickness: 1.0pt),
      ),
      corner-label: "a",
      ),
      
    image-with-circles(
      img-path + "3d_vessels_thresh.png",
      circles: (
        (x: 22%, y: 12%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 50%, y: 92%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 12%, y: 80%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 31%, y: 85%, r: 6mm, colour: black, thickness: 1.0pt),      ),
      corner-label: "b",
      ), 

    // image-with-circles(
    //   img-path + "thr_only.png",
    //   // circles: (
    //   //   (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
    //   // ),
    //   corner-label: "2",
    //   ),

    image-with-circles(
      img-path + "3d_thresh_only.png",
      circles: (
        (x: 22%, y: 12%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 50%, y: 92%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 12%, y: 80%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 31%, y: 85%, r: 6mm, colour: black, thickness: 1.0pt),
      ),
      corner-label: "c",
      ),

    image-with-circles(
      img-path + "3d_gt.png",
      circles: (
        (x: 22%, y: 12%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 50%, y: 92%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 12%, y: 80%, r: 6mm, colour: black, thickness: 1.0pt),
        (x: 31%, y: 85%, r: 6mm, colour: black, thickness: 1.0pt),      
        ),
      corner-label: "d",
      ),

  ), //CA-RU-R (1)
  caption: [*Sample 1*, 3D visuals highlighting the many small disconnected predictions of thresholding against CollaboratiVessel, in black: vessels either missed by thresholding, or containing disconnections.], //Circled in black in figures b, d, e: a gap not identified by any method
) <fig:CA-RU-R_222_3d_quant>
#v(0.5cm)




=== Evaluation takeaways

Following the evaluation of CollaboratiVessel against thresholding using voxel level clDice and higher order heatmaps and bipartite matching, as well as examining the outputs of CollaboratiVessel in 3D views, it is clear that clDice fails to capture the complexity of predicting vessels with sufficient accuracy for it to be used as a reliable measure of vessel prediction performance. The biases towards vessel size drowns out the real signal of vessel presence. Additionally, clDice completely fails to capture the metrics highlighted in the heatmaps: many small disconnected predictions are not relevant for downstream tasks, but still artifically boost the performance of clDice for thresholding. The bipartite matching also highlights the need for a metric that can evaluate something akin to a reconnection rate: how good a method is at not splitting a continuous prediction into sub predictions.

A worthwhile extension to evaluation would be further development of these vessel level metrics and a procedure for abstracting away the noise induced by manual annotations.

// In order to properly evaluate vessel predictions, it is required at a minimum to evaluate them at the level of structures: evaluation using heatmaps and matching should constitute the jumping off point towards


//correspondence between pipeline (left), ground truth (center, top 50 by volume), and thresholding (right). Node size encodes vessel volume. Lines show which predicted vessels overlap which GT vessels. 

// OLD: this was interesting but didn't compile well
// #figure(
//   gt-coverage-strip(
//     (
//         ("", "../../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv"),
//         ("", "../../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv"),
//         ("", "../../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv"),
//         ("", "../../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv"),
//         ("", "../../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv"),
//         ("", "../../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv"),
//       ),
//     y-cap: 15,   // cap display at 15 if threshold has extreme outliers
//   ),
//   caption: [Per-GT-vessel prediction count across six subvolumes.
//             Each dot is one GT vessel. *0* = missed, *1* = clean match,
//             *2+* = fragmented. Dashed line marks perfect 1:1 correspondence.]
// )
// Key design choices:

// Dots at y=0 are the missed GT vessels (slightly transparent to distinguish from matched).
// Dots at y=1 are clean matches — these should dominate for your pipeline.
// Dots at y=2+ are fragmented GT vessels — thresholding will have many of these.
// y-cap lets you cap the y-axis to avoid threshold outliers (e.g. 50 tiny predictions on one GT vessel) compressing all the interesting range near 0–5. Dots hitting the cap still appear at the cap value.
// Horizontal jitter stacks dots at the same y value side by side so nothing is hidden.
// OLD: this was interesting but didn't compile well


// === Qualitative analysis and ground truth

// We begin by analyzing the two volumes with large over-segmentation identified previously: CA-RU-R 687/451/666 and CA-LL-R 298/233/427. These show marked over-segmentation ...

// Order:
// CA-RU-R 222
// CA-RU-R 666
// CA-LL-R 427
// CA-NM-L 319
// CA-NM-L 957
// CA-LL-L1 498


// #let img-path = "../../resources/images/qualitative_evaluation/CA-RU-R_x_916_y_901_z_222/p2/"
// #figure(
//   grid(
//     columns: (1fr, 1fr),
//     rows: 2,
//     column-gutter: 0.4em,
//     row-gutter: 0.6em,

//     figure(
//       // image-with-circles(
//       //   "../" + img-path + "base.png",
//       //   (
//       //     (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
//       //   ),
//       // ),
//       image(img-path + "base.png", width: 100%),
//       caption: [base],
//       supplement: none,
//       numbering: none,
//     ),
  
//     figure(
//       image(img-path + "vessels.png", width: 100%),
//       caption: [pipeline output, default settings],
//       supplement: none,
//       numbering: none,
//     ),

//     figure(
//       image(img-path + "median_thr.png", width: 100%),
//       caption: [(a) threshold: median annotation value],
//       supplement: none,
//       numbering: none,
//     ),

//     figure(
//       image(img-path + "thr.png", width: 100%),
//       caption: [(b) threshold: peak clDICE],
//       supplement: none,
//       numbering: none,
//     ),

//   ),
//   caption: [CA-RU-R: Comparison of pipeline with thresholding based on (a) median user point value (b) optimal value for maximizing clDICE with known ground truth. Example shows ideal scenario for thresholding: vessels are segmented (although weakly, and present disconnections for the fainter vessels), while the pipeline under segments one large vessel.],
// ) <fig:CA-RU-R_222_2d>


// // TODO: 3D analysis
// #let img-path = "../../resources/images/qualitative_evaluation/CA-RU-R_x_916_y_901_z_222/p1/"
// #figure(
//   grid(
//     columns: (1fr, 1fr),
//     rows: 2,
//     column-gutter: 0.4em,
//     row-gutter: 0.6em,

//     figure(
//       // image-with-circles(
//       //   "../" + img-path + "base.png",
//       //   (
//       //     (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
//       //   ),
//       // ),
//       image(img-path + "3d_vessels_only.png", width: 100%),
//       caption: [Pipeline output, default settings],
//       supplement: none,
//       numbering: none,
//     ),
  
//     figure(
//       image(img-path + "3d_vessels_thresh.png", width: 100%),
//       caption: [Optimal threshold and Pipeline],
//       supplement: none,
//       numbering: none,
//     ),

//     figure(
//       image(img-path + "3d_thresh_only.png", width: 100%),
//       caption: [Threshold only],
//       supplement: none,
//       numbering: none,
//     ),

//     figure(
//       image(img-path + "3d_gt.png", width: 100%),
//       caption: [Ground truth],
//       supplement: none,
//       numbering: none,
//     ),

//   ),
//   caption: [*CA-RU-R (1)*: Comparison of 3D Views: thresholding captures large plates, has gaps and holes. Pipeline output is more continuous, although conservative on vessel size. Ground truth shows the variance introduced by non expert manual annotation highlighting its limitations as a comparison point: vessels are larger, size is less consistent, and some small thin _smears_ are visible: areas during annotation that may have appeared on one slice to be a vessel, but weren't vessel like in subsequent slices and were not removed.],
// ) <fig:CA-RU-R_222_3d>



// #let img-path = "../../resources/images/qualitative_evaluation/SLICES CA-NM-L_x_900_y_900_z_957/"
// #figure(
//   grid(
//     columns: (1fr, 1fr),
//     rows: 2,
//     column-gutter: 0.4em,
//     row-gutter: 0.6em,

//     figure(
//       // image-with-circles(
//       //   "../" + img-path + "base.png",
//       //   (
//       //     (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
//       //   ),
//       // ),
//       image(img-path + "vessels.png", width: 100%),
//       caption: [Pipeline output, default settings],
//       supplement: none,
//       numbering: none,
//     ),
  
//     figure(
//       image(img-path + "vessels_thresh.png", width: 100%),
//       caption: [Optimal threshold and Pipeline],
//       supplement: none,
//       numbering: none,
//     ),

//     figure(
//       image(img-path + "thresh.png", width: 100%),
//       caption: [Threshold only],
//       supplement: none,
//       numbering: none,
//     ),

//     figure(
//       image(img-path + "gt.png", width: 100%),
//       caption: [Ground truth],
//       supplement: none,
//       numbering: none,
//     ),

//   ),
//   caption: [*CA-NM-L (2)*: A high contrast scenario with large vessels, the only subsample requiring tailoring the pipeline hyperparameters to an average diameter of 12 vox +/- 6. Pipeline successfully extracts longer vessels and picks up the discontinuous vessels in the right hand side.],
// ) <fig:CA-NM-L_957_3d>


// Stages:
// • Frangi (1³=1 tile(s)): σ sum [3.0,18.0] vox
// • Intensity: μ_v=171.2+/-48.1, 
// • Tube growth: 163,232 voxels (final)
// • Thresholded at: 0.12

// Loaded evaluation chunk #1: VSA_Eval_1 from /home/sean/Desktop/Labels/Run 2/SLICES CA-NM-L_x+900_y+900_z+957

// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.547, clDice=0.692, IoU=0.377, P=0.459, R=0.677, vol(pred/gt)=1.47
//      GT=109,713 vox, pred=161,795 vox, shape=(301, 409, 450), src IJK=[0:450, 41:450, 0:301]
//      Centerlines: pred=10.9mm (6 br, avg 1.8mm), gt=8.1mm (15 br, avg 0.5mm)
//      Threshold (172) vs GT: Dice=0.832, clDice=0.823, IoU=0.712, P=0.909, R=0.767, vol(thr/gt)=0.84, thr=92,520 vox
//      Pred vs Threshold: Dice=0.520, clDice=0.607, IoU=0.351, vol(pred/thr)=1.75
//      Threshold centerline: thr=7.4mm (108 br, avg 0.1mm)
// Mean — Pred vs GT: Dice=0.547, clDice=0.692, IoU=0.377, P=0.459, R=0.677, vol=1.47
// Mean centerline length: pred=10.9mm, gt=8.1mm
// Threshold diag: threshold=172; total thresh voxels in volume: 92,562; source value range: [43.0, 255.0]
// Mean — Threshold vs GT: Dice=0.832, clDice=0.823, IoU=0.712, P=0.909, R=0.767, v ol=0.84
// Mean — Pred vs Threshold: Dice=0.520, clDice=0.607, IoU=0.351
// Mean threshold centerline: thr=7.4mm





// TODO: revisit
// /home/sean/Documents/GitHub/ucl-2026-based-on-kul-typst-template/resources/images/qualitative_evaluation/XL_CA-LU-R_BOT_S_W/CB-LULL-L
// === Large subsamples

// 433 433 465
// CB-LULL-L 931

// Previously the 6x6x6 subsampling grid resulted in images approximately 200-300 voxels across. In @fig:CA-LU-R_BOT_S_W CA-RU-R is sampled on a 2x2x1 grid: the bottom right 687x676x1332 chunk is taken. Peak memory use hits 40GB and runtime is approximately 2h. Pipeline parameters are left at default settings, and 41 vessel, background and outside points are placed.

// // CA-LU-R_BOT_S_W
// #let img-path = "../../resources/images/qualitative_evaluation/SLICES CA-NM-L_x_900_y_900_z_957/"
// #figure(
//   grid(
//     columns: (1fr, 1fr),
//     rows: 3,
//     column-gutter: 0.2em,
//     row-gutter: 0.25em,

//     figure(
//       // image-with-circles(
//       //   "../" + img-path + "base.png",
//       //   (
//       //     (x: 20%, y: 45%, r: 9mm, colour: red, thickness: 0.8pt),
//       //   ),
//       // ),
//       image(img-path + "vessels.png", width: 100%),
//       caption: [2D view],
//       supplement: none,
//       numbering: none,
//     ),
//     figure(
//       image(img-path + "vessels_thresh.png", width: 100%),
//       caption: [2D view],
//       supplement: none,
//       numbering: none,
//     ),


//     figure(
//       image(img-path + "thresh.png", width: 100%),
//       caption: [Thresholding],
//       supplement: none,
//       numbering: none,
//     ),
//     figure(
//       image(img-path + "gt.png", width: 100%),
//       caption: [Pipeline],
//       supplement: none,
//       numbering: none,
//     ),


//     figure(
//       image(img-path + "gt.png", width: 100%),
//       caption: [Zoomed threshold],
//       supplement: none,
//       numbering: none,
//     ),
//     figure(
//       image(img-path + "gt.png", width: 100%),
//       caption: [Zoomed pipeline],
//       supplement: none,
//       numbering: none,
//     ),

//   ),
//   // caption: [*aaa*: ],
// ) <fig:CA-LU-R_BOT_S_W>


// #v(0.5cm)
// #let RES = "../../../resources/images/results/new_pipeline_may_15"
// #figure(
//   draw-dice(
//     (
//       (name: "CA-RU-R\n916/901/222",
//        tool_csv: "./results.csv", tool_row: 0,
//        thr_csv:  RES + "/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv", thr_row: 89),
//       (name: "CA-RU-R\n687/451/666",
//        tool_csv: "./results.csv", tool_row: 1,
//        thr_csv:  RES + "/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv", thr_row: 73),
//       (name: "CA-LL-R\n298/233/427",
//        tool_csv: "./results.csv", tool_row: 2,
//        thr_csv:  RES + "/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv", thr_row: 64),
//       // (name: "SLICES CA-NM-L_x+1800_y+1800_z+319",
//       //  tool_csv: "./results.csv", tool_row: 4,
//       //  thr_csv:  "/THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv", thr_row: 64),
//       // (name: "SLICES CA-NM-L_x+900_y+900_z+957",
//       //  tool_csv: "./results.csv", tool_row: 5,
//       //  thr_csv:  "/THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv", thr_row: 64),
      
//       (name: "CA-LL-L1\n559/604/498",
//        tool_csv: "./results.csv", tool_row: 5,
//        thr_csv:  RES + "/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", thr_row: 94),
//     ),
//   ),
//   caption: [DICE and clDICE of pipeline against thresholding, using the optimal threshold for the highest DICE/clDICE]
// )
// #v(0.5cm)


// #v(0.5cm)
// #let RES = "../../../resources/images/results/vessel_exps_15_may"
// #figure(
//   draw-dice(
//     (
//       (name: "CA-LL-R\n559/604/498",
//        tool_csv: RES + "/PIPE_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", tool_row: 220,
//        thr_csv:  RES + "/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", thr_row: 94),

//     ),
//   ),
//   caption: [DICE and clDICE of pipeline against thresholding, using the optimal threshold for the highest DICE/clDICE]
// )
// #v(0.5cm)
      

// // points on xy: vessel volume in x, vessel length in y, coloured by method
// #figure(
//   scatterplot-chart(
//     "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//     x-col: "volume_voxels",
//     y-col: "length_mm",
//     group-col: "method",
//     x-label: "Vessel volume (voxels)",
//     y-label: "Vessel length (mm)",
//   ),
//   caption: [Comparison of CA-LL-L1_498 vessel characteristic distribution]
// )

// #figure(
//   scatterpanel-chart(
//     "../../../resources/images/results/vessel_exps_15_may/VESSELS_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv",
//     x-label: "Vessel volume (voxels)",
//     y-label: "Vessel length (mm)",
//   ),
//   caption: [Vessel volume vs length density by method for CA-LL-L1_498. The pipeline detects more vessels overall; the distribution shape shows whether they cover the same regions.]
// )






// // Order:
// // CA-RU-R 222
// // CA-RU-R 666
// // CA-LL-R 427
// // CA-NM-L 319
// // CA-NM-L 957
// // CA-LL-L1 498


// //Updated 17 may: CA-RU-R 222
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.297, clDice=0.425, IoU=0.174, P=0.589, R=0.199, vol(pred/gt)=0.34
//      GT=109,490 vox, pred=36,910 vox, shape=(222, 216, 229), src IJK=[0:229, 0:216, 0:222]
//      Centerlines: pred=22.1mm (101 br, avg 0.2mm), gt=27.0mm (131 br, avg 0.2mm)
//      Threshold (151) vs GT: Dice=0.173, clDice=0.178, IoU=0.095, P=0.099, R=0.697, vol(thr/gt)=7.07, thr=774,304 vox
//      Pred vs Threshold: Dice=0.052, clDice=0.081, IoU=0.027, vol(pred/thr)=0.05
//      Threshold centerline: thr=189.1mm (958 br, avg 0.2mm)
// Mean — Pred vs GT: Dice=0.297, clDice=0.425, IoU=0.174, P=0.589, R=0.199, vol=0.34
// Mean centerline length: pred=22.1mm, gt=27.0mm
// Threshold diag: threshold=151; total thresh voxels in volume: 790,886; source value range: [0.0, 255.0]
// Mean — Threshold vs GT: Dice=0.173, clDice=0.178, IoU=0.095, P=0.099, R=0.697, vol=7.07
// Mean — Pred vs Threshold: Dice=0.052, clDice=0.081, IoU=0.027
// Mean threshold centerline: thr=189.1mm

// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,ridge_threshold,ridge_iterations,auto_seed_rounds,auto_seed_max,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,4,3,2,0.01,5,8,200,163.00,30.05,24,27,11,11,0.2969,0.4246,0.1743,0.5888,0.1985,0.337,0.1727,0.1779,0.0945,0.0986,0.6970,7.072,0.0521,0.0808,0.0268,0.5730,0.0273,0.048,26.99,22.13,11.23,189.10,19.33


// //Updated 17 may: CA-RU-R 666
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.205, clDice=0.216, IoU=0.114, P=0.156, R=0.299, vol(pred/gt)=1.92
//      GT=15,954 vox, pred=30,648 vox, shape=(215, 225, 229), src IJK=[0:229, 0:225, 0:215]
//      Centerlines: pred=28.8mm (256 br, avg 0.1mm), gt=5.3mm (34 br, avg 0.2mm)
//      Threshold (130) vs GT: Dice=0.037, clDice=0.027, IoU=0.019, P=0.019, R=0.838, vol(thr/gt)=44.51, thr=710,177 vox
//      Pred vs Threshold: Dice=0.059, clDice=0.074, IoU=0.030, vol(pred/thr)=0.04
//      Threshold centerline: thr=397.4mm (9980 br, avg 0.0mm)
// Mean — Pred vs GT: Dice=0.205, clDice=0.216, IoU=0.114, P=0.156, R=0.299, vol=1.92
// Mean centerline length: pred=28.8mm, gt=5.3mm
// Threshold diag: threshold=130; total thresh voxels in volume: 732,055; source value range: [49.0, 197.0]
// Mean — Threshold vs GT: Dice=0.037, clDice=0.027, IoU=0.019, P=0.019, R=0.838, vol=44.51
// Mean — Pred vs Threshold: Dice=0.059, clDice=0.074, IoU=0.030
// Mean threshold centerline: thr=397.4mm

// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,ridge_threshold,ridge_iterations,auto_seed_rounds,auto_seed_max,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,4,3,2,0.01,5,8,200,138.00,9.16,9,9,7,7,0.2048,0.2155,0.1141,0.1557,0.2991,1.921,0.0368,0.0267,0.0188,0.0188,0.8377,44.514,0.0591,0.0739,0.0305,0.7144,0.0308,0.043,5.29,28.77,3.82,397.41,5.38



// //Updated 17 may: CA-LL-R 427
// // Old data:
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.220, clDice=0.220, IoU=0.124, P=0.133, R=0.641, vol(pred/gt)=4.82
//      GT=2,643 vox, pred=12,732 vox, shape=(91, 95, 99), src IJK=[0:99, 0:95, 51:142]
//      Centerlines: pred=10.1mm (79 br, avg 0.1mm), gt=1.4mm (15 br, avg 0.1mm)
//      Threshold (109) vs GT: Dice=0.032, clDice=0.040, IoU=0.016, P=0.016, R=0.989, vol(thr/gt)=60.10, thr=158,836 vox
//      Pred vs Threshold: Dice=0.131, clDice=0.199, IoU=0.070, vol(pred/thr)=0.08
//      Threshold centerline: thr=68.0mm (399 br, avg 0.2mm)
// Mean — Pred vs GT: Dice=0.220, clDice=0.220, IoU=0.124, P=0.133, R=0.641, vol=4.82
// Mean centerline length: pred=10.1mm, gt=1.4mm
// Threshold diag: threshold=109; total thresh voxels in volume: 379,224; source value range: [89.0, 156.0]
// Mean — Threshold vs GT: Dice=0.032, clDice=0.040, IoU=0.016, P=0.016, R=0.989, vol=60.10
// Mean — Pred vs Threshold: Dice=0.131, clDice=0.199, IoU=0.070
// Mean threshold centerline: thr=68.0mm

// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,ridge_threshold,ridge_iterations,auto_seed_rounds,auto_seed_max,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,4,3,1,0.01,5,8,200,125.00,7.82,5,7,3,3,0.2205,0.2203,0.1239,0.1331,0.6413,4.817,0.0324,0.0398,0.0164,0.0165,0.9886,60.097,0.1314,0.1994,0.0703,0.8850,0.0709,0.080,1.37,10.12,1.27,68.03,1.38
// // New data: TODO



// //Updated 17 may: CA-NM-L 319
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.298, clDice=0.508, IoU=0.175, P=0.626, R=0.196, vol(pred/gt)=0.31
//      GT=11,115 vox, pred=3,474 vox, shape=(197, 124, 124), src IJK=[0:124, 0:124, 122:319]
//      Centerlines: pred=3.2mm (26 br, avg 0.1mm), gt=2.5mm (17 br, avg 0.1mm)
//      Threshold (154) vs GT: Dice=0.055, clDice=0.016, IoU=0.028, P=0.028, R=0.921, vol(thr/gt)=32.41, thr=360,260 vox
//      Pred vs Threshold: Dice=0.017, clDice=0.012, IoU=0.009, vol(pred/thr)=0.01
//      Threshold centerline: thr=444.5mm (4208 br, avg 0.1mm)
// Mean — Pred vs GT: Dice=0.298, clDice=0.508, IoU=0.175, P=0.626, R=0.196, vol=0.31
// Mean centerline length: pred=3.2mm, gt=2.5mm
// Threshold diag: threshold=154; total thresh voxels in volume: 655,371; source value range: [0.0, 255.0]
// Mean — Threshold vs GT: Dice=0.055, clDice=0.016, IoU=0.028, P=0.028, R=0.921, vol=32.41
// Mean — Pred vs Threshold: Dice=0.017, clDice=0.012, IoU=0.009
// Mean threshold centerline: thr=444.5mm

// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,ridge_threshold,ridge_iterations,auto_seed_rounds,auto_seed_max,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,4,3,2,0.01,5,8,200,191.00,33.73,6,7,10,10,0.2979,0.5078,0.1750,0.6255,0.1955,0.313,0.0551,0.0159,0.0283,0.0284,0.9206,32.412,0.0170,0.0119,0.0086,0.8898,0.0086,0.010,2.48,3.19,1.52,444.49,3.56



// // Updated 17 may: SLICES CA-NM-L 957
// // WARN: increased vessel sizes
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.626, clDice=0.756, IoU=0.455, P=0.830, R=0.502, vol(pred/gt)=0.60
//      GT=109,713 vox, pred=66,354 vox, shape=(301, 409, 450), src IJK=[0:450, 41:450, 0:301]
//      Centerlines: pred=8.9mm (11 br, avg 0.8mm), gt=8.1mm (15 br, avg 0.5mm)
//      Threshold (171) vs GT: Dice=0.833, clDice=0.817, IoU=0.714, P=0.904, R=0.773, vol(thr/gt)=0.86, thr=93,806 vox
//      Pred vs Threshold: Dice=0.667, clDice=0.699, IoU=0.500, vol(pred/thr)=0.71
//      Threshold centerline: thr=8.0mm (129 br, avg 0.1mm)
// Mean — Pred vs GT: Dice=0.626, clDice=0.756, IoU=0.455, P=0.830, R=0.502, vol=0.60
// Mean centerline length: pred=8.9mm, gt=8.1mm
// Threshold diag: threshold=171; total thresh voxels in volume: 93,852; source value range: [43.0, 255.0]
// Mean — Threshold vs GT: Dice=0.833, clDice=0.817, IoU=0.714, P=0.904, R=0.773, vol=0.86
// Mean — Pred vs Threshold: Dice=0.667, clDice=0.699, IoU=0.500
// Mean threshold centerline: thr=8.0mm

// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,ridge_threshold,ridge_iterations,auto_seed_rounds,auto_seed_max,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,8,6,1,0.01,5,8,200,213.00,39.27,13,14,9,9,0.6258,0.7562,0.4554,0.8302,0.5021,0.605,0.8333,0.8166,0.7142,0.9039,0.7729,0.855,0.6667,0.6992,0.5000,0.8046,0.5691,0.707,8.08,8.86,6.89,7.99,6.86



// // Updated 16 may: SLICES CA-LL-L1_x+559_y+604_z+498
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.254, clDice=0.417, IoU=0.146, P=0.432, R=0.180, vol(pred/gt)=0.42
//      GT=59,974 vox, pred=24,985 vox, shape=(249, 201, 186), src IJK=[0:186, 0:201, 0:249]
//      Centerlines: pred=16.0mm (92 br, avg 0.2mm), gt=9.4mm (73 br, avg 0.1mm)
//      Threshold (152) vs GT: Dice=0.043, clDice=0.042, IoU=0.022, P=0.022, R=0.881, vol(thr/gt)=39.91, thr=2,393,476 vox
//      Pred vs Threshold: Dice=0.014, clDice=0.016, IoU=0.007, vol(pred/thr)=0.01
//      Threshold centerline: thr=1394.4mm (1118 br, avg 1.2mm)
// Mean — Pred vs GT: Dice=0.254, clDice=0.417, IoU=0.146, P=0.432, R=0.180, vol=0.42
// Mean centerline length: pred=16.0mm, gt=9.4mm
// Threshold diag: threshold=152; total thresh voxels in volume: 2,393,476; source value range: [104.0, 255.0]
// Mean — Threshold vs GT: Dice=0.043, clDice=0.042, IoU=0.022, P=0.022, R=0.881, vol=39.91
// Mean — Pred vs Threshold: Dice=0.014, clDice=0.016, IoU=0.007
// Mean threshold centerline: thr=1394.4mm

// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,ridge_threshold,ridge_iterations,auto_seed_rounds,auto_seed_max,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,4,3,2,0.01,5,8,200,176.00,23.51,8,9,14,14,0.2543,0.4166,0.1457,0.4324,0.1801,0.417,0.0431,0.0415,0.0220,0.0221,0.8814,39.909,0.0139,0.0164,0.0070,0.6730,0.0070,0.010,9.43,15.95,6.55,1394.45,29.66




















// BAD: same as what's above but ugly
// #figure(
//   results-chart(
//     (
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, col: "pred_gt_precision",   colour: rgb("#003f5c"), label: "Tool Precision"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, col: "pred_gt_precision",   colour: rgb("#78529b"), label: "Thr Precision"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, col: "pred_gt_recall", colour: rgb("#ef537d"), label: "Tool Recall"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, col: "pred_gt_precision", colour: rgb("#ffa600"), label: "Thr Recall"),
//     ),
//     1.0,
//     "Score",
//   ),
//   caption: [Precision/recall of pipeline against thresholding, using the optimal threshold for the higest DICE/clDICE],
// )







// #v(0.5cm)
// #figure(
// results-chart((
//   (col: "cl_len_pred_mm", colour: rgb("#003f5c"), label: "Tool"),
//   (col: "cl_len_thr_mm",  colour: rgb("#78529b"), label: "Threshold"),
//   (col: "gt_len",  colour: rgb("#ef537d"), label: "Ground truth"),
// ), 60.0, "mm"),
//   caption: [Continuous length estimates of predicted vessels],
// )
// #v(0.5cm)


// #figure(
//   results-chart(
//     (
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, col: "pred_gt_dice",   colour: rgb("#003f5c"), label: "Tool Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, col: "pred_gt_dice",   colour: rgb("#78529b"), label: "Thr Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, col: "pred_gt_cldice", colour: rgb("#ffa600"), label: "Thr clDice"),

//         (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         row: 19, col: "pred_gt_dice",   colour: rgb("#003f5c"), label: "Tool Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         row: 73, col: "pred_gt_dice",   colour: rgb("#78529b"), label: "Thr Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         row: 19, col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv",
//         row: 73, col: "pred_gt_cldice", colour: rgb("#ffa600"), label: "Thr clDice"),

//         (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 36, col: "pred_gt_dice",   colour: rgb("#003f5c"), label: "Tool Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 64, col: "pred_gt_dice",   colour: rgb("#78529b"), label: "Thr Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 36, col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv",
//         row: 64, col: "pred_gt_cldice", colour: rgb("#ffa600"), label: "Thr clDice"),
//     ),
//     1.0,
//     "Score",
//   ),
//   caption: [DICE and clDICE of pipeline against thresholding, using the optimal threshold for the higest DICE/clDICE],
// )










// #figure(
//   results-chart(
//     (
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, col: "pred_gt_dice",   colour: rgb("#003f5c"), label: "Tool Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, col: "pred_gt_dice",   colour: rgb("#78529b"), label: "Thr Dice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 8, col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
//       (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         row: 89, col: "pred_gt_cldice", colour: rgb("#ffa600"), label: "Thr clDice"),
//     ),
//     1.0,
//     "Score",
//     // derived-series: (
//     //   (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     //     row: 8, num: "vessel_seeds_correct", den: "vessel_seeds_total",   
//     //     colour: rgb("#003f5c"), label: "Pipeline Vessel seeds"),
//     //   (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     //     row: 89, num: "bg_seeds_correct",     den: "bg_seeds_total",   
//     //     colour: rgb("#78529b"), label: "Pipeline BG seeds"),
//     //   (csv: "../../../resources/images/results/new_pipeline_may_15/PIPE_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     //     row: 8, num: "vessel_seeds_correct", den: "vessel_seeds_total",
//     //     colour: rgb("#ef537d"), label: "Threshold Vessel seeds"),
//     //   (csv: "../../../resources/images/results/new_pipeline_may_15/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     //     row: 89, num: "bg_seeds_correct",     den: "bg_seeds_total",
//     //      colour: rgb("#ffa600"), label: "Threshold BG seeds"),
//     // )
//   ),
//   caption: [DICE and clDICE of pipeline against thresholding, using the optimal threshold for the higest DICE/clDICE],
// )









// #v(0.5cm)
// #figure(
//   results-chart((
//     (col: "pred_gt_vol", colour: rgb("#003f5c"), label: "Pred Ratio"),
//     (col: "thr_gt_vol",  colour: rgb("#ffa600"), label: "Thr Ratio"),
//   ), 24.0, "Ratio"),
//   caption: [Ratio of segmentation to ground truth volume, offering a quantification for extrapolation (higher = more extrapolation/false positives).],
// )
// #v(0.5cm)


// As shown, the algorithm produces in 2 of 6 cases an extreme extrapolation. In 4 of 6 cases, extrapolation is a lot more closely aligned with thresholding.Next, classical DICE and connection weighted clDICE scores are interesing to obseve, although they suffer from the extrapolation, for the four closely matched cases. Here it can be seen that in those 4 cases, the DICE and clDICE scores are close.
// #v(0.5cm)
// // #figure(
// //   results-chart((
// //     (col: "pred_gt_dice", colour: rgb("#003f5c"), label: "Tool Dice"),
// //     (col: "thr_gt_dice",  colour: rgb("#78529b"), label: "Thr Dice"),
// //     (col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
// //     (col: "thr_gt_cldice",  colour: rgb("#ffa600"), label: "Thr clDice"),
// //   ), 1.0, "DICE"),
// //   caption: [DICE and clDICE results],
// // )
// // DICE + seed agreement on the same chart:
// #figure(
//   results-chart(
//     (
//       (col: "pred_gt_dice", colour: rgb("#003f5c"), label: "Tool Dice"),
//       (col: "thr_gt_dice",  colour: rgb("#78529b"), label: "Thr Dice"),
//       (col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
//       (col: "thr_gt_cldice",  colour: rgb("#ffa600"), label: "Thr clDice"),
//     ),
//     1.0,
//     "Score",
//     derived-series: (
//       // (num: "vessel_seeds_correct", den: "vessel_seeds_total", colour: rgb("#ef537d"), label: "Pipeline Vessel seeds"),
//       // (num: "bg_seeds_correct",     den: "bg_seeds_total",     colour: rgb("#ffa600"), label: "Pipeline BG seeds"),
//       // (num: "thr_vessel_seeds_correct", den: "thr_vessel_seeds_total", colour: rgb("#ef537d"), label: "Threshold Vessel seeds"),
//       // (num: "thr_bg_seeds_correct",     den: "thr_bg_seeds_total",     colour: rgb("#ffa600"), label: "Threshold BG seeds"),
//     )
//   ),
//   caption: [DICE vs seed agreement],
// )
// #v(0.5cm)

// This shows what appears to be substantially better performance than our tool, however when evaluating the length of predicted vessels within the ground truth:


// #v(0.5cm)
// #figure(
//   results-chart(
//     (
//       (col: "pred_gt_dice", colour: rgb("#003f5c"), label: "Tool Dice"),
//       (col: "thr_gt_dice",  colour: rgb("#78529b"), label: "Thr Dice"),
//       (col: "pred_gt_cldice", colour: rgb("#ef537d"), label: "Tool clDice"),
//       (col: "thr_gt_cldice",  colour: rgb("#ffa600"), label: "Thr clDice"),
//     ),
//     1.0,
//     "Score",
//     derived-series: (
//       (num: "vessel_seeds_correct", den: "vessel_seeds_total", colour: rgb("#003f5c"), label: "Pipeline Vessel seeds"),
//       (num: "bg_seeds_correct",     den: "bg_seeds_total",     colour: rgb("#78529b"), label: "Pipeline BG seeds"),
//       (num: "thr_vessel_seeds_correct", den: "thr_vessel_seeds_total", colour: rgb("#ef537d"), label: "Threshold Vessel seeds"),
//       (num: "thr_bg_seeds_correct",     den: "thr_bg_seeds_total",     colour: rgb("#ffa600"), label: "Threshold BG seeds"),
//     )
//   ),
//   caption: [DICE, clDICE & seed agreement],
// )
// #v(0.5cm)





// #v(0.5cm)
// #figure(
// results-chart((
//   (col: "cl_len_pred_mm", colour: rgb("#003f5c"), label: "Tool"),
//   (col: "cl_len_thr_mm",  colour: rgb("#78529b"), label: "Threshold"),
//   (col: "gt_len",  colour: rgb("#ef537d"), label: "Ground truth"),
// ), 60.0, "mm"),
//   caption: [Continuous length estimates of predicted vessels],
// )
// #v(0.5cm)


// Precision / recall allow us to disentangle the issue of false positives and oversegmentation:

// #v(0.5cm)
// #figure(
//   results-chart((
//     (col: "pred_gt_precision", colour: rgb("#003f5c"), label: "Tool precision"),
//     (col: "thr_gt_precision",  colour: rgb("#78529b"), label: "Thresh precision"),
//     (col: "pred_gt_recall",  colour: rgb("#ef537d"), label: "Tool recall"),
//     (col: "thr_gt_recall",  colour: rgb("#ffa600"), label: "Thresh recall"),
//   ), 1.0, "mm"),
//   caption: [Precision/recall analysis],
// )
// #v(0.5cm)

// From this graph we can see that the precision is consistently lower than thresholding, however recall is higher. 


// === Qualitative analysis


// Crop for CA-RU-R 666
// 1537 528
// 3237 528
// 1537 1905
// 3237 1905




// #v(0.5cm)
// #figure(
//   // pr-curve((
//   //   ("../../../resources/images/sweep_experiment/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv", "Thresholding", rgb("#e63946")),
//   //   ("../../../resources/images/sweep_experiment/SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv", "CollaboratiVessel", rgb("#457b9d")),
//   //   ("../../../resources/images/sweep_experiment/frangi_sweep_005/FRANGI_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv", "Frangi", rgb("#ff1a1a")),
//   //   ("../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv", "Frangi Wider", rgb("#1afbff")),
//   // )),

//   pr-curve((
//   (
//     csv:    "../../../resources/images/sweep_experiment/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     label:  "Thresholding",
//     colour: rgb("#e63946"),
//     x: (num: "bg_seeds_correct",     den: "bg_seeds_total"),
//     y: (num: "vessel_seeds_correct",  den: "vessel_seeds_total"),
//   ),
//   (
//     csv:    "../../../resources/images/sweep_experiment/SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     label:  "CollaboratiVessel",
//     colour: rgb("#457b9d"),
//     x: (num: "bg_seeds_correct",     den: "bg_seeds_total"),
//     y: (num: "vessel_seeds_correct",  den: "vessel_seeds_total"),
//   ),
//   (
//     csv:    "../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//     label:  "Frangi",
//     colour: rgb("#b4d94d"),
//     x: (num: "bg_seeds_correct",     den: "bg_seeds_total"),
//     y: (num: "vessel_seeds_correct",  den: "vessel_seeds_total"),
//   ),
//   )),
//   caption: [CA-RU-R 222 
  
//   Precision recall curve comparing thresholding with our algorithm, highlighting the regime differences. Precision of 100% is never reached because certain high valued pixels do not belong to vessels, and invesely ],
// )
// #v(0.5cm)
// Peak precision 0.6342 at threshold_193 w recall 0.2058
// 




// Intermediary old may 15 15h15
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.277, clDice=0.400, IoU=0.161, P=0.602, R=0.180, vol(pred/gt)=0.30
//      GT=109,490 vox, pred=32,697 vox, shape=(222, 216, 229), src IJK=[0:229, 0:216, 0:222]
//      Centerlines: pred=19.7mm (79 br, avg 0.2mm), gt=27.0mm (131 br, avg 0.2mm)
//      Threshold (151) vs GT: Dice=0.173, clDice=0.178, IoU=0.095, P=0.099, R=0.697, vol(thr/gt)=7.07, thr=774,304 vox
//      Pred vs Threshold: Dice=0.048, clDice=0.075, IoU=0.025, vol(pred/thr)=0.04
//      Threshold centerline: thr=189.1mm (958 br, avg 0.2mm)
// Mean — Pred vs GT: Dice=0.277, clDice=0.400, IoU=0.161, P=0.602, R=0.180, vol=0.30
// Mean centerline length: pred=19.7mm, gt=27.0mm
// Threshold diag: threshold=151; total thresh voxels in volume: 790,886; source value range: [0.0, 255.0]
// Mean — Threshold vs GT: Dice=0.173, clDice=0.178, IoU=0.095, P=0.099, R=0.697, vol=7.07
// Mean — Pred vs Threshold: Dice=0.048, clDice=0.075, IoU=0.025
// Mean threshold centerline: thr=189.1mm

// CSV:
// chunk,vessel_size,vessel_std,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,vessel_seeds_correct,vessel_seeds_total,bg_seeds_correct,bg_seeds_total,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_gt_mm,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mmVSA_Eval_1,4,3,1,True,0.1,0.01,5,True,8,200,1.2,0.05,163.00,30.05,23,27,11,11,0.2769,0.4004,0.1607,0.6022,0.1798,0.299,0.1727,0.1779,0.0945,0.0986,0.6970,7.072,0.0480,0.0749,0.0246,0.5923,0.0250,0.042,26.99,19.72,10.06,189.10,19.33
// Intermediary old may 15 15h15


// PR curve 
// #figure(
//     xy-curve(
//     (
//       (csv: "../../../resources/images/sweep_experiment/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         label: "Thresholding",      colour: rgb("#e63946")),
//       (csv: "../../../resources/images/sweep_experiment/SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         label: "CollaboratiVessel", colour: rgb("#457b9d")),
//       (csv: "../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//         label: "Frangi", colour: rgb("#459d6b")),
//     ),
//     x-label: "Recall",
//     y-label: "Precision",
//   ),
//   caption:[CA-RU-R 222]
// )

// #figure(
//   xy-curve(
//     (
//       (
//         csv: "../../../resources/images/sweep_experiment/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//           label: "Thresholding", colour: rgb("#e63946"),
//         x: (num: "bg_seeds_correct",     den: "bg_seeds_total"),
//         y: (num: "vessel_seeds_correct", den: "vessel_seeds_total"),
//       ),
//       (
//         csv: "../../../resources/images/sweep_experiment/SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//           label: "CollaboratiVessel", colour: rgb("#457b9d"),
//         x: (num: "bg_seeds_correct",     den: "bg_seeds_total"),
//         y: (num: "vessel_seeds_correct", den: "vessel_seeds_total"),
//       ),
//       (
//         csv: "../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
//           label: "Frangi", colour: rgb("#459d6b"),
//         x: (num: "bg_seeds_correct",     den: "bg_seeds_total"),
//         y: (num: "vessel_seeds_correct", den: "vessel_seeds_total"),
//       ),
//     ),
//     x-label: "BG seed accuracy",
//     y-label: "Vessel seed accuracy",
//   )
// )


// #v(0.5cm)
// #figure(
//   pr-curve((
//     ("../../../resources/images/sweep_experiment/THRESH_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv", "Thresholding", rgb("#e63946")),
//     ("../../../resources/images/sweep_experiment/SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv", "CollaboratiVessel", rgb("#457b9d")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_005/FRANGI_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv", "Frangi", rgb("#ff1a1a")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-RU-R_x_687_y_451_z_666_experiment.csv", "Frangi Wider", rgb("#1afbff")),
//   )),
//   caption: [CA-RU-R 666],
// )
// #v(0.5cm)



// #v(0.5cm)
// #figure(
//   pr-curve((
//     ("../../../resources/images/sweep_experiment/THRESH_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv", "Thresholding", rgb("#e63946")),
//     ("../../../resources/images/sweep_experiment/SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv", "CollaboratiVessel", rgb("#457b9d")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_005/FRANGI_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv", "Frangi", rgb("#ff1a1a")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-LL-R_x+298_y+233_z+427_experiment.csv", "Frangi Wider", rgb("#1afbff")),
//   )),
//   caption: [CA-LL-R 427],
// )
// #v(0.5cm)

// 319
// #v(0.5cm)
// #figure(
//   pr-curve((
//     ("../../../resources/images/sweep_experiment/THRESH_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv", "Thresholding", rgb("#e63946")),
//     ("../../../resources/images/sweep_experiment/SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv", "CollaboratiVessel", rgb("#457b9d")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_005/FRANGI_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv", "Frangi", rgb("#ff1a1a")),
//     // ("../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-NM-L_x+1800_y+1800_z+319_experiment.csv", "Frangi Wider", rgb("#1afbff")),
//   )),
//   caption: [CA-NM-L 319],
// )
// #v(0.5cm)


// 957
// #v(0.5cm)
// #figure(
//   pr-curve((
//     ("../../../resources/images/sweep_experiment/THRESH_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv", "Thresholding", rgb("#e63946")),
//     ("../../../resources/images/sweep_experiment/SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv", "CollaboratiVessel", rgb("#457b9d")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_005/FRANGI_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv", "Frangi", rgb("#ff1a1a")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-NM-L_x+900_y+900_z+957_experiment.csv", "Frangi Wider", rgb("#1afbff")),
//   )),
//   caption: [CA-NM-L 957],
// )
// #v(0.5cm)

// 498
// #v(0.5cm)
// #figure(
//   pr-curve((
//     ("../../../resources/images/sweep_experiment/THRESH_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", "Thresholding", rgb("#e63946")),
//     ("../../../resources/images/sweep_experiment/SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", "CollaboratiVessel", rgb("#457b9d")),
//     ("../../../resources/images/sweep_experiment/frangi_sweep_005/FRANGI_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", "Frangi", rgb("#ff1a1a")),
//     // ("../../../resources/images/sweep_experiment/frangi_sweep_0025_and_vessel_diversity/FRANGI_SLICES_CA-LL-L1_x+559_y+604_z+498_experiment.csv", "Frangi Wider", rgb("#1afbff")),
//   )),
//   caption: [CA-LL-L1 498],
// )
// #v(0.5cm)












// === CA-RU-R
// The CA-RU-R tumor comes from Run 2 and is considered reliable. Point 1 was dropped as it is outside of the volume of interest
// //17 Vessel, 6 Background and 8 Outside points were placed, with vessel size estimate of 3 +/-3 voxels measured using the data probe tool, and the denoise kernel set to 8 voxels. All other settings were left to default.
// // The pipeline ran for 166 seconds, with a reported mean vessel value was 178 with a standard deviation of 37. This mean was used for a thresholding segmentation, in order to compare the two methods as well as compare them with the manually annotated ground truth.


// ==== 222:

// 3 5 8 
// Intensity: μ_v=175.2±32.9
// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.327, clDice=0.382, IoU=0.196, P=0.288, R=0.378, vol(pred/gt)=1.31
//      GT=109,490 vox, pred=143,797 vox, shape=(222, 216, 229), src IJK=[0:229, 0:216, 0:222]
//      Centerlines: pred=16.2mm (35 br, avg 0.5mm), gt=27.0mm (131 br, avg 0.2mm)
//      Threshold (175) vs GT: Dice=0.413, clDice=0.354, IoU=0.261, P=0.526, R=0.341, vol(thr/gt)=0.65, thr=70,899 vox
//      Pred vs Threshold: Dice=0.376, clDice=0.472, IoU=0.231, vol(pred/thr)=2.03
//      Threshold centerline: thr=11.1mm (217 br, avg 0.1mm)

// Mean — Pred vs GT: Dice=0.327, clDice=0.382, IoU=0.196, P=0.288, R=0.378, vol=1.31
// Mean centerline length: pred=16.2mm, gt=27.0mm
// Threshold diag: threshold=175; total thresh voxels in volume: 71,323; source value range: [0.0, 255.0]
// Mean — Threshold vs GT: Dice=0.413, clDice=0.354, IoU=0.261, P=0.526, R=0.341, vol=0.65
// Mean — Pred vs Threshold: Dice=0.376, clDice=0.472, IoU=0.231
// Mean threshold centerline: thr=11.1mm


// chunk,vessel_size,vessel_std,denoise_kernel,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mm
// CA-RU-R_x+916_y+901_z+222,3,5,8,2,True,0.1,0.01,5,True,8,200,1.2,0.05,163.00,30.05,0.3271,0.3815,0.1956,0.2881,0.3784,1.313,0.4135,0.3539,0.2606,0.5260,0.3406,0.648,0.3759,0.4719,0.2315,0.2806,0.5691,2.028,16.21,7.25,11.05,5.50




// ==== 666:

// 3 4 8 Intensity: μ_v=145.9±8.8, 8/9 vessels correct

// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.087, clDice=0.198, IoU=0.046, P=0.046, R=0.833, vol(pred/gt)=18.11
//      GT=15,954 vox, pred=288,856 vox, shape=(215, 225, 229), src IJK=[0:229, 0:225, 0:215]
//      Centerlines: pred=36.0mm (43 br, avg 0.8mm), gt=5.3mm (34 br, avg 0.2mm)
//      Threshold (146) vs GT: Dice=0.271, clDice=0.410, IoU=0.157, P=0.651, R=0.171, vol(thr/gt)=0.26, thr=4,196 vox
//      Pred vs Threshold: Dice=0.026, clDice=0.122, IoU=0.013, vol(pred/thr)=68.84
//      Threshold centerline: thr=2.1mm (110 br, avg 0.0mm)

// Mean — Pred vs GT: Dice=0.087, clDice=0.198, IoU=0.046, P=0.046, R=0.833, vol=18.11
// Mean centerline length: pred=36.0mm, gt=5.3mm
// Threshold diag: threshold=146; total thresh voxels in volume: 4,216; source value range: [49.0, 197.0]
// Mean — Threshold vs GT: Dice=0.271, clDice=0.410, IoU=0.157, P=0.651, R=0.171, vol=0.26
// Mean — Pred vs Threshold: Dice=0.026, clDice=0.122, IoU=0.013
// Mean threshold centerline: thr=2.1mm


// chunk,vessel_size,vessel_std,denoise_kernel,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mm
// SLICES CA-RU-R_x+687_y+451_z+666,3,4,8,2,True,0.1,0.01,5,True,8,200,1.2,0.05,138.00,9.16,0.0872,0.1984,0.0456,0.0460,0.8333,18.106,0.2711,0.4098,0.1568,0.6509,0.1712,0.263,0.0261,0.1218,0.0132,0.0132,0.9104,68.841,35.96,4.04,2.09,1.34



// // ==== 1110
// // Outside of volume




// === CA-LL-R
// Run 2, settings 2 2 4, small vessels, low contrast and low resolution hence the small smoothing

// // ==== 711 
// // Outside of volume 
// // ==== 569 
// // Outside of volume

// ==== 427:

// Intensity: μ_v=119.2±4.1, 7/7 vessels 2/3 background

// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.079, clDice=0.223, IoU=0.041, P=0.041, R=0.953, vol(pred/gt)=23.08
//      GT=2,643 vox, pred=61,003 vox, shape=(91, 95, 99), src IJK=[0:99, 0:95, 51:142]
//      Centerlines: pred=9.4mm (4 br, avg 2.4mm), gt=1.4mm (15 br, avg 0.1mm)
//      Threshold (119) vs GT: Dice=0.543, clDice=0.628, IoU=0.373, P=0.421, R=0.767, vol(thr/gt)=1.82, thr=4,821 vox
//      Pred vs Threshold: Dice=0.135, clDice=0.338, IoU=0.072, vol(pred/thr)=12.65
//      Threshold centerline: thr=2.0mm (75 br, avg 0.0mm)

// Mean — Pred vs GT: Dice=0.079, clDice=0.223, IoU=0.041, P=0.041, R=0.953, vol=23.08
// Mean centerline length: pred=9.4mm, gt=1.4mm
// Threshold diag: threshold=119; total thresh voxels in volume: 5,959; source value range: [89.0, 156.0]
// Mean — Threshold vs GT: Dice=0.543, clDice=0.628, IoU=0.373, P=0.421, R=0.767, vol=1.82
// Mean — Pred vs Threshold: Dice=0.135, clDice=0.338, IoU=0.072
// Mean threshold centerline: thr=2.0mm


// chunk,vessel_size,vessel_std,denoise_kernel,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mm

// SLICES CA-LL-R_x+298_y+233_z+427,3,4,8,2,True,0.1,0.01,5,True,8,200,1.2,0.05,125.00,7.82,0.0792,0.2233,0.0412,0.0413,0.9531,23.081,0.5434,0.6275,0.3731,0.4207,0.7673,1.824,0.1350,0.3382,0.0724,0.0728,0.9214,12.654,9.41,1.19,1.97,0.97



// === CA-NM-L
// Run 2

// // ==== 0
// // Outside of volume

// ==== 319
// Barely in volume, Gradient


// Intensity: μ_v=177.2±18.1, 3 4 8 7/7 vessels correct, 10/10 background correct

// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.293, clDice=0.547, IoU=0.171, P=0.180, R=0.786, vol(pred/gt)=4.37
//      GT=11,115 vox, pred=48,587 vox, shape=(197, 124, 124), src IJK=[0:124, 0:124, 122:319]
//      Centerlines: pred=3.9mm (19 br, avg 0.2mm), gt=2.5mm (17 br, avg 0.1mm)
//      Threshold (177) vs GT: Dice=0.233, clDice=0.089, IoU=0.132, P=0.142, R=0.662, vol(thr/gt)=4.67, thr=51,883 vox
//      Pred vs Threshold: Dice=0.349, clDice=0.307, IoU=0.212, vol(pred/thr)=0.94
//      Threshold centerline: thr=56.1mm (612 br, avg 0.1mm)

// Mean — Pred vs GT: Dice=0.293, clDice=0.547, IoU=0.171, P=0.180, R=0.786, vol=4.37
// Mean centerline length: pred=3.9mm, gt=2.5mm
// Threshold diag: threshold=177; total thresh voxels in volume: 187,297; source value range: [0.0, 255.0]
// Mean — Threshold vs GT: Dice=0.233, clDice=0.089, IoU=0.132, P=0.142, R=0.662, vol=4.67
// Mean — Pred vs Threshold: Dice=0.349, clDice=0.307, IoU=0.212
// Mean threshold centerline: thr=56.1mm

// chunk,vessel_size,vessel_std,denoise_kernel,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,
// SLICES CA-NM-L_x+1800_y+1800_z+319,3,4,8,2,True,0.1,0.01,5,True,8,200,1.2,0.05,191.00,33.73,0.2927,0.5468,0.1714,0.1798,0.7860,4.371,0.2335,0.0894,0.1322,0.1417,0.6616,4.668,0.3492,0.3075,0.2116,0.3611,0.3381,0.936,3.93,1.64,56.15,2.65


// ==== 957

// SLICES CA-NM-L_x+900_y+900_z+957
// Large vessels with high difference wrt background.
// 4 6 8 Intensity: μ_v=198.0±38.0,

// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.566, clDice=0.685, IoU=0.395, P=0.479, R=0.691, vol(pred/gt)=1.44
//      GT=109,713 vox, pred=158,263 vox, shape=(301, 409, 450), src IJK=[0:450, 41:450, 0:301]
//      Centerlines: pred=13.5mm (10 br, avg 1.3mm), gt=8.1mm (15 br, avg 0.5mm)
//      Threshold (198) vs GT: Dice=0.744, clDice=0.795, IoU=0.592, P=0.981, R=0.599, vol(thr/gt)=0.61, thr=67,068 vox
//      Pred vs Threshold: Dice=0.521, clDice=0.571, IoU=0.352, vol(pred/thr)=2.36
//      Threshold centerline: thr=6.6mm (20 br, avg 0.3mm)

// Mean — Pred vs GT: Dice=0.566, clDice=0.685, IoU=0.395, P=0.479, R=0.691, vol=1.44
// Mean centerline length: pred=13.5mm, gt=8.1mm
// Threshold diag: threshold=198; total thresh voxels in volume: 67,070; source value range: [43.0, 255.0]
// Mean — Threshold vs GT: Dice=0.744, clDice=0.795, IoU=0.592, P=0.981, R=0.599, vol=0.61
// Mean — Pred vs Threshold: Dice=0.521, clDice=0.571, IoU=0.352
// Mean threshold centerline: thr=6.6mm

// chunk,vessel_size,vessel_std,denoise_kernel,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mm
// SLICES CA-NM-L_x+900_y+900_z+957,4,6,8,2,True,0.1,0.01,5,True,8,200,1.2,0.05,213.00,39.27,0.5660,0.6850,0.3947,0.4792,0.6912,1.443,0.7441,0.7953,0.5924,0.9806,0.5995,0.611,0.5207,0.5713,0.3520,0.3707,0.8746,2.360,13.48,7.43,6.56,6.46




// === CA-LL-L1
// Run 1, unreliable, very noisy

// // ==== 0
// // Outside of volume

// // ==== 249
// // 2 3 12
// // noisy, very few vessels, mostly air, dropped

// ==== 498

// 5/9 vessels
// 3 4 8 Intensity: μ_v=172.3±20.5, 
// SLICES CA-LL-L1_x+559_y+604_z+498

// Evaluation against ground-truth chunks
// (metrics on GT>0 bbox + 5-voxel margin)
//   • VSA_Eval_1: Dice=0.202, clDice=0.322, IoU=0.112, P=0.126, R=0.513, vol(pred/gt)=4.08
//      GT=27,722 vox, pred=113,162 vox, shape=(249, 201, 186), src IJK=[0:186, 0:201, 0:249]
//      Centerlines: pred=13.3mm (17 br, avg 0.8mm), gt=4.6mm (28 br, avg 0.2mm)
//      Threshold (172) vs GT: Dice=0.258, clDice=0.180, IoU=0.148, P=0.160, R=0.666, vol(thr/gt)=4.16, thr=115,442 vox
//      Pred vs Threshold: Dice=0.390, clDice=0.379, IoU=0.242, vol(pred/thr)=0.98
//      Threshold centerline: thr=37.2mm (755 br, avg 0.0mm)

// Mean — Pred vs GT: Dice=0.202, clDice=0.322, IoU=0.112, P=0.126, R=0.513, vol=4.08
// Mean centerline length: pred=13.3mm, gt=4.6mm
// Threshold diag: threshold=172; total thresh voxels in volume: 115,442; source value range: [104.0, 255.0]
// Mean — Threshold vs GT: Dice=0.258, clDice=0.180, IoU=0.148, P=0.160, R=0.666, vol=4.16
// Mean — Pred vs Threshold: Dice=0.390, clDice=0.379, IoU=0.242
// Mean threshold centerline: thr=37.2mm

// chunk,vessel_size,vessel_std,denoise_kernel,frangi_tiles_per_axis,intensity_likelihood,vessel_prior,ridge_threshold,ridge_iterations,auto_seed,auto_seed_rounds,auto_seed_max,auto_seed_intensity_sigma,component_min_prob,median_intensity,std_intensity,pred_gt_dice,pred_gt_cldice,pred_gt_iou,pred_gt_precision,pred_gt_recall,pred_gt_vol,thr_gt_dice,thr_gt_cldice,thr_gt_iou,thr_gt_precision,thr_gt_recall,thr_gt_vol,pred_thr_dice,pred_thr_cldice,pred_thr_iou,pred_thr_precision,pred_thr_recall,pred_thr_vol,cl_len_pred_mm,cl_match_pred_mm,cl_len_thr_mm,cl_match_thr_mm
// SLICES CA-LL-L1_x+559_y+604_z+498,3,4,8,2,True,0.1,0.01,5,True,8,200,1.2,0.05,182.00,25.71,0.2020,0.3221,0.1123,0.1257,0.5132,4.082,0.2580,0.1804,0.1481,0.1600,0.6662,4.164,0.3902,0.3788,0.2424,0.3941,0.3863,0.980,13.33,2.96,37.19,3.88


// === Visualizations

// smallest_run,smallest_run_slices,reliable, number of slices done
// Run 2,Slices CA-LL-R,true, 3 -> did the small ones :(
//CA-LL-R 415 424 1938

// Run 2,Slices CA-RU-R,true, 3

// Run 2,Slices CB-RURL-R,true
// Run 2,Slices CB-LURU-L, true
// Run 2,Slices CA-LL-L,true

// Run 2,Slices CA-NM-L,true, 3 -> NW 900 works well on just regular thresholding -> I DID RUN 2 IN NW


// Run 1,Slices CA-NM-L,true, 0 
// Run 1,Slices CA-LL-L1,false, 2  

// Run 1,Slices CA-LL-L2,false
// Run 1,Slices CA-RU-R,true
// Run 1,Slices CB-LLRL-L,false








// = Ablation and simplification

// == Motivation: performance limits at scale <performance_and_memory>
//    [the data management + performance content, compressed]

// == Ablation methodology
//    [how you set probability-map weights to zero, what you measured]

// == Findings
//    [the table, with the key insight: Frangi alone delivers 
//     nearly the same point-wise accuracy as the full pipeline,
//     at a fraction of the runtime and memory cost]

// == Implications
//    [what gets kept (Frangi), what gets cut (random forest, 
//     marching squares for vessel growth, complex probability stacking),
//     and what new problems remain (false positives, small-vessel 
    // handling, evaluation methodology) — preview of Chapter 3


