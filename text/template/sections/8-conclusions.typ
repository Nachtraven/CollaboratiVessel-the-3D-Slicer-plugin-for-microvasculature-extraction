// 1. Deliver a user-friendly 3D Slicer extension.
// 2. Leverage a user-in-the-loop approach for point placement & basic vessel-size context to drive automated parameter selection, replacing manual error-prone hyperparameter tuning.
// 3. Build the segmentation core on multiple algorithms, combined through an evidence accumulating framework that enables per component tuning.
// 4. Identify through ablation the most relevant components to control runtime and avoid overly complex algorithms
// 5. Export useful segmentations for downstream analysis

= Conclusion and future perspectives

The work laid out in this thesis set out to answer the question of _How can an open-source microvasculature extraction pipeline be developed, able to be used by non-computer scientists, leveraging classical segmentation methods and sparse user-driven input to produce improved segmentations when compared to thresholding on CECT data across a diverse dataset?_, question to which CollaboratiVessel was created to answer: a 3D Slicer plugin that combines vesselness and intensity priors with vessel reconstruction steps leveraging user placed points with minimal hyperparameter tuning.

#linebreak()
The principal contributions of this work can be summarized as follows: *A user friendly 3D Slicer plugin*, CollaboratiVessel, was created. It requires no coding to operate, and can export binary segmentations compatible with downstream analysis tools. The UI was designed with prospective users in mind, with pre-tuned hyperparameters and offering only the necessary options. The associated code was written in a modular fashion to enable simple changes and future expansion to other datasets. Collaborativessel leverages *a framework for extrapolative prediction* with a different segmentation paradigm to thresholding or machine learning. As opposed to purely hard evidence based methods like thresholding that do not extrapolate or interpolate vessels, or purely data driven methods for extrapolation and interpolation that require learning from data, a multistep approach is successfully used. This approach enforces priors and connects vessels based on evidence to successfully extract connected vessel segmentations. 

*A user-in-the-loop segmentation approach* was followed, that differentiates this work from classical deep learning approaches to solving challenging segmentation tasks. The algorithm, user and data are all treated as working together towards a same goal, with user inputs leveraged in the loop and outputs directly shown the user in a 3DSlicer segmentation window, enabling rapid iteration and adjustment by modifying hyperparameters or revising segmentations with built-in 3D Slicer tools if required. 

Finally, *A manually annotated evaluation dataset* was created, with six 3D subvolumes spanning four tumour samples annotated, a valuable resource for future work on CECT microvasculature segmentation. These annotations were used in *a framework for evaluating prediction quality* beyond voxel-level Dice and clDice. The evaluation work in this thesis explores the use of ways of evaluating vessel segmentation relevant for future work on the data, using heatmaps to visualize tubularity and bipartite vessel matching to capture fragmentation and missed-vessel rates.




// TODO: revise from here ----------

// The algorithm implemented is robust to small disconnections, and reconstructs plausible networks across different challenging scenarios without requiring extensive user modification of the segmentation.

// The initial goal, being very wide in scope and problem definition, is naturally satisfied within certain constraints: the memory limitations as well as the implementation of 3D Slicer restricts analysis to smaller volumes, with the step of tiling taken to mitigate this. The output 2D Slices still require downstream analysis by an expert and specialized software to enable extraction of more detailed clinical results, and the user adjustable hyperparameters still require the user to interact and iteratively act as a member of the pipeline, injecting some subjectivity and bias. 

// The final software is modular and easily extensible, and the current work opens the door towards future collaboration between departments on challenging analysis tasks.

// Our predictions are more vessel like and enforce a certain shape -> downstream biases

// Our predictions extrapolate -> we should investigate if others would annotate these points
// Using simulation would enable better validation because we could ablate with a known GT

// The fact there is a loop with re-seeding means that in examples with few possible candidates there is a pressure towards over segmentation, and inversely when there are many weak candidates we capture them. This is partially intentional, but given a distribution of possible vessels, there is a zone in which we are optimal. Work would be required to seed and expand based on this graph, but to obtain this graph we'd need to have a lot more reference data.



== Limitations

The initial goal, being very wide in scope and problem definition, is naturally satisfied within certain constraints: 

// the memory limitations as well as the implementation of 3D Slicer restricts analysis to smaller volumes, with the step of tiling taken to mitigate this. The output 2D Slices still require downstream analysis by an expert and specialized software to enable extraction of more detailed clinical results, and the user adjustable hyperparameters still require the user to interact and iteratively act as a member of the pipeline, injecting some subjectivity and bias. 
// #linebreak()
*Memory and inference scale* Due to the size of scans and limitations with how 3D Slicer currently handles them, CollaboratiVessel operated on manually cut subvolumes. Tiling of memory intensive steps was implemented, but without an improvement in base memory use in 3D Slicer, it will not suffice to infer on datasets more than approximately a fith memory size. Inference time also varies widely due to the iterative nature of certain logic steps, taking 10 to 30 minutes per subvolume, with large variations independent of volume size due to the amount of predicted vessels and their size. These two limitations (memory and inference time) limit immediate adoption and constitue the largest barriers to adoption.

#linebreak()
*Annotation quality and bias* is also a concern: annotations were produced by a single non-domain-expert annotator. Vessels not clearly visible in 2D slice views were not annotated, and as a result little extrapolation was done. This results in a bias towards larger and more visible vessels, and a systematic undersegmentation of small and low-contrast vessels or vessels in a volume with a gradient. This benefits thresholding, whos prediction mechanism does not infer vessel connections, and who does not enforce vessel size variation or continuity and penalises the connectivity-aware extrapolation.

#linebreak() // three of which from data considered _reliable_,
*Sample size and diversity* The six subvolumes only explored four datasets, a small subset of all provided datasets. As a result performance may not generalise well to out of distribution datasets.//  of the sample data.

#linebreak()
*User variability and shape bias* The user-placed seed points and vessel size prior (and its enforcement) introduce some annotator-dependent variability in the placement of seeds. The user selected vessel size and standard deviation enforce a tubular shape prior through Frangi and ridge extraction. This risks undersegmenting vessels, and introducing a bias in downstream tasks that may not be aware of this prior, as well as hinder the comparison of data between different segmentation techniques.

// and vessel under segmentation. Two users annotating the same scan may produce different
// -> discuss what is an issue, mainly the inference size and the memory use/cpu time
// -> also discuss limitation on annotation and resulting evaluation

== Future work

Future work can be plotted into three main directions: improvements to inference speed, vessel extraction performance and generalization and evaluation metrics:

#linebreak()
*Inference speed* is currently a limiting factor to the evaluation and use of CollaboratiVessel: improvements would allow inference on larger volumes, faster iteration and better exploration of hyperparameters. This could be achieved by either improving 3D Slicer itself, or moving the principal data handling tasks outside of 3D Slicer to be able to use libraries that would enable techniques such as _streaming_ or _chunking_. It may also be possible to get around the limitations of 3D Slicer by automating the process of cutting chunks, importing, analyzing and exporting their results. 

Despite using libraries constructed with speed in mind for this work, a full C++ implementation of the plugin could reduce memory and compute time substantially, as well as enabling parallelism currently blocked by python and its single thread nature. It may be relevant to ask the question of the position of 3D Slicer as a tool for inference, or if it should be purely used as a tool for visualizing and working on the input points/hyperparameters and final results.


#linebreak()
*Extraction performance* could be improved by exploring and implementing an automated configuration of the advanced hyperparameters based on the inference volume size and dimensions. It would also be beneficial to expose more hyperparameters that are currently hard coded, and integrate some method of configuring them automatically, such as with a grid search of parameters based on user placed points. Extra data outside of the current distribution could also be tested, relevant to understand the shift in performance as the task at hand changes.

#linebreak()
*Improvements in evaluation* such as automated methods for measuring and comparing vessels across methods is a relevant direction to explore, as better metrics enables a better understanding of what contributions matter and how they impact outputs. Developping an algorithm without these metrics forces slow and deliberate step by step exploration of the search space of possible algorithms, as opposed to enabling automatic searching. These improved metrics could also better reflect the downstream tasks which vessel extraction is intended to enable.

Additionally, a method of comparison between volumes would be needed to enable comparative studies, and methods for standardization such as vessel extraction or export based on characteristics (such as distance from the outer shell) would be relevant. Current binary label export binarizes outputs, loosing much of the information about possible vessels that CollaboratiVessel has generated, discarding elements that could be extracted from the skeletonized outputs such as the centerlines, branching ratios or vessel diameter distrubutions.

Finally, supplemental annotations from one or more annotators would enable inter-annotator agreement measurements, as well as improve tumor coverage and provide a more reliable ground truth. Alternatively, or as a supplement, simulated data (synthetic vasculature with known geometry) would be relevant to allow the creation of data with a known ground truth, and through ablation, style transfer or other methods could be made to emulate the current data, offering sufficient data volumes for more detailed and precise evaluation and potentially utilizing deep learning.  




// Finally, this work purely made use of the CPU. Techniques to move computation to GPU could enormously speed up processing, although at the cost of less user friendly
// GPU acceleration of the Frangi convolutions and the ridge extraction step
// is a natural target: both are parallelisable operations with existing GPU
// implementations in the medical imaging literature.

=== Data based extensions

As illustrated in Figure 2.2 (_Vascular segmentation methods positioned by data need and topological awareness_), we exist in the upper left quadrant: one that avoids the need for large amounts of data or machine learning, but that trades it for higher complexity in terms of vessel understanding, and extrapolation/interpolation based on hard coded algorithms. The delivered work was built as a _bootstrapping_ tool: the first step in an interative process to help extract vessels, which themselves could be used as a baseline for future learning based methods. Each subvolume produced by a user running CollaboratiVessel is a potential training sample for a learned model. Given an expert with both some knowledge of vessels as well as knowledge of learning based techniques, a segmentation network potentially including topology awareness could augment CollaboratiVessel while still keeping elements such as the user-in-the-loop seed mechanism for guiding inference on new samples.

#linebreak()
This would close the loop described in the problem statement: classical methods provide an accessible entry point, the tool accumulates annotations, and the annotations eventually enable the data-driven performance that classical methods cannot reach without requiring the upfront annotation investment that made data-driven approaches inaccessible at the outset.



#v(2.5cm)
#linebreak()
*Note of the author:*

#linebreak()
When the first pairs of scissors were developped for mass production, right handed-ness was not just the majority of potential users but the implicit default due to societal and educational factors. As development effort shifted from solving the functional problem to improving the user experience and outcomes, left handed scissors began to appear and they became more widespread, used by a wider range of skill levels, from children to professional tailors. 

#linebreak()
In a sense, this thesis is the initial scissors of microvasculature, while also existing in a highly specific niche of 3D structure segmentation: a solution to the broad problem of vasculature extraction that does not necessarily satisfy all users, or produce an ideal result, but still functionally brings a solution to the problem of challenging vascular extraction better than the thresholding used before. The door is now open to iterations that can either make the solution higher performance by continuing the bootstrapping towards data intensive methods, or more fit for a specific purpose or user by simplifying or automating extraction, or even adapt it to other problem areas that may have noisy data from which tubular structures must be extracted.




//This, coupled with the price pressure of producing a single uniform item and the limitations of the technology resulted in scissors developped with righthandedness built into them. When the social norm relaxed, and as more emphasis was placed not on merely the production of a product to solve a problem but also on the quality of the result _and_ the user experience, scissors developped specifically for righthanded and lefthanded users became common.

//When setting out to solve a task, especially in the bootstrapped method as done here, it is common to produce a result that does not necessarily satisfy all users, or produce an ideal result.Care was taken during the development to work on a solution that enabled both downstream software users to modify the work, as well as downstream research users, but the resulting software, as is naturally the case for a work done on novel tasks such as this one, still requires iteration before being ready for its time in the sun.

// It bears to mention that the data used during this thesis is both challenging due to real limitations of CECT as well as due to limitations at the time of collection: having been obtained in 2016, techniques and knowledge has advanced, potentially paliating the shortcomings of some of the data issues faced here. 

// Running inference on GPU
// Training machine learning

