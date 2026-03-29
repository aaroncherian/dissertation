== Math
Often, the process of calibration is defined using the pinhole camera model, which describes the projection of a point in 3D space onto the 2D image plane of an idealized pinhole camera @MultiviewVideoAcquisition2018. Within in this model are two main parameters necessarily for successful camera calibration, intrinsics and extrinsics, which we can estimate using the calibration algorithm proposed by Zhang @zhangFlexibleNewTechnique2000.



* Camera Extrinsics *

If camera intrinsics can be described as how a camera "sees" the world, extrinsics can be described as where exactly that camera is in the world, relative to the worlds origin. Camera extrinsic parameters define the pose (position and orientation) of a given camera relative to the calibration board. Extrinsic parameters consist of a rotation $R$ and a translation $t$ and are often commonly expressed as a combined matrix of $[R t]$. This is also equivalent to the transformation: 

// $ X_c = R X_w + t $ <eq:extrinsics>

where $X_c$ is the 3D coordinates of a point in the camera coordinate system and $X_w$ represents the coordinates of the same point in the world coordinate system. 

// * The camera matrix: combining intrinsics and extrinsics *

// Together, @eq:intrinsics and @eq:extrinsics can create the camera matrix $P$:

// $ P = K [R t] $ <eq:camera_matrix>

// where $K$ is the intrinsics matrix and $[R t]$ the extrinsics matrix. @eq:camera_matrix can be used to map 3D world coordinates into 2D image coordinates using:

// $ x = P X $ <eq:mapping>
// where $x$ is the 2D image point in pixels, and $X$ is the homogenized coordinates of the 3D world point. 

// While this math may sound daunting, it may be simpler to think of this process like so: transforming an 3D point into an image is a series of operations. First, we take the 3D point that exists in the world reference frame and transform it into the reference frame of the camera using camera extrinsics. Then, we project the that point onto a 2D image plane using intrinsics. 

* Calibration: Calculating intrinsics and extrinsics *

For us to be able to successfully use @eq:mapping, we now have two unknowns to solve for, $K$ and $[R t]$. This is possible if something is providing us with $X$, a known 3d point, and $x$, its known pixel coordinates. This is where calibration comes in. 

On the ChArUco board, each corner has a known position relative to every other corner. If each black square, say, is 30mm in length and width, if we set our world origin to be the first marker in the board (0,0,0), then we know that the second marker in that row is (30,0,0), the next as (60,0,0) and so on. Thus, we have known 3D point locations. Each marker has an ID associated with it that is detectable using computer vision. In each image, we find where each corner appears in pixel coordinates $(u,v)$. Thus, we have two unknowns, and every detected corner gives us an equation with which to solve for them. This leads to an overconstrained system which then looks to optimize for the most robust camera parameters. For each 'guess' taken for $K$ and $[R t]$, the system will take the 3D points and reproject them _back_ onto the image - the distance between where the corner was actually detected, and where predicted corner lands is known as reprojection error. Optimization then looks to adjust and refine our parameters until total reprojection error is minimized. 

Now, we have an estimate of $K$ for a given camera, which does not change. We also have the matrix $[R t]$, which represents the pose of a given camera with the respect to the board. Once we have multiple cameras that have been calibrated with respect to the board, we can then begin to find their positions with respect for each other. As our camera positions in the real world are fixed, we can then start to actually estimate position in the real world.


// *Reconstruction*

// For a given set of 2D keypoints from temporally aligned set of camera images, the known intrinsic and extrinsic parameters are used to define a ray originateing from the camera optical center. The ray for a detected point is given by:

// $
//   P(lambda) = C_i + lambda d_i
// $

// where $C_i$ is the camera center in world coordinates (obtained from the extrinsics), $d_i$ is the unit direction vector of the ray in world coordinates (obtained from the intrinsics), $lambda$ scalar depth parameter, and $P(lambda)$ represents a point along the ray in world space. 

// #figure(
//   image("3d_reconstruction.svg", width: 120%,),
//   caption: [],
// ) <fig-reconstruction>



// However, a single ray is not enough to determine the depth $lambda$ of the point. Therefore, observations from multiple cameras (@fig-reconstruction) are required. Given corresponding rays from multiple camera views, the 3D point is estimated as the point that best satisfies all ray constraints, typically by minimizing some error metric across views. In FreeMoCap, triangulation is performed using the Direct Linear Transform (DLT) method, which reformulates the multi-view geometry as a linear system and solves for the 3D point using singular value decomposition (SVD).