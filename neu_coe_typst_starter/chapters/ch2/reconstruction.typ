== 3D Reconstruction

The final key step in markerless motion capture is triangulating 3D data. Here, the camera matrices estimated in camera calibration and the 2D keypoints estimated by the pose estimation software are used to reconstruct data into 3d. 

#figure(
  image("3d_reconstruction.svg", width: 120%,),
  caption: [],
) <fig-reconstruction>



Post-processing of reconstructed data is handled in our package `SkellyForge`, which applies interpolation and Butterworth filtering of data. 




