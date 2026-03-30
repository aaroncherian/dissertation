== 3D Reconstruction

The final key step in the markerless motion capture pipeline is triangulating 2D keypoint detections into 3D coordinates (@fig-reconstruction-example). The underlying math of triangulation is explored in the following chapter. For each frame, the camera projection matrices estimated during calibration and the 2D keypoint detections from each camera view are used to solve for the 3D position of each keypoint via direct linear transformation (DLT), using a modified implementation of the Anipose toolkit @AniposeToolkitRobust2021.

#figure(
  image("reconstructed_human.png", width:50%),
  caption: [An example frame of data reconstructed from six cameras using a MediaPipe pose estimation backend. ]
) <fig-reconstruction-example>

Because pose estimators can produce erroneous detections in individual camera views due to occlusion, background clutter, or unusual body configurations, a progressive outlier rejection procedure is applied during triangulation. 

For each keypoint on each frame, the system first triangulates using all available cameras and computes the mean reprojection error across those views. If this error falls below a defined threshold, the solution is accepted. If it exceeds the threshold, the system tests all N-1 camera subsets, retriangulating with each combination that drops a single camera, and identifies the subset producing the lowest mean reprojection error. If the ratio of the original error to the best subset error exceeds an improvement threshold, the refined solution replaces the default. For cases where the improvement ratio falls between 1.0 and the threshold, a weighted blend is used to transition smoothly between the two solutions.

=== SkellyForge
`SkellyForge` is a separate post-processing package that operates on the reconstructed 3D trajectories. It applies gap interpolation for frames where no acceptable triangulation solution was found, followed by low-pass Butterworth filtering to attenuate high-frequency noise in the coordinate time series. Like `SkellyTracker`, `SkellyForge` is designed as a modular component of the pipeline, with an architecture that can accommodate additional post-processing methods as they are developed.


*Research Significance*

Triangulation accuracy is directly affected by the number of available cameras. Additional viewpoints improve the spatial geometry of the system during triangulation, leading to more robust and accurate 3D estimates. This is where the accessibility of FreeMoCap's hardware approach has a secondary benefit beyond cost savings alone. 

Because `SkellyCam` uses low-cost webcams, scaling the number of cameras is inexpensive. The six-camera system used for all data collection in this work had an approximate total camera hardware cost of \$120. In comparison, a six-camera setup using OpenCap would require six iOS devices, costing roughly \$1000- \$1500 even with the cheapest available iPhones - and systems like Theia3D require substantially more expensive hardware still. 

The same design decision that improves accessibility also enables practical scaling of camera count, which in turn improves triangulation robustness and accuracy. In this context, accessibility and data quality are not competing objectives, but are directly aligned.
