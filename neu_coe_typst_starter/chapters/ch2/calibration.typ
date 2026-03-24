== Calibration 
In order to reconstruct 3D data from the 2D camera images, it is necessary to determine how each camera observes the world and where each camera is positioned within it. This process, known as camera calibration, establishes the geometric relationships required to project 2D image features into a shared 3D coordinate system. 

Camera calibration estimates two key components: intrinsic parameters, which describe how each camera maps light onto its image sensor, and extrinsic parameters, which describe the position and orientation of each camera relative to a common world reference frame.

For calibration and 3D reconstruction, FreeMoCap utilizes a modified implementation of the Anipose toolkit @AniposeToolkitRobust2021. Calibration is performed using a ChArUco board, a hybrid calibration target consisting of a checkerboard pattern overlaid with uniquely identifiable ArUco markers. This board can be printed on standard paper and mounted to a rigid surface, or produced directly as a rigid board.

The calibration procedure is designed to be accessible to non-expert users. During calibration, the user moves the ChArUco board throughout the capture volume while ensuring that it is visible to multiple cameras simultaneously. Varying the board's position and orientation, particularly introducing changes in depth and tilt, improves the robustness of intrinsic and extrinsic parameter estimation.

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


=== The math behind calibration
Often, the process of calibration is defined using the pinhole camera model, which describes the projection of a point in 3D space onto the 2D image plane of an idealized pinhole camera @MultiviewVideoAcquisition2018. Within in this model are two main parameters necessarily for successful camera calibration, intrinsics and extrinsics, which we can estimate using the calibration algorithm proposed by Zhang @zhangFlexibleNewTechnique2000.

* Camera Intrinsics * 

Camera intrinsics broadly put, is a description of how a given camera "sees" the world. More technically, intrinsics describe the internal properties of a camera. Core intrinsic properties include focal length, the principal point, and skew @heikkilaFourstepCameraCalibration1997. 

The intrinsics camera matrix $K$ is typically defined as:

$ K = mat(
  f_x, s,   c_x;
  0,   f_y, c_y;
  0,   0,   1
) $ <eq:intrinsics>

where $(f_x, f_y)$ are the focal length in pixels, $[c_x, c_y]$ is principal point where the optical axis of the camera intersects with the image plane, and $s$ is the skew, which accounts for any non-rectangular pixels. 

Because the ideal pinhole camera does not have a lens, camera calibration processes will often also correct for camera lens distortion. Camera intrinsics help move data from the camera space into the image space in pixel coordinates.

* Camera Extrinsics *

If camera intrinsics can be described as how a camera "sees" the world, extrinsics can be described as where exactly that camera is in the world, relative to the worlds origin. Camera extrinsic parameters define the pose (position and orientation) of a given camera relative to the calibration board. Extrinsic parameters consist of a rotation $R$ and a translation $t$ and are often commonly expressed as a combined matrix of $[R t]$. This is also equivalent to the transformation: 

$ X_c = R X_w + t $ <eq:extrinsics>

where $X_c$ is the 3D coordinates of a point in the camera coordinate system and $X_w$ represents the coordinates of the same point in the world coordinate system. 

* The camera matrix: combining intrinsics and extrinsics *

Together, @eq:intrinsics and @eq:extrinsics can create the camera matrix $P$:

$ P = K [R t] $ <eq:camera_matrix>

where $K$ is the intrinsics matrix and $[R t]$ the extrinsics matrix. @eq:camera_matrix can be used to map 3D world coordinates into 2D image coordinates using:

$ x = P X $ <eq:mapping>
where $x$ is the 2D image point in pixels, and $X$ is the homogenized coordinates of the 3D world point. 

While this math may sound daunting, it may be simpler to think of this process like so: transforming an 3D point into an image is a series of operations. First, we take the 3D point that exists in the world reference frame and transform it into the reference frame of the camera using camera extrinsics. Then, we project the that point onto a 2D image plane using intrinsics. 

* Calibration: Calculating intrinsics and extrinsics *

For us to be able to successfully use @eq:mapping, we now have two unknowns to solve for, $K$ and $[R t]$. This is possible if something is providing us with $X$, a known 3d point, and $x$, its known pixel coordinates. This is where calibration comes in. 

On the ChArUco board, each corner has a known position relative to every other corner. If each black square, say, is 30mm in length and width, if we set our world origin to be the first marker in the board (0,0,0), then we know that the second marker in that row is (30,0,0), the next as (60,0,0) and so on. Thus, we have known 3D point locations. Each marker has an ID associated with it that is detectable using computer vision. In each image, we find where each corner appears in pixel coordinates $(u,v)$. Thus, we have two unknowns, and every detected corner gives us an equation with which to solve for them. This leads to an overconstrained system which then looks to optimize for the most robust camera parameters. For each 'guess' taken for $K$ and $[R t]$, the system will take the 3D points and reproject them _back_ onto the image - the distance between where the corner was actually detected, and where predicted corner lands is known as reprojection error. Optimization then looks to adjust and refine our parameters until total reprojection error is minimized. 

Now, we have an estimate of $K$ for a given camera, which does not change. We also have the matrix $[R t]$, which represents the pose of a given camera with the respect to the board. Once we have multiple cameras that have been calibrated with respect to the board, we can then begin to find their positions with respect for each other. As our camera positions in the real world are fixed, we can then start to actually estimate position in the real world.



