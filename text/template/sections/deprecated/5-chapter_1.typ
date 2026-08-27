// Chapter 1: Plugin development and vasculature extraction MVP
//    Software for 3D Data analysis
//      Plugin development
//    Segmentation of tumor vascularization
//      Enforcing a principled approach
//      Implementation
//        Threhsolding
//        Algorithmic extraction
//    Results

// Chapter 2: Ablation study and performance review
//    Motivations for ablation
//    Performance concerns
//      Data formats for performance
//      Data loading for performance
//    Conclusion

// Chapter 3: Micro vasculature extraction
//    Final algorithm implementation
//    Evaluation method
//      Annotation
//      Calculating loss
//    Results on all data

// After -> results

//The process of segmentation of a structure from the background by an algorithm can be seen as the output with a higher confidence than the background noise that the point belongs to the class of interest. The goal of any algorithm is to integrate this process of discrimination in some form: it can be encoded into the algorithm itself such as in OTSU, it can come from an algorithm with hyperparameters that can be adjusted as with objectness filters, or can be entirely data driven as in machine and deep learning.

// With groundwork laid, an initial experimental plugin was developed that took in the data from the slices and, using a configurable threshold, output a segmented 3D volume. This threshold based segmentation was evaluated to validate the basic functionality of buttons, learn how 3D Slicer plugins are constructed. Following this learning step, implementation began. // and served as the basis for the subsequent features: // augmented iteratively to add the features required, which were extracted from the meetings with supervisors and lab members. These problems and the chosen solutions are broken down from the initial problem statement in @prob_statement:




// This thesis builds a complex pipeline, then identifies what was contributing to performance, before building a simpler pipeline that performs comparably with a fraction of the resources from this knowledge

= Software tool development <data_intro>


The team had prior experience in three tools for the analysis of 3D data: Avizo: a proprietary and paid software, Dragonfly3D: with either a "FreeD" free-for-academics or paid commercial license, and a bare metal approach using python code. These three analysis methods were favored by different users: those having been in the team a long time had adapted to the team standard of Avizo, also the recommended starting point for new joiners; Dragonfly3D was used by team members that had previously worked on data elsewhere and used software on their own devices, and the "bare metal" approach was taken by students wishing to avoid the substantial learning curve and friction involved with using one of the two aforementioned softwares to carry out basic analysis. Avizo and Dragonfly3D were considered as potential candidates for the creation of a vessel extraction tool, however this proved challenging would not satisfy the desire for an open source alternatives offering extendability and re-usability by other researchers.

In order to maintain interoperability with the Avizo and Dragonfly3D the 3D Slicer plugin needed to export data in one of two ways: *(i)* a fashion that transparently fits into the existing pipeline, namely that of exporting raw binary segmentations that could then be re-imported elsewhere *(ii)* an export format that better enforces scientific rigor and enables easier data sharing, in the form of DICOM. This second option will offer the team growth perspectives in opening the door for easier collaboration with computer scientists as well as other researchers downstream.


== 3D Slicer Plugin

As the 3D Slicer ecosystem is diverse with many existing tools, available plugins with similar goals (vascular extraction) and similar data formats (high resolution CT) were tested. It was noted that many available plugins were either unmaintained, throwing errors during installation or use or did not successfully produce outputs; this is despite 3D Slicer having two classes of plugins: "official" via the extension manager @SlicerDocsExtensions (further broken down by maintenance type) and user installable or "non official".

After testing various plugins, the following common limitations came to surface:
- 3D Slicer hangs when executing algorithms, and this execution happens without communication. The OS will ask the user if they wish to stop the program.
- UI development is restrictive: UI must be in the left corner, and few context menus are available
- Execution in Python is inefficient, and plugins that aimed to use multiple cores called external libraries
- Machine learning extensions did not come pre-packaged with the model weights and often required a GPU and installation of external software
- Errors during installation were not user-friendly enough for a non computer scientist to be able to debug an installation problem
- The 3D Slicer forums contained ample amounts of users having issues with different plugins


=== Implementation

// https://www.slicer.org/wiki/Documentation/Nightly/Training#Tutorials_for_software_developers
3D Slicer is multi platform and is built around plugins to carry out tasks, communicating with the Medical Reality Markup Language (MRML) @MRML_diagram, where modules read and write to MRML nodes. These plugins can be implemented in one of three forms: as command line interface (CLI) tools where they may be called as an encapsulated piece of code and is the most abstracted way of working with external code or a C++/Scripted (Python) loadable module @SlicerTutorialPerkins. The Scripted loadable approach was selected for its use of Python, lowering the barrier to entry, ability to use the UI features of 3D Slicer, and having access to the full slicer API. Work was carried out in Visual Studio Code under Ubuntu 24.04.

#v(0.5cm)

#figure(
  image("../../resources/software/Scripted_Module_Implementation.png", width: 65%),
  caption: [Structure for module implementation from @SlicerTutorialPerkins],
) <MRML_diagram>

#v(0.5cm)

To implement a plugin, the extension wizard #footnote[https://slicer.readthedocs.io/en/latest/user_guide/modules/extensionwizard.html#extension-wizard] was used to generate the required extension boilerplate, and the ScriptedLoadableModule was used as a starting point for the implementation code. 3D Slicer implements a user interface development module in QT, enabling near drag and drop creation of UI elements, making it the natural method of developing a seamless UI experience. Although basic, this radically simplifies the process of creating a cross platoform UI.

#figure(
  image("../../resources/misc/QT_ui_designer.png", width: 65%),
  caption: [QT user interface designer],
) <QT_ui> 

#v(0.5cm)



== Segmentation of tumor vascularization

As seen during the literature review, a wide variety of solutions exist for segmentation, as well as a diversity of different plugins for 3D Slicer. Additionally, the problem of lacking existing annotated data limits the possible data driven approaches beyond those making use of basic annotations able to be done by the user. As a result, after testing existing plugins, it was chosen to implement a multi stage pipeline that would leverage user feedback.


=== Principled hyper parameter selection

During user interviews it was noted that software users often made decisions without a principled, replicable and data driven decision method. Windowing and grey value were selected based on expertise, problematic for multiple reasons:

1. As the selected values are not data driven, decisions and pipelines cannot easily be replicated, and are more fragile
2. As the user acts as the evaluator to the actions done, they induce bias in the subsequent steps
3. Any user without knowledge of the downstream steps or what to look out for will not be able to make a fully informed decision for the hyperparameters to select, requiring iteration and potentially falling into local optima.

A principled approach was required: in order to select thresholds and evaluate the performance of the algorithm "in the loop", as well as offer the user immediate feedback, a system of anchor points was implemented. These anchors are the first step in the process, and are obtained by having the user click "add" followed by placing the point in any of the 2D windows. They can be saved and exported, as well as imported. Following the learning that users often do not take the time to properly name files and folders, the name when exporting is automatically constructed from the current data series name and description, as well as the full current date and time.

A second key element implemented to guide downstream steps was the expected vessel size and deviation in voxels. This parameter is easy to measure and is critical for certain steps such as the subsequent seed annotation analysis.

#v(0.5cm)
#figure(
  image("../../resources/software/overview_seed_vessel_param.png"),
  caption: [View of the seed annotation and vessel size definition panes. The user may press add, click on the locations in any of the right hand panes, as well as import previous annotations or export the current points.],
)
#v(0.5cm)

=== Segmenting using multiple features

During research multiple interesting algorithms appeared relevant to test. In order to combine the information provided by e.g. thresholding with that of Frangi, an interesting approach was used to explicit the process of evidence accumulation: the use of a *probability map*, where each algorithm or method saves point wise probabilities, allowing them to be weighed and stacked. This approach was selected as it allows the accumulation of evidence across steps in the pipeline, and if multiple probability maps are saved (one for each step or method) they can be given weights when being combined to create the final segmentation. 

#v(0.5cm)
#figure(
  image("../../resources/software/frangi_probability_map.png", width: 80%),
  caption: [Visualization of the vesselness probability map as defined by the Frangi feature. Intensity corresponds to vesselness probability],
)
#v(0.5cm)


=== Thresholding segmentation

As noted in @imaging_and_seg, the simplest method of segmentation is thresholding. Given the nature of CECT intends to give the structures of interest high grey values, this is an intuitive method with a strong prior. It is however not sufficient alone for three reasons: *(i)* the shell effect in CECT, where the contrast enhancing agent has higher concentrations on the outside or surface of the tumor, results in values that would be segmented as "vessel" even though they are not. *(ii)* grey value gradients appear between the outside and center of the samples and *(iii)* incomplete staining resulting in discontinuous vessels.

#v(0.5cm)
#figure(
  image("../../resources/software/threshold_131_255_example.png", width: 75%),
  caption: [The shortcoming of threshold based segmentation visualized, with the "shell" being included.],
)
#v(0.5cm)

The shell effect can be tackled by fitting a shape to the outside of the sample, however following a user interview demonstrating the feature a critical issue was raised: in tumors, it is common for the outside to contain large and plentiful vascularization. Removal would both bias results as well as reduce the overall performance by preventing these outside vessels from being segmented. Secondly, a threshold does not hold up to the gradients in images that are present which, in prior work carried out on this data, resulted in rejection of samples with a gradient considered too large. Finally, standard thresholding does not do anything to combat the incomplete staining resulting in discontinuous vessels. As a result, thresholding was utilized in the probability map stacking after shell removal, but given a low contribution.


=== Traditional algorithms

// Source the SimpleITK https://simpleitk.org/doxygen/v2_4/html/classitk_1_1simple_1_1ObjectnessMeasureImageFilter.html
When annotated by the user, vessels are identified on a local scale using the grey value difference between the vessel with contrast enhancing agent and the background. Grey value alone is, as laid out above, not _sufficient_, but it contributes some proof towards the presence of a blood vessel, given the presence of a grey value difference and a vessel-like shape. As a result, to obtain vessels from the user placed starting points, a series of different steps were assembled to form a _pipeline_.

To go beyond the limitations of threshold based segmentation, the generalized C++ implementation of Frangi in SimpleITK was used. The algorithm was applied at multiple scales (different expected vessel sizes) with the outputs collected together into one segmentation. Frangi is known for having multiple hyperparameters that require fine tuning: in order to offer the user a simple solution, the parameters for the minimum and maximum vessel scale are pre-defined, and the vessel parameters hard coded. 

Additionally, as the user has already provided high confidence starting points in the form of annotations, the marching squares algorithm was applied to extract vessels attached to these points, as mentioned in Lesage _et al_ @LESAGE2009819.


=== Machine learning

TODO: Initial experiments included a random forest classifier trained on points labeled high-confidence by the combined Frangi-and-marching-squares output, with the goal of recovering vessel regions outside the user's annotation neighborhood. This component was retained through initial development but was ablated in Chapter 2

// When extracting high likelihood points from the combination of the probability maps of Frangi and Marching squares, a subset of all possible vessels is obtained: those expanded from the user placed points with high likelihood to be vessels. As these are high probability to be correct, they were extracted and used for training a random forest classifier - leveraging the data efficiency advantages of classial methods as input to a machine learning model. This model saw substantial revisions downstream, and was intended to be fed augmented data in order to acquire a robustness to small disconnections.

== Results
 
TODO: This complex pipeline produced encouraging results on the development dataset (CA-LL-R): 26/27 vessel points and 16/16 background points correctly classified. The encouraging single-dataset performance, however, masked two issues that became apparent when the pipeline was tested on other datasets: severe performance limitations under larger inputs (Chapter 2.1), and substantial redundancy among the pipeline's components (Chapter 2.2). The figure below illustrates the development-dataset output that motivated the optimism, alongside artifacts (blob-like flood-fill responses, disconnections at low-signal regions) that foreshadow the issues addressed in subsequent chapters

// After the first round of development, a multi stage pipeline was obtained: from the user placed points, a shell removal step was done, and subsequently the user "vessel" points were grown using region growing to follow the ridges defined by the high grey value points. Frangi was also used to obtain a vesselness probability layer. These points grown from the user annotations, when also having a high vesselness score, were then treated as a baseline for exporting data around the user placed points and creating a simple classifier based on random forests. The random forest was then inferred on the whole image to obtain other high likelihood points that could be expanded using marching squares. Finally, these layers (Frangi, Intensity, collated marching squares) were combined and a final threshold based on the values of the user annotated points applied to obtain a binary segmentation map. This complex method led to promising results:


#v(0.5cm)
#figure(
  image("../../resources/software/long_pipeline_promising_cropped.png", width: 80%),
  caption: [Visualization of the segmentation following the multi stage pipeline during development. Successful continuous vessel segmentation and few small noisy sections. Performance, as measured using user annotated points, of 26/27 vessels and 16/16 background points correctly classified. Also visible: Blob-like artifacts from flood fill weight not being suppressed by Frangi, alongside disconnections in due to larger low signal areas.],
)
#v(0.5cm)