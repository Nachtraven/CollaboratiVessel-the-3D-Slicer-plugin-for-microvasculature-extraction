= Micro vasculature extraction


== Final vessel extraction flow


== Data annotation for evaluation

As mentioned, the user is expected to place vessel, background and outside-of-volume points. These act as points used to define hyperparameters of the algorithms, but also as a performance metric: when the pipeline is run, feedback is given with how many vessel points are correctly classified. However this method of performance evaluation has shotcomings: it evaluates the data in a pointwise fashion, ignoring critical elements for downstream tasks such as connectivity, and relies on the human evaluating a 2D plane, ignoring parameters such as gap filling. As users also place points generally towards the center of the vessels, there is little measurement of the width of vessels beyond if a background point ends up being caught in the vessel prediction.

As a result of this, it was decided to provide more dense annotations in the form of fully annotated regions taken from different scans: 

=== Annotation procedure & tools

// TODO: add visualization
Annotation was carried out using 3D slicer on 64x64x64 regions randomly selected from the provided samples: these regions were selected from one of 25 regions cropped from the center of the image. This ensures that points exist 

== Performance results

The final algorithm was ran on 192x192x192 volumes to provide context around the annotated 64x64x64 regions:

//once the final algorithm was in development applied to each of the pieces of data provided, with as baseline for each dataset a manually annotated 64x64x64 region.




// == Final algorithm

// // TODO: add source smoothing https://discourse.slicer.org/t/turn-off-all-smoothing-in-segmentation/1933/22
// After the initial algorithm development, demonstration of the results, meeting with the lab researchers to show and discuss the outputs, and the ablation that reduced inference time and improved vessel extraction, a final design was reached:





// // In order to place the end user is placed in the segmentation loop and offers feedback to the algorithms
// //   1. The selected approach for this was the placement of so called "anchor" points, points the user has identified as being either *(i)* vessel, *(ii)* background/non vessel and *(iii)* outside of volume
// // 1. A method that makes use of existing, extendable software 3DSlicer @3Dslicer_paper
// //   1. The plugin is impleted in 3D Slicer and uses the standard interface
// // 2. A method that integrates voxel level metrics such as DICE @og_dice_loss and vasculature relevant metrics such as @clDice_loss_func and @CFLoss_loss_func
// // 3. A method that is well documented, and enables reproducibility
// // 4. A method that outputs a portable format of segmentation, namely voxel level segmentation, as individual slices or a DICOM imaging format 


