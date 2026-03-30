#import "../template.typ": flex-caption

= Practical Considerations in Markerless Motion Capture

== Introduction
The preceding three chapters have presented various metrics of accuracy and sensitivity for FreeMoCap across gait, balance, and prosthetic gait contexts. While any research study has limitations, the most important one that I can emphasize is this: The accuracy of a motion capture session is shaped by a confluence of factors: hardware, environment, camera positioning, participant characteristics, and the choices made by the person collecting the data. In any validation study of a markerless system (this one included) *the reported metrics of accuracy are not fixed properties of the software package or system*. The reported metrics reflect what that system was able to achieve under the specific conditions that is was in. 

Consider, for example, our laboratory environment. The data in this work were collected in a space that is optimized for motion analysis: a wide, open room with sufficient space for multi-camera setups, controllable window shades to fix lighting conditions, minimal visual clutter, and clean backgrounds. These conditions are not representative of many real-world environments, particularly in-home or clinical settings, and should not be assumed as a baseline expectation.

This chapter is an effort to outline practical considerations for collecting motion capture data, drawing from my experiences in conducting these studies and highlighting factors that I have found strongly influence data quality in the hopes that it can inform or help other validation and collection in the future


== Markerless motion capture is a technique

The first and foremost point is that markerless motion capture is not just a tool, but a technique. 
While systems like FreeMoCap can be used out of the box to produce clean, usable data, collecting research-quality data usually requires iteration. This might mean tinkering with the lighting and camera placement decisions, recording data, observing points of failure in reconstruction and trying all over again. 

I find the most useful way to think about it is this: good markerless motion capture is like good videography or photography. Producing high quality images requires more than just a capable camera, it requires attention to lighting, consideration of framing, the background, and also, experience. Markerless motion capture operates on the same principles. The raw data are the recorded videos, and the quality of those videos directly constrains the quality of the reconstructed motion.
The following sections outline the key factors that were important in the collection of these datasets.

== Clothing

Clothing should generally be form-fitting, although prior work suggests that clothing alone may not have a major impact on tracking accuracy @horsakRepeatabilityMinimalDetectable2024 @augustineEffectsTightLoosefitting2023. Perhaps more so than the fit of the clothing, an important factor to consider is contrast. I've found that there are two questions worth asking when evaluating any camera view: 

1) How easily can the participant be distinguished from the environment? 

2) How easily can different limbs be distinguished from one another?  

To explain this further, in our early pilot testing for this study, participants wore full-black body suits with black shoes on a black treadmill. Here, we generally found poor results largely because we failed at both criteria. First, the participant was note easily distinguishable form the environment. Perhaps unsurprisingly, black pants and shoes do not provide much contrast on a black treadmill. Second, limbs that are all the same, dark color were difficult to differentiate from one another, particularly during dynamic movement where overlapping segments further reduced visual separability.

We found much more success in modifying our participant attire to increase contrast. Participants wore sleeveless shirts and shorts, and shoes were spray-painted white to improve visibility. @fig-clothing below shows the difference between our participant attire during our pilot testing and the validation study proper. 

#figure(
    image("practicals/clothing.png", width: 85%),
    caption: flex-caption([Attire worn by participants during markerless motion capture recording. *Left*: Initial pilot testing attire: a full body suit with black shoes. Note the difficulty in clearly distinguishing the ankles and feet from the treadmill belt. *Right*: Validation study attire: shorts, a sleeveless shirt to add limb contrast, and white shoes to add environmental contrast. Exposing the joints (elbows and knees) adds much necessary contrast to the body, particularly during gait.],
    [Attire considerations in markerless data collection])
) <fig-clothing>


While not strictly related to clothing, participants with longer hair should tie it back during a recording, especially if there is a camera directed at that participant from the back. I have found issues in pose estimation algorithms from this viewpoint if hair obscures the neck the neck. 


== Lighting

Returning to my earlier metaphor, lighting, as in photography, is fundamental. The subject needs to be well-lit, and this matters particularly because minimizing motion blur often means keeping exposure settings low, which inherently darkens the camera view. Participant skin color is also a factor here, as darker skin tones against a dark environment compound the contrast challenges. The goal is even, sufficient illumination across the full body, with particular attention to whatever body regions are most relevant to the analysis.

@fig-clothing illustrates this as well. In our initial pilot testing, we used a single spotlight resting on the ground and aiming _up_ at the participants' upper bodies. However, in gait, the limbs of primary interest are the lower ones - and the ground-level light left the treadmill belt and lower limbs underlit. In our final validation setup, we used three stage lights aimed downward toward the treadmill surface to improve lower-limb illumination. This arrangement approximated the three-point lighting approach common in film and photography, which helped minimize shadows cast by the participant onto the treadmill belt.

== Framing 

Framing of the participant fully in the camera views is important. Particularly if they will largely be staying in place through the recording, participants should take up as much of the camera view as possible, while still ensuring their whole body is still visible. Camera height and tilt should be optimized to the participant to keep them visible. When doing final touches on camera orientation, I may ask the participant to assume a T-pose where they outstretch their hands, or to go through the motions of the action they will perform to make sure that there is no camera view in which a limb moves out of frame. 


== Background
The background should, to the extent that is possible, be free of clutter. Primarily, this is because pose estimation algorithms are imperfect and sometimes prone to what we call the "ghost skeleton" problem - which is when the pose estimation software detects joint center keypoints on something that is, distinctly, not a human. These hauntings occur particularly in recordings where the participant is a bit distant from the camera. Keeping the area where you are recording free of as much clutter as possible can help mitigate this problem. Strong framing of the participant as discussed above also helps here, as the better a participant is framed, the less reason pose estimation algorithms have to hunt for a person elsewhere. 

== The Amount of Cameras

Research describing the best number of cameras can be a little contradictory. Theia3D requires an absolute minimum of six cameras, but suggests at least eight. Uhlrich et al. found minimal benefits when moving from two to five cameras with OpenCap @uhlrichOpenCapHumanMovement2023, while Yang et al. found substantial decrease in error using an OpenPose-based motion capture system @yangEvaluationCameraConfigurations2025. 

We used six cameras because, quite frankly, that is the maximum number of USB ports that were available on the lab computer to use. Generally, we recommend at least three cameras. But the exact number might change depending on the space available and the task at hand. For example, if you were trying to track overground gait, I would suggest using as more cameras to achieve visual coverage of the space. However, Darici et al., using FreeMoCap, still reported accurate metrics for overground gait over a 6 meter walkway using just 3 cameras @dariciLowCostMarkerlessMotion2025a.

== The Positioning of Cameras

Personally, I believe camera positioning is a key part of gathering good data. I spent many months optimizing our six camera setup to my liking for our validation (pictured in @fig-treadmill, for reference), which has led to a myriad of opinions that should be taken as more preference than statement of fact.  

For example, I prefer to avoid fully sagittal views of a participant when possible, as they invite heavy occlusion and don't provide as much data. Instead, I prefer oblique angles positioned to capture the whole body, even if favoring one side primarily, to make sure each camera is gathering as much data about the participant as possible. 

#figure(
    image("practicals/treadmill.png", width:80%),
    caption: [Positioning of six cameras around a treadmill to capture data for our validation study]
) <fig-treadmill>

Camera positioning is also highly task dependent, and that task is ultimately be the most important factor in where cameras are positioned. 

For tasks where the participant moves across a wide area, such as overground gait, the camera positioning strategy shifts. Rather than framing the participant tightly as one would around a treadmill, the goal becomes covering the space itself. One should consider the full area the participant might move through, identify the regions they care about most, and position the cameras so that at any given point within that area, at least two cameras have the participant in view for triangulation. @fig-overground shows a five-camera overground gait setup we tried as an example. Two cameras were placed at opposite ends of the walkway in portrait orientation, angled to look down the full length of the path - the reasoning being that as the participant moved far enough from one end camera to leave its field of view, they would be approaching the other. The remaining three cameras were positioned along the side of the walkway in landscape orientation to maximize lateral coverage. Between the five cameras, the goal was to ensure that no matter where the participant was on the walkway, at least two cameras could see them. Note in this case, the mixed use of portrait and landscape orientations to maximize ground coverage. 

#figure(
    image("practicals/overground.png"),
    caption: flex-caption([Five camera setup for overground gait capture. Two cameras at opposite ends of the walkway are oriented in portrait mode to view the full length of the path, providing overlapping coverage as the participant moves between them. Three cameras along the side are oriented in landscape mode to maximize lateral coverage. ],
    [Five camera setup for overground gait capture])
    
) <fig-overground>

Now, to contradict my earlier opinion regarding sagittal planes - we once recorded participants on a stationary row machine, and due to the occlusions from the machine that purely frontal planes would cause, I used purely sagittal views instead, which did provide clean data (@fig-bike).

#figure(
    image("practicals/stationary_row.png"),
    caption: [Camera views to record participants on a stationary row machine]
) <fig-bike>

As you may now surmise, the ultimate answer is that there
is no exact answer as to where the cameras should be positioned. Each activity (e.g., squatting, jumping, one-leg balance) will require its own necessary camera setup. What it requires is a bit of patience, tinkering, and iteration to find what results in the best data - hence, markerless motion capture is a technique.  








