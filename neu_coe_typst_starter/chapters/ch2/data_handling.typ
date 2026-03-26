== Handling Motion Capture Data

A key issue in building out a flexible framework to integrate, run and reconstruct data from multiple pose estimation trackers is that each pose estimation algorithm outputs its own unique set of keypoints. Without standardized representation, downstream biomechanical analyses would require different pipelines for each tracker, making it difficult to compare results or extend the system. 

This resulted in the development of `SkellyModels`, a skeletal representation framework that decouples tracker-specific data from downstream analyses. Each supported tracker is described by a structured configuration file (YAML) that specifies keypoint names, order and other relevant anatomical information (e.g., segment connections, anthropometric data to calculate center of mass, etc.) The multi-tracker comparisons presented in Chapters 3 and 4 (for MediaPipe, RTMPose and ViTPose) were conducted using a single shared analysis pipeline enabled by this architecture. Any new supported tracker requires then only authoring a new configuration file to be used. In practice, this facilitates the contribution of new pose estimation software to the intended framework as well, encouraging user contributions by easing the burdern of work needed to add something new. 

An additional benefit of this particular representation is the ability to integrate DeepLabCut, which presents an option for users to train their own custom models, even on non-human landmarks. Chapter 6 presents work uses a custom-trained DeepLabCut software in order to track prosthetic limbs. 


