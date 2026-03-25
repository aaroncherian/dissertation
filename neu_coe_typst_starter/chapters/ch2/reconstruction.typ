== 3D Reconstruction

The final key step in the markerless motion capture pipeline is triangulating 2D keypoint detections into 3D coordinates. For each frame, the camera projection matrices (containing intrinsics and extrinsics) estimated during calibration and the 2D keypoint detection from each camera view are used to solve for 3D position via direct linear transformation. 

Because pose estimators can produce erroneous detections in individual views (due to occlusions, background clutter, odd movements etc.), we implement a progressive outlier rejection procedure during triangulation. For each joint center on each frame, the system first triangulates a 3D data point using all available cameras, and then computes mean reprojection error across those cameras. Should this error fall below a threshold, the solution is accepted.

If the error exceeds the threshold, the system tests all camera combinations, retriangulating with each subset, computing resulting mean reprojection error. The lowest reprojection error and its associated camera combination is compared against the original solution - if the error improvement ratio exceeds a defined threshold, the refined solution replaces the default. 

Post-processing of the reconstructed 3D trajectories is handled by the FreeMoCap package SkellyForge, which applies gap interpolation and low-pass Butterworth filtering to reduce high-frequency noise in the final coordinate time series.


