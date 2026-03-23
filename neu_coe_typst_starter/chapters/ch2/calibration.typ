== Calibration 
For us to reconstruct 3D data from the 2D frames produced by cameras, it is key for our cameras to know where they are in a 3D space. This step of creating a 3D space in which the cameras are positioned and oriented is known as calibration. 

Our method of calibration is called a ChArUco board, which is a black and white chess board with ArUco markers on it. This board can be printed onto a standard piece of paper and mounted onto a firm surface, or printed directly onto a rigid board itself. 

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

* Practical calibration in FreeMoCap *

For those of us that glazed over the math of calibration, the following section looks at the practicalities. FreeMoCap utilizes a modified implementation of Anipose toolkit for calibration and reconstruction @AniposeToolkitRobust2021. The ChArUco board allows each camera to estimate where it relative to another camera in 3D space (@fig-cal_meth). where multiple cameras have light-of-sight to the board create pairwise connections that eventually create connections between all cameras in the network, linking them into one shared. This method of pairwise linkage allows even diametrically opposed cameras that may not be able to share a single view of the board together to be included in the camera calibration process. 

#figure(
  image("calibration_method.png", width: 50%,),
  caption: [An overview of the calibration process across multiple cameras],
) <fig-cal_meth>


