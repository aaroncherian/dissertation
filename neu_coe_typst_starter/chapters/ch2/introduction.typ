== Introduction

The motivation behind the FreeMoCap Project is, in a sense, quite simple: providing free motion capture for everyone. While this work will validate and characterize our system against existing standards in the literature, our goal is not to convince researchers and clinicians to abandon their marker-based setups or commercial markerless systems. Rather, FreeMoCap is intended as an answer for anyone — researcher, animator, or student — who does not currently have access to motion capture. A functional setup can be built from widely available consumer hardware, with a minimum cost as low as two USB webcams.

In this chapter, we present FreeMoCap as a flexible, open-source framework for video-based motion capture. Rather than centering on a single pose estimation method, the system is designed to support multiple tracking approaches within a unified pipeline. The chapter describes the core components of the framework — camera calibration, synchronized video acquisition, pose estimation, 3D reconstruction, and skeletal modeling — with an emphasis on how these components enable extensibility, reproducibility, and cross-method comparison.

Most current markerless motion capture pipelines share a few key steps in order to move from a set of 2D images to 3D reconstructed data: camera calibration, synchronized video acquisition, pose estimation of 2D keypoints, and reconstruction of 3D data. A typical recording with a multi-view markerless system first involves positioning and orienting the cameras. Camera positioning is often task- and subject-specific, depending on the environment and number of cameras. Next, the cameras are calibrated to estimate intrinsic and extrinsic parameters. The user then takes a series of recordings, which are processed by estimating 2D joint landmarks (keypoints) using pose estimation software per camera, and then reconstructing them into 3D space. The following sections describe each of these steps, their implementation in FreeMoCap, and key considerations.




