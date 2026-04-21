== Standardized data representation

A key issue in integrating, running and reconstructing data from multiple pose estimation trackers is that each algorithm comes with its own unique outputs and keypoints. Without a standardized representation, downstream biomechanical analyses would require different pipelines for each tracker, making it difficult to compare results or extend the system. 

This motivated the development of `SkellyModels`, a skeletal representation framework that decouples tracker-specific data from downstream analyses. Each supported tracker is described by a structured configuration file (YAML) that specifies keypoint names, ordering, and anatomical metadata. This metadata includes segment connections and anthropometric parameters used to calculate quantities such as center of mass. Because the biomechanical information is defined at the model level rather than hard-coded into analysis scripts, adding support for a new tracker requires only authoring a new configuration file, with no changes to the downstream pipeline.

The multi-tracker comparisons presented in Chapters 3 and 4 were conducted entirely through this architecture. MediaPipe, RTMPose, and ViTPose data were all processed through a single shared analysis pipeline with no tracker-specific modifications. This also lowers the barrier for contributing new pose estimation backends to the framework, as integrating a new tracker does not require rewriting analysis code.

This design also means that our pipeline does not assume a fixed or standard set of output key points from a pose estimation software, which enables integration with DeepLabCut @mathisDeepLabCutMarkerlessPose2018 - a framework that allows users to train custom models on arbitrary landmarks, including non-human or non-standard keypoints. Chapter 6 presents work using a custom-trained DeepLabCut model to track prosthetic limb landmarks, a case where general-purpose pose estimators are insufficient.

