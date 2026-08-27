= State of the art

// Add papers: 

// Three-dimensional multi-scale line filter for segmentation and visualization of curvilinear structures in medical images https://www.sciencedirect.com/science/article/abs/pii/S1361841598800091
// skeletonization algorithm in scikit-image: Building Skeleton Models via 3-D Medial Surface Axis Thinning Algorithms https://www.sciencedirect.com/science/article/abs/pii/S104996528471042X

// Image Segmentation Using Deep Learning: A Survey https://arxiv.org/pdf/2001.05566


// TODO: add from https://forum.image.sc/t/comparison-of-some-tools-for-3d-dense-ground-truth-annotations/38918/39
// https://project-monai.github.io/
// https://home.webknossos.org/

== Software in Research

To work on 3D CT scans researchers at the UCLouvain faculty IMMC (Institute of Mechanics, Materials, and Civil Engineering) use a variety of software explicitly related to the core task of working with 3D volumes: Avizo, CTAn and Dragonfly3D (amongst others), but software is also used implicitly at earlier steps: the OS of the computers, software in the scanner, etc. These pieces of software rarely receive the spotlight in the process of research, but their use places barriers that undermine the scientific principles of open, reproducible, and replicable work by locking processes behind licenses and fees reaching into the tens of thousands of euros per year.

// , it is common however that scientific research be carried out in part or fully using closed source or proprietary software, with licenses costing multiple thousands, as is the case for Avizo. These software are occasionally available under a "free for research" liencese,

// The kinds of software used in a research setting vary by location, as well as in scope, purpose, availability, expense and licensing. At the UCLouvain faculty IMMC (Institute of Mechanics, Materials, and Civil Engineering), research is carried out on tissue samples using computed tomography techniques. In doing so, a variety of software is used: both as explicit steps in the pipeline for tasks such as segmenting samples in 3D, using Avizo or Dragonfly3D, or implicitly as elements of the pipeline that lay before the steps done by researchers (software running on CT machines) or in the infrastructure, such as the OS used on computing devices.  

// #linebreak()
// The guiding principles of research dictate that Open, reproducible, and replicable practices are a fundamental part of science, it is common however that scientific research be carried out in part or fully using closed source or proprietary software, with licenses costing multiple thousands, as is the case for Avizo. These software are occasionally available under a "free for research" liencese, such as FreeD offered by Dragonfly3D @dragonfly_freed_license, discussed later. For most published research in biology, the relevant software to the research runs on top of a abstracted computational stack, as a result we will focus on the level of software specific to the extraction of information from the Micro-CT scans provided.
// Other pieces of paid software are part of the infrastructure such as the operating system Windows used on the lab computers, an implicit cost to replication

=== Software Licenses 

Software licenses are closely linked with the monetary and scientific costs of use: they govern the terms under which a piece of software may be used, modified, and redistributed and broadly fall into two categories: proprietary (closed source) and open source. Proprietary software restricts access to its source code and is generally distributed under a paid license, although exceptions exist in the form of freeware: proprietary software made available at no cost, as with Dragonfly3D's FreED license. Open source software makes its source code publicly available and is (in the majority of cases) as a result free of charge. Licenses enable the owner of the original software to control the distribution and use of extensions and modifications: Dragonfly3D does not explicitly allow sharing extensions #footnote["\[The user\] shall not distribute or transfer the Software or Improvements to any person or third parties, without prior written permission from \[Dragonfly3D\]" @DragonflyFreeDLicense], unlike #link("https://slicer.readthedocs.io/en/latest/user_guide/about.html#license")[3DSlicer]

//Within open source licenses, meaningful distinctions exist between permissive licenses (such as MIT or BSD), which place few restrictions on reuse, and copyleft licenses (such as the GPL family), which require that derivative works remain open source. For our purposes, we will consider software that shares its source code and places no barrier to entry in the form of a license cost as "open".

#linebreak()
Open source software matters in scientific research: First, being free removes a significant barrier to entry, with any researcher, regardless of institutional resources being able to access, run, and reproduce a pipeline built on open source tools. This is a prerequisite for replicability. Secondly open source software is extensible: prior work can be built upon by accessing, modifying and learning from its source code and development. This capacity for incremental improvement mirrors the broader scientific process itself, where each work builds upon prior results. In the medical field, caveats exist to protect from clinical use such as 3D Slicer, published under a modified BSD license. Software such as Orthanc @orthanc_paper_jodogne place importance on enforcing sharing of modifications, and is published under a copyleft license, GPLv3.

// It is a medical image viewer whose architecture deliberately relies on pre-existing open components such as the Lua scripting language and standard networking protocols, enabling the community to extend its functionality without duplicating prior effort.

// #linebreak()
// The standard for open and free software at the OS level is Linux, a kernel, on top of which various distributions are built such as Ubuntu as used in this thesis, or one of a variety of over one thousand others @wikipedia_linux_distributions. On the OS is run the software that is used during the various stages of scientific work. Of these stages, relevant to this thesis are the software required to process the outputs of a Micro-CT machine: software able to reconstruct the 3D representation of the imaged target from the collection of 2D slices provided by the CT machine.

With this in mind, all code written in the implementation of this thesis, as well as the code to generate this document and the notes taken in the process of redaction, are made open source under the MIT license (for code) and labeled under the creative commons as CC0 - No Rights Reserved (for creative works - the writing).


=== Software for 3D analysis <sota_sw_for_3d>

// Drawing from Dragonfly3D's own comparative software list and a search for available tools, those 
The outputs after reconstruction of a CT scan are in the form of a stack of slice-by-slice files that can then be assembled into a 3D volume. Software relevant to this thesis can be divided along the same axis introduced in the previous section: commercial/closed source and open source/free. On the commercial side, the main options include (Bold indicating those actively used in the UCLouvain IMMC) #text(weight: "bold")[Dragonfly3D, Avizo, CTAn], Amira, Analyze and CTVol (by Bruker), Aphelion, Image Pro, Imaris, MeVisLab, Mimics, ScanIP, Octopus, VG Studio, Zeiss Inspect. On the open source and freeware side, the principal options are 3D Slicer, Chimera, Blender, Dream3D, Drishti, ImageJ, FIJI, IMOD, MeshLab, OsiriX, ParaView, SimVascular, VesselKnife and VisIt. Additionally, code first specialised and focused tools, made in a research context exist such as SPROUT and nnU-Net.//, the latter being a deep learning framework for medical image segmentation.

//, candidate software was evaluated against a set of technical criteria, ordered by importance:
#linebreak()
For the purposes of this thesis, software was required to meet the following requirements: *(1)* Import a 3D scan from individual 2D slices in standard formats, *(2)* Export data to non-proprietary formats, and *(3)* Allow coded plugins/code extensions.
// 4. Ability to (manually or automatically) segment parts of a scan, especially of blood vessels and availability of external tools specifically designed for vascular segmentation.

#linebreak()
With the goal of developing software for practical real world use, the following aspects were also weighed:
1. Availability of dedicated support forums & tutorial videos
2. Active development
3. Prior use by the lab researchers, and by researchers of the field more broadly.
4. Ease of installation and barrier to entry

#linebreak()
From this it is clear that standalone approaches requiring coding such as DeepVesselNet @tetteh2020deepvesselnet and SPROUT @sprout_segmentation_volumetric are to be discarded as candidates. The software in use at the laboratory for blood vessel segmentation (Avizo, Dragonfly3D) were tested and compared to open source alternatives 3D Slicer and ImageJ/FIJI. ImageJ and its distribution FIJI have a rich history in biological image analysis, having also been used in the past in the lab and on CT data. An extensive plugin ecosystem relevant for this work is available, such as the Frangi vesselness @imagej_frangi algorithm, but native support for vascular network extraction in 3D is limited. 

3D Slicer @3Dslicer_paper emerged as the most suitable tool, due to its wide adoption in the medical field, existing plugin ecosystem with vascular specific tools such as The Vascular Modeling Toolkit @vmtk and R-Vessel-X @affane2025rvesselx. Beyond satisfying the core technical criteria of importing 3D scans as stacks of 2D slices, as well as import and export of open formats such as DICOM, 3D slicer also has extensive instructions and prior work in manual and semi-automatic segmentation. The Extension Manager is particularly relevant to this work, enabling non technical users to install the plugin without needing to code and free of charge, as opposed to the paid extensions for vascular extraction available for tools like Avizo and Dragonfly3D.

// #linebreak()
// The combination of a stable, widely adopted platform with active community support and specialised vascular tooling makes 3D Slicer the most appropriate choice for extracting and analysing the vasculature from Micro-CT data in a reproducible and extensible manner.

#v(1cm)

#linebreak()
_*Problem 1.* In an extensive and diverse software landscape, our software must fit into an existing well documented segmentation tool: 3DSlicer, be easy to use: click only installation and offer compelling performance._










// -----------------------------------------

// TO ADD: EXCEPTIONALLY RELEVANT: https://pdf.sciencedirectassets.com/273258/1-s2.0-S1742706120X00043/1-s2.0-S1742706120300532/main.pdf
// Exploring polyoxometalates as non-destructive staining agents for contrast-enhanced microfocus computed tomography of biological tissues

#pagebreak()
== Tissue imaging

The process of imaging is a critical step in obtaining an understanding of a tissue in both clinical and research contexts. 2D histology is considered the gold standard having a long history @2d_histo_sota_balcaen2023revealing and producing high resolution images down to 5 μm for light based methods. The diversity in imaging techniques for 2D histology has rapidly increased the resolution, with electron microscopy able to reach in the order of sub nanometer scale @histology_used_for_cancers_he2012histology. Progress has also increased the dimensionality of imaging, with computation enabling rapid progress in 3D methods using techniques like tomography, where multiple images are taken non destructively of a target from different angles and assembled, used in-vivo and ex-vivo methods such as computed tomography (CT) and magnetic resonnance (MRI).

#linebreak()
For tasks such as measuring the impact of a drug on vascularization, quantification is particularly relevant: Understanding the three-dimensional structure of biological tissue is a prerequisite for the analysis of structure-altering drugs such as Pazopanib, where changes in tumor vascularization are inherently spatial and quantifiable across multiple parameters. For such tasks, 2D histology is insufficient: Physical sectioning of the sample is destructive, is not orientation-agnostic, and introduces deformation artifacts that are difficult to compensate for even with embedding techniques @3dnondestructive_softtissue_µtomo, additionally samples may undergo structural changes over time during preparation: they dry out, and certain elements oxydize, although techniques exist to mitigate this @litt_review_greet_debournonville2019contrast.

#linebreak()
To achieve 3D imaging from 2D histology, 2D slices are stacked across a virtual axis @extending2d_histo_to_3d. The resolution achievable when stacking 2D slices to reconstruct a virtual third dimension is limited by slice thickness and inter-slice registration errors. Certain optical techniques making use of slices allow partial recovery of 3D information from 2D acquisitions, such as confocal microscopy, light sheet microscopy, and optical coherence tomography @cryoct_maes2022cryogenic, they are limited in sample penetration depth and volume. When the target structure to be imaged and understood does not follow a single preferred axis, as is fundamentally the case for vascular networks and especially those of tumors, the limitations of slice-based histology make proper reliable quantification of blood vessel parameters impossible, and the relevance of 3D methods like MRI and CT clear. 


=== 3D imaging techniques for histology

Non-destructive 3D volumetric imaging methods overcome many of the limitations of 2D slice based histology by collecting data uniformly across dimensions, enabling virtual slicing across any plane without requiring physically sectioning the sample. Techniques for 3D imaging range from the aformentioned microscopy techniques using visible or near infrared light, to techniques like MRI that utilize magnetic fields or X-Ray imaging in the form of X-ray microfocus computed tomography (CT). These techniques allow the collection of qualitative and quantitative 3D microstructural data of tissues and their constituents: analysis is not restricted to a single orientation and does nott require sample destruction. They also have associated high resolution variants allowing micrometer level imaging: Micro-MRI has an inherently high-contrast for soft tissues and is able to reach 20 μm @Chen2018; Micro-CT is commonly used at 6µm, as in the data used in this document and resolutions down to 1µm are possible, but the technique suffers from low contrast when imaging soft tissue, when extra technques are not used @2d_histo_sota_balcaen2023revealing. These techniques are the most relevant for ex-vivo tissue histology at the scale of small animal models, due to their small maximum capture volume.

// A lot of this section is sourced on the single paper, is that ok?

=== Contrast-enhanced micro-CT

As mentionned, standard Micro-CT suffers from low contrast between soft tissues making the visualization of blood vessels difficult. To improve contrast two common approaches exist: imaging methodology changes, and sample modification. Imaging techniques such as phase-contrast Micro-CT (PC-CT) utilize the refractive properties of the X-rays rather than its absorption alone, enhance soft tissue edge detection at the cost of higher complexity and long acquisiton times. Tissue modifying techniques that aim to increase contrast include the use of various Contrast Enhancing agents (CESAs): Casting contrast agents (CCA) are perfused into vasculature but pressure must be controlled carefully @exvivo_cardioct and is not applicable to our usecase due to the size of vessels to be observed. Diffusion contrast-enhacing agents reach the structure of interest and bind to it based on diffusion through the structure to be imaged, termed CECT. For the tumor vascularization studied in this thesis, ex-vivo tissue binding CESAs are used, namely Hafnium Wells-Dawson Polyoxometalates (Hf-WD POM) due to its nondestructive nature and low tissue shrinkage during incubation after excision. Techniques exist that can be used in combination with CESAs: contrast can be increased using freezing to increase contrast Cryogenic contrast-enhanced microCT (cryo-CECT) which preserves tissue microstructure with reduced deformation @cryoct_maes2022cryogenic.

//CECT is of particular relevance for imaging large vascular networks because of the ability to inject the CE agent into the vasculature @exvivo_cardioct, in tumors however the microvasculature present a challenge: small blood vessels do not lend themselves to perfusion, so alternatives are used namely diffusion. 
#linebreak()
Tumors also present a particularity in that they are frequently partially or entirely devoid of residual hemoglobin, preventing or reducing the action of CESAs and thereby reducing contrast and introducing discontinuities. Diffusion based contrast-enhacing agents also bring an additional disadvantage as seen in the data provided for this thesis: the diffusion of CE agents throughout the tissue happens from the outside in, resulting in a gradient of the amount of agent and as a result a gradient in contrast, as opposed to perfusion CESAs that follow the blood vessels. 

///CECT was utilized for the acquisition of the tumor images in this thesis due to its ability to enable differentiation of the blood vessel boundaries and reasonable image acquisition times.
// "Too-high pressures can lead to tissue damage, whereas too-low pressures might result in incomplete filling of the desired vessels. Viscosity is also an important factor to consider for reaching the smaller capillaries and for keeping the perfusion pressure low" from @exvivo_cardioct

#v(1cm)

#linebreak()
_*Problem 2.* The the wide diversity of available modalities for 3D imaging and with their subtypes, the different machines and their acquisition parameters, variability in samples and their preparation, staining agents and methods, as well as large diversity of tissue types come together to present a challege in creating a method that is re-usable, even within the same lab. Any method used for the segmentation of small blood vessels should be robust to the gradients caused by diffusion CECT, and able to handle variable contrast levels._





== Vascular Segmentation: From General Methods to Vasculature-Specific Pipelines



























// ----------------------------------------------------------------
// Deprecated 27-04-2026 to combine both segmentation and vasculature extraction sections


// Two broad classes of contrast agents are used in this context. Casting contrast agents (CCAs) - such as Microfil or barium sulfate suspensions - are perfused through the vasculature prior to excision, physically filling the vessel lumen with a radio-opaque material that polymerizes in place. These contrast agents are pigmented or radiopaque casting materials injected throughout the animal for vascular visualization in situ, often through transcardiac perfusion procedures. While effective, the use of these vascular casting contrast agents results in terminal studies. Additionally, due to the higher viscosity and non-miscible nature of compounds such as Microfil, higher pressures are required to achieve uniform vascular filling, resulting in vessel bulging or even rupture. Tissue-binding CESAs, by contrast, are applied ex-vivo by incubation after excision, enriching the X-ray attenuating atom content in specific tissue compartments through chemical interactions rather than physical filling. Care must be taken that both the CA staining protocol and the image acquisition setup do not hamper the non-destructive character of the methodology, and compatibility with subsequent biochemical assays should be considered.

// A key and widely discussed challenge with both classes of contrast agents is the uniformity of their distribution throughout the sample. For diffusible contrast agents, higher standard deviation values in image intensity within a tumor can be due to defective perfusion of tumor tissues - well-perfused tumors will be uniformly enhanced, resulting in smaller variance, while poorly vascularized regions may show heterogeneous or absent contrast uptake. In the context of tumor vasculature specifically, this is compounded by the intrinsically abnormal architecture of tumor-associated vessels: rapid angiogenesis within a tumor leads to the development of immature, poorly organized, leaky vasculature, which affects both the perfusion of casting agents and the diffusion kinetics of tissue-binding CESAs. For ex-vivo samples where vascular perfusion is no longer active, passive diffusion of the CE agent from the sample surface is the primary mechanism of uptake, and diffusion gradients across large or dense tissue samples can result in under-staining of central regions and over-staining near the surface [Silva et al., 2015; Kerckhofs et al., 2022].


// #linebreak()
// Segmentation need not be based on a single input: there exist imaging techniques combining multiple imaging modalities such as micro-CT and µMRI @micro-CT_mri_multimodal. 
// multimodal approaches combining micro-CT with MRI have been used to simultaneously characterize vascular architecture and tissue composition in the context of biomaterial angiogenesis studies @micro-CT_mri_multimodal. In the oncological context, micro-CT of tumor microvasculature presents specific challenges: the spatial scales of interest span from large feeding vessels to sub-resolution capillaries, the vascular density and tortuosity are elevated relative to normal tissue, and the quantity of available samples is typically small, limiting the applicability of data-hungry learning methods.

// // #linebreak()
// // Early approaches to three-dimensional vascular reconstruction in tumor tissue relied on serial histological sectioning followed by manual or semi-automatic
// alignment and segmentation of individual sections, before rendering a three-dimensional model /*3D reconstruction of extravascular matrix and blood vessels in uveal melanoma*/. These methods are destructive, labor-intensive, and prone to registration artifacts at section boundaries. 3D imaging techniques like micro-CT offer a non-destructive alternative with isotropic resolution, though at the cost of lower contrast for soft tissue structures without the use of contrast agents, and with the added complexity of beam hardening artifacts in specimens with heterogeneous composition.


// -----------------------------------------

// With the goal of reconstructing vascularization in imaged tissue, we aim to take in data from an imaging modality, process it through a software pipeline, and obtain at output a data structure with higher information density than the input. This process of reducing the amount of raw data, but increasing the utility or information content of the data, is explored widely in the field of computer science. It underlies concepts such model fitting to noisy data [5.2] or as more commonly carried out in a biological context and industry, image segmentation, where the goal is to separate regions of a 2D image into multiple segments and objects [5.3].

// Image segmentation plays a central role in accelerating, standardizing medical image analysis by enabling quantitative analysis of different kinds: by classifying pixels with semantic labels (semantic segmentation), partitioning of objects (instance segmentation) or a combination of both across the entire image space (panoptic segmentation) [5.1]. The task can be as simple and as old as separating objects from a background, a problem that has been explored in computer science for multiple decades @OTSU_segmentation, or more complex as in panoptic segmentation, only being posed in 2018 @panoptic_seg_og. In the context of volumetric biological imaging, segmentation extends naturally into three dimensions, where voxel-wise labeling must account for spatial continuity across image slices and the complex, branching topology of structures such as blood vessel networks.

// 5.1 Image Segmentation Using Deep Learning: A Survey
// 5.2 RANSAC https://doi.org/10.1145/358669.358692
// 5.3 FIRST EDITION! Computer Vision: Algorithms and Applications. Berlin, Germany



// Here I want to talk about priors: we used to want to encode the human expertise with expert models and a lot of parameters to tune, then we started to have FCNs which were difficult to train, we moved on the CNNs which worked with the tech we had due to being more data efficient by having the locality prior of the convolution, then we moved to transformers that removed that prior, enabled longer range dependencies and modeled the compression decompression process more explicitly, however requiring lots of data.

#pagebreak()
== Segmentation

The purpose of imaging a tissue is to generate an image containing sufficient data to enable useful information to be extracted. This can be seen by the progress in imaging techniques of the _acquisition process_ laid out in the previous section, to make the data of interest more salient (using agents to enhance the contrast) or to make the data more granular (increasing resolution). The _information extraction_ process has also seen improvements over time: classically analysis was carried out by humans, which evolved towards computerization due to the ability to write algorithms that can process and extract information of interest from an image. 

// ranging from simple classical methods such as the OTSU method for edge detection @OTSU_segmentation to more computationally expensive, complex and inscrutable deep learning. Deep learning algorithms are known to act as a form of information compression algorithm @ml_is_compression, starting from a data source with many individual data points, such as an image, and ending with as little as a single class output as illustrated in @alexnet_og_deeplearning.

//higher levels of representation were also enabled, where the output of a pipeline may be the reconstruction of a structured output such as a network or skeleton, as is seen with software skeletonization methods @skan. 

// Image segmentation methods evolved in complexity over time as techniques and computational resources grew: from the OTSU method for edge detection enabling two classes @OTSU_segmentation to deep learning @alexnet_og_deeplearning. 

//Deep learning algorithms are known to act as a form of information compression algorithm @ml_is_compression, starting from a data source with many individual data points, such as an image, and ending with as little as a single class output as illustrated in 

//span a wide spectrum of complexity, from classical signal processing approaches to modern deep learning architectures, and vary in output format, from pixel wise annotation and single class prediction to higher-order structural extraction methods that reason about the topology of extracted objects as in skeletonization.

#linebreak()
Image segmentation methods evolved in complexity over time as techniques and computational resources grew. In its simplest form, intensity-based thresholding methods such as Otsu's method @OTSU_segmentation operate by iteratively finding an optimal intensity threshold that separates foreground from background by minimizing intra-class variance. Such methods are computationally inexpensive and interpretable, but are sensitive to noise, imaging artifacts, and intensity inhomogeneities, as they optimize for a numerical goal. Gradient based methods constitute a natural first approach to CECT, as the goal of utilizing a contrast enhancing agent is to increase the salience of the structures of interest, however algorithms that reason globally over an entire image can fail due to diffusion gradients as mentioned previously, as well as noise. Region-growing @region_growing implementations starting from given point(s) such as marching squares, and watershed algorithms extend this idea by incorporating spatial connectivity, iteratively expanding labeled regions from seed points according to local intensity gradients, making them more robust to global intensity variation, however remaining susceptible to over- or under-segmentation in complex structures. These simple techniques are also not context aware: they can create discontinuities due to not integrating priors of the structure they are segmententing, such as the connectivity of blood vessels.

// TODO: Revise the position of this
#linebreak()
Beyond grey value based methods, algorithms integrating handcrafted priors exist such as Gabor filters or Hessian-based filters, where particularly relevant for vessels is Frangi's multiscale vessel enhancement filter @frangi_og_paper, recently improved in @beyond_frangi where the eigenvalues of the Hessian matrix of local image intensities at multiple Gaussian scales is analyzed to produce a vesselness score for each voxel, responding to tubular structures while suppressing circular and planar structures. The Frangi vesselness algorithm has been particularly influential in vessel segmentation tasks, as it explicitly models the prior of tubular geometry inherent in blood vessels. These methods offer greater robustness than simple thresholding but depend heavily on the user fine tuning algorithm hyper parameters to optimize performance for a given domain or usecase, and as a result of this feature engineering, can fail to generalize across imaging conditions @imagej_frangi. 

Additionally the filter's response degrades at vessel bifurcations, at the endpoints of vessels, and in regions of low contrast. In @beyond_frangi extensions to the vesselness formulation are proposed that improve responses at junctions and at low contrast boundaries to increase robustness of the filter.

#linebreak()
Beyond filter-based mathematically driven approaches that work on small image localities lay methods relying on optimization: minimal path methods formulate vessel centerline extraction as an optimization problem. The path of least cost is taken between user-defined endpoints, with cost derived from vesselness or image intensity. In @minimal_path_tubular the geometry of vessels is incorporated, adding radius as an additional dimension of the path space. This class of methods is particularly well-suited to expert-in-the-loop approaches where small amounts of data need to be annotated: a user can place seed points that guide the extraction of a complete vascular tree, requiring no training data, and enabling iterative improvement. This method can be seen used for large arteries and airways in @vmtk. This strength is also a weakness: the low scalability means that for a densely vascularized tissue, or a tissue with non uniform characteristics, many seed points can be required wich is impractical. Automatic seed point placement is a potential solution, but remains an open problem.



=== Machine learning

Data driven approaches represented a major revolution in data analysis over classical methods: they enabled the data characteristics themselves to drive the configuration of the hyperparameters of the algorithm. So called supervised machine learning take in labeled example data and output a result, such as in k-nn a class output based on neighbors, or in tree decision algorithms @xgboost. The paradigm of deep learning exploded in popularity with @alexnet_og_deeplearning and led to fully convolutional encoder-decoder architectures being used in the medical domain, such as with U-Net @unet_og_paper, representing a major revolution in image segmentation and offering a leap in performance. 

U-Net specifically constituted a breakthrough in medical imaging due to its ability to segment large images with high compute and data efficiency, and across multiple scales by introducing skip connections between encoder and decoder pathways. These allow the network to combine low-level spatial detail with high-level semantic context, enabling the segmentation of thin structures that require context such as cells and vasculature. The structure of U-Net can be extended into 3D with different approaches such as @3d_unet. Recently, transformer-based architectures have superceeded convolutional networks as a more generalist approach to machine learning, being applied to object detection @detr_paper and being extended to segmentation, offering higher performance thanks to a more general computation model: expert crafted feature extraction is removed, such as in the locality prior of convolutions, enabling the capture of more diverse features and long-range spatial dependencies. 

#linebreak()
However as data dimensionality increases, so must the amount of training or example data increase, an issue for convolutional networks and even more so for transformers. This limits the application of deep learning to Micro-CT data where annotated data is expensive and where inter dataset variance is large, even though attempts exist to paliate the data thirst by offering pre-trained models for 3D CT data @nnunet_paper, or by crafting more data efficient models. Examples also exist of trying to make use of so called foundational models, based on a large transformer and able to be "prompted" to customize the segmentation to the usecase at hand @SEMERARO2025102218. 



// Here could cite https://arxiv.org/abs/2003.07311 clDice -- A Novel Topology-Preserving Loss Function for Tubular Structure Segmentation
=== Error calculation

When training a model, or evaluating a method, is is important to be able to measure performance in a repeatable and objective way independent of human feedback. In their simplest form for binary classification, the error rate is simply the amount of correctly classified examples, however as dimensionality of outputs increased, so did the complexity of evaluation methods.

#linebreak()
Loss functions such as cross-entropy used for binary classification calculate the loss on a pixel by pixel basis, based on the predicted distribution. It can be used for segmentation @unet_og_paper, however it is important to recall that our prediction task carries a heavy imbalance due to many more pixels being the background class. With cross-entropy loss, each prediction is independent, meaning for our biased distribution there is a prior of predicting background and producing fragmented or incomplete vessel predictions. There exist loss functions created that integrate the class imbalance explicitly, such as DICE @og_dice_loss however these do not integrate the prior of connectivity or any spatial relatedness: each prediction is treated as independent.


// Using clDice loss for a model thus encodes the prior that blood vessels are connected tubular structures into the model structure itself. //, avoiding the need for separate skeletonization and repair steps. making use of the aformentioned skeletonization techniques,
// When available, problem specific evaluation metrics can better reflect performance in downstream tasks.
#linebreak()
For vasculature specifically, breaks in connectedness can be difficult to reconnect downstream, motivating the creation of custom loss function in @clDice_loss_func called clDice, that integrate the prior of connectedness, and build it into the loss function for predictions. In @CFLoss_loss_func clinically-relevant vascular features are encoded into the loss function. When evaluating a segmentation method consideration of the downstream analysis of its use to extract relevant features, such as tortuosity and branching ratio, is important to consider. As a result, and driven by the needs expressed by the team members, outputs will be evaluated based on point-wise loss of user annotated points, as well as on a manually annotated pixel level baseline. The challenging parameter of connectivity, difficult to capture in the loss, will be manually measured by selecting target areas and reported separately.

// Sequential pipelines have the weakness that errors propagate and compound across each stage, and can result in more fragile pipelines, sensitive to noise or changes in domain. Additionally, it can be difficult to evaluate if a change in performance may have an impact on downstream tasks. 

//Disconnections in the segmentation mask can produce disconnected graphs if the algorithm does not account for this possibility, and if proper care has not been given to provide hyperparameters that enable tuning, or the ability to modify the code used at the different steps, the pipeline becomes unusable. This motivates approaches that integrate structural priors directly into the segmentation model, or that formulate centerline extraction as a joint optimization rather than a post-processing step (*Problem 3.1*).


#v(1cm)

#linebreak()
_*Problem 3.* Segmentation has progressed towards more and more data hungry algorithms, without a corresponding increase in the availability of annotated CECT datasets. Our segmentation method should make use of minimal external data sources, and focus on classical methods._




// DICE loss: from the overlap coefficient of prediction and ground truth on the entire space. It is a ratio of IoU, intersection to union and the absolute count of background voxels does not dominate -> robust to class imbalance vs BCE


// TODO: Revise
// #linebreak()

// #linebreak()
// Optimizing for even higher order parameters is also possible, such as clinically relevant parameters. CF-Loss @CFLoss_loss_func optimizes the loss function for retinal multi-class vessel segmentation and vascular feature measurement, focusing on improving the performance on clinically relevant metrics. clDice and CF-Loss can be used in conjunction with other loss functions such as the lower order DICS, and act as a complimentary extra constraint for network training.

// #linebreak()
// The selection of a loss function or combination of functions through weighing amounts to choosing which structural priors to encode in the optimization objective. For our case of vascular segmentation in small tumor micro-CT volumes with heavy class imbalance and the goal of extracting clinically relevant metrics that are topological correct, a compound loss will be used that combines the imbalance prior, as seen in DICE, and a structurally oriented loss function (*Problem 3.2.*).


// OLD and bad 24-04-2026:
// #linebreak()
// _*Problem 3.1.* Methods for extracting blood vessels can do so at different levels of abstraction. It is important to be able to select the level of abstraction desired in the software, and for any method used to export to have adjustable parameters for this purpose._

// #linebreak()
// _*Problem 3.2.* The selected evaluation method should encode the structure of blood vessels as a prior in some form, in order to ensure that quantified prediction performance matches with qualified performance as experienced by the user._

// Moving between levels of representation modifies the balance between information fidelity, robustness to segmentation errors, and the specificity of the downstream analysis task. Segmentation masks carry spatial information in the image frame while being difficult to analyze quantitatively, limiting to the use of lower order metrics such as volume. Graphs on the other hand are the richest representations quantitiatively, enabling the extraction of volume as well as self reflexive parameters such as tortuosity. Generally pipelines chain these representations sequentially due to simplicity and scrutability: it is easier to collect and annotate data in image space than in graph space, and graph space data does not necessarily translate perfectly back to image space. 










// #linebreak()
// Beyond classification and pixel or voxel-wise labeling, methods exist that aim to extract higher-order structural constructs. For tree and network-like structures such as vascular networks, skeletonization algorithms abstract a binary segmentation mask to a centerline representation that preserves the branching topology of the original structure. In order to have centerline extraction be an output of a deep learning model, it can be formulated directly as an optimization problem alongside pixel or voxel wise segmentation, enabling it to be utilized in the training loop as will be explored later. At the highest level of abstraction, graph-based representations encode the vascular network as a set of nodes (bifurcation points and endpoints) connected by edges (vessel segments), each annotated with attributes such as radius, length, and tortuosity. Abstract representations enable the highest quality downstream quantitative analysis, including branching order, fractal dimension, or inter-vessel spacing, impossible to derive from a raw segmentation mask alone @tetteh2020deepvesselnet, as well as enable simulations with tools such as @simvascular


// SOTA vasculature seg:
// 2010 Tubular Structure Segmentation Based on Minimal Path Method and Anisotropic Enhancement
// 2020 Cardiac multi-scale investigation of the right and left ventricle ex vivo: a review
// 2018 A Survey of Methods for 3D Histology Reconstruction

// Vasc & micro-CT
// Optimization of MicroCT Imaging and Blood Vessel Diameter Quantitation of Preclinical Specimen Vasculature with Radiopaque Polymer Injection Medium

// For cancers/tumors/small vasc
// 2003 Three-Dimensional Reconstruction of Extravascular Matrix Patterns and Blood Vessels in Human Uveal Melanoma Tissue: Techniques and Preliminary Findings
// 2023 on the variability of annot: E pluribus unum: prospective acceptability benchmarking from the Contouring Collaborative for Consensus in Radiation Oncology crowdsourced initiative for multiobserver segmentation



#pagebreak()
== Vasculature extraction <imaging_and_seg>

Vasculature extraction from 3D tomographic data is a longstanding challenge in computer science, extending before the current era of deep learning @LESAGE2009819, where the single and multistep segmentation methods were compared, making use of models such as Hessian based filters, centerline tracking and seed based intensity methods. The issue of data availability for training deep learning models is also known, with approaches to tackle the issue by using simulation with a data generating model used to generate virtual training 3D scans, which can then either directly be used or serve as a basis for transfer learning, where a model is first trained on a similar task with large data availability then fine-tuned on a small amount of in-domain data @tetteh2020deepvesselnet. Blood vessels are highly diverse, ranging in size for tumors from 10µm to hundreds of µm @microct_tumor_angio, diverse in their shape and branching structures. They however present a distinctive and consistent set of geometric priors being tubular, connected, branching structures and contain blood which can provide a different imaging profile to the surrounding tissue. 


// TODO:
#linebreak()
Deep learning has been applied to vascular segmentation in for blood vessel extraction with notable success: DeepVesselNet @tetteh2020deepvesselnet introduced a family of architectures designed for vessel segmentation, centerline prediction, and bifurcation detection in 3D angiographic data by making explicit use of the structural priors inherent to blood vessels as secondary learning targets. Training on centerline and bifurcation labels jointly with segmentation masks improves topological results when compared to simple segmentation training, by providing extra prior generating signals to the model, highlighting the benefits of explicitly utilizing structural priors. V-Net @vnet_paper extended U-Net @unet_og_paper into 3D and improved performance by modifying the loss function; Dice loss is used for the overlap between predicted and ground truth segmentation masks as opposed to cross-entropy, as it is better suited for the class-imbalanced setting characteristic of vessel segmentation where vessel voxels represent a small minority of the image volume.

// Loss functions and class imbalance.
#linebreak()
A major and difficult to circumvent limitation of (supervised) deep learning approaches for vascular extraction is their dependence on relatively large volumes of annotated training data. Manual annotation of vascular networks in micro-CT images is time intensive and requires expert knowledge, and the resulting annotations are known to exhibit significant inter-annotator variability @variability_in_annotations_xray_lin2023pluribus. This variability represents an irreducible uncertainty in the ground truth that places an upper bound on the performance achievable by any supervised method, especially those training on voxel level data. Work-arounds exist, such as removing the inter-annotator noise by first performing structural extraction on the data, and then using these structures to segment the base image, however this presents the problem of introducing the biases of the skeletonization step backwards in the pipeline, into the deep learning model weights. Additionally, models trained on one imaging protocol, contrast agent, sample batch, or tissue type exhibit degraded performance when applied to data from a different distribution: this is termed domain shift, and is particularly acute in methods with imaging methods containing many adjustable parameters and machine specificities like micro-CT imaging where the aformentioned parameters vary widely between laboratories (*Problem 4.2*).


=== Existing pipelines

// TODO: add InVesalius: open-source platform for volume reconstruction and segmentation from medical imaging data
Several software tools and pipelines have been developed to support vascular segmentation and analysis workflows. TKTubeTK @ITKTubeTK_paper_github offers a library of algorithms for tubular structure segmentation and graph extraction built on the ITK framework. The Vascular Modeling Toolkit (VMTK) @vmtk integrates in 3DSlicer and provides a user friendly comprehensive suite of tools for vascular segmentation and vascular extraction: centerline extraction and surface reconstruction. VesselKnife @vesselknife provides an integrated pipeline targeting vessel segmentation, skeletonization, and graph extraction from micro-CT data. For analysis, SKAN @skan provides a well documented Python library for the quantitative analysis of skeleton graphs extracted from binary segmentation masks, enabling computation of branch length distributions, tortuosity, and network connectivity. SimVascular @simvascular extends vascular extraction into simulation, enabling downstream modeling of blood flow within reconstructed vascular geometries.

#linebreak()
The landscape of vascular segmentation tools reflects a broader conflict throughout bio-informatics, medical informatics and bioimagery: general-purpose deep learning segmentation frameworks offer good performance on the datasets they are trained on, but require large annotated datasets and offer limited interpretability or controllability as well as aren't baked into tools used by researchers; classical model-based methods such as Frangi filtering are more transparent and adjustable, built into existing tools and easy to use, but require manual parameter tuning and struggle with complex vascular geometries. 

#v(1cm)

#linebreak()
_*Problem 4.1.* Current methods for segmentation often ignore the structural priors that underly the data generation process. An effective, robust and transferrable method for blood vessel segmentation must thus encode the relevant structural priors, namely connectedness, shape, and branching structure_

#linebreak()
_*Problem 4.2.* Deep learning based segmentation methods that rely on a large corpus of images fit to the distribution on which they are trained, that suffer when the domain shifts due to changes in imaging methodology or sample variance, are not robust enough, nor transferrable enough to enable replicable work across multiple datasets. Any algorithm to extract blood vessels from tumors must contain user adjustable hyper parameters to enable fitting to the parameters of their data, as well as avoid the need for training data beyond a single test example._

#linebreak()
_*Problem 4.3.* Existing vascular segmentation pipelines are typically designed and validated for a single imaging modality, contrast strategy, or tissue type. The fragmentative nature of research means there exist few user friendly modular pipelines with adjustable parameters that can be adapted to the specific imaging characteristics of small tumor micro-CT (non uniform contrast agent diffusion, limited sample size, low contrast and tumor vessel specificities). Robust, reproducible vascular reconstruction usable for quantifying the vasculature network with an accuracy sufficient for clinical and research applications is thus out of reach for most lab work . A robust pipeline must expose interpretable parameters that allow adapation to the users specific imaging context, without requiring retraining as with common deep learning methods, or re-annotation._













// In the state of the art, you indicate what has been studied, why it has been studied, and, in general terms, how it has been studied. This section contains:
// ✓ The background of the study (= context);
// ✓ Research that has been done in the frame of your thesis topic;
// ✓ Information that is needed for the reader to understand your topic and the remaining scientific issues/problems.
// ➔ Make a fluent story of it, and not just a sum up of different papers or references.

// ➔ The context (per paragraph or section) usually ends with a conclusion or problem statement that sets the scene for your specific research questions and project aim + objectives




// -----------------------------------------------------------

// The contrast agents of relevance for this paper are inteded for use ex-vivo, specifically binding to  

// Two broad classes of contrast agents are used in this context. Casting contrast agents (CCAs) - such as Microfil or barium sulfate suspensions - are perfused through the vasculature prior to excision, physically filling the vessel lumen with a radio-opaque material that polymerizes in place. These contrast agents are pigmented or radiopaque casting materials injected throughout the animal for vascular visualization in situ, often through transcardiac perfusion procedures. While effective, the use of these vascular casting contrast agents results in terminal studies. Additionally, due to the higher viscosity and non-miscible nature of compounds such as Microfil, higher pressures are required to achieve uniform vascular filling, resulting in vessel bulging or even rupture. Tissue-binding CESAs, by contrast, are applied ex-vivo by incubation after excision, enriching the X-ray attenuating atom content in specific tissue compartments through chemical interactions rather than physical filling. Care must be taken that both the CA staining protocol and the image acquisition setup do not hamper the non-destructive character of the methodology, and compatibility with subsequent biochemical assays should be considered.

// A key and widely discussed challenge with both classes of contrast agents is the uniformity of their distribution throughout the sample. For diffusible contrast agents, higher standard deviation values in image intensity within a tumor can be due to defective perfusion of tumor tissues - well-perfused tumors will be uniformly enhanced, resulting in smaller variance, while poorly vascularized regions may show heterogeneous or absent contrast uptake. In the context of tumor vasculature specifically, this is compounded by the intrinsically abnormal architecture of tumor-associated vessels: rapid angiogenesis within a tumor leads to the development of immature, poorly organized, leaky vasculature, which affects both the perfusion of casting agents and the diffusion kinetics of tissue-binding CESAs. For ex-vivo samples where vascular perfusion is no longer active, passive diffusion of the CE agent from the sample surface is the primary mechanism of uptake, and diffusion gradients across large or dense tissue samples can result in under-staining of central regions and over-staining near the surface [Silva et al., 2015; Kerckhofs et al., 2022].

// published results are rarely directly comparable. The choice of imaging method, contrast agent, and processing workflow profoundly shapes what structures are visible and measurable in the resulting volume, making 3D histological imaging an inherently context-specific endeavour that demands careful justification of each step in the pipeline.

// - Silva et al. (2015), *Scientific Reports* - X-ray staining micro-tomography and diffusion challenges @3dnondestructive_softtissue_µtomo
// - Leyssens, Pestiaux & Kerckhofs (2021), *Int J Mol Sci* - cardiovascular microCT review  
                // A Review of Ex Vivo X-ray Microfocus Computed Tomography-Based Characterization of the Cardiovascular System 
// - Schaad et al. (2017), *Scientific Reports* - vascular casting agent comparison
// - Badea & Johnson (2015), *Frontiers in Pharmacology* - nanoparticle contrast agents for micro-CT
// - Moldovan et al. (2015), *PLOS ONE* - iodine-based contrast for mouse brain micro-CT


// // ---- Initial

// `== Tissue imaging`

// Understanding the three-dimensional structure of biological tissue is a prerequisite for the analysis of structure-altering drugs such as Pazopanib, where the effect of interest - changes in tumor vascularization - is inherently spatial. Classical 2D histology, while remaining the reference method for human biopsy analysis in oncology, is fundamentally limited in this regard. The technique requires physical slicing of the sample, which is destructive, potentially deforming, and critically, not orientation-agnostic. A large number of slices may be needed to capture structures that do not follow a particular axis, as is the case with vascular networks. Furthermore, classical histology samples dry out during preparation, and the resolution achievable when reconstructing a third dimension by stacking 2D slices is limited. While some techniques such as confocal microscopy, light sheet microscopy, and optical coherence tomography allow partial extraction of 3D information from 2D acquisitions, they remain constrained in the depth and scale of tissue they can characterize.

// Non-destructive volumetric imaging methods overcome many of these limitations. Magnetic resonance imaging (MRI) and computed tomography (CT) - and their higher-resolution variants, micro-MRI and microCT - enable virtual slicing across any plane without physically sectioning the sample. Micro-MRI offers strong contrast on soft tissue, while microCT excels on calcified structures but achieves sub-micrometer resolution. Crucially, both modalities can be used in conjunction with contrast-enhancing staining agents (CESAs), which extend their applicability to soft tissue. In the case of microCT, this gives rise to contrast-enhanced microCT (CECT), which has been reviewed for ex-vivo data acquisition and has demonstrated its utility in contexts such as canine cardiac analysis and vascular exploration in small animal models.


// -----------------------------------------------------------



// In order to process the 2D slices into 3D, various software are available. Bellow is a grid containing the pieces of software considered in the context of this thesis for the analysis of the micro-ct slices, separated by license type. For the sake of our analysis, any software not available free of charge without pre-requisites is considered commercial:

// Based on Dragonfly3D's own list, in resources/software/dragonfly3Dsoftwarelist.jpg

// Commercial software
// Amira Or Avizo
// Analyze by AnalyzeDirect
// CTAn and CTVol by Bruker
// Image Pro by Media Cybernetics
// Imaris by Oxford Instruments Bitplane
// MeVisLab 
// Mimics by Materialise
// ScanIP by Simperware
// Octopus by inCT
// uCT
// VG Studio
// Zeiss Inspect
// Dragonfly3D

// Opensource or Freeware
// 3D Slicer
// Chimera
// Blender
// Dream3D
// Drishti
// ImageJ
// FIJI
// IMOD
// Meshab
// OsiriX
// ParaView
// Visit

// Other software includes:
// SPROUT 
// nnU-Net


// When comparing these pieces of software for potential use in this thesis, the following technical criteria were considered, from most to least important:
// - Ability to import 3D scan from individual 2D slices of JPEG/PNG/TIFF/BMP/DICOM format
// - Ability to segment blood vessels
// - Ability to export data to non proprietary formats: JPEG/PNG/TIFF/BMP/DICOM or other
// - Ability to add software plugins to extend capabilities
// - Availability of external software intended for blood vessel segmentation
// - Ability to manually segment areas of the 3D scan

// User friendliness was also considered:
// - Availability of instructions online in the form of dedicated support forums
// - Availability of youtube videos
// - Prior use of the software by people with a background in biology for other tasks
// - Ease of installation

// By default, three proprietary pieces of software were retained for the following comparison, due to their prior use in the research team carrying out the work: Dragonfly3D, CTAnn and Avizo. From the parameters laid out above, 3DSlicer, SPROUT and ImageJ/Fiji were retained for deeper comparison.

// Compare them, 3DSlicer comes out above due to having VMTK and R-Vessel-X.


// ----------------------- Commented 26-02-26



// Greet:
// 1. Broad → it's a funnel
// 2. Broad: blood vessels in tissues, important to charact, many imaging, ours is CECT, problems eixist
//     1. How do people do seg, not robust, not bla bla
//     2. Other alternatives
//         1. 3DSlicer available, discuss how it is used
//             1. Every section focuses more and more, describe main problems, the more you go down, the more you have well defined research questions. Very brief mentions of research questions
// 3. After SOTA 2pp: problem statement, general goal, objectives
//     1. Based on the levels above, summarize points mentioned in SOTA
//         1. Important remaining research questions are etc etc etc, main goal is this, objectives are a b c

// Sébastien:
// 2. SOTA (bio oriented, explain the pipeline, explain variability), (10pp)
  
// There is a review article that was incomplete, lots of the literature focused on ex-vivo
// Focus on ex-vivo but get some algos from in-vivo. Data ex-vivo is much more complex.
// Missing connections helps on the medical field → it’s the reconnection aspect that matters. ex-vivo it’s both the segmentation and the reconnection.

// Talk about the fact that clinical CT grey value does a good job, micro ct ex-vivo is a lot more difficult that’s why we focus on ex-vivo. There is transferability from ex to in vivo but the other way isn’t necessarily the case.

// // Comparing shortcomings of CECT with 2D histo
// // Another reason for the absence of these very small vessels on CECT is that CA
// // binds to blood cells such as red blood cells, so if there is no blood, there will be
// // no staining. On the other hand, CD31 binds to a transmembrane glycoprotein
// // expressed by endothelial cells and platelets [68]. It is therefore possible that CD31
// // could detect very small blood vessels even in the absence of blood, whereas CA
// // cannot.

// // briefly SOTA 3D histology for drug screening, the need for 3D histo is clear for companies developping drugs, I focus on antiangionetic drugs on tumor -> refer to Lisa thesis (effect of pazopanib)

// #pagebreak()

// With the goal of reconstructing tumor vascularization for the analysis of the antiangionetic drug Pazopanib in the context of cancer treatment, we begin by exploring the use of histology for drug sreening, followed by imaging methods, more specifically contrast-enhanced Micro CT, and finish with an exploration of the methods of structure extraction from images.


// == Histology for drug screening 

// In order to bring new drugs to market, a set of steps must be followed that are established by organisations such as the European Medical Association in the European Union, or the Food and Drug Administration in the U.S [1.1]. One of the key steps is collecting data on the effectiveness of the drug, done through clinical trials. These trials, before taking place in humans, are done on animals in a controlled lab environment, where collected data is analyzed for the outcomes and side effects of the drug. In the analysis process for Pazopanib, tumors are sampled and analysed ex-vivo, the histology of these tumors is critical in identifying the impact of treatment when compared to a control. 

// The conclusions taken from each step in the clinical trial decide if the trial moves on, meaning that a more accurate prediction with tighter confidence intervals enables a better discriminative power and reduces the amount of effective drugs discarded due to uncertainty from process limitations. 


// === Histology in industry

// Histology is in use in industry for clinical trials amongst other tasks, and the field is growing [2.1]. Histology is used due to its large amounts of qualitative data and high discriminative power, and is interpreted by experts during the process of drug research. It is used in clinical trials of structure altering drugs, or where the effect of interest is expected to be visible, and is generally done by specialized histopathologists [2.1]. Clinical trials vary widely in their design, as well as have a large variety of possible targets, in oncology specifically, 2D histology remains the most widely used technique [2.3], [2.27, 2.60] for the histology of human biopsies. For the analysis of Pazopanib, 2D histology is the reference method used to evaluate tumors. 


// ==== 2D histology

// The field of histology is born from 2D histology of tissue under microscope magnification. 2D microscope slice histology, known as "classical histology", takes the form of tissue sample collection, often embedding of the tissue, followed by staining with various agents, applied to increase contrast or highlight certain structures, and ending in investigation using optical or electron microscopy [3.1]. This technique is used due to its delivery of a large amount of relevant quanlitative data imediately interpretable by experts, and high discriminative power, although it is time consuming and is costly as a result [3.2]. As a technique it has evolved in multiple directions, from the utilization of advanced staining agents [3.2] allowing the staining of a broad range of classes (DNA, proteins, lipids, or carbohydrates), to different lighting wavelenghts, ranging from ultraviolet [3.3] to infrared [3.4]. 

// #linebreak()
// 2D histology is limited by its requirement to slice the target tissue before analysis, resulting in destructive modification of the sample. This slicing has the potential of deforming the tissue, with various techniques developed to conteract this [3.5] such as embedding in a wide variety of mediums. Slicing is also not orientation agnostic, and a large number of slices might be required for a sufficient spatial analysis of the sample, especially in situations where the observation target does not follow a particular axis, as with vascularization.

// #linebreak()
// The limitations of pure 2D histology are now resulting in quantitative histology moving in the direction of 3D analysis, especially when 3D structure of the tissue is relevant. 

// #linebreak()
// Unmentioned above: 
// - samples dry out in classical histo, 
// - the resolution is limited when stacking
// - there are methods for extracting some 3D info from the 2D slices ex:"confocal microscopy light sheet microscopy or optical coherence tomography" https://doi.org/10.1038/s41467-022-34048-4


// ==== 3D histology

// 3D histology is an evolution of 2D histology, increasing the amount of information available for analysis, and as a result improving discriminative power when compared to 2D classical histology. In its most basic form as an evolution of classical 2D histology, it involves taking multiple 2D slices and aligning then stacking them to create a virtual third axis [4.1]. 3D histology is relevant for tumor analysis [4.2], allowing for structural understanding of a tissue, such as in [4.2] enabling "the spread and infiltration of invasive carcinoma to be understood". This form of histology is often still done in the same methods as with 2D, where a human carries out interpretation, requiring common standards and communication, such as in [4.3]

// #linebreak()
// Other well known methods for 3D histology that do not require slicing and thus avoid sample damage and destruction are magnetic resonance imaging (MRI) and computed tomography (CT), each having a higher resolution variant, micro-MRI and microCT respectively. These techniques enable virtual slicing, allowing observation across any plane, and have resolutions of tens microns for micro-MRI down to sub-micrometer scale for MicroCT.
// MRI is interesting for tissue observation due to its high contrast on soft tissue, as opposed to CT that performs best on calcified tissue. Both methods however are able to make use of contrast-enhancing staining agents (CESAs) [4.4,4.5] resulting in the ability for microCT to be readily used for imaging soft tissue, and is termed contrast-enhanced microCT (CECT) and reviewed for ex-vivo data acquisition in [4.6]. CECT is of particular interest for ex-vivo 3D histology due to the wide variety of staining agents available, and has proven its use in canine heart analysis [4.7] and for vasculature exploration of small animals [4.8].

// _Not certain about if or how to place the quote, as it is specifically for cancer._


// ===== CECT Imaging

// Full section on the state of the art of CECT - TODO


// == Structure reconstruction (or: Vascularization reconstruction, Interpretation methods of 3D imaging?)

// This section is leaning towards segmentation, as in survey [5.1]

// #linebreak()

// With the goal of reconstructing vascularization in imaged tissue, we aim to take in data from an imaging modality, process it through a software pipeline, and obtain at output a data structure with higher information density than the input. This process of reducing the amount of raw data, but increasing the utility or information content of the data, is explored widely in the field of computer science. It underlies concepts such model fitting to noisy data [5.2] or as more commonly carried out in a biological context and industry, image segmentation, where the goal is to separate regions of a 2D image into multiple segments and objects [5.3].


// === Segmentation

// Image segmentation plays a central role in medical image analysis by enabling quantitative analysis of different kinds: by classifying pixels with semantic labels (semantic segmentation), partitioning of objects (instance segmentation) or a combination of both across the entire image space (panoptic segmentation) [5.1]. The task can be as simple and as old as separating objects from a background, a problem that has been explored in computer science for multiple decades [5.4], or more complex as in panoptic segmentation, only being posed in 2018 [5.5].


// ==== Methods of Segmentation

// Segmentation methods have evolved over time: from classical computer vision to machine learning and later deep learning methods 

// TODO: Extend history to highlight the progression in complexity and the higher and higher levels of information extraction achieved

// #figure(
//   image("../../resources/images/timeline_from_PanopticSegmentationAReview.png", width: 100%),
//   caption: [
//     From (6.1) Timeline evolution of image segmentation (better version to be found or created)
//   ],
// )


// ==== Imaging and Segmentation of vasculature


// Vasculature reconstruction and segmentation of 3D images often requires human segmentation [6.2]. Alternative automated methods are less precice 



// Sources to be investigated and read:

// + 2013 Application of Micro-Computed Tomography With Iodine Staining to Cardiac Imaging, Segmentation, and Computational Model Development
// + 2010 Micro computed tomography for vascular exploration 
// + 2025 Micro-computed tomography to visualize preserved vascular architecture in decellularized human vaginal tissue: explorative study
// + 2004 Micro-computed tomography of the vasculature in parenchymal organs and lung alveoli

// Non tomo:
// + 2021 Robust segmentation of vascular network using deeply cascaded AReN-UNet
// + 2023 Vessel Delineation Using U-Net: A Sparse Labeled Deep Learning Approach for Semantic Segmentation of Histological Images
// + 2015 Quantification of Microvascular Tortuosity during Tumor Evolution Using Acoustic Angiography

// Vasc references:
// + 1976 The Vascularization of Tumors 
// + 2013 Springer Nature, "Vascularization"
// + 1982 Vascularization of Tumors: A Review


// #pagebreak()

// Sources, will be re-done once finalized:

// 1.1 https://www.ema.europa.eu/en/human-regulatory-overview/research-development


// 2.1 https://doi.org/10.1111/his.14099
// #linebreak()
// 2.2 Not great, behind paywall "Challenges Faced by Cross-sectional Imaging and Histological Endpoints in Clinical Trials" https://doi.org/10.1093/ecco-jcc/jjw161
// #linebreak()
// 2.3 not the best source "The dream and reality of histology agnostic cancer clinical trials" https://doi.org/10.1016/j.molonc.2014.06.002
// #linebreak()
// 2.27 Wlodarski 27: https://pubmed.ncbi.nlm.nih.gov/32445458/
// #linebreak()
// 2.60 Wlodarski 60: https://pubmed.ncbi.nlm.nih.gov/37008634/


// 3.0 Section partially inspired from https://doi.org/10.1155/2019/8617406
// #linebreak()
// 3.1 Source from [0], Mescher, L. A. Junqueira's basic histology. Text and atlas 14th ed. (McGraw-Hill, 2016).
// #linebreak()
// 3.2 https://www.ncbi.nlm.nih.gov/books/NBK557663/
// #linebreak()
// 3.3 https://pmc.ncbi.nlm.nih.gov/articles/PMC6223324/
// #linebreak()
// 3.4 https://pmc.ncbi.nlm.nih.gov/articles/PMC10408309/
// #linebreak()
// 3.5 Source from [3.0]: https://doi.org/10.1155/2019/8617406


// 4.1 https://doi.org/10.1016/j.ajpath.2012.01.033
// #linebreak()
// 4.2 https://doi.org/10.1136/jcp.2004.024794
// #linebreak()
// 4.3 Veterenary based? Not strongest article: Tseng LJ, Matsuyama A, MacDonald-Dickinson V. Histology: The gold standard for diagnosis? Can Vet J. 2023 Apr;64(4):389-391. PMID: 37008634; PMCID: PMC10031787
// #linebreak()
// 4.4 Single Ho 3+-doped upconversion nanoparticles for high-performance T2-weighted brain tumor diagnosis and MR/UCL/CT multimodal imaging: https://doi.org/10.1002/adfm.201401609
// #linebreak()
// 4.5 Three-dimensional non-destructive soft-tissue visualization with X-ray staining micro-tomography: https://doi.org/10.1038/srep14088
// #linebreak()
// 4.6 Review Greet: Contrast-Enhanced MicroCT for Virtual 3D Anatomical Pathology of Biological Tissues: A Literature Review https://doi.org/10.1155/2019/8617406
// #linebreak()
// 4.7 Application of Micro-Computed Tomography With Iodine Staining to Cardiac Imaging, Segmentation, and Computational Model Development https://doi.org/10.1109/tmi.2012.2209183
// #linebreak()
// 4.8  Micro computed tomography for vascular exploration  https://doi.org/10.1186/2040-2384-2-7


// 5.1 IEEE Image Segmentation Using Deep Learning: A Survey https://doi.org/10.1109/TPAMI.2021.3059968
// #linebreak()
// 5.2 RANSAC https://doi.org/10.1145/358669.358692
// #linebreak()
// 5.3 FIRST EDITION! Computer Vision: Algorithms and Applications. Berlin, Germany
// #linebreak()
// 5.4 OTSU https://doi.org/10.1109/TSMC.1979.4310076
// #linebreak()
// 5.5 Panoptic https://doi.org/10.48550/arXiv.1801.00868
// #linebreak()
// 5.6 U-Net https://doi.org/10.48550/arXiv.1505.04597


// 6.1 Panoptic Segmentation: A Review https://doi.org/10.48550/arXiv.2111.10250
// 6.2 micro-CT visualize preserved vascular architecture in decellularized human vaginal tissue: explorative study https://doi.org/10.1038/s41598-025-14452-8
// #linebreak()


// #pagebreak()



// ----------------------- Commented 26-02-26



// === Connected papers

// #figure(
//   image("../../resources/images/Cryogenic contrast-enhanced microCT enables nondestructive 3D quantitative histopathology of soft biological tissues.png", width: 90%),
//   caption: [
//     Connected papers of Cryogenic contrast-enhanced microCT enables nondestructive 3D quantitative histopathology of soft biological tissues
//   ],
// )


// #hide[

// == Imaging

// #image("/assets/image.png", width:250pt)

// Visualize imaging across  axes: frequency, resolution and dimensionality. TBD how to make this visually interesting and easy to read.
// Also across imaging mediums?

// #v(12pt)

// Goal here - separate the imaging modalities by what they interact with:
// - Low frequency mechanical imaging (10^5 - 10^8 Hz): pressure waves, accoustic properties of organs to be imaged
// - Molecular and electronic scale interactions (10^6 - 10^15 Hz): electromagnetic waves probing bulk dielectric properties, molecular bonds, or electronic states of the tissues and organs imaged (also: surface profile)
// - High-frequency electromagnetic (10^16 - 10^21 Hz): X-rays interact with atomic electrons and gamma rays can interact with nuclei, probing material elemental composition

// #v(12pt)

// Potentially: how 3D images are made from 2D images
// *TODO*: Clarify terminology reconstruction vs segmentation vs skeletonization/nodes

// #v(24pt)

// === Medical imaging

// State how imaging is used in medicine
// - classical 2D histo and how it started the field of imaging
// - shortly mention 1D methods
// - discuss 3D methods
// - in depth on CT

// Of these, each type has notable advantages and disadvantages. If we focus on MicroCT, the imaging medium used in this document, we note the main disadvantage of the high radiation dose during imaging, requiring this method to be done ex-vivo. MicroCT also suffers from very variable contrast, and the term covers a wide breadth of different techniques and machine settings, due to the wide range of X-rays possible, methods for generating them and methods for reconstructing images.

// #v(24pt)

// === Imaging uses

// Of all the imaging techniques used in medicine, it is rare for the imaging technique alone to be sufficient in diagnosing a problem. Imaging methods can result in images ranging from Echocardiograms, requiring specialized training to interpret, to classical X-rays, such as those that initiated the world of (in body or through body imaging? name for this?) by Röntghen with the famous radiogram of (his?) hand.

// The images from imaging techniques require interpretation in part because they contain limited semantic information: the difference between different structures in the image, and the link to real body parts, is generally heavily context dependent, relying on interpretation skills built up over years of education by experts such as those in radiology.

// #v(24pt)


// ==== Focus on MicroCT and CECT

// Explore existing methods more than in the intro
// Touch on methods for segmentation, vasculature extraction, the CE process


// === Pre-processing/filtering/area of interest

// === classical techniques (thresholding)
// limitations

// === Machine learning techniques

// === Tools used in the real world (Avizo, Dragonfly)



// #v(24pt)

// == Existing approaches to semantic extraction

// === traditional image processing (thresholding, filtering, morphological ops).

// - Show it working for CECT
// - Show it failing for some examples, motivate need for going deeper

// === model-based and graph-based reconstruction

// - Discuss what it is
// - Discuss its downsides (tuning, expert knowledge, fragile to context changes)

// === machine learning / deep learning methods.

// - Discuss its use for semantic extraction
// - Discuss its downsides
// -- need for lots of data
// -- poor generalization
// -- poor re-usability by other researchers
// -- poor failure characterization: can fail in unexpected ways, or silently
// -- poor wider scientific community understanding of how to validate and pipeline ML


// == Portable machine learning / Opensource / Freely available software

// Discuss limitations of current softwares wrt portability

// === Opensource
// SOTA of Opensource methods

// === Closed source / Paid
// SOTA of closed source methods


// == Vascularization reconstruction

// Vascularization in different body parts and tissues -> explain it varies and if anyone has done a review

// ]