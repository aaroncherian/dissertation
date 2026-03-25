== Introduction

The motivation behind the Free Motion Capture (FreeMoCap) Project is, in a sense, quite simple: provide free motion capture for everyone. This chapter presents FreeMoCap as a flexible, open-source framework for video-based motion capture. The chapter describes the core components of the framework — camera calibration, synchronized video acquisition, pose estimation, 3D reconstruction, and skeletal modeling — with an emphasis on how these components enable extensibility, reproducibility, and cross-method comparison.

* The typical markerless motion capture pipeline *

Most current markerless motion capture pipelines share a few key steps in order to move from a set of 2D images to 3D reconstructed data: camera calibration, synchronized video acquisition, pose estimation of 2D keypoints, and reconstruction of 3D data. A typical recording with a multi-view markerless system first involves positioning and orienting the cameras. Camera positioning is often task- and subject-specific, depending on the environment and number of cameras. Next, the cameras are calibrated to estimate intrinsic and extrinsic parameters. The user then takes a series of recordings, which are processed by estimating 2D joint landmarks (keypoints) using pose estimation software per camera, and then reconstructing them into 3D space. The following sections describe each of these steps, their implementation in FreeMoCap, and key considerations.




