== Introduction

The motivation behind the Free Motion Capture (FreeMoCap) Project is, in a sense, quite simple: provide free motion capture for everyone. Despite advances in markerless motion capture, the ability to measure human movement remains constrained by cost, technical complexity, and environmental requirements, often limiting its use to well-resourced laboratories and specialized applications. As a result, many potential users—researchers, clinicians, educators, and creators—are left without practical access to these tools.

FreeMoCap is designed as a fully open-source markerless motion capture framework that prioritizes accessibility at every level of the pipeline. It is built to work with consumer-grade webcams, requires no physical markers or specialized recording environment, and provides a complete processing pipeline from synchronized video acquisition through 3D kinematic reconstruction. Its architecture is modular and tracker-agnostic, allowing users to swap between pose estimation backends depending on their needs. 

This chapter describes the core components of the FreeMoCap framework and the design decisions that shape them. In doing so, it examines how choices motivated by accessibility also carry direct implications for the quality and flexibility of the resulting motion capture data.

== Key Steps in Markerless Motion Capture

Markerless motion capture systems generally follow a common set of transformations to estimate 3D human movement from 2D image data. These steps include synchronized video acquisition, camera calibration, 2D pose estimation, and 3D reconstruction. 

A typical multi-view recording begins with positioning and orienting cameras around the subject. Camera placement is often task and environment-dependent, with considerations for visibility, occlusion, and coverage. The cameras are then calibrated to estimate intrinsic and extrinsic parameters, defining how 3D world coordinates project into each image. Following calibration, synchronized video of the subject is recorded across all views.

These videos are processed by estimating 2D joint landmarks (keypoints) independently in each camera view using pose estimation algorithms. Corresponding keypoints across views are then used to reconstruct 3D joint positions in world coordinates. The following sections describe each of these steps in detail, along with their implementation in FreeMoCap and key considerations in their design.




