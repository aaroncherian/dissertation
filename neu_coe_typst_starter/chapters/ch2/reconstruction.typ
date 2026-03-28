== 3D Reconstruction

The final key step in the markerless motion capture pipeline is triangulating 2D keypoint detections into 3D coordinates (@fig-reconstruction-example). For each frame, the camera projection matrices estimated during calibration and the 2D keypoint detections from each camera view are used to solve for the 3D position of each keypoint via direct linear transformation (DLT). FreeMoCap's triangulation implementation is built on the Anipose library @AniposeToolkitRobust2021.

#figure(
  image("reconstructed_human.png", width:50%),
  caption: [An example frame of data reconstructed from six camera using a MediaPipe pose estimation backend. ]
) <fig-reconstruction-example>

Because pose estimators can produce erroneous detections in individual camera views due to occlusion, background clutter, or unusual body configurations, a progressive outlier rejection procedure is applied during triangulation. Incidentally, this procedure was contributed by an open-source community member and is exemplifies the benefits of community contributions. 

For each keypoint on each frame, the system first triangulates using all available cameras and computes the mean reprojection error across those views. If this error falls below a defined threshold, the solution is accepted. If it exceeds the threshold, the system tests all N-1 camera subsets, retriangulating with each combination that drops a single camera, and identifies the subset producing the lowest mean reprojection error. If the ratio of the original error to the best subset error exceeds an improvement threshold, the refined solution replaces the default. For cases where the improvement ratio falls between 1.0 and the threshold, a weighted blend of the default and refined solutions is used, with an exponential weighting function that transitions smoothly between the two to avoid frame-to-frame oscillation in the reconstructed trajectories.

`SkellyForge` is a separate post-processing package that operates on the reconstructed 3D trajectories. It currently applies gap interpolation for frames where no acceptable triangulation solution was found, followed by low-pass Butterworth filtering to attenuate high-frequency noise in the coordinate time series. Like `SkellyTracker`, `SkellyForge` is designed as a modular component of the pipeline, with an architecture that can accommodate additional post-processing methods as they are developed.

