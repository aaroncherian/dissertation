== Calibration 
When using multiple cameras to reconstruct 3D data, it is important to calibrate them, that is, align them all into a shared 3D space. Various methods of calibration exist. Our calibration tool is a ChArUco board, which is a board with aruco markers on it. This can be printed on a piece of paper and mounted on a board, or printed directly onto a rigid board. To calibrate, the user takes a recording where they wave the board around in front of the cameras. 

The board allows each camera to estimate where it relative to another camera in 3D space (@fig-cal_meth). where multiple cameras have light-of-sight to the board create pairwise connections that eventually create connections between all cameras in the network, linking them into one shared. This method of pairwise linkage allows even diametrically opposed cameras that may not be able to share a single view of the board together to be included in the camera calibration process. 

#figure(
  image("calibration_method.png", width: 50%,),
  caption: [An overview of the calibration process across multiple cameras],
) <fig-cal_meth>

Camera calibration outputs the camera intrinsics (how the camera sees the world) and camera extrinsics (where the camera is in the world), which is critical to reconstructing 3D data later in the pipeline. 

