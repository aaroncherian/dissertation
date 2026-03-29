== Pose Estimation

Pose estimation is a computer vision task that identifies meaningful keypoints within an image. In human pose estimation, these keypoints typically correspond to joint centers. In practice, pose estimation produces 2D keypoint locations in pixel coordinates for each camera and frame of a recording. 

#figure(
  image( "pose_estimation_examples.png", width: 100%),
  caption: [Examples of landmarks estimated on a human body from three different pose estimation algorithms. *Left*: MediaPipe; *Middle*: RTMPose; *Right*: ViTPose.]
)

Pose estimation has become a critical part of the architecture of modern markerless motion capture software and introduces two key challenges in markerless motion capture systems. First, the choice of pose estimation algorithm can significantly impact accuracy. Accuracy differs between pose estimation software @needhamAccuracySeveralPose2021 @ceriolaComparativeAnalysisMarkerless2024 @washabaughComparingAccuracyOpensource2022, and errors in 2D keypoint localization propagate directly into 3D kinematic estimates. Many general-purpose models are not optimized for movement science applications, as their underlying datasets may lack biomechanical relevance or sufficient representation of specific populations @seethapathiMovementScienceNeeds2019 @needhamAccuracySeveralPose2021.  For example, a later chapter in this work examines the failings of current pose estimation when tracking a lower-limb prosthesis user. With the rapid development of computer vision the landscape has shifted, with datasets that are task and population specific being released @yeungAthletePose3DBenchmarkDataset2025 @yingLDPoseInclusiveHumana @RefiningOpenPoseNew.

This however, leads us to our second consideration - even when suitable pose estimation models exist, integrating them into motion capture pipelines remains a challenge. Many existing systems are tightly coupled to a single backend, requiring substantial effort to incorporate alternative models and limiting flexibility for researchers.

=== SkellyTracker: Modular Pose Estimation 

To address this limitation, we have developed our pose estimation package `SkellyTracker` as a framework that decouples pose estimation from the rest of the processing pipeline. The system defines a standardized interface for pose estimation models, allowing new trackers to be integrated by implementing this interface. As a result, different pose estimation algorithms can be used interchangeably within the same pipeline without requiring changes to downstream processing steps.

This design provides several advantages. Similar to how our synchronization approach enables scalability in hardware, this pose estimation framework allows users to select algorithms that best match their research needs. By leveraging the open-source nature of the project, this approach also enables community-driven contributions.  Researchers can integrate pose estimation models needed for their research and make them immediately accessible to others, promoting scientific transparency and reproducibility. More broadly, it facilitates the translation of advances in computer vision into practical tools for movement science.

The default FreeMoCap pipeline utilizes MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, a free-open source framework based on the CNN BlazePose @bazarevskyBlazePoseOndeviceRealtime2020. We selected MediaPipe based on practicaly and accessibility. MediaPipe is simple to install and interface with using Python scripts. It is also computationally lightweight, and can be run on a CPU-only computer. Thus, of many available options, MediaPipe makes our software the most accessible for the widest range of users. 

The following chapters in this work will present alongside MediaPipe, three different pose estimation trackers, ViTPose, RTMPose, and a custom-trained DeepLabCut model, as an evaluation of the benefits of a modular, pose estimation-agnostic framework for markerless motion capture.
