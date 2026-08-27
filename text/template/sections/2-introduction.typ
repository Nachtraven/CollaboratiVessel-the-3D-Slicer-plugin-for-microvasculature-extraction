// Notes moved to "2-introduction-backup-29-04.typ"
// 2D histology → limitations → 3D imaging → micro-CT → contrast-enhanced micro-CT → the vasculature segmentation problem → the tooling/usability gap → the contribution
// Tighten the introduction's first paragraph to three sentences and introduce the Pazopanib dataset as the test bed
// (1) tissue structure matters for function, vasculature especially; (2) 3D imaging is now the way to capture it, but the data is hard to process; (3) here's the specific problem this thesis addresses.

//  across different wavelenghts, ranging from sound and infrared to magnetic resonance and x-ray imaging.



// is this introducing the reader to the problem, or is it surveying prior work?
// Am I telling the reader something they need in order to evaluate the gap, or am I re-motivating the thesis? If the latter, it belongs in the intro (or nowhere).

// Introduction = why this work exists. It motivates the problem in the reader's terms (biology, drug evaluation, dataset specificity), names the gap, and announces the contribution. Claims here are allowed to be uncited or lightly cited because they're framing, not survey.
// State of the art = what has been tried and why it's insufficient. It surveys the landscape with citations, compares options, and ends each subsection with a "Problem N" box (which you're already doing — good pattern). Claims here must be defended.

//To obtain an understanding of such tissues 2D histology stands as the gold standard, but the limitations it presents in capturing three dimensional structures like those of vasculature have driven the adoption of high resolution 3D imaging techniques. Micro-computed tomography (Micro-CT) stands as a method able to achieve resolutions enabling the extraction of vessels ranging down into the micrometer range, and has multiple contrast-enhanced variants aiming to improve tissue separation. These methods generate orders of magnitude more data than traditional microscopy and pose new challenges in information extraction and processing.

// == Biological motivation

// Tissue samples are collected and imaged in order to gain an understanding of their structure and composition, called histology or histopathology in the case of diseased tissue. Classically this is done ex-vivo in 2D, with sections analyzed manually under a microscope by a human, the gold standard for tissue analysis @2d_histo_sota_balcaen2023revealing. However the technique has a fundamental limitation: information is not captured at the same granularity along all three axes. Methods exist to stack slices and reconstruct a 3D volume @methods_for_3d_histo_pichat2018survey, but axial resolution is limited by section thickness, and dead space between slices leaves regions where no information is acquired @litt_review_greet_debournonville2019contrast and the cutting process itself induces changes in tissue structure @extending2d_histo_to_3d.

// For tasks such as measuring the impact of a drug on vascularization, quantification is particularly relevant: Understanding the three-dimensional structure of biological tissue is a prerequisite for the analysis of structure-altering drugs such as Pazopanib. For such tasks,


// #linebreak() Old "Obtaining information from imaging":
// When faced with complex data the paths for researchers are twofold: either _manual analysis_ of the data, or _utilization of algorithms_ to aid in the separation of their structures of interest. Manual annotation suffers from high subjectivity, strong variance between annotators @variability_in_annotations_xray_lin2023pluribus and requires time and expert annotators, meaning both direct use and use in machine learning present challenges. Additionally, annotation natively in 3D is challenging: it is difficult to properly consider all three axes simultaneously, hindering work on small 3D structures like vasculature. 

// When using algorithms for extraction, users are pulled towards user friendly and simple methods: (1) generalist methods such as thresholding, easily understandable and widely available, but performing poorly on data that cannot be separated by intensity alone, and (2) a wide spectrum of techniques that carry a richer prior or set of priors about the target structure, ranging from purpose developed algorithms to data driven ones as in deep learning. For vessel analysis, simple methods are easy to apply but result in discontinuities in blood vessels, artefacts, and don't generalize across samples, as well as require the selection of a fixed threshold per sample, a step not performed in a repeatable principled fashion, as learned from user interviews. 

// Angiogenesis is the process of vascular growth exploited by tumors that antiangiogenic drugs aim to disrupt , an 
// angiogenesis  the process of vascular growth exploited by tumors that antiangiogenic drugs aim to disrupt - quantifying changes in vascular structure is essential to evaluating treatment efficacy. The dataset motivating this work consists of contrast-enhanced Micro-CT scans of murine tumors collected to assess the antiangiogenic drug Pazopanib, a tyrosine kinase inhibitor influencing the formation of new blood vessels whose mechanism of action is expected to manifest as measurable changes in vasculature. 


// Biological tissue function depends strongly on spatial organization and composition. This is particularly true for evaluating vascular networks, where branching geometry, vessel diameters, and connectivity define how functional the vascularization is. In order to evaluate Pazopanib, a tyrosine kinase inhibitor influencing the formation of new blood vessels whose mechanism of action is expected to manifest as measurable changes in vasculature, accurate 3D segmentation of these structures is required.

// Vasculature is inherently 3D and spans entire tissues, having parameters based on high order abstractions such as shape and relative changes over a path. This 3D nature, combined with the limitations of slice-based methods, motivates high-resolution 3D imaging: for the dataset used in this work, contrast-enhanced Micro-CT scans were acquired using an agent that increases the attenuation of the small blood vessels. 


// #linebreak()
// Existing tools for analyzing Micro-CT data are dominated by proprietary paid software and the available open-source alternatives lack robust solutions to extract small-scale vasculature with its challenging specificities: low contrast, non vessel-like structures, diffusion gradients, and vessels only a few voxels across. As a result, the vasculature in the provided dataset has resisted prior analysis attempts.


//Evaluating Pazopanib, a tyrosine kinase inhibitor whose antiangiogenic mechanism is expected to manifest as measurable changes in vascular structure, therefore depends on accurate extraction and subsequent quantification. 



= Introduction

Biological tissue function depends strongly on spatial organization of its constituents, its cells and extracellular matrix. This is particularly true for vascular networks in organs and tumors, whose branching geometry, vessel diameters, and connectivity collectively determine how functional the vascularization is. Interpretation of the effect of diseases or drug treatments on tissue vascularization depends therefore on accurate imaging data extraction and subsequent structural quantification. Vascular networks have higher-order structural properties: vessel densities, diameters, branching frequency and changes in tortuosity which cannot be reliably recovered from 2D images, nor from voxel-level metrics in 3D datasets that ignore network topology. This 3D nature motivates the use of high-resolution 3D imaging able to discern small vessels inside of tissues. 

In this work, in order to examine vessels in ex-vivo biopsies of murine tumors, micro-computed tomography (microCT) is used to generate high resolution 3D datasets. It suffers however from low contrast between soft tissues, for which contrast-enhancing agents were utilized to increase vessel signal strength, a technique termed contrast-enhanced microCT (CECT).

#linebreak()
High resolution 3D imaging brings with it new challenges when compared to 2D histology: a single CECT dataset can reach into the thousands of slices, with large datasets on the order of 3000³ at 16 bits per voxel, resulting in orders of magnitude more data than a comparable 2D acquisition. This means that manual analysis as with 2D microscopy is impractical. CECT data itself is also highly variable and challenging to analyze: datasets differ on the same machine due to changes in the imaged tissue, contrast agents and protocols used to make structures of interest visible, and further variation arises across machines and due to researchers' choices of acquisition parameters. Microvasculature presents additional challenges, illustrated in @fig:cect-data-examples: vessels are only a few voxels across with low contrast and many discontinuities, the surrounding tissue can contain high-signal non-vessel-like structures, as well as shell artefacts and contrast gradients across the imaged volume.

#linebreak()
Analysis techniques for CECT data can broadly be grouped into two, both with significant drawbacks. Data driven techniques such as machine learning exhibit poor out-of-distribution performance, needing retraining for new datasets or target structures. This requires technical expertise with large quantities of annotated training data that is challenging to produce. Classical algorithmic techniques avoid the need for annotated data but are typically delivered through host software to enable user interaction, which is a fragmented landscape of closed source, paid proprietary commercial software, or open-source software with variable quality. Neither technique has robust out-of-the-box solutions for microvasculature extraction. As a result vessels in datasets like ours are unable to be accurately and reliably extracted, which prevents downstream characterization of tissue vascularization.

Classical algorithmic methods avoid the data-acquisition problem but are typically delivered through host software, and the available host platforms form a fragmented landscape of paid proprietary commercial tools and open-source tools of variable quality

//Modern deep-learning methods are also not a silver bullet: they bring extra challenges, requiring significant technical expertise, large quantities of annotated training data that is challenging to produce, and frequently exhibit poor out-of-distribution performance, meaning researchers must retrain models in order to achieve relevant performance. 


#include("./appendices/intro_cect_image_annotations.typ") // Some example images of the data:
// Description: Slices illustrating the principal challenges: *(a)* A large high contrast vessel of approximately 14 voxels (indicated by the circle). *(b)* A large high-intensity non vessel-like structure resulting from hemorrhage. *(c)* Upper, left: many small vessels in cross-section, ranging from 2 to 8 voxels in diameter, where the partial-volume effect is present, as well as compression artifacts. *(d)* Outer surface: the "shell effect", a high-intensity boundary surrounding the tumor caused by the limited diffusion of the contrast agent - also visible: a strong gradient between outside and center *(e, f)* Two slices from the same volume, separated by 5 voxels along the z-axis. The vessel indicated appears discontinuous in (e) but continuous in (f), highlighting the relevance of 3D methods.
#v(0.1cm) 

==== Contribution and scope

To address the challenges of microvasculature extraction from CECT data, an open-source pipeline called CollaboratiVessel is created in this thesis to obtain segmented blood vessels, with the goal of enabling downstream extraction of biologically relevant vasculature characteristics. 

CollaboratiVessel is an easily installable plugin for 3D Slicer, an open-source and free base software, that ingests data in DICOM and outputs binary masks, a portable data formats familiar to researchers, to ensure re-usability and compatibility with existing downstream analysis. To segment vessels CollaboratiVessel implements multi-scale vesselness filtering, seed-guided region growing, ridge following and endpoint reconnection. Hyperparameter tuning is handled by providing robust and tested standard parameters while keeping those relevant for common domain shifts in resolution, vessel size and intensity exposed, enabling adaptation to new datasets. User input is leveraged in the segmentation loop with manually placed points guiding segmentation, and ease of use is prioritized to bridge the divide between computer science and researchers. Final performance is measured against a manually annotated baseline and intensity thresholding, the previously used technique that did not succeed in segmenting with sufficient consistency for subsequent analysis. CollaboratiVessel outperforms thresholding on vessel consistency and continuity, extracting vessels more relevant for downstream analysis, and exceeds manual annotation in extrapolation capabilities, while requiring minimal human intervention and maintaining repeatability and consistency across runs.

#linebreak()
All code written in the implementation of this thesis is made open-source under the MIT license, and the source of this document is labeled under the creative commons as CC0 - No Rights Reserved.




// Old Obtaining information from imaging
// Quantifying tumour micro vasculature and its changes in response to antiangiogenic drugs requires extracting 3D vessel networks from imaging data, a challenging task that current open-source tools fail to do reliably .

// The uptake and adoption of techniques beyond single step analysis remains limited outside of the walls of computer science labs due to the barrier to entry associated with using a new tool or method being too high: proprietary paid tools are used, research software is often unmaintained or poorly documented and algorithms are challenging to run on different machines. Modern deep learning based algorithms add even more barriers: dedicated GPUs are typically required @unet_og_paper, input data must be converted to specific formats, and out-of-distribution data often demands retraining, requiring data and computer science knowledge. 



// Implemented methods are tested for robustness by examining performance on data previously considered non segmentable due to non uniform contrast agent staining.






//This combination of data volume percludes human analysis, and data heterogeneity challenges algorithmic analysis.


// #linebreak()
// There is also the issue of data diversity stemming from the increase in dimensionality and available imaging methods: even for one given imaging type such as Micro-CT, there is high scan to scan variance between different tissues, a wide array of machines and machine settings, and different contrast or staining agents that can be used at different concentrations and with different methodologies for getting them into the tissue of interest. This huge diversity natually drives a huge diversity in data with as consequence a fragmented and diverse data processing landscape. 

// // #linebreak()
// Our imaging method of choice for analyzing blood vessels, Micro-CT, presents low contrast between soft tissue: techniques exist to increase contrast and improve visibility such as cryo-CT @cryoct_maes2022cryogenic or the utilization of contrast enhacing staining agents (CESAs) in Contrast-Enhanced CT called CECT, as used for the data in this thesis. Although essential to increase the contrast between tissue types, these techniques still do not enable sufficient differentiation for small vascular networks such as those found in the murine tumors collected for the evaluation of Pazopanib to allow threshold based classification as is commonly used for bone or for samples with high contrast agent presence @litt_review_greet_debournonville2019contrast, this was shown during the analysis phase of @wlodarski, the source of the data used here, where threshold based segmentation was used and resulted in poor performance.


// == Computer science as a tool

// This annotation variance, combined with the time required to manually segment, means that the small vascular networks in the provided data have yet to be manually segmented. 

// The inter annotator variance can be explained in mutliple fashions: expertise difference, tool type and experience, available time, subjectivity and more. Additionally, annotation natively in 3D is challenging, meaning it is difficult to annotate while properly considering all three axis simultaneously, hindering the annotation of small 3D structures like vasculature. This annotation variance, combined with the time required to manually segment, means that the small vascular networks in the provided data have yet to be manually segmented. 



// HERE IMPORTANT TO MENTION AUTOMATIC ML NN-UNET
// Situation: computer science is not used outside of computer science labs and papers
