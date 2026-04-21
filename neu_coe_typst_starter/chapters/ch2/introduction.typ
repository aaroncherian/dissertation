#import "../../template.typ": flex-caption

== Introduction

Despite advances in markerless motion capture, the ability to measure human movement remains constrained by cost, technical complexity, and environmental requirements, often limiting its use to well-resourced laboratories and specialized applications. As a result, many potential users (e.g., researchers, clinicians, educators, and creators) are left without practical access to these tools. The motivation behind the Free Motion Capture (FreeMoCap) Project is, in a sense, quite simple: provide free motion capture for everyone.

FreeMoCap @queenFreeMoCapFreeOpen2024 is a fully open-source markerless motion capture framework that prioritizes accessibility at every level of the pipeline. It is built to work with consumer-grade webcams, requires no physical markers or specialized recording environment, and provides a complete processing pipeline from synchronized video acquisition through 3D kinematic reconstruction. The architecture is modular and tracker-agnostic, allowing users to swap between pose estimation backends depending on their needs. 

It is perhaps easy to assume that accessibility must come at the cost of accuracy (and across the landscape we can see that trade-off is frequency observed). However, as this chapter will argue, design choices made in the service of accessibility can also directly improve the quality of the data a system produces. The following sections describe the core components of the FreeMoCap framework with that principle in mind.



== Key steps in markerless motion capture

Markerless motion capture systems generally follow a common set of transformations to estimate 3D human movement from 2D image data. These steps include synchronized video acquisition, camera calibration, 2D pose estimation, and 3D reconstruction. 

#figure(
  image("pipeline.png", width: 110%),
  caption: flex-caption(
    [Typical steps in markerless motion capture pipeline. *Synchronized recording* produces temporally aligned video frames. *Calibration* estimates the camera extrinsics and intrinsics. *Pose estimation* estimates the pixel coordinates of joint centers along the body per camera frame. *3D reconstruction* triangulates the 3D position of a joint using the calibration and pose estimation data. ],
    [Typical steps in markerless motion capture])
) <fig-pipeline>



A typical multi-view recording begins with positioning and orienting cameras around the subject. Camera placement is often task and environment-dependent, with considerations for visibility, occlusion, and coverage. The cameras are then calibrated to estimate intrinsic and extrinsic parameters, defining how 3D world coordinates project into each image. Following calibration, synchronized video of the subject is recorded across all views.

These videos are processed by estimating 2D joint features (often referred to as keypoints) independently in each camera view using pose estimation algorithms. Corresponding keypoints across views are then used to reconstruct 3D joint positions in world coordinates. The following sections describe each of these steps in detail, along with their implementation in FreeMoCap and key considerations in their design.




