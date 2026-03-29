#import "../../template.typ": flex-caption

== Calibration 
In order to reconstruct 3D data from the 2D camera images, it is necessary to determine how each camera observes the world and where each camera is positioned within it. The former describes what we call intrinsic parameters, which is how each camera maps light onto its image sensor. The latter describes extrinsic parameters, which is the position and orientation of each camera relative to a common world reference frame.  

Camera calibration is the process of calculating the intrisic and extrinsic parameters of a set of cameras, establishing the geometric relationships required to project 2D image features into a shared 3D coordinate system.


* The calibration process *

For calibration and 3D reconstruction, FreeMoCap utilizes a modified implementation of the Anipose toolkit @AniposeToolkitRobust2021. Calibration is performed using a ChArUco board, a hybrid calibration target consisting of a checkerboard pattern overlaid with uniquely identifiable ArUco markers (@fig-board). This board can be printed on standard paper and mounted to a rigid surface, or printed directly onto a rigid board.

#figure(
  image("calibration_board.png", width: 75%),
  caption: flex-caption(
    [A ChArUco board being  detected during a frame of calibration. Each marker on the board (known as an ArUco marker) has a unique ID that can be detected, and subsequently each corner between a pair of markers also has associated IDs. The detected corner IDs are annotated in blue on the image.],
    [A ChArUco board with detections])
) <fig-board>


To calibrate, the user moves the ChArUco board throughout the capture volume while ensuring that it is visible to multiple cameras simultaneously. Varying the board's position and orientation, particularly introducing changes in depth and tilt, improves the robustness of intrinsic and extrinsic parameter estimation.

The ChArUco board provides a shared reference that allows all cameras to be estimated within a common coordinate system (@fig-cal_meth). When a camera shares a view of the board with another camera, this creates a pairwise connection between the two. These pairwise connections eventually link all cameras into one shared network, allowing cameras that are diametrically situated to be linked together during the calibration process. 

#figure(
  image("calibration_method.png", width: 50%,),
  caption: [An overview of the calibration process across multiple cameras],
) <fig-cal_meth>

At the start of the recording, the ChArUco board may be placed flat on the ground within the shared field of view of all cameras, in what we term ground plane calibration. In this configuration, the plane of the board defines the reference coordinate system for reconstruction (@fig-groundplane). As a result, reconstructed 3D data are expressed in a coordinate frame where the ground plane corresponds to $Z=0$ and the orientation of the axes is aligned with the board. This initialization ensures that reconstructed kinematic data are immediately situated within a physically meaningful coordinate system, reducing the need for post hoc alignment or rotation.

#figure(
  image("groundplane.svg", width: 80%,),
  caption: [The ChArUco board can be used to set the reference coordinate system of the world. Left: The axes for the 5x3 board configuration; Right: The axes for the 7x5 board configuration. The $X$ and $Y$axes are defined by the origin marker $0$ and the furthest markers along the edge of the board. The $Z$ axis is defined to as the normal vector pointing up from the board.],
) <fig-groundplane>



