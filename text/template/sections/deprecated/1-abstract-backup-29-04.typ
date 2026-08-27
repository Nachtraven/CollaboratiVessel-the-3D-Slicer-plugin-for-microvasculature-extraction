// Old abstract
// The accurate reconstruction of tissue vascularization in ex-vivo biopsies is essential to quantitative analysis of samples, to enable their comparison across various treatment profiles, and achieve the level of accuracy required for drug research. We aim to enable the analysis of antiangionetic drugs for cancer treatment, specifically focused on pazopanib, by improving quantification of vascularization. Classical histology methods such as 2D histology suffer from a lack of accuracy due to the slicing process, and when used for vascularization reconstruction, loose the ability to reconstruct its structucal nature. 3D techniques such as contrast enhanced Micro CT enables the acquisition of high resolution 3D images of ex-vivo samples aided by a contrast agent, but does not enable direct quantitative information extration due to discontinuities, noise, low contrast and small features. In this document, a method for the structural reconstruction of vascularization from microct images is presented, enabling analysis of the impact of antiangionetic drugs on the vascularization of tumors in mice.

TODO

Driven by the link between tissue structure and function, medical imaging has evolved from its humble beginnings of 2D microscopy towards higher and higher resolution 3D imaging. Contrast-enhanced micro-tomography, one of these high resoluton methods, was used with the purpose of separating the micro-vasculature of tumors, 

The process of data analysis, its associated tools and methods, has become central to the scientific process.


Advanced imaging methods such as contrast-enhanced micro tomography aim to separate tissue by use of contrast enhacing agents, but noise in imaging and the multiscale, dispersed nature of vascularization result in the need for more powerful software methods to enable the comparison of samples across various treatment profiles, and achieve the levels of accuracy required for drug research. In this document the clinical pipeline is examined from end to end, a more powerful extraction method for vascular structures in challenging use cases is developed, and the groundwork laid for principled, scientifically rigorous work to be carried out.

// Abstract from review article:
// A key method for analyzing 3D data is Segmentation, used to separate structures of interest from the background and measure their parameters, but this techniques generally lays outside of the expertise of the entity wishing to analyze the data. As is shown, even entirely human driven extraction of information by means of manual segmentation presents large inter expert variance that is generally ill characterized in publicly available datasets. As a result, it is desirable to use computer assistance in the form of Segmentation: methods are plentiful, ranging from manual, semi automated to fully automated algorithm driven methods, with these recently extending gaining popularity in the form of deep learning. Here, the reader is guided through the diversity of methods for different use cases, and presented with a comparative evaluation discussing pitfalls and advantages for each. The basic evaluation techniques used to measure performance of these algorithms is also discussed: incorrect measurement of the performance of an algorithm hinders the downstream analysis of the extracted data. By discussing segmentation methods the reader is informed as to which technique may be more relevant for their priorities and knowledge of evaluation methods enables prioritization of the right kind of performance for integration of segmentation into downstream tasks.




// Following Greet 21-04-2026:












// === Notes:
// - Vascularization is unique due to being multiscale (ie the same structure when zoomed in/out)
// - Metastatis is unique due to being a form of disease that is angiogenic 
// - Metastatis is unique due to being multiscale (somewhat - it does have differentiation)
// - Vascularization is common amongst many lifeforms (here research what ties this together?)
// - Vascularization is key to evolution/multicellular life (here - proper understanding: develop independently multiple times)
// - Vascularization is different in its requirements for understanding and evaluation due to being a supporting system. You must be able to have a structural understanding (think: tortuosity)

// - Analysis of vasc. is challenging due to being multiscale
// - Analysis of vasc. is challenging due to imaging technologies
// - Analysis of vasc. is challenging due to requirement for structural reconstruction, which is a higher order of extraction of information than classification

// - Reconstruction is challenging due to imaging specificities (discontinuities - paper here on CE agent use)
// - Reconstruction is challenging due to spatial relations (paper on the types of vessels and their shapes)

// === Short pitch:

// I am working on reconstructing the vascularization network using microct, a method of ct or xray scanning that is of particularly high resolution. The raw images are generally not directly usable as the vascularization is discontinuous, and the way it appears in images varies is based on the size of the vasculature: for example more contrast agent can be present in larger vessels, and smaller vessels may not get much or any agent, but contrast in this case being due to the red blood cells. I use tumors as a target for analysis, with the goal of achieving cross organ (cross structure?) reconstruction and quantification. 


// == First try:

// Soft tissue analysis presents multiple challenges relating to the required techniques to obtain structural information. One such technique is MicroCT, an Ex-vivo method of 3D reconstruction. However, this process, as with all imaging processes, does not produce semantic information in and of itself. The step of semantic extraction generally makes use of expert knowledge, computer algorithms, or more recently machine and deep learning. In this document, we aim to develop an adaptable and re-usable method for the semantic extraction of blood vessels from MicroCT scans, characterized by one practical application: that of extracting vascularization of tumors, in order to compare tumors treated with a vasculature modifying treatment with control tumors.

// === Second try:

// The analysis and quantification of Vascularization in tissues is a challenging task due to diversity and its multiscale nature: the vascular system is present in every organ of the human body, and varies from micrometers to millimeters or even centimeters in size. An imaging technique capable of this level of dynamic range is Micro-CT imaging, sometimes used with contrast agents to aid in differentiation and contrast. In this document, we explore the process of extracting higher level structures from MicroCT images of tumors, in order to enable efficacy analysis of antiangionetic treatments.


// === Third(rough) try:

// Vascularization is everywhere in humans, but also in a lot of non human -> more widely, its a feature of large multicellular life.
// Analysis of Vascularization is challenging due to it being multiscale, and it is underdeveloped due to being a supporting system.
// Most imaging techniques have the limitation that they don't extract structure, which is essential to analyzing vasculature's function, *due to the Vascularization system being a system that exists to support structure.*  
// One promising imaging method is (micro) CT, due to its ability to reconstruct in 3D without physical deformation, however this technique, like all techniques, does not allow direct extraction of structure.
// Here we propose a technique that takes into account the multiscale nature of vascularization to extract structure and enable analysis of vasculature changes as a component of treatment of tumors.

// ]