// Writing tutorial https://www.youtube.com/watch?v=pM6orL-bGDc

// Describe the situation - we want to extract small vasculature in order to be able to compare the impact of a drug on tumor vasc

// Describe the problem or question - we cannot accurately extract the vasculature parameters with current tools, and the parameters we do extract are low level when compared to our structures

// Describe how others have approached the problem - This is a problem in computer science that people have tried to solve using computer vision, more specifically segmentation. They have tried to solve it with basic methods (thresholding, lisa), expert knowledge (jerma frangi etc) and advanced data driven generalist methods (machine and deep learning). As a result of the divide between computer science and biology, the tools intended for use by biologists are often integrated in expensive closed source packages. 

// Explain a need to approach it in a different way or expand on what's been done - most applications of more advanced algorithms don't work well on small vasculature - they fail to extract the vessels to a level that enables higher order analysis. They are also not integrated into tools, often being more of a computer science endeavor and forgtetting about the actual use case. When they are integrated in tools, there is a cost and scientific barrier: it is difficult to replicate and difficult to expand upon, both foundational scientific requirements 

// Say what you aim to do - I aim to apply algorithms that distil expert knowledge inside of open source tools in an expandable way. These algorithms are augmented by use of the prior of blood vessel connectivity, knowledge we acquire from prior deep learning work, that teaches us that it can be more relevant to encode knowledge in the loss function than in the algorithm itself


// --------------
// Underlying structure:

// Start with a cause or stimulus which results in a situation or event
// From this, you get a problem or question
// This problem or question has: effects or responses, which result in Response by others/partial answers/other consequences
                                                                // -> this is circular and results in other effects/responses

// For the context, we want to have a progress or evolution in situations, be it chronological or technological, that drives our story. We always want to motivate our context - previous people didn't do work without a motivation/cause

// --------------
// Litterature review:

// 1. No need to show everything that has been read. We put together a narative with the best and most interesting sources
// 2. Every paper is a response to a problem, question or situation
// 3. These papers can be within a more general context of the litterature

// e.g. Research into 3D information extraction and analysis has gained pace in recent years, especially since the explosion in different imaging techniques, and techniques enabling analysis of different kinds of tissues. One of the main aims of this research has been to automate the separation between the structure of interest and background, in order to enable analysis of parameters such as volume and surface area. This research has progressed into the extraction of higher level features, in lockstep with the development of higher level algorithms in the computer vision space, such as skeleton extraction aiming to obtain not voxel or pixel wise classification, but to place points and rertices in 3D space.

// "This chapter will outline the most recent developments, key discoveries and current state of the art regarding ..."

// e.g. Following the discovery of contrast enhancement for CT, there has been an increase in the need for more advanced intelligent algorithms than simple thresholding as used for bone/soft tissue, due to the increase in ability of CT for discrimination of diverse targets with lower relative contrast, contrast gradients, and overlaps in signal strength between structures (speaking here of the overlap between vessels and organs taking up the CESA).
// This has lead to a great deal of different algorithms being developed for use at different points in the scientific pipeline: from computer scientists working directly on data or even on virtual data, to researchers without an engineering background using off the shelf visual tools with ample documentation and instructions. 
// This chapter will discuss the key difference between a purely computer science approach to solving the segmentation of data with the applied use of segmentation in a laboratory or clinical context

// While there has been extensive effort in bringing open source tools for analysis to the clinical context, such as orthanc with their 3D viewer, there is a gap in the the application of multi stage advanced algorithms within user friendly, open source tools
// This chapter discusses the existing tools used in clinical and research settings, as well as the existing advanced algorithms


// Segmentation in biology exploded following the introduction of u-net, due to its focus on data efficiency and applicability to higher resolutions.

// How do we define segmentation performance? As initially used in Alexnet, <CE loss> can be point wise, but as is discussed in u-net, point wise has limitations especially in imbalanced datasets. Their proposed metric such as DICE improves on this, allowing class weighting, but only takes into account the amount of incorrect pixels without associating a weighting of the gravity of an error. As noted in xx, this has the effect of ignoring locality ...

// Methods are detailing the response to a problem: e.g. methods for evaluating -> problem to solve to answer your research question of how to improve performance.

// --- Narrow your focus to one problem at a time, consider the options, make a decision
// Does the idea we are trying to implement fit into our narrative? Maybe it is worth trying an alternative?


// Abstract from 17-04 0958:
// As medical imaging has evolved from humble beginnings of 2D microscopy analyzed by human observation towards higher and higher resolution 3D imaging generating orders of magnitude more data in the process, the step of data analysis and its required tools and methods have become central to leveraging the data for information extraction. The evolution of these imaging methods has also opened the door to new possibilities for the study of structures whos intrinsic organization in 3D contributes towards function, embodied in the usecase of tissue vascularization. Advanced imaging methods such as contrast-enhanced micro tomography aim to separate tissue by use of contrast enhacing agents, but noise in imaging and the small, dispersed nature of the vascularization of tumors result in the need for more powerful software methods to enable the comparison of samples across various treatment profiles, and achieve the levels of accuracy required for drug research. In this document the clinical pipeline is examined from end to end, a more powerful extraction method for vascular structures in challenging use cases is developed, and the groundwork laid for principled, scientifically rigorous work to be carried out.


// From KUL guidelines
// The main matter: heart of the thesis, it contains the real content. One should be able to read only the main matter to take in the whole story. The chapters have a logical sequence, which must be made evident to the reader. 
// First chapter: introduction the reader must be informed about the research field of the master’s thesis, situating it in a broader context. The goals of the thesis, as well as previous work, are described from a technical point of view. The structure of the thesis text is briefly explained. 
// Other chapters Each chapter, except the first and the last one, starts with an introduction to the contents of the chapter. If readers would only read the introductions, they should have an overview of the contents of the master’s thesis and the relation between the chapters.



// = Introduction


// Start with a cause or stimulus which results in a situation or event
// From this, you get a problem or question
// This problem or question has: effects or responses, which result in Response by others/partial answers/other consequences
                                                                // -> this is circular and results in other effects/responses

// For the context, we want to have a progress or evolution in situations, be it chronological or technological, that drives our story. We always want to motivate our context - previous people didn't do work without a motivation/cause


// ------------------------------

// Describe the situation - 
// Bio research for tissues has progressed from 2D to 3D analysis, due to it being more advantageous to better understand tissues where the structure in 3D is essential to the functionning, such as for vasculature. This progression means there is a lot more data, and the need for tools to help in the analysis, which have all evolved over time as the imaging methods gained traction in different research fields. When doing research on these tissues, biologists use software to assist them: this is outside of their domain of expertise, meaning they rely on prior work for extraction techniques, and the tools that enable them. Prior work for extracting info is often not directly re-usable because the tool landscape is fragmented, advanced methods are often beyond the understanding of the biologist or not available with the "surrounding" software and they are behind a paywall, or the data isn't available.

// This manifests in our usecase of micro vasculature extraction from tumors: in order to be able to measure the impact of a drug on the vasculature when comparing a reference tumor to a treated one, it must be possible to compare them with high enough certainty and using biologically relevant parameters. Currently the vasculature cannot be extracted with enough fidelity to enable downstream analysis: Previous work at UCLouvain attempted to make use of proprietary software and poorly documented pipelines, and used extraction methods that did not reach a level of confidence and accuracy to enable decisionmaking. Extraction of vasculature, and more largely the separation of structures of interest in an image, is a problem in computer science that people have tried to solve using segmentation. Often basic methods are used due to their simplicity such as grey level thresholding (lisa) and their availability in the tools familiar or provided to the researcher.



// Need to approach coding a solution differently:
// When a researcher in computer science works on data such as is used here, it is common for them to circumvent the "wrapper" software problem by using code directly: this results in a lot of cutting edge algorithms being inscrutable or not re-usable by biologists for future work, and is not scientifically rigorious as it is difficult to replicate and to expand upon, both foundational scientific requirements. In this document, the work will be implemented within a free and open source "wrapper": 3D Slicer, already commonly used for the analysis of 3D data as well as for CECT. It already has existing software intended for (large) blood vessel segmentation, and has an active community around it.

// Need to approach segmenting differently:
// Due to the diversity of CECT data, off the shelf algorithms don't work well on our small vasculature because of its low contrast, noise, disconnections and gradient: Grey level thresholding does not preserve connectivity, critical to blood vessel analysis, and fails to properly segment with the gradient and noise. Machine learning based algorithms aren't available for our data usecase, and annotated data does not exist to offer us a training set to work with. This naturally pushes us towards algorithms that do not require training data but encode some of what machine learning extracts in the training process such as Jerma or Frangi: they encode the tubular prior of the vasculature we aim to exctract.

// We need to approach using Jerma/Frangi differently:
// However these data free techniques still suffer issues: they have many hyper parameters that are left to the user to adjust, meaning they are difficult to use, often aren't set in a principled fashion, and don't transfer between samples.


// The goal:
// In this thesis aim to apply algorithms that distil expert knowledge inside of open source tools in an expandable way. These algorithms are augmented by use of the prior of blood vessel connectivity, knowledge we acquire from prior deep learning work, that teaches us that it can be more relevant to encode knowledge in the loss function than in the algorithm itself

// ------------------------------





// Bio research for tissues has progressed from 2D to 3D analysis, due to it being more advantageous to better understand tissues where the structure in 3D is essential to the functionning, such as for vasculature. This progression means there is a lot more data, and the need for tools to help in the analysis, which have all evolved over time as the imaging methods gained traction in different research fields. When doing research on these tissues, biologists use software to assist them: this is outside of their domain of expertise, meaning they rely on prior work for extraction techniques, and the tools that enable them. Prior work for extracting info is often not directly re-usable because the tool landscape is fragmented, advanced methods are often beyond the understanding of the biologist or not available with the "surrounding" software and they are behind a paywall, or the data isn't available.


// Start with a cause or stimulus which results in a situation or event
// From this, you get a problem or question
// This problem or question has: effects or responses, which result in Response by others/partial answers/other consequences
                                                                // -> this is circular and results in other effects/responses



// Causes:
// Shift from 2D to 3D in biology, namely microCT and CECT, motivated by structural-function relationships.
//  This increased data volume
//    Need for automated analysis tools.
//  This introduced challenges (noise, low contrast, gradients, general variability).
//    Need for robust replicable methods that translate

// Problem:
// Current methods fail to accurately extract small vasculature (e.g., tumor vascularization).
// Existing methods (thresholding, expert-driven algorithms) are either too simplistic or inaccessible (closed-source, paywalled, poorly documented).
// Bad reproducibility because of paywalled options

// Effects:
// Fragmented tools: Biologists rely on suboptimal methods (e.g., thresholding) due to lack of expertise or access.
// Reproducibility crisis: Closed-source tools and undocumented pipelines hinder scientific rigor.
// Gap in advanced methods: State-of-the-art algorithms (e.g., Frangi, ML) are rarely deployed in user-friendly, open-source tools



= Introduction

In the field of biology the cutting edge in analysis of tissues has evolved from 2D histology, carried out by humans looking through microscopes, to a wide variety of 3D techniques across different wavelenghts, ranging from sound and infrared to magnetic resonance and x-ray imaging. The pursuit of higher resolution and fidelity reconstruction is driven by the importance of tissue structure in function, particularly for vascular networks where it plays a critical role. While 2D histology is established as the gold standard for tissue analysis, its limitations in capturing three dimensional structure have driven the adoption of high-resolution 3D imaging techniques, such as micro-computed tomography (Micro-CT) and its contrast-enhanced variants aiming to improve tissue separation. These methods generate orders of magnitude more data than traditional microscopy, enabling detailed analysis of complex structures like tumor vasculature but posing new challenges in extraction and processing. Small vessels are characterized by low contrast, noise, and contrast-enhancement agent gradients, not able to be accurately reconstructed using conventional methods. Current approaches also suffer from poor replicability and accessibility due to the widespread use proprietary software. This gap between computational advances and biological workflows underscores the need for open-source, user-friendly tools integrating principled extraction methods.

To address this a pipeline for micro vasculature extraction from CECT data is developed in the form of a plugin for 3D Slicer, an open-source tool widely used in the medical imaging field. Scientific rigor is enforced by removing subjective user adjustment of hyperparameters, robustness and transferrability to new data is improved by using algorithms with adjustable hyperparameters, and adoption is encouraged by optimizing usability, to bridge the divide between computer vision research and biological applications.

// With reproducibility being @10simple_rules_reproducibility, wth only the hurdle of image acquisition. Today many more hurldes have appeared: on top of acquisition the tools to carry out the process of analysis are often complex, requiring many decisions about parameters to be made, introducing biases and the software landscape contains many proprietary or paywalled tools. 

// Tissue analysis has naturally also seen the uptake of software tools, however the creation and extension of these tools, and the algorithms that drive image processing more generally, fall outside of the domain of expertise of most Biologists, resulting in a reliance on prior work and existing tools and pipelines. // This prior work is often not directly applicable or re-usable due to the use of closed source tools and the variability in data acquisiton, meaning that researchers may fall back to simpler, more generalist methods.  //: when carrying out research . It is natural for researchers to not have extensive knowledge across all fields required for a particular experiment, which is compensated for by relying on the existing corpus of prior research work, established methods, and available tools.



// Research based on multi step pipelines, especially those incorporating expensive software, are unable to be extended or replicated independently. Free and open source data processing tools  paliate the reproducibility and replicability problems by providing free and extensible software, publication of the data as well as data versionning enable an understanding of the steps carried out in modifying and obtaining the final result data, and automation in information extraction processes such as segmentation remove the tacit data filtering done by a human in the annotation processes.

== Biological motivation

// Tissues are complex and have a 3D element, and vascularization even more so - entirely depends on 3D
// Biological tissues are characterized by a spatially complex architecture, composition, and organization of their constituents at the microscale, referred to as the tissue microstructure. Due to the strong correlation between the tissue microstructure and its function, analysing the microstructure is crucial to gain a better understanding of how healthy and diseased tissues function, and is relevant across fields - from archeology to cardiology.

// More background on the situation
Biological tissues are spatially complex, diverse in composition and organization of their constituents at the microscale. Tissue microstructure is closely linked to its function: soft tissue analysis is foundational to modern medecine, being used everywhere from clinical environments to laboratories. Tissue samples are collected and imaged in order to gain an understanding of their structure and composition, called histology or histopathology in the case of diseased tissue. Classically, this sampling and subsequent analysis has been done _ex-vivo_ in 2D using a microscope, often manually analyzed, setting the gold standard for histology @2d_histo_sota_balcaen2023revealing. However classical 2D histology presents the distinct disadvantage of being unable to obtain information at the same granularity in all three axis: slices may be stacked to obtain a 3D result, but resolution in the third axis is limited to section thickness, with the stacked planes separated by a dead space where no information is acquired @litt_review_greet_debournonville2019contrast, and the cutting process induces changes in tissue structure @extending2d_histo_to_3d.

// Motivating our work of extracting vessels
#linebreak()
For the purpose of evaluating the use of the antiangiogenic drug Pazopanib, a tyrosine kinase inhibitor which blocks the creation of new blood vessels as a means for cancer treatment, accurate reconstruction of tumor vasculature is required. Vascularization is by nature 3D and covers entire tissues, and simple volume estimates do not capture important parameters such as tortuosity, connectivity/branching and cross section profile. This 3D nature, coupled with the limitations of 2D methods, motivates the use of 3D imaging: for the purpose of tumor evaluation, contrast-enhanced Micro-CT scans were collected with an agent to increase the contrast of blood vessels.


#v(0.5cm)
#include("./appendices/intro_cect_image_annotations.typ")
#v(0.5cm)



// The shortcomings of classical 2D histology make the asessment and quantification of hollow and highly heterogeneous tissues like vasculature, for which spatial relationships are particularly relevant, challenging @litt_review_greet_debournonville2019contrast. Due to these limitations alternatives such as 3D imaging methods that do not require slicing and have high spatial resolution in all axis are particularly relevant for blood vessel analysis.

// Motivating CECT OG
// #linebreak()
// Histology is relevant in both clinical and laboratory environments. Clinically, histopathological analysis of tissue samples is extensively used for use cases such as cancer detection and grading @histology_used_for_cancers_he2012histology where a sample is analysed manually or with computer assistance. In laboratories for tasks such as clinical trials, histopathologists carry out manual microscopic evaluation @pathology_in_clinical_trials_provenzano2015standardization. 


== The role of computer science

// Motivating the presence of computer science for imaging
Microscopy as a technique and method for tissue analysis predates the field of computer science. As noted, 2D microscopy has downsides and use cases where tissue structure is of relevance have pushed the use of more data intensive and computerized imaging techniques, namely 3D methods. To collect 3D data, the simplest is to extend 2D techniques by stacking slices @methods_for_3d_histo_pichat2018survey. This method limits the resolution across the slicing axis, and does not alleviate the tissue deformation challenges, although is doable without extensive computerization. Non invasive 3D imaging methods rely on wavelengths able to further penetrate the tissue to be imaged: visible light can be used for shallow 3D imaging of soft tissues, with longer wavelengths such as x-rays able to penetrate completely through soft tissue as well as cartilage and bone, requiring a computerized reconstruction pipeline to generate final usable data. Although the machines and methods exist to collect high resolution 3D data using various wavelengths and associated techniques, such as Micro-MRI and Micro-CT, the analysis of high resolution 3D data is not as straightforward as with 2D histological slices: there are many more slices, often thousands, requiring exponentially more time for manual review and annotation. 

// Motivating the use of algorithms that have generalization capabilities, and motivating the need for unified software
#linebreak()
There is also the issue of data diversity stemming from the increase in dimensionality and available imaging methods: even for one given imaging type such as Micro-CT, there is high scan to scan variance between different tissues, a wide array of machines and machine settings, and different contrast or staining agents that can be used at different concentrations and with different methodologies for getting them into the tissue of interest. This huge diversity natually drives a huge diversity in data with as consequence a fragmented and diverse data processing landscape. //The available software  with often duplicate work when easy to use or free and open tools are not available.

#linebreak()
Our imaging method of choice for analyzing blood vessels, Micro-CT, presents low contrast between soft tissue: techniques exist to increase contrast and improve visibility such as cryo-CT @cryoct_maes2022cryogenic or the utilization of contrast enhacing staining agents (CESAs) in Contrast-Enhanced CT called CECT, as used for the data in this thesis. Although essential to increase the contrast between tissue types, these techniques still do not enable sufficient differentiation for small vascular networks such as those found in the murine tumors collected for the evaluation of Pazopanib to allow threshold based classification as is commonly used for bone or for samples with high contrast agent presence @litt_review_greet_debournonville2019contrast, this was shown during the analysis phase of @wlodarski, the source of the data used here, where threshold based segmentation was used and resulted in poor performance.


== Computer science as a tool

#linebreak()
When faced with complex data the paths for researchers are twofold: either manual annotation of the data, or utilization of algorithms to aid in the separation of their structures of interest. Manual annotation suffers from high subjectivity, strong variance between annotators @variability_in_annotations_xray_lin2023pluribus and requires time and expert annotators. The inter annotator variance can be explained in mutliple fashions: expertise difference, tool type and experience, available time, subjectivity and more. Additionally, annotation natively in 3D is challenging, meaning it is difficult to annotate while properly considering all three axis simultaneously, hindering the annotation of small 3D structures like vasculature. This annotation variance, combined with the time required to manually segment, means that the small vascular networks in the provided data have yet to be manually segmented. 

// HERE IMPORTANT TO MENTION AUTOMATIC ML NN-UNET
#linebreak()
The variance in manual annotations, as well as time taken, motivate the need for automated or algorithm based annotation techniques. Users for whom the purpose of analyzing data is not to contribute or work on the process of analysis are pulled towards user friendly and simple methods, where data analysis is a tool to enable information extraction. These algorithmic annotation techniques can themselves again be split into two categories: (1) simple, generalist methods such as thresholding, easily understandable and widely available, however having has poor performance on data that cannot easily be split purely based on grey values and (2) a wide spectrum of techniques that carry a richer prior or set of priors about the target structure, ranging from Otsu to machine learning. For vessel analysis, simple methods are easy to apply but result in discontinuities in blood vessels and don't generalize across samples, as well as require the selection of a fixed threshold per sample, which was discovered during user interviews to be carried out based on the users prior experience, not a principled, repeatable manner. 

// Situation: computer science is not used outside of computer science labs and papers
#linebreak()
The uptake and adoption of advanced techniques remains limited outside of the walls of computer science labs due to the lack of readily available user friendly solutions, where the barrier to entry or friction associated with using a new tool or method is too high due to a wide array of issues: proprietary paid tools are used, research software is often unmaintained or poorly documented with algorithms challenging to run on different machines due to a large library of pre-requisite software, software versionning, or different OS. For modern deep learning based algorithms, hardware is often a limiting factor due to requiring dedicated GPUs @unet_og_paper, the requirement of particular data formats, or poor performance requiring re-training.


#linebreak()
In this thesis work will be carried out to create an open source, user friendly, data driven and robust small blood vessel extraction method for obtaining segmented blood vessels, with the goal of enabling downstream extraction of clinically relevant vasculature characteristics. This goal is defined by the usecase of a dataset of Contrast-Enhanced Micro-CT data acquired to examine the use of Pazopanib. CollaboratiVessel is created as an easily installable plugin for 3DSlicer, an open-source and free base software, that ingests and outputs data in portable data formats familiar to researchers, to ensure re-usability and compatibility with existing downstream software. The plugin implements proven algorithms with user adjustable hyperparameters to enable easy re-use without requiring expertise in computer science. Implemented methods are compared with existing pipelines for extracting fine blood vessels, and tested for robustness by examining performance on data previously considered non segmentable due to non uniform contrast agent staining.

All code written in the implementation of this thesis, as well as the code to generate this document and the notes taken in the process of redaction, are made open source under the MIT license (for code) and labeled under the creative commons as CC0 - No Rights Reserved (for creative works - the writing).






// Old comments from Round 1:

// Native methods of 3D imaging have been developed to paliate the issues of 2D histology: microscopy methods such as confocal microscopy, 3D ultrasound imaging, magnetic resonnance and x-ray imaging. High resolution variants of the latter two exist in the form of micro-Magnetic Resonance Imaging (micro-MRI) and microfocus X-ray Computed Tomography (microCT), able to .


// In order to evaluate the efficacy of the drug Pazopanib, a cancer treatment drug of the antiangiogenic drug group, which block the creation of new blood vessels essential to tumor development

// accurate analysis of blood vessel characteristics beyond simple volume measurements are required  


// #linebreak()
// Blood vessel understanding and reconstruction has emerged over the past years as a critical element in understanding and pushing the boundaries in new drug research: angiogenesis, or the creation of new blood vessels, is a key step in the growth and spread of cancerous tumors. Classical methods, relevant for qualitative understanding and estimation, fall short in terms of accuracy for quantitative analysis for clinical trials [0.4]. 2D reconstruction suffers due to its inherent variability resulting from the slicing process and lack of resolution, with the field is progressing towards the use of high resolution 3D data for these quantitative analysis tasks.

// #linebreak()
// We will begin by diving into the current state of the art in histology for drug sreening, followed by the MicroCT methods used, and finish with an exploration of the methods of image understanding more broadly, 

// #linebreak()

// you should come with CECT being a new tool for
// 3d biology but limitations = reconstruction of the
// vasculature network in 3d -> here is where the SOTA
// will continue on + thesis topic will work on


// - 0.4 Sources on angiogenesis in tumors from Wlodarski

// ------------------------------






// * avoid giving information outside of expertise and is redundant *
// * start SOTA with biopsies -> clinical biopsies vs drug development biopsies *
// "classical way" is classical 2D histo, explain reason why 3D is much better
// 3D is better because vasculature
// tumors result in biopsies result in needing to analyze vasculature results in histo result in 2d or 3d result in better or worse vascularization reconstruction results in ml, thresholding, classical methods. For segmentation, review article of Isabelle! You can learn from clinical cases for DL

// the motivation for segmentation is different in clinical vs in industrial. Different evaluation criteria, different reasons

// == Goal: SMART (Specific, Measurable, Achievable, Relevant, Time-bound)

// Develop a re-usable, robust vascular reconstruction pipeline for MicroCT that:
// + Handles vessels across 10-10 000µm scales - to be fixed
// + - Express in size relative to the image: diameter of 5 and 15/20 voxels
// + Represents vascularization in a method that allows extraction of clinically relevant metrics - papers on vasc
// + - Tortuosity
// + - Branching angles
// + - Branching ratio 
// + - amount of branches
// + - connectivity -> interconnected vs not (ie has endpoints, more endpoints in organs, more interconnected in tumors (?) and necrosis in center of tumor due to lack of vasc)
// + - flow
// + - thickness distribution "thickness map" - fitting sphere midpoints -> we want to see a distribution
// + Integrates with existing tools: Dragonfly, Avizo, Orthanc


// + amount of branches per side, size of the branches/length of the branches, count nodes 


// Evaluate for tumor, from the tree, to ensure transferrability to other domains
// If I improve segmentation -> impact on final outcome -> sensitivity analysis
// Translation of segmentation into the tree -> sensitivity analysis
// Focus on process of evaluating the segmentation


// TODO additions:
// - having re-usability enables future federated machine learning
// - better research and citate on the interpretable machine learning -> goal of transferrability and re-use
// - better explanation of semantic and semantic segmentation, and its up/downsides
// - Graph-based reconstruction
// - Explore why existing methods fail
// - active phrasing for titles & subtitles
// - Link sections explicitly (e.g., "Having established the need for vascular reconstruction, we now compare imaging modalities...").
// - Focus on extracting problems in the intro


// == Vascularization

// * --> atlas of anatomy third edition and anatomy course page on moodle *

// - Define tumor vascularization (blood vessel networks in tumors induced by the tumor to continue growing -> see wlodarski).
// - Role of vascularization: nutrient/oxygen supply to tumor, metastasis/spreading but can also allow treatment delivery
// - Why reconstruction of vascularization matters -> allows us to estimate state of tumor, better evaluate treatments that act on vasc.

// #v(12pt)

// - The whole human body is vascularized, every organ
// - - Mention key figures 
// - It plays a key role in many diseases
// - - Diseases of the vascular system: leading cause of death (heart failure)
// - - Other diseases: uses the system to move around & human body uses it to move white blood cells around
// - - Other diseases: uses the system to feed itself (cancer/tumors) & human body too

// #v(12pt)

// - It is multiscale - explore vasculature papers
// - It is a common structure amongst living organisms - as with abstract: clarify if it evolved independently multiple times, and that its commonality is structure and not the "liquid"
// - It is it is critical to multicellularity

// #v(12pt)

// - It can be analysed qualitatively -> cite some forms of vasculature studies that indirectly measure or evaluate it
// - - using vascular studies
// - - using tools (Stethoscopes)
// - It can be analysed quantitatively -> cite some forms of vasc. studies that directly measure it and cite papers that use it for anti-angio drugs
// - - using post mortem dissection
// - - using imaging techniques

// #v(24pt)

// == MicroCT

// * scheme of going from simple to complex, funnel towards ex vivo imaging, biomedical imaging *
// * make clearer the steps going towards *
// * focus on invivo and ex vivo and imaging, organ to cell scale *
// ~
// * Focus on structural imaging and CT/MRI*
// ~
// * SOTA really focus on histology -> be careful to avoid in vivo, histology in 3D *
// ~
// * SOTA: reason for research, explain why you're doing things *
// ~
// "In case of cancer diagnosis, a biopsy is taken, in industry biopsy of animals to assess drugs, crucial to understand diseases and find treatment. Classical method is histology (assessement of biological tissues at a micro scale) classical 2d histo is the usual way of doing it, but there are limitations in this for vasculature due to its 3d structure, discuss new methods for 3d histo (and one is CECT) and you're limited in µCT analysis of data is difficult"
// * main problem statement * : cect problem in segmentation of vasculature
// We need to do more advanced segmentation, we can refer to in-vivo, and we can learn and get inspiration from it 

// What is MicroCT <> CT (resolution, ex-vivo nature, sample preparation).
// - Why are CEST agents used
// - Explain contrast mechanisms for soft tissue and vessels (contrast agent vs native contrast like RBCs).
// - Explain issue with ynamic nature of the images: big vessels vs small vessels

// Conclude with why we're using MicroCT for this situation and more generally why MicroCT can be attractive for vascularization (3D, high resolution) and why it is challenging (noise, artifacts, variation with vessel size).

// #v(24pt)

// === Imaging interpretation

// * state of the art of quantitative *
// ~
// Clinics are already happy about 3d visualization, radiologist is happy seeing things in 3D. reduce bias of radiology interpretation. Their goal is not to be super accurate, but it is to evaluate qualitatively "is the tumor in the liver vascularized"
// ~
// In histo, eg for pharma companies and drug treatment, you need solid numbers, you need quantitative measures.
// * ex vivo "clients" are different! they want quantitative, its a different population *
// ~
// The fundamental progress that has occured over the past century in imaging has been one of hand-in-hand progression of imaging techniques with interpretation techniques, from 2D images to 3D reconstructions such as those seen in MRI. (from here not sure?) We will argue that, in order to be able to make sense of MicroCT imaging, the same way MRI required tomographic reconstruction (not really, here the idea is to focus on the different techniques to increase contrast or highlight differences?), a step almost no human could do themselves, it is required to develop new techniques, that go further than imaging or simply classifying points in space as one or the other category, as seen in segmentation. It is argued that reconstruction: the process of extracting a higher order of information from our imaging data, is necessary to be able to make sense of systems as complex as those of vascularization.

// #v(24pt)

// === Analysis for Vascularization characterization

// - Pros and cons for each wrt to vascular analysis (resolution, invasiveness/ex or in vivo, 3D vs 2D, contrast/colour) 

// #v(24pt)

// == Exploring the reconstruction problem

// Most current imaging techniques produce non semantic data
// - Example of imaging that does extract (near) semantic data: xray of bones
// - Widen to most other imaging and other xray based techniques: most don't differentiate so well

// Return to CECT:
// - It outputs data that needs processing, explain why, discuss voxel sizes, discuss the use of staining agents

// Present semantic extraction / segmentation / reconstruction of structures.
// - Situations and examples where it is good
// - Contrast with specific issues in your setting:
// -- Dynamic nature of the target based on size
// -- 3D problematic

// #v(24pt)

// We lack the priors of the radiologist
// We're extracting a model that exists in peoples heads, qualitatively evaluates, and we're bringing 

// -> even if we make a 3D render, the radiologist doesn't care about small things missing, they care about the anatomy
// -> difference in goals vs qualitative evaluation: the model is scrutable/interpretable/real, from which you can get quantitative figures
// -> segmentation needs to be neat, accurate, robust to small changes and noise

// * final presentation: make good visualization showing the differece with some ablation. Explain difference between typical evaluation with dice, and the real structural evaluation. Show that DICE being really high or low doesn't necessarily reflect the actual final output. Benefit from the area under the curve difference wrt classical methods *

// * use the tumor case as one case study to explain what I'm doing: briefly SOTA 3D histology for drug screening, the need for 3D histo is clear for companies developping drugs, I focus on antiangionetic drugs on tumor -> refer to Lisa thesis (effect of pazopanib) *