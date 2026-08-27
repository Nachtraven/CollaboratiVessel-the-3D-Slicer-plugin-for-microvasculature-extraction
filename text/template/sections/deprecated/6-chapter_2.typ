= Contending with limitations 

// Here we want to talk about the issue encountered after the last step previously: I developed the algo looking at one piece of data (the smallest). Inference was taking over an hour and using nearly all my RAM (baseline RAM of 9gb, when the data was loaded it was 13 and when running the pipeline it reached ~44 out of a total maximum of 48).
// When I tried to infer on other datasets, it either ran out of ram or took extremely long time. This prompted the ablation study
// The ablation study showed that Frangi was the largest contributor.
// As a result, I re-started the process from frangi, and this is detailed in the last chapter: I manually annotate some data as a baseline and use a new pipeline for extraction.

== Micro-CT Data management challenges

// TODO: Insert image of the provided folder/data? 
Data management for Micro-CT scans is a challenge for users: after a scan is completed, they receive data from the CT machine in the form of a collection of 16 bit TIFF files: heavy, with a single 2000x2300 slice at 16bits per pixel weighing *9.2MB*, or as is often the case the data is saved as 3 channels, resulting in 27.6MB, and a whole 2400 slice scan weighing at least *22.1GB*. Scans are then windowed to 8 bit, occasionally with some form of compression, and the empty slices are removed: this generally halves or more the total data amount. This windowing process was documented as being unprincipled: the window was chosen based on the researchers best judgment, and the original uncompressed data discarded.

Furthermore, certain researchers would then carry out a lossy compression of the data in the form of JPEG image slices, as was the case with the data used in this thesis: the total scan weights provided ranged from *0.103* to *13.2GB* (597x698x854 to 3000x3000x2653) and the original lossless data was not preserved, in both cases the windowing and the compression were motivated by data storage cost concerns.

Finally, the provided data was generally given with little or no context: the data was provided in the form of a folder containing images as well as experiments that were run, with no associated dates and without grounding context such as the scan voxel size or parameters of the scanning machine. These issues of dataset size and compression resulted in challenges unforseen during the literature review which required particular attention.


== Performance challenges

The initial plugin development phase took place using the CA-LL-R dataset, the smallest uncompressed dataset @uncompressed_dataset_size, to enable rapid prototyping and evaluation of the performance. Following the initial success in extraction based on points placed by the user, tests were carried out on larger datasets.




// #let stats = csv("../../Thesis-Sean-Nachtrab-EPL-25-26/prototyping_scratchpad/CE-CT_study_angiogenesis_stats.csv")
#import "@preview/lilaq:0.6.0" as lq

#let xs = range(9)
#let ys = (12, 51, 23, 36, 38, 15, 10, 22, 86)

#lq.diagram(
  width: 9cm,
  xaxis: (subticks: none),

  lq.bar(
    xs, ys
  ),

  ..xs.zip(ys).map(((x, y)) => {
    let align = if y > 12 { top } else { bottom }
    lq.place(x, y, pad(0.2em)[#y], align: align)
  })
)

#v(0.5cm)
#figure(
  image("../../resources/misc/uncompressed_image_folder_sizes.png", width:90%),
  caption: [TODO: This is a placeholder. TODO: Add horizontal lines for the RAM of computers. 
  
  Visualization of the raw dataset sizes, obtained by multiplying width, height and depth by 8 bits per pixel],
) <uncompressed_dataset_size>
#v(0.5cm)


As noted in @data_intro, the total data required for an uncompressed scan can reach into the tens or hundreds of GB. During the initial software evaluation, 3D Slicer was successful in loading all datasets on the development machine - however it was not verified at the time how much memory was being used. The testing of the pipeline on other datasets revealed the performance limitations of the implemented approach: with initial end to end runtime being about an hour and requiring 24GB of system memory, larger datasets saw an increase in inference time to un-manageable levels, as well as limitations of system memory. 

These performance issues have multiple sources: when implementing a 3D Slicer plugin in python, a single thread is available, and this thread locks all other 3D Slicer activity (this fact extends to other 3D Slicer functions such as loading and saving). When running on a large scan, combined with the generation of probability maps and the sequential algorithms, memory usage exceeded ram, reached into swap, and could run seemingly indefinitely (success was only observed on smaller scans). This is a known issue with 3D Slicer #footnote[Performance limitations as #link("https://discourse.slicer.org/t/title-slow-and-unstable-performance/4988")[discussed on here the forums]].


#v(0.5cm)
#figure(
  grid(
    rows: 2,
    // columns: 2,
    gutter: 3pt,
    image("../../resources/misc/RAM_cpu_use_during_a_run.png", width: 90%),
    image("../../resources/misc/RAM-cb-luru-r.png", width: 90%),
  ),
  caption: [1. CA-LL-L2 RAM utilization during segmentation: baseline after loading dataset, below 24GB utilization, during processing 100% RAM and swap are used, 2. Run 1, CB-LURU-R showing full RAM and SWAP utilization],
) <system_performance>
#v(0.5cm)


#linebreak()
Methods exist to handle such large datasets: the most basic approach is cutting down of full scans into smaller chunks, or subsampling the scans with some form of interpolation. Cutting scans down has the disadvantage of requiring stitching after running algorithms, and if done using 3D slicer's built in slicing, requires the ability to load the full dataset. An experiment was run, where a target scan was cut into 4 smaller sections using Python; this proved to be unwieldy for annotation and running the pipeline. Subsampling requires the the target structures to be large enough to allow it: subsampling to 1/4 resolution means that any vessel 4 voxels across would be reduced to approximately a single voxel.

Industry standard methods exist for handling large datasets: HDF5 is intended to _store_ such large multidimensional arrays and efficiently enable loading subsections, however this data storage format is totally incompatible with most medical imaging software, and is not the standard used by CT machines. Standards such as DICOM did not provision for the possibility that data such as those generated by micro-CT may exist in the future in the medical domain, and do not deal well with dynamically loading large datasets from memory. To _operate on_ large multidimensional arrays in Python, there exist libraries such as #link("https://www.dask.org/")[Dask] that enable "chunking" of the data to process smaller areas: this could enable improved scaling to larger scans.

#linebreak()
These performance concerns highlight a continuous issue encountered during the writing of this thesis: the complexity of methods able to be tested was limited by the choice of software, volume of data and the hardware available. Lab computers available to students have 32GB of ram, less than the computer used for the testing and writing of code, and it was noted by previous students working on MicroCT imaging that they had struggled to run algorithms across the whole image. In the end, much effort was invested in the research, testing and optimization of the algorithms, and runtime concerns pushed development towards the use of methods implemented in C++ available with Python bindings, such as the SimpleITK Frangi filter used. 



== Ablation study

Given the initial positive outputs of the pipeline but with the limitations in terms of memory and performance, it was decided to carry out an ablation study. It is common for software approaches comprising multiple steps to not correctly quantify the contribution of each individual step to the overall algorithm performance, and properly understand the performance/cost tradeoff of these steps. 

In order to ablate the algorithm, the weights of the probability map of each step was set to 0 except the one under test, which was done for all the parameters of the pipeline. For performance measurements, RAM and CPU utilization were monitored alongside runtime with unused steps disabled. This showed that the Frangi vesselness step was the most important to obtaining high vessel extraction performance, offering the same 26/27 correctly classified vessel points as the full pipeline. Additionally the performance evaluation method was highlighted as lacking: false positives and discontinuities in the blood vessels were not properly penalized, and small vessels were not being correctly segmented; all things that point wise annotations fail to capture.


#import "@preview/tblr:0.5.0": *
#import "@preview/plotst:0.2.0": *

#let data = from-csv(delimiter: "|", "
Baseline                            | 1  | 9    | NA  | NA      | 0
Loaded dataset & point annotation   | 1  | 13   | NA  | NA      | 0
Pre-processing (shell, intensity)   | 1  | 13.4 | 19  | 24 of 27| 198
Vesselness                          | 20 | 22.5 | 38.4| 26 of 27| 176
Fast marching algorithm             | 1  | 28   | 28  | Minor   | 225
Tube extraction                     | 1  | 20   | 21  | Minor   | 1786
Tree training and inference         | 1  | 16   | 32  | Minor   | 1991
")

#let bar(x) = {
  rect(width: int(x) / 2000 * 2in, fill: blue, text(fill: white, x))
  }

#tblr(columns: 6,
  stroke: none,
  align: center+horizon,
  // formatting directives
  rows(within: "header", auto, fill: aqua.lighten(60%), hooks: strong),
  cols(within: "body", 0, align: left, fill: gray.lighten(70%), hooks: strong),
  cols(within: "body", -1, align: left, hooks: bar),
  // content
  table.header([Method],[CPU\ Threads],[RAM\ GB],[RAM\ Peak GB],[Performance\ Contribution], [Inference\ Time]),
  ..data,
  caption: [Ablation study measurements],
)


== Conclusion of the ablation study

The removal of all steps (shell removal, random forest) except vesselness resulted in improved performance for extraction of vessels in the outer shell, as noted previously being a crucial point, as well as a large performance increase: vessel extraction went from taking multiple hours to under 20 minutes. It also successfully reduced RAM and swap usage, enabling effective running of the algorithm on larger samples. As a result of this small ablation study, the probability map approach was simplified to reduce memory usage, with a single map being successively updated, and focus was moved towards the use of simple, scientifically grounded extraction based on line-like features with a step for combatting the disconnections in vessels.




// Baseline 9GB

// 13.4 - 19GB
// 1.39 198

// 14.6GB
// 1.28 176

// 22.5 - peaks 38.4GB vesselness
// 1.15 225

// 28GB
// 2.33 186

// 21GB fast march
// 4.59 598
