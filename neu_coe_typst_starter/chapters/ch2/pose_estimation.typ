== Pose Estimation

Pose estimation is a computer vision task that identifies meaningful keypoints within an image. In human pose estimation, these keypoints typically correspond to joint centers. In practice, pose estimation produces 2D keypoint locations in pixel coordinates for each camera and each frame of a recording. 

#figure(
  image( "pose_estimation_examples.png", width: 120%),
  caption: [Examples of landmarks estimated on a human body from three different pose estimation algorithms. Left: MediaPipe; Middle: ViTPose; Right: RTMPose.]
)

* Use and limitations of pose estimation in markerless motion capture *

Pose estimation has become a critical part of the architecture of modern markerless motion capture software. OpenCap utilizes OpenPose or HRNet, for example, while Theia Markerless uses a proprietary custom trained algorithm. 

Despite its essential role in the process, general out-of-the-box pose estimation algorithms are often not well suited for movement science applications @seethapathiMovementScienceNeeds2019, @needhamAccuracySeveralPose2021. In the past few years, work has been done to address some of these issues by creating datasets and algorithms that are task and population specific @yeungAthletePose3DBenchmarkDataset2025 @yingLDPoseInclusiveHumana @RefiningOpenPoseNew. However, the challenge of integrating them and using them in a markerless motion capture software remains. Most existing motion capture systems are tightly coupled to a single pose estimation backend, forcing researchers who wish to use alternative models to build custom pipelines from scratch.


* SkellyTracker: design and motivations *

The default FreeMoCap pipeline utilizes MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, a free-open source framework based on the CNN BlazePose @bazarevskyBlazePoseOndeviceRealtime2020. We made this choice from a practicality and usability standpoint. MediaPipe is simple to install and interface with using Python scripts. It is also computationally lightweight, and can be run on a CPU-only computer. Thus, of many available options, MediaPipe makes our software the most accessible for the widest range of users. 

Other pose estimation algorithms however, may be more accurate and appropriate for research needs. Additionally, it was intended that FreeMoCap should not be coupled tightly to any one algorithm, but act as a framework that can integrate a library of pose estimation software as computer vision technology evolves. 

Our package for handling pose estimation, `SkellyTracker`, is a a modular sub-package that decouples pose estimation from the rest of the processing pipeline. We define a standardized interface for pose estimation models using a modular design pattern. New trackers can be integrated by implementing this interface, allowing them to be used interchangeably within the same pipeline without modifying downstream processing steps.

This has multiple benefits. Similar to how users can scale hardware to match their research needs, we also aim for users to be able to 'plug in' different pose estimation software according to their research needs (i.e., using a pose estimation algorithm trained on a specific dataset or population). Successful implementation of the plug-in model would the open-source nature of this framework to enable community-driven contributions. Researchers can integrate pose estimation models needed for their research and make them immediately accessible to others, promoting transparency and reproducibility. In the computer vision field, this approach could accelerate the translation of novel pose estimation methods from research settings into practical use. Finally, this model could facilitate comparison and benchmarking of different pose estimation algorithms. 

The following work will present alongside MediaPipe, three different pose estimation trackers, ViTPose, RTMPose, and a custom-trained DeepLabCut model, as an evaluation of the benefits of a modular, pose estimation-agnostic framework for markerless motion capture.
