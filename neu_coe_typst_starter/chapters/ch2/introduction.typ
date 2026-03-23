== Motivation

The motivation of the FreeMoCap Project is in a sense, quite simple: providing free motion capture for everyone. A number of times I have been asked who I consider our 'competitors' in the field to be. I remember the answer I gave then, and the more time I have spent on this project the more confident I have grown in it. While this work will validate and characterize our system and often compare it to existing standards in literature, our goal is not to convince researchers and clinicians to abandon their marker-based setups or commercial markerless systems. For us, our software should be the answer for anyone, researcher to animator to high school student, who does not have access to motion capture to build a setup according to their available resources. The following chapter outlines and explains the pipeline of the FreeMoCap software while also highlighting our  work in making this an accessible, scaleable project. 

== Introduction

Most current markerless motion capture pipelines share a few key steps in order to move from a set of 2D images to 3D reconstructed data. 

+ Camera calibration
+ Synchronized video acquisition
+ Pose estimation of 2D keypoints
+ Reconstruction of 3D data

A typical data collection or recording with a multi-view markerless motion capture first involves positioning and orienting of the cameras. Optimal camera positioning is often task and subject-specific and dependent on the environment and the number of cameras. Next, the cameras are calibrated to estimate camera intrinsics and extrinsics. At this point, the user is able to take a series of recordings. The processing of these recordings involves 2D estimation of joint landmarks (often termed keypoints) using pose estimation software, per camera. Next, data is reconstructed into the 3D space, with various amounts of post-processing depending on the software and pipeline. 

The following sections provide an overview of each of these step, its implementation in the FreeMoCap pipelines, and key considerations.


