#import "../../template.typ": flex-caption

== Pose Estimation

Pose estimation is a computer vision task that identifies meaningful keypoints within an image. In human pose estimation, these keypoints typically correspond to joint centers. In practice, pose estimation produces 2D keypoint locations in pixel coordinates for each camera and frame of a recording. 

#figure(
  image( "pose_estimation_examples.png", width: 100%),
  caption: flex-caption([Examples of landmarks estimated on a human body from three different pose estimation algorithms. *Left*: MediaPipe; *Middle*: RTMPose; *Right*: ViTPose.],
  [Examples of landmarks estimated on a human body from three different pose estimation algorithms])
)

Pose estimation is a core component of modern markerless motion capture, but its
integration introduces two key challenges.

First is accuracy. Errors in 2D keypoint localization propagate directly into 3D kinematic estimates, and accuracy differs between pose estimation algorithms  @needhamAccuracySeveralPose2021 @ceriolaComparativeAnalysisMarkerless2024 @washabaughComparingAccuracyOpensource2022. Many general-purpose algorithms are not optimized for movement science applications, as their underlying datasets may lack biomechanical relevance or sufficient representation of specific populations @seethapathiMovementScienceNeeds2019 @needhamAccuracySeveralPose2021. A later chapter in this work, for example, examines the failings of current pose estimation software when tracking a lower-limb prosthesis user. However, continued development in computer vision has led to a growing number of task-specific and population-specific datasets @yeungAthletePose3DBenchmarkDataset2025 @yingLDPoseInclusiveHumana @RefiningOpenPoseNew. Training pose estimation algorithms on these datasets and implementing them into markerless motion capture could be critical for addressing task and population-specific research needs.

This leads to the second challenge: integration. Even when suitable pose estimation models exist, integrating them into motion capture pipelines remains challenging. Many systems are tightly coupled to a single backend. Theia3D, for instance, utilizes a proprietary pose estimation algorithm that cannot be replaced. Thus, researchers looking to implement a specific pose estimation model must often implement their own pipelines from the ground up. 

=== SkellyTracker

`SkellyTracker`, the pose estimation manager for FreeMoCap, is a framework that decouples pose estimation from the rest of the processing pipeline. The software defines a standardized interface for pose estimation models, allowing new trackers to be integrated by implementing this interface. As a result, different pose estimation algorithms can be used interchangeably within the same pipeline without requiring changes to downstream processing steps. Similar to how our synchronization approach enables scalability in hardware, this architecture gives researchers more control over their processing pipeline. 

The default FreeMoCap pipeline utilizes MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, a free, open-source framework based on the CNN BlazePose @bazarevskyBlazePoseOndeviceRealtime2020. We selected MediaPipe on the basis of practicality and accessibility. MediaPipe is simple to install and interface with using Python scripts. It is also computationally lightweight, and can be run on a CPU-only computer. Thus, of many available options, MediaPipe makes our software the most accessible for the widest range of users. 

* Research Significance: Benchmarking *

As the software interface allows pose estimation backends to be swapped without any change to the rest of the pipeline, we can directly compare how different algorithms perform under identical conditions (i.e., using the same cameras, calibration, reconstruction and post-processing). These comparisons can aid in detailed benchmarking of pose estimation algorithms in markerless motion capture, a noted need by the research community @needhamAccuracySeveralPose2021. The following chapters take advantage of this by evaluating three additional trackers alongside MediaPipe: ViTPose, RTMPose, and in one chapter a custom-trained DeepLabCut model. These comparisons both serve as an evaluation of pose estimation performance and a demonstration of the practical benefits of a modular, pose estimation architecture. 

