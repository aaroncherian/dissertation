== Introduction

With how neatly computer vision  can be packaged these days, it can be extremely easy to go through the entire process of markerless motion capture without having to touch the underlying math of what is happening. This chapter, for those who choose to read it, details some of the mathematics of how camera images can become 3D data. 

== The Image and Reference Frames

Before diving into the equations it's important to frame what the problem that's being solved here. 

The problem of markerless motion capture is this: on a given frame, we have these features on a 2D *image* taken by a *camera* that we want to project into the *real world*.  

Each of these bolded terms represents a different _reference frame_, and understanding what that means is important. A reference frame is an origin and a set of axes that describes where something is - and each of these terms has a different way of doing so. The image knows where something is in pixel locations. The camera knows the direction of something relative to its lens. And the world is the shared 3D space that all of those cameras and that something being tracked exist in. 

To make this concrete: the *image* says 'Object A is a pixel on row 845, column 401'. The *camera* says 'Object A is 2 feet in front of me a bit to the right'. 

#figure(image("frames.png", width: 85%),
caption: [Illustration of the image and camera reference frames. The image frame coordinates are 2D pixel coordinates. The camera reference frame always has the camera at the origin, with the Z-axis pointing along the camera's optical axis (the center of an optical system).])

== The World Reference Frame

The role of the *world* frame becomes a more intuitive when we remember that in a multi-camera system, there's a second camera also seeing Object A. So, Camera 1 says "Object A is 2 feet in front of me a bit to the right", and Camera 2 says "Actually, Object A is actually 4 feet in front of _me_ and a bit to the left." Each camera can only describe where Object A is relative to itself - and so we introduce a shared reference frame: the world frame. We define a new reference frame with a shared origin and axes, "Heads up, Camera 1, in this new coordinate system you're at point [1,1,1] and Camera 2, you're at [2,2,1]." This frame is the *world* frame. 

#figure(
  image("world_frame.png", width: 100%),
  caption: [Construction of the world frame. Left: The object of interest is described by two separate camera reference frames with no way to communicate. Right: The creation of a common world reference frame to describe the position of the camera and the object. ]
)

But the positioning of the camera in the frame is only half the problem. When Camera 1 says "2 feet in front of me and bit to the right", those directions (_in front of_ and _to the right_) are defined by Camera 1's orientation (i.e., the way it sees the world). "Forward" in Camera 1's language might mean "left" in Camera 2's language. So we not only need to know _where_ each camera is, we also need to know _which way it's facing_ so we can convert each camera's local description ("in front of me, to the right") into the shared language of the world frame. ("2 units in the positive X direction, 3 units in positive Y direction of the world").

We call the positioning of the camera relative to the origin a _translation_, and the conversion of its 'language' a _rotation_. 

== Moving from pixels to the real world

So now we have three reference frames - the image, the camera, and the world - and to reconstruct a point, we need to move a pixel from the image to a point in the camera frame, build a shared world reference frame, and move the point from the camera into the world reference frame.

To do that, we first need to understand the reverse - how does a 3D point in the world become a 2D pixel in an image? This is described by something called the _pinhole camera model_ @MultiviewVideoAcquisition2018. While it seem counterintuitive to learn this from the opposite direction of what we want, the logic is straightforward - we need to learn the forward process so we can invert it. 

The forward process describes two transformations we need to estimate:

*Extrinsics: world to camera*

Extrinsics, put simply, is the description of where exactly the camera is in the world and how it is orientated. If that sounds familiar, it' s because just a little ways up we walked exactly through that and called it the camera's _translation_ and _rotation_. Formally, the extrinsic parameters define the pose (position and orientation) of a given camera. The extrinsic parameters consist of a rotation matrix $R$ and a 
translation vector $t$:

$ X_c = R X_w + t $ <eq:extrinsics>

where $X_w$ is the 3D position of a point in the world frame ("2 units in the positive X direction, 3 units in positive Y direction of the world) and $X_c$ is the position of that same point expressed in the camera's local frame ("in front of me, to the right"). $R$ encodes 
the camera's orientation - it rotates the world's axes into the camera's axes (the "language" conversion we discussed earlier). $t$ encodes the camera's position - the offset between the world origin and the camera origin.

* Camera Intrinsics * 

Camera intrinsics broadly put, is a description of how a given camera "sees" the world and these parameters describe how a point in the camera's local 3D space gets projected onto the 2D image plane.  More technically, intrinsics describe the internal properties of a camera. Core intrinsic properties include focal length, the principal point, and skew @heikkilaFourstepCameraCalibration1997. 

The intrinsics camera matrix $K$ is defined as:

$ K = mat(
  f_x, s,   c_x;
  0,   f_y, c_y;
  0,   0,   1
) $ <eq:intrinsics>

where $(f_x, f_y)$ are the focal length in pixels, $[c_x, c_y]$ is principal point where the optical axis of the camera intersects with the image plane, and $s$ is the skew coefficient, which accounts for any non-rectangular pixels. 

* The camera matrix: combining intrinsics and extrinsics *

Together, @eq:intrinsics and @eq:extrinsics can create the camera matrix $P$:

$ P = K [R | t] $ <eq:camera_matrix>

where $K$ is the intrinsics matrix and $[R t]$ the extrinsics matrix. @eq:camera_matrix maps a 3D world point directly to a 2D pixel location:

$ x = P X $ <eq:mapping>
where $x$ is the 2D image point in pixels, and $X$ is the 3D world point in homogeneous coordinates. This is the full forward model: world frame, through the camera frame, onto the image.

Because the ideal pinhole camera does not have a lens, camera calibration processes will often also correct for camera lens distortion. Camera intrinsics help move data from the camera space into the image space in pixel coordinates.

== Calibration

Now we get to the markerless motion capture of it all.  With the pinhole model, we showed that when a 3D point becomes a pixel on an image, the camera extrinsics first convert it into a 3D point in the camera's local reference frame, and then the camera intrinsics project it onto the image plane.

But in markerless motion capture we want to go in the other direction.
We have pixel coordinates on an image and we want to turn them into 3D positions in the world. To do that, we need to run the forward model in reverse - which means we need to know the parameters that define it. That is: the intrinsic and extrinsic parameters for each camera.

The step in markerless motion capture we call *calibration* is the process of estimation those two parameters. The previous chapter detailed the calibration process (waving a ChArUco board around) from a functional standpoint - now we look at the mathematics underlying the process. 

The forward model (@eq:mapping) tells us:

$ x = P X$,
where $x$ is a pixel location, $X$ is a 3D world point, and $P$ contains the intrinsic and extrinsic parameters we are trying to find. Which means if we had an object whose 3D positions we already knew, and we could detect where those same points appear in each camera's image, we would have known values on both sides of the equations, and then we could solve for the camera parameters.

This is the role of the ChArUco board. 

#figure(image("../ch2/calibration_board.png", width:50%),
caption: [This figure is a copy of one from the previous chapter. A ChArUco board being  detected during a frame of calibration. Each marker on the board (known as an ArUco marker) has a unique ID that can be detected, and subsequently each corner between a pair of markers also has associated IDs. The detected corner IDs are annotated in blue on the image.]) <fig-charuco-math>

On the ChArUco board (@fig-charuco-math), each corner has a known position relative to every other corner. So, if each square is say 30 mm in length, and we decide that the world origin is the first corner of the board at $(0,0,0)$, and then the next corner of that row is $(30,0,0)$ and the next at $(60,0,0)$ and so in. These are our known 3D world points $X$. Each corner also has a unique ID that is detectable using computier vision, allowing us to find where each corner appears in the image as pixel coordinates $(u,v)$. These are our detected 2D points $x$. 

#figure(
  image("calibration_math.png", width:95%),
  caption: [The calibration process using a ChArUco board. The world origin is defined as the first corner of the board, and using the known square size the 3D world coordinates of the other coordinates can be found. Computer vision can detect the pixel locations of the corners in the image. Thus, the solution for $x = P X$ can be optimized for to find $P$, the camera matrix containing intrinsic and extrinsic parameters. ]
)

So, every detected corner gives us an equation between a known $X$ and observed $x$, where the only unknowns are the camera parameters. With enough corners detected across enough images, the system becomes overconstrained and we can optimize for the set of intrinsic and extrinsic parameters (optimization is, non-technically, the process of finding the best answers through a series of guesses that ideally, slowly become more accurate over time). For each guess taken for a set of parameters, the system projects the known 3D points back onto the image using the forward model — the distance between where a corner was actually detected and where the model predicts it should appear is the reprojection error. Optimization adjusts the parameters until total reprojection error is minimized.

This yields an intrinsic matrix K for each camera, which remains constant as long as the camera's optics do not change. It also yields extrinsic parameters [R|t] representing each camera's pose relative to the board. 

Each camera's extrinsic parameters describe its position and orientation relative to the calibration board. Since we defined the world origin at the 
board, this means each camera's extrinsics directly place it in the world frame. Critically, the cameras are fixed in the real world — they do not move between calibration and recording. So if Camera 1 is at [R₁|t₁] and Camera 2 is at [R₂|t₂], both relative to the same board, then their positions relative to each other are permanently known. They share a common reference point, and their spatial relationship is locked in.

#figure(
  image("board_connection.png", width: 90%),
  caption: [Deriving camera-to-camera relationships from shared calibration. Each camera's extrinsic parameters (C₁|board and C₂|board) describe its pose relative to the calibration board, which defines the world origin. Because both cameras are calibrated against the same board, their positions relative to each other (C₁|₂) can be computed. ]
)

Once multiple cameras have been calibrated with respect to the same board, their positions relative to each other are also known — and we have the shared world frame we need for reconstruction.

== Reconstruction

We now have everything we need. Each camera's intrinsic and extrinsic parameters are known, and a pose estimation model has detected a landmark in each camera's image as a 2D pixel coordinate. The question is: how do we turn those pixels into a 3D point in the world?

For a given camera, the intrinsics and extrinsics define a ray — a line that originates at the camera's center in world space and passes through the detected pixel, extending outward into the scene. This ray can be expressed as:

$
  P(lambda) = C_i + lambda d_i
$

where $C_i$ is the camera center in world coordinates (obtained from the extrinsics), $d_i$ is the unit direction vector of the ray in world coordinates (obtained from the intrinsics), $lambda$ a scalar depth parameter, and $P(lambda)$ represents a point along the ray in world space. Every point along that ray would project onto the same pixel — so from a single camera's perspective, the landmark could be anywhere along that line. One camera gives us direction, but not depth.

#figure(
  image("reconstruction.png", width: 130%),
  caption: [3D reconstruction via triangulation. Each camera detects points P₁ and P₂ in its image as 2D pixel coordinates. Using each camera's intrinsic and extrinsic parameters, these pixel detections define rays extending from each camera into the world. The 3D position of each point is estimated where the corresponding rays from multiple cameras converge.]
)

This is where the multi-camera setup becomes essential. If a second camera also detects the same landmark, we get a second ray from a different position and angle. In a perfect world, those two rays would intersect at exactly one point — the true 3D location of the landmark. In practice, noise in the detections means the rays will not perfectly intersect, so we estimate the 3D point as the location that minimizes its distance to all rays. In FreeMoCap, this triangulation is performed using the Direct Linear Transform (DLT) method, which reformulates the problem as a linear system and solves it using singular value decomposition (SVD).

