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

Clothing should be on the tighter fitting end, although research has shown that clothing may not have a major impact on tracking accuracy @horsakRepeatabilityMinimalDetectable2024 @augustineEffectsTightLoosefitting2023. Perhaps moreso than the tightness of the clothing, an important factor to think of is contrast. I've found that there are two questions related to contrast worth asking when looking at any camera view 

1) How easy is it to distinguish your participant from the environment? 

2) How easy is it to distinguish different limbs of your participant from each other?  

To explain this further, in our initial pilot testing for the validation study, participants wore full-black body suits with black shoes on a black treadmill. Here, we generally found poor results because we failed at both these questions. Regarding the first question, black pants and black shoes are not easy to distinguish on a black treadmill. Regarding the seconds, limbs that are all dressed in black are very difficult to differentiate, particularly in dynamic activities such as gait. We then switched our participant attire to sleeveless shirts, shorts, and spray-painted the shoes white to add the necessary contrast. @fig-clothing below shows the difference between our participant attire during our pilot testing and the validation study proper. 

#figure(
    image("practicals/clothing.png"),
    caption:[Attire worn by participants during markerless motion capture recording. *Left*: Initial pilot testing where the participants wore a full body suit with black shoes. Note how it is hard in the photo to clearly differentiate where the ankles and feet are on the treadmill. *Right*: Validation study attire, with shorts and sleeveless shirt to add limb contrast, and white shoes to add environment contrast. Exposing the joints (elbows and knees) adds much necessary contrast to the body, particularly during gait.]
) <fig-clothing>



== Lighting

Returning to our earlier metaphor, lighting, as in photography, is fundamental. The subject needs to be well-lit, and this matters particularly because minimizing motion blur often means keeping exposure settings low, which inherently darkens the camera view. Participant skin color is also a factor here — darker skin tones against a dark environment compound the contrast challenges. The goal is even, sufficient illumination across the full body, with particular attention to whatever body regions are most relevant to the analysis.

@fig-clothing illustrates this as well. In our initial pilot testing, we used a single spotlight resting on the ground and aiming _up_ at the participants' upper bodies. However, in gait, the limbs of primary interest are the lower ones - and the ground-level light left the treadmill belt and lower limbs underlit. In our final validation setup, we used three stage lights aimed downward toward the treadmill surface to improve lower-limb illumination. This arrangement approximated the three-point lighting approach common in film and photography, which helped minimize shadows cast by the participant onto the treadmill belt.

== The Amount of Cameras

Research describing the best number of cameras can be a little contradictory. Theia3D requires an absolute minimum of six cameras, but suggests at least eight. Uhlrich et al. found minimal decrease in error when moving from two to five cameras with OpenCap @uhlrichOpenCapHumanMovement2023, while Yang et al. found substantial decrease in error using an OpenPose-based motion capture system @yangEvaluationCameraConfigurations2025. Part of why we used six cameras, quite frankly, is because that is the maximum amount of USB ports available on the computer to plug into. 

Generally, we recommend at least three cameras. But the exact number might change depending on the space available and the task at hand. For example, if you were trying to track overground gait, I would suggest using as many cameras as you need to achieve visual coverage of the space. 

== The Positioning of Cameras

Personally, I believe in camera positioning is a key part of gathering good data. I spent many months optimizing our six camera setup to my liking for our validation (pictured in @fig-treadmill, for reference), and have come up with a myriad of personal-though-not-necessarily-supported-by-research-viewpoints. 
For example, I prefer to avoid fully sagittal views of a participant when possible, as they invite heavy occlusion and don't provide as much data. I prefer to use frontal views and oblique angles to make sure each camera is gathering as much data about the participant as possible. 

#figure(
    image("practicals/treadmill.png", width:80%),
    caption: [Positioning of six cameras around a treadmill to capture data for our validation study]
) <fig-treadmill>

Camera positioning is also highly task dependent, and that task might ultimately be the most important factor in where cameras are positioned. 

For tasks where the participant moves across a wide area, such as overground gait, the camera positioning strategy shifts. Rather than framing the participant tightly as you would around a treadmill, the goal becomes covering the space itself. You consider the full area the participant might move through, identify the regions you care about most, and position the cameras so that at any given point within that area, at least two cameras have the participant in view for triangulation. @fig-overground shows a five-camera overground gait setup we tried as an example. Two cameras were placed at opposite ends of the walkway in portrait orientation, angled to look down the full length of the path — the reasoning being that as the participant moved far enough from one end camera to leave its field of view, they would be approaching the other. The remaining three cameras were positioned along the side of the walkway in landscape orientation to maximize lateral coverage. Between the five, the goal was to ensure that no matter where the participant was on the walkway, at least two cameras could see them. Note in this case, the mixed use of portrait and landscape orientations to maximize ground coverage. 

#figure(
    image("practicals/overground.png"),
    caption: [Five-camera setup for overground gait capture. Two cameras at opposite ends of the walkway are oriented in portrait mode to view the full length of the path, providing overlapping coverage as the participant moves between them. Three cameras along the side are oriented in landscape mode to maximize lateral coverage. ]
    
) <fig-overground>


To even contradict my earlier advice regarding sagittal planes - we once recorded participants on a stationary row machine, and due to the occlusions from the machine that purely frontal planes would cause, I used purely sagittal views instead and for this particular task successfully collected clean data (@fig-bike).

#figure(
    image("practicals/stationary_row.png"),
    caption: [Camera views to record participants on a stationary row machine. The natural occlusions caused by the machine itself caused some difficulties in camera positioning, but these particular viewpoints gave us good data.]
) <fig-bike>

Ultimately, the answer is that there is no exact answer as to where the cameras should be positioned. What it requires is a bit of patience, tinkering, and iteration to find what gets you the best data. This is what I mean when I call it a technique. 




We had a highly controlled setup. Camera tripod positions were marked on the floor with tape to maintain as much consistency in camera placement across participants as possible, though specifics of camera height and orientation were tuned to most clearly view the participant in the frame.




