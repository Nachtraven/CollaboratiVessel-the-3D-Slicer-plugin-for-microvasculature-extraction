// Notes moved to "1-abstract-backup-29-04.typ"


// As tissue imaging techniques have evolved from 2D to 3D and progressively increased in resolution, with current datasets weighing over 100GB, associated tooling for analysis has evolved in lockstep with specific usecases in mind. Due to the diversity 

// The process of data analysis, its associated tools and methods, has become central to the scientific process.

// Advanced imaging methods such as contrast-enhanced micro tomography aim to separate tissue by use of contrast enhacing agents, but noise in imaging and the multiscale, dispersed nature of vascularization result in the need for more powerful software methods to enable the comparison of samples across various treatment profiles, and achieve the levels of accuracy required for drug research. In this document the clinical pipeline is examined from end to end, a more powerful extraction method for vascular structures in challenging use cases is developed, and the groundwork laid for principled, scientifically rigorous work to be carried out.


Tissue biopsy imaging has evolved from 2D microscopy to 3D modalities of ever-increasing resolution, with current contrast-enhanced microCT (CECT) datasets comprising tens of gigabytes and spanning thousands of voxels. The computational tools needed to extract coherent 3D structures from these volumes has lagged behind: existing solutions are either proprietary, only implement simple methods that do not generalize, or rely on deep learning expertise and associated data that is unavailable publicly and difficult to produce. This thesis focuses on CECT datasets of tumor vasculature on which previous standard image segmentation showed limited accuracy, with the main challenges being that vessels can span only a few voxels across, be disconnected, data can contain regions of high signal non vessel structures and contrast staining can be non-uniform.

#linebreak()
Therefore, in this thesis an open-source 3D Slicer plugin called CollaboratiVessel is proposed for microvasculature extraction from CECT data, constructed based on CECT datasets from murine tumors collected for the study of the antiangiogenic drug Pazopanib. Rather than requiring annotated data or computer science expertise, the end user is placed in the algorithmic loop by providing sparse input to an extraction pipeline that combines multi-scale vesselness filtering with ridge following and reconnection, ingesting and emitting standard formats compatible with downstream analysis software. CollaboratiVessel is evaluated on CECT datasets with manually annotated ground truths, and is shown to recover vascular structure with improved connectedness than currently used intensity-based thresholding methods, supporting future research on vascular changes and enabling work on structures with more challenging vasculature than was previously possible.

// founded on multi-scale vesselness filtering, intensity likelyhood, ridge following and endpoint reconnection. The implementation


//All code, the source of this document, and working notes are released under permissive open licenses to support reuse and further development.

 //making it principled, adaptable to new datasets without retraining, and usable by researchers without a computer science background. 



#linebreak()
// problem -> gap (generally) -> contribution (mine) -> result *TODO: missing significance (the impact)*