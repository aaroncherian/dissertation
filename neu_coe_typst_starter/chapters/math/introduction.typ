#import "../../template.typ": flex-caption


== Introduction

With how neatly computer vision  is packaged these days, it is entirely possible to go through  the entire process of markerless motion capture without having to touch the underlying math. I myself found reasons to avoid diving into the underlying mechanics for about three to four years, until a particularly confounding bug in our calibration pipeline forced me to walk into the belly of the beast. There are a great many resources out there that walk through, in depth, the concepts I touch upon in these chapters (the pinhole camera model, computer vision and calibration, rotation matrices and reference frames), and this chapter is not meant to replace them. What those resources don't typically do is connect these ideas to each other in the context of markerless motion capture. Making those connections myself took several months of working across many sources, and synthesizing that understanding is the goal of this chapter. This chapter should be taken as an aside that is not directly relevant to the main work itself, but is written for the curious soul who may be curious about what is happening underneath the hood of markerless motion capture.  

*A note on language*

The language in this chapter occasionally dips into casual or informal syntax. This is intentional. There is no shortage of formally written treatments of these topics - what I found myself lacking was an explanation that traded precision of language for clarity of understanding. This chapter is written with understanding as the priority, where sometimes the clearest path to a concept runs through simple, familiar wording rather than proper terminology.

== Defining concepts: The problem

Before diving into any equations, it is important to frame the problem that we are trying to solve in markerless motion capture. Pose estimation tracking gives us the 2D pixel locations of (in human pose estimation) anatomical joint centers. In multi-view markerless motion capture, we want to take those 2D pixel locations from multiple cameras and turn it into 3D data. 

So, on a given frame, we have these features on a 2D *image* that was taken by a *camera*, and we want to project it into the *real world*.  

Each of these bolded terms represents a different _reference frame_, and it's helpful to have an intuition for what that means before moving forward. 

== Defining concepts: Reference frames

A reference frame is an origin and a set of axes that describes where something is. Each of our major 'locations' of interest (the *image*, the *camera*, and the *real world*) has a different way of describing what it sees.

* The camera and image reference frames *

We first begin with understanding how an image and camera understand "where" an object of interest is. The *image* knows where something is in pixel locations. The *camera* knows the direction of something relative to its lens. As mentioned, a reference frame is an origin and a set of axes, and there are standard definitions for how we can define image and camera reference frames (@fig-im_cam-frame).

 For the *image*, the origin $(0,0)$ is usually placed in the top left corner, with $+X$ going rightward and $+Y$ downward (these axes may sometimes be written as $u$ and $v$ for image coordinates instead of $X$ and $Y$.) For the *camera*, the origin $(0,0,0)$ is that camera itself. More specifically, it is usually the optical center of the camera lens. $+Z$ is defined as the axis going through the optical center of the camera (the line of sight of the camera), while $+X$ and $+Y$ again point rightward and downward respectively. These are parallels of the $X$ and $Y$ in the image frame - this time we now add depth into the mix with $Z. $


To make this concrete: the *image* says 'Object A is a pixel on row 845, column 401'. The *camera* says 'Object A is 2 feet in front of me a bit to the right'. 

#figure(image("frames.png", width: 85%),
caption: flex-caption([Illustration of the image and camera reference frames. The image frame coordinates are 2D pixel coordinates. The camera reference frame always has the camera at the origin, with the Z-axis pointing along the camera's optical axis (the center of an optical system).],
[Illustration of the image and camera reference frames.]
)) <fig-im_cam-frame>

*The world reference frame*

Now we're left with the *world* reference frame. This one can be a little more tricky to describe, because unlike the image and camera reference frames where the origins and axes have standard definitions, the *world* frame is a bit more arbitrary. In some sense, we can imagine a 3D space, and put an origin anywhere with any orientation and call that a *world* reference frame. Why then, would that be useful for us in markerless motion capture? 

The role of the *world* frame becomes more intuitive when we remember that in a multi-camera system, there is, at minimum, a second camera also seeing Object A. 

So, Camera 1 says "Object A is 2 feet in front of me a bit to the right", and Camera 2 says "Actually, Object A is actually 4 feet in front of _me_ and a bit to the left." 

Each camera can only describe where Object A is relative to itself, and so we need to introduce a common way for the cameras and objects to be defined: Enter the *world* reference frame.  We define a new reference frame with a shared origin and axes and say "Heads up, Camera 1, in this new coordinate system you're at point [1,1,1] and Camera 2, you're at [2,2,1]." This frame is the *world* frame. If you're wondering how we set the origin and orientation of the axes for this new reference frame for motion capture, we'll touch on that later. 

#figure(
  image("world_frame.png", width: 100%),
  caption: flex-caption([Construction of the world frame. Left: Without a world reference frame, the object of interest is described by two separate camera reference frames with no way to communicate. Right: With the creation of a world reference frame, the object and cameras are now described in a standard way relative to our new axes.],
  [Construction of the world reference frame])
)

But positioning the camera in this new *world* frame is only half the problem. There's also what I might call a 'language' conversion issue - how do we go from Object A being described separately by two *cameras* to being described in one standard way in the *world*?

When Camera 1 says it sees something "2 feet in front of me and a bit to the right", those directions (_in front of_ and _to the right_) are defined by Camera 1's orientation (i.e., the way it sees the world). However, the way Camera 1 sees the world (physically, the way the camera is pointed) won't match the way Camera 2 sees the world. So, "forward" in Camera 1's language might mean "left" in Camera 2's language. So we not only need to know _where_ each camera is, we also need to know _which way it's facing_ so we can convert each camera's local description ("in front of me, to the right") into the shared language of the world frame. ("2 units in the positive X direction, 3 units in positive Y direction of the world").

Mathematically, we call the positioning of the *camera* relative to the *world* origin a _translation_, and the conversion of its personal 'language' into the shared one a _rotation_. 

Something that still may not seem intuitive is, in this realm of 'translating' camera languages, how do Camera 1 and Camera 2 suddenly agree on where this 3D point is? And if an image only gives us 2D coordinates, how do we turn that into a 3D point? 

Hold onto that thought, we'll get there. 

#figure(
  image("summary.png"),
  caption: flex-caption(
    [Overview of moving from a pixel in an image to a triangulated 3D point. Pixel coordinates are brought into the camera reference frame. We construct a world reference frame and place the cameras within it, and then triangulate the points location in the world using multiple cameras.],
    [Overview of moving from a pixel in an image to a triangulated 3D point]
  )) <fig-summary>

So to summarize (@fig-summary), now we have three reference frames - the *image*, the *camera*, and the *world* - and to reconstruct a point, we need to move a pixel from the *image* to a point in the *camera* frame, build a shared *world* reference frame, and move the point from the camera into the *world* reference frame (again, if this last step seems like a black box, we'll get there).

To do that, we first need to understand the reverse - how does a 3D point in the world become a 2D pixel in an image? Or more simply, if you take a picture of a tree, how does that three dimensional tree become a two dimensional image on your phone screen? 


== The pinhole camera model: How an object becomes an image



This is described by something called the _pinhole camera model_. While it seems counterintuitive to look at turning an object into a series of pixels when what we really want is to turn a series of pixels into an object, the logic is straightforward - we need to learn the forward process so we can invert it. The forward process describes two transformations we need to estimate, and we call them extrinsics and intrinsics. 

*Camera extrinsics*

Extrinsics, put simply, are the description of where exactly the camera is in the world and how it is oriented. If that sounds familiar, it's because just a little ways up we walked exactly through that and called it the camera's _translation_ and _rotation_. Formally, the extrinsic parameters define the pose (position and orientation) of a given camera. The extrinsic parameters consist of a rotation matrix $R$ and a 
translation vector $t$:

$ X_c = R X_w + t $ <eq:extrinsics>

where $X_w$ is the 3D position of a point in the world frame ("2 units in the positive X direction, 3 units in positive Y direction of the world) and $X_c$ is the position of that same point expressed in the camera's local frame ("in front of me, to the right"). $R$ encodes 
the camera's orientation - it rotates the world's axes into the camera's axes (the "language" conversion we discussed earlier). $t$ encodes the camera's position relative to the world origin.

* Camera intrinsics * 

Camera intrinsics, broadly put, are a description of how a given camera "sees" the world and these parameters describe how a point in the camera's local 3D space gets projected onto the 2D image plane.  More technically, intrinsics describe the internal properties of a camera. Core intrinsic properties include focal length, the principal point, and skew @heikkilaFourstepCameraCalibration1997. 

The intrinsics camera matrix $K$ is defined as:

$ K = mat(
  f_x, s,   c_x;
  0,   f_y, c_y;
  0,   0,   1
) $ <eq:intrinsics>

where $(f_x, f_y)$ are the focal length in pixels, $[c_x, c_y]$ is the principal point where the optical axis of the camera intersects with the image plane, and $s$ is the skew coefficient, which accounts for any non-rectangular pixels. 

* The camera matrix: combining intrinsics and extrinsics *

Together, @eq:extrinsics and @eq:intrinsics can create the camera matrix $P$:

$ P = K [R | t] $ <eq:camera_matrix>

where $K$ is the intrinsics matrix and $[R t]$ the extrinsics matrix. @eq:mapping maps a 3D world point directly to a 2D pixel location:

$ x = P X $ <eq:mapping>
where $x$ is the 2D image point in pixels, and $X$ is the 3D world point in homogeneous coordinates. 

This is the full forward model: world frame, through the camera frame, onto the image.

== Calibration

Now we get to the markerless motion capture of it all.  With the pinhole model, we showed that for a 3D point to become a pixel on an image, the camera extrinsics first convert it into a 3D point in the camera's local reference frame, and then the camera intrinsics project it onto the image plane.

But in markerless motion capture we want to go in the _other direction_. We have pixel coordinates on an image and we want to turn them into 3D positions in the world. To do that, we need to run the forward model in reverse - which means we need to know the parameters that define it. That is: the intrinsic and extrinsic parameters for each camera.

The step in markerless motion capture we call *calibration* is the process of estimating those two parameters. The previous chapter detailed the calibration process (waving a ChArUco board around) from a functional standpoint - now we look at the mathematics underlying the process. 

The forward model (@eq:mapping) tells us $ x = P X$,
where $x$ is a pixel location ("Object A is a pixel on row 845, column 401"), $X$ is a 3D world point ("Object A is 2 units in the positive X direction, 3 units in positive Y direction of the world"), and $P$ contains the intrinsic and extrinsic parameters we are trying to find. So, if we had an object with a known 3D position, and we could detect that position in each image given to us by a camera, we would have known values on both sides of the equations, and then we could solve for the camera parameters.

This is the role of the ChArUco board. 

#figure(image("../ch2/calibration_board.png", width:50%),
caption: flex-caption([A ChArUco board being detected during a frame of calibration. Each marker on the board (known as an ArUco marker) has a unique ID that can be detected, and subsequently each corner between a pair of markers also has associated IDs. The detected corner IDs are annotated in blue on the image.],
[A ChArUco board being detected during a frame of calibration])) <fig-charuco-math>

Remember that the *world* reference frame needs an origin and axes placed somewhere - and that the choice is, in principle, arbitrary. The ChArUco board is where we make that choice. We place the world origin at a corner of the board, and align the axes with the board's edges.

On the ChArUco board (@fig-charuco-math), each corner has a known position relative to every other corner. So, if each square is say 30 mm in length, and we decide that the world origin is the first corner of the board at $(0,0,0)$, and then the next corner of that row is $(30,0,0)$ and the next at $(60,0,0)$ and so on. These are our known 3D world points $X$. Each corner also has a unique ID that is detectable using computer vision, allowing us to find where each corner appears in the image as pixel coordinates $(u,v)$. These are our detected 2D points $x$. 

#figure(
  image("calibration_math.png", width:95%),
  caption: flex-caption([Estimation of intrinsics and extrinsics from a calibration board. The world origin is defined as the first corner of the board, and using the known square size the 3D world coordinates of the other coordinates can be found. Computer vision can detect the pixel locations of the corners in the image. Thus, the solution for $x = P X$ can be optimized to find $P$, the camera matrix containing intrinsic and extrinsic parameters.],
  [Estimation of intrinsics and extrinsics from a calibration board])
)

So, every detected corner gives us an equation between a known world $X$ and detected pixel $x$, where the only unknowns are the camera parameters. With enough corners detected across enough images, the system becomes overconstrained (that is, we have far more equations than unknowns, which gives us redundant information to work with) and we can optimize for the set of intrinsic and extrinsic parameters (optimization is, non-technically, the process of finding the best answers through a series of guesses that ideally  become more accurate over time).

For each guess taken for a set of parameters, the system projects the known 3D points back onto the image using the forward model — the distance between where a corner was actually detected and where the model predicts it should appear is the reprojection error. Optimization adjusts the parameters until total reprojection error is minimized.

This yields an intrinsic matrix K for each camera, which remains constant as long as the camera's optics do not change. It also yields extrinsic parameters [R|t] representing each camera's pose relative to the board. In addition to K and [R|t], the calibration process may also estimate lens distortion coefficients. The pinhole model assumes an ideal camera with no lens, but real cameras introduce warping - calibration corrects for this as part of the same optimization.

Now, because the world origin is the calibration board, and each camera's extrinsics describe its pose relative to that board, we now have something we didn't have before: a common language between cameras. Camera 1 knows where it is relative to the board. Camera 2 also knows where it is relative to the board. And because it's the same board, Camera 1 and Camera 2 now know where they are relative to each other. 

To try and simplify this, it's a bit like two people who haven't met trying to figure out where the other is - but both know exactly how far they are from the same landmark. And from that, they can figure out how far apart they are (possibly with some error, but that happens in calibration as well!)

It is worth noting that during calibration, the board is being moved around the scene - so our reference point is, somewhat counterintuitively, a moving object. But the cameras are fixed. Each time the board appears in a new 
position, that is another snapshot of the same stationary cameras seeing a known object from a new angle. More snapshots means more evidence, and the optimization uses all of them to pin down each camera's true, fixed pose.

#figure(
  image("board_connection.png", width: 90%),
  caption: flex-caption([Deriving camera-to-camera relationships from shared calibration. Each camera's extrinsic parameters (C₁|board and C₂|board) describe its pose relative to the calibration board, which defines the world origin. Because both cameras are calibrated against the same board, their positions relative to each other (C₁|₂) can be computed.],
  [Deriving camera-to-camera relationships from shared calibration])
)

Mathematically, each camera's extrinsics are a transformation from the world frame to that camera's local frame. If we know the transformation from the world to Camera 1 and the transformation from the world to Camera 2, we can chain them together - go from Camera 1's frame back to the world, and then from the world into Camera 2's frame - to get the transformation between the 
two cameras directly.

Once multiple cameras have been calibrated with respect to the same board, their positions relative to each other are also known - and we have the shared world frame we need for reconstruction.

== Reconstruction

Earlier, I asked you to hold onto two questions: how do two cameras agree on where a 3D point is, and how do we get 3D data out of 2D images? We now have everything we need to answer both.

Each camera's intrinsic and extrinsic parameters are known, and a pose estimation model has detected a landmark in each camera's image as a 2D pixel coordinate. For a given camera, the intrinsics and extrinsics define 
a ray - a line that originates at the camera's center in world space and passes through the detected pixel, extending outward into the scene. This ray can be expressed as:

$
  P(lambda) = C_i + lambda d_i
$

where $C_i$ is the camera center in world coordinates (obtained from the extrinsics), $d_i$ is the direction vector of the ray (obtained from the pixel location and the intrinsics), and $lambda$ is a scalar depth 
parameter. Every point along that ray would project onto the same pixel - so a single camera can tell us the direction of an object, but not how far away it is. This is the fundamental limitation of a 2D image: in collapsing the world onto a flat plane, depth is lost.

So we're halfway there. We asked: how do we turn a 2D pixel into a 3D point? The answer so far is: one camera gets us a line in 3D space, which is more than a pixel but less than a point. To pin down the actual location 
(i.e., to recover that lost depth) we need a second camera.

This is where the multi-camera setup becomes essential. If a second camera also detects the same landmark, we get a second ray from a different position and angle. 


Remember the question from earlier - how do two cameras suddenly agree on where a 3D point is? This is the answer. They don't communicate. They each independently cast a ray into the world, and geometry does the rest. Where the rays meet is where the point must be - and because calibration placed both cameras in the same *world* reference frame, that intersection is a real position in 3D space. This is triangulation. And more cameras means more rays, which means more information constraining that intersection - this is one reason why adding cameras generally improves reconstruction accuracy.

#figure(
  image("reconstruction.png", width: 130%),
  caption: flex-caption([3D reconstruction via triangulation. Each camera detects points P₁ and P₂ in its image as 2D pixel coordinates. Using each camera's intrinsic and extrinsic parameters, these pixel detections define rays extending from each camera into the world. The 3D position of each point is estimated where the corresponding rays from multiple cameras converge.],
  [3D reconstruction via triangulation])
)

Now, in a perfect world, every ray would intersect at exactly one point. Unfortunately, it's not so simple. As you may have noticed, there's a lot of estimation that goes into this process. Intrinsics and extrinsics are estimates, so if either is slightly off, that's noise that shifts the ray. Pose estimation algorithms are also an estimate of where the landmark is - and those estimates of the ground truth location might be slightly different camera to camera (especially if it's harder to see that joint in a particular camera view), and that's noise that shifts the ray. 

All of this to say, there's a lot of steps in this process that can introduce error, and by the time each ray from a camera is cast, each one has been nudged slightly by calibration error and detection noise, which means that every camera may not neatly intersect at one clean point. That means once again, we need to estimate the best answer given imperfect information. There are many methods for how this estimation can proceed - the implementation of calibration and triangulation we use in FreeMoCap uses the Direct Linear Transform (DLT) method @AniposeToolkitRobust2021.  So instead of a clean intersection, we look for the single point in 3D space that comes closest to all rays simultaneously. The DLT method sets this up as a linear system and solves it using singular value decomposition (SVD).

It is worth stepping back to appreciate what is happening here. Everything we just described - casting rays, triangulating, estimating a 3D position - happens for every tracked landmark, on every frame, across every camera. A single frame of human pose estimation might track 30 or more joints, and a typical recording might run for thousands of frames. The full reconstruction is this entire pipeline running at scale: 2D detections in, 3D skeleton out.

== Conclusion

With the calibrated camera parameters and the triangulation process described above, we can take 2D pixel detections from multiple synchronized cameras and recover 3D positions in a shared world space. This is the core mathematical machinery underlying FreeMoCap's reconstruction pipeline - and ultimately, what makes it possible to turn a set of ordinary webcam videos into motion capture data.