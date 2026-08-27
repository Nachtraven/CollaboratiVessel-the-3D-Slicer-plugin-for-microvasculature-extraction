// #import "./appendices/graph_results.typ": results-chart
#import "appendices/precision_recall.typ" : xy-curve

// Problem statement: 2 pages, contains general goal, objectives
// summarize points mentioned in SOTA
// Highligts important remaining research questions, main goal and sub objectives

// - ✓ Formulate again relevant, simple, measurable, and feasible research questions that are still remaining (should be clear after reading the SOTA)
// - ✓ State the research aim or hypothesis of the project, and formulate concrete objectives

// Recap 2/3 sentences, restate the situation that the SOTA established.
// Gap/aim: Name the unfilled niche, and state your aim as a positive proposition.
// Objectives: Concrete, scoped sub-goals that together meet the aim.


// Comment: Microvasculature in CECT Micro-CT data is characterized by small and low contrast vessels with discontinuities and diffusion-induced intensity gradients. Existing extraction methods divide between data-driven approaches that require annotated training data unavailable for this regime, and classical methods that require careful hyperparameter tuning. Existing software pipelines generally target large vasculature or are unintegrated into software tools.

// Alternative question formulation:
// "Can a classical-method extraction pipeline driven by sparse user input produce useful microvasculature segmentations on CECT data without requiring annotated training data?" (yes/no testable)
// "How can sparse user input be used to drive a classical extraction pipeline that handles the discontinuities and gradient artifacts of CECT microvasculature data?" (mechanism question)
= Problem statement, goal and objectives

== Problem statement
In a diverse software landscape for analysis of 3D data, this work aims to answer the question _"How can an open-source microvasculature extraction pipeline be developed, able to be used by non-computer scientists, leveraging classical segmentation methods and sparse user-driven input to produce improved segmentations when compared to thresholding on CECT data across a diverse dataset?"_ Answering this question requires abiding by three principal constraints:

#linebreak()
*(i)* Data: CECT tissue microvasculature with compression artifacts, intensity gradients and discontinuities, and a highly imbalanced data distribution with small target structures only a few voxels across. 

#linebreak()
*(ii)* Segmentation and its two paradigms: _data-driven_ methods (machine learning) with potentially high performance but transferring poorly across datasets and requires annotated training data that is difficult to generate for CECT, and _classical_ methods that encode vessel priors explicitly but require hyperparameter tuning, and reason locally with poor extrapolation resulting in fragmented segmentations and weaker performance in low-contrast regions.

#linebreak()
*(iii)* Tooling: existing software is focused on low resolution data, human arteries and organs with large vessels and few disconnections. Microvasculature extraction methods are sparse, rarely tailor-made or integrated into available tooling

// To make the segmentation gap concrete thresholding is used as a reference:, the simplest existing and most accessible method that has previously been used to tackle this issue

== Goal and objectives

// Split this up?
This thesis aims to develop a 3D Slicer extension that produces connected microvasculature segmentations on CECT through a hybrid pipeline combining classical algorithms with sparse user input, achieving higher vessel retrieval rates than thresholding while  also improving connectivity, measured using a bipartite matching and clDice, operating across data with strong and weak contrast gradients.

#linebreak()
To do so, the following objects must be defined:
1. Deliver a user-friendly 3D Slicer extension able to export in formats useful for downstream analysis.
2. Leverage a user-in-the-loop approach for point placement & basic vessel-size context to drive automated parameter selection, replacing manual error-prone hyperparameter tuning.
3. Build the segmentation core on multiple algorithms, combined through a framework that enables per component tuning, evaluation and allows for future extension. 


#linebreak()
To make the segmentation gap concrete, the simple and previously used approach of intensity thresholding is evaluated. The shortcomings are expressed in @fig:pr_methodo: a sweep is run across all possible thresholding values, and measure against a manually annotated ground truth on an illustrative subvolume that contains small disconnected vessels, a light gradient, and some noisy elements. The precision-recall curve ignores true negatives and avoids giving them an outsized weight, but still allows us to understand the problem at hand: classical thresholding, no matter how high, will include false positives (_all high valued voxels are not necessarily vessels, the structural gap (1)_) such as in the shell region in @fig:thresholding_with_shell and at low values needed to capture faint vessels, the false positives are very high (_vessel intensities overlap with background, a challenging extraction situation, making thresholding a compromise (2)_).

// TODO: Could I better explain the trade-off? Would an ROC curve be better than precision/recall?
// PR curve 
// Precision  = True Positives / (True Positives + False Positives)
// Recall     = True Positives / (True Positives + False Negatives)
#v(0.15cm)
#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: top,
    image("../../resources/images/methodology_pr_curve_data_with_bar.jpg", width: 90%),
    
    
    box[
      #xy-curve(
        (
          (csv: "../../../resources/images/sweep_experiment/THRESH_SLICES_CA-RU-R_x_916_y_901_z_222_experiment.csv",
          label: "Thresholding",
          colour: rgb("#e63946")),
        ),
        x-label: "Recall",
        y-label: "Precision",
        chart-width:180pt,
        chart-height:180pt,
        pad-left: 12pt,
        pad-bottom: 2pt,
        legend-width: 70pt,
        // show-legend: false
      )

      // Arrow 1 — points up-left
      #place(left + top,
        dx: 30pt, dy: 45pt,
        line(
          start: (0pt, 20pt),
          end: (0pt, -40pt),
          stroke: 1pt + black,
          // marker-end: "stealth",
        )
      )
      #place(left + top,
        dx: 35pt, dy: 25pt,
        text(size: 8pt)[_(1) structural gap_]
      )

      // Arrow 2 — points down-right
      #place(left + top,
        dx: 110pt, dy: 130pt,
        line(
          start: (0pt, 0pt),
          end: (40pt, 30pt),
          stroke: 1pt + black,
          // marker-end: "stealth",
        )
      )
      #place(left + top,
        dx: 110pt, dy: 115pt,
        text(size: 8pt)[_(2) challenging extraction_]
      )
    ]
  ), //Run 2 CA-RU-R
  caption: [*(Left)* Typical CECT cross section, with vessels (high valued, inside the sample) and non-vessel-like structures (high signal areas on the outside) *(Right)* Thresholding precision-recall curve showing _(1) structural gap_: precision never reaches 1.0 because there are false positives in high valued areas and _(2) challenging extraction_: precision falls off sharply as recall increases due to the rapid increase in false positives; high recall cannot be achieved without sacrificing precision]
) <fig:pr_methodo>