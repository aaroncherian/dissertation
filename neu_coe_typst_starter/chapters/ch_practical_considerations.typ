= Practical Considerations in Markerless Motion Capture

== Introduction
Across the preceding three chapters, I have presented various metrics of accuracy and sensitivity for FreeMoCap across gait, balance, and prosthetic gait contexts.  Perhaps the most important disclaimer I can offer is this: in any validation of a markerless system (this one included) the reported metrics of accuracy are not fixed properties of a software package or a system. 

In my experience, the accuracy of a motion capture session is shaped by a confluence of factors: hardware, environment, camera positioning, participant characteristics, and the choices made by the person collecting the data. The metrics reported in any validation study, including those in this dissertation, reflect what a specific configuration was able to achieve under specific conditions. They are not universal guarantees. 

Consider our laboratory setup for example - the data in this work was collected in that is built and optimized for different kinds of motion analysis. The space is wide and open with space for a six camera setup, has windows with controllable shades to help keep lighting conditions controlled, and minimal clutter and clean white walls to provide a clean background for pose estimation software to latch onto. This is not necessarily representative of real world environments, and not an expectation we can hold of in-home and clinical environments. 

What we can do however, is try to make widely known the practices of what one can do it get better data. This chapter is an effort to write about practical considerations in collecting motion capture data from a markerless motion capture system, in the hopes that it can inform or help other validation and collection in the future. 

== The important things to know

The first and foremost finding that I can relate is that markerless motion capture is not just a tool, but also a technique. While many users might be able to use this as an out-of-the-box tool to get the data they need, I find that the more you expect out of it, the more there is to learn. Technique is practiced and refined over time - and so will the accuracy of the motion capture data you capture from the system. 

In describing markerless motion capture as a technique, I would put it like so: good motion capture is like good videography and photography. Just as these are skills one needs to hone to take cinematic videos and Instagram-worthy pictures, so too is motion capture a technique that needs to be practiced in order to get research quality data. 

This metaphor was not just a one-off. Ultimately in markerless motion capture, the raw data are the videos that are taken of the subject. he considerations one must make in taking a good photo or video (e.g., proper lighting, framing against the background, positioning of the subject within the frame) often apply to markerless motion capture. 

== Clothing

Clothing should be tight-fitting and ideally, contrasting with the environment. Pose estimation software generally, is looking for a human-like object to place joint centers on, and so the more obviously human-like we can make our subject/participant look, the more we can aid our 2D tracking of the subject. In initial pilot testing of our validation study, participants wore full-body black suits. We found that these were detrimental to our accuracy, particularly in gait. Black-on-black makes overlapping limbs in a camera view hard to contrast - therefore we switched to sleeveless shirts and tight fitting shorts to better provide contrast. We took special care to spray paint shoes worn by the participants to be white such that they had clear contrast against the black belts of our instrumented treadmill. 

== Lighting
Lighting matters. As in taking a photo, you want the subject to be well-lit, this too matters in markerless motion capture. This matters matters even more when considering that often to minimize motion blur, we must keep our exposure settings somewhat lower which also makes the camera view darker. Therefore, it should be of interest to keep the limbs of interest as well-illuminated as possible. Participant clothing and skin colors should be considering in the lighting. Window shades were always shut with overhead lighting turned on to make sure that time of day and sunlight was never a factor the lighting of our participant. We used three stage lights to light the participant, particularly pointing them down towards the treadmill to illuminate the belt and further improve lower-limb lighting, and approximating a 3 point lighting approach often used in film and photography to minimize the shadows caused by the lights themselves. 

== Camera Positioning

The positioning of multiple cameras matters. Frankly, I spent many months optimizing our six camera setup to my liking. From a personal standpoint, I prefer avoiding fully saggital angle. If the subject is relatively stationary in the capture area, I like to try and make sure each camera is gathering as much data about the participant as possible. Fully saggital plane views cut out perhaps 50% of the data you could be gather about the participant, while also contributing to the occlusion problem. Generally, I preferred to place any saggital views as being somewhat oblique saggital - where it could fully see both sides of the participant, even if one side was fairly more obvious to the camera. 

== Everything is task-dependent 

Camera positioning is also highly task dependent. A participant walking on a treadmill will require a participant walking overground for 10 feet. For the former, cameras would want to be placed closer around the treadmill making sure that each camera has the best possible view of the subject at all times. For the latter, you might find that cameras are better placed wider apart to maximize camera view coverage of the walkway in an effort to make sure that at any given point in the participants route, multiple cameras have view of them to reconstruct data from. 



For a participant that is squatting, it may be important to position the cameras such that occlusion during the squat itself is minimized, which may require different camera angles. To contradict my own advice about avoiding purely saggital planes earlier - when recording participants on a stationary bike, I found moderate success in having cameras completely saggital to the subject on either side of the subject to better account from occlusion in the bike. 

We had a highly controlled setup. Camera tripod positions were marked on the floor with tape to maintain as much consistency in camera placement across participants as possible, though specifics of camera height and orientation were tuned to most clearly view the participant in the frame.




