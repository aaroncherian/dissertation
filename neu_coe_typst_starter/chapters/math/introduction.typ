== Introduction

With how neatly computer vision  can be packaged these days, it can be extremely easy to go through the entire process of markerless motion capture without having to touch the underlying math of what is happening. This chapter, for those who choose to read it, details some of the mathematics of how camera images can become 3D data. 

== The conceptual aspects 

Before diving into the equations it's important to frame what the problem that's being solved here. 

The problem of markerless motion capture is this: on a given frame, we have these features on a 2D *image* taken by a *camera* that we want to project into the *real world*.  

Each of these bolded terms represents a different _reference frame_, and understanding what that means is important. A reference frame is an origin and a set of axes that describes where something is - and each of these terms has a different way of doing so. The image knows where something is in pixel locations. The camera knows the direction of something relative to its lens. And the world is the shared 3D space that all of those cameras and that something being tracked exist in. 

To make this concrete: the *image* says 'Object A is a pixel on row 845, column 401'. The *camera* says 'Object A is 2 feet in front of me a bit to the right'. 

#figure(image("frames.png", width: 85%),
caption: [Illustration of the image and camera reference frames. The image frame coordinates are 2D pixel coordinates. The camera reference frame always has the camera at the origin, with the Z-axis pointing along the camera's optical axis (the center of an optical system).])

The role of the *world* frame becomes a more intuitive when we remember that in a multi-camera system, there's a second camera also seeing Object A. So, Camera 1 says "Object A is 2 feet in front of me a bit to the right", and Camera 2 says "Actually, Object A is actually 4 feet in front of _me_ and a bit to the left." Each camera can only describe where Object A is relative to itself - and so we introduce a shared reference frame: the world frame. We define a new reference frame with a shared origin and axes, "Heads up, Camera 1, in this new coordinate system you're at point [1,1,1] and Camera 2, you're at [2,2,1]." This frame is the *world* frame. 

#figure(
  image("world_frame.png", width: 100%),
  caption: [Construction of the world frame. Left: The object of interest is described by two separate camera reference frames with no way to communicate. Right: The creation of a common world reference frame to describe the position of the camera and the object. ]
)

But the positioning of the camera in the frame is only half the problem. When Camera 1 says "2 feet in front of me and bit to the right", those directions (_in front of_ and _to the right_) are defined by Camera 1's orientation (i.e., the way it sees the world). "Forward" in Camera 1's language might mean "left" in Camera 2's language. So we not only need to know _where_ each camera is, we also need to know _which way it's facing_ so we can convert each camera's local description ("in front of me, to the right") into the shared language of the world frame. ("2 units in the positive X direction, 3 units in positive Y direction of the world").

We call the positioning of the camera relative to the origin a _translation_, and the conversion of its 'language' a _rotation_. 