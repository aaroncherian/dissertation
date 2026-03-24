== 3D Reconstruction

The final key step in markerless motion capture is triangulating 3D data. Here, the camera matrices (see @eq:camera_matrix) estimated in camera calibration and the 2D keypoints estimated by the pose estimation software are used to reconstruct data into 3d. 

#figure(
  image("3d_reconstruction.svg", width: 120%,),
  caption: [],
) <fig-reconstruction>

For a given set of 2D keypoints from temporally aligned set of camera images, the known intrinsic and extrinsic parameters are used to define a ray originateing from the camera optical center. The ray for a detected point is given by:

$
  P(lambda) = C_i + lambda d_i
$

where $C_i$ is the camera center in world coordinates (obtained from the extrinsics), $d_i$ is the unit direction vector of the ray in world coordinates (obtained from the intrinsics), $lambda$ scalar depth parameter, and $P(lambda)$ represents a point along the ray in world space. 

However, a single ray is not enough to determine the depth $lambda$ of the point. Therefore, observations from multiple cameras (@fig-reconstruction) are required. Given corresponding rays from multiple camera views, the 3D point is estimated as the point that best satisfies all ray constraints, typically by minimizing some error metric across views. In FreeMoCap, triangulation is performed using the Direct Linear Transform (DLT) method, which reformulates the multi-view geometry as a linear system and solves for the 3D point using singular value decomposition (SVD).

Post-processing of reconstructed data is handled in our package `SkellyForge`, which applies interpolation and Butterworth filtering of data. 




