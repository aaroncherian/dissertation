// appendix_practical.typ — practical considerations appendix.
// NOT compiled on its own; #included by appendices.typ.
// Appendix numbering follows include order, so moving the #include in
// appendices.typ is all that is needed to reorder it.

#import "elife.typ": *

#appendix(title: "Practical Considerations for Markerless Motion Capture")[

A key limitation of characterizing and validating a markerless motion capture system, from our experience with assembling and recording with them is that the accuracy of a motion capture session is shaped by a confluence of factors: hardware, environment, camera positioning, participant characteristics, and the choices made by the person collecting the data. In any validation study of a markerless system (this one included) *the reported metrics of accuracy are not fixed properties of the software package or system*. The reported metrics reflect what that system was able to achieve under the specific conditions that it was in. 

Consider, for example, our laboratory environment. The data in this work were collected in a space that is optimized for motion analysis: a wide, open room with sufficient space for multi-camera setups, controllable window shades to fix lighting conditions, minimal visual clutter, and clean backgrounds. These conditions are not representative of many real-world environments, particularly in-home or clinical settings, and should not be assumed as a baseline expectation.


An important point to understand is that markerless motion capture is not just a tool, but a technique. While these systems can be used out-of-the-box to produce usable data, collecting research-quality data requires iteration and experimentation. A good way to consider it is that good markerless motion capture is akin to good videography or photography. Producing high quality images requires more than just a capable camera, it requires attention to lighting, consideration of framing, the background, and also, experience. Markerless motion capture operates on the same principles. The raw data are the recorded videos, and the quality of those videos directly constrains the quality of the reconstructed motion.

The following sections outline the key factors that we found important in the collection of our validation datasets. 

== Clothing

Clothing should generally be form-fitting, although prior work suggests that clothing alone may not have a major impact on tracking accuracy @horsakRepeatabilityMinimalDetectable2024 @augustineEffectsTightLoosefitting2023. However, we found that an equally important factor to consider is contrast, and the particular consideration of these two questions: 

1) How easily can the participant be distinguished from the environment? 

2) How easily can different limbs be distinguished from one another?  

In our early pilot testing for this study, participants wore full-black body suits with black shoes on a black treadmill. Here, we generally found poor results largely because we failed at both criteria. First, the participant was not easily distinguishable from the environment, as black pants and shoes do not provide much contrast on a black treadmill. Second, limbs were difficult to differentiate, particular during dynamic movements with overlapping segments. 

We found much more success in modifying our participant attire to increase contrast. Participants wore sleeveless shirts and shorts, and shoes were spray-painted white to improve visibility. @fig-clothing below shows the difference between our participant attire during our pilot testing and the validation study proper. 

#figure(
    image("practicals/clothing.png", width: 85%),
    caption: [Attire worn by participants during markerless motion capture recording. *Left*: Initial pilot testing attire: a full body suit with black shoes. Note the difficulty in clearly distinguishing the ankles and feet from the treadmill belt. *Right*: Validation study attire: shorts, a sleeveless shirt to add limb contrast, and white shoes to add environmental contrast. Exposing the joints (elbows and knees) adds helpful contrast to the body, particularly during gait.]
) <fig-clothing>


We also recommend that participants with longer hair should tie it back during a recording, particularly if there is a camera directed at that participant from the back, as we found issues in pose estimation tracking from this viewpoint if hair was obscuring the neck. 

== Lighting

We found that lighting is a critical aspect to consider. Thomas et al. found that room lighting conditions could impact frontal and transverse plane kinematics @thomasLightsCamerasAction2026. The subject should be be well-lit, and this matters particularly because minimizing motion blur often means keeping exposure settings low, which inherently darkens the camera view. Participant skin color is also a factor here, as darker skin tones against a dark environment compound the contrast challenges. The goal is even, sufficient illumination across the full body, with particular attention to whatever body regions are most relevant to the analysis.

@fig-clothing illustrates this as well. In our initial pilot testing, we used a single spotlight resting on the ground and aiming _up_ at the participants' upper bodies. However, in gait, the limbs of primary interest are the lower ones - and the ground-level light left the treadmill belt and lower limbs underlit. In our final validation setup, we used three stage lights aimed downward toward the treadmill surface to improve lower-limb illumination. This arrangement approximated the three-point lighting approach common in film and photography, which helped minimize shadows cast by the participant onto the treadmill belt.

== Framing 

Framing of the participant fully in the camera views is important. Particularly if they will largely be staying in place through the recording, participants should take up as much of the camera view as possible, while still ensuring their whole body is visible. Camera height and tilt should be optimized to the participant to keep them visible. While adjusting camera orientation, we often asked participants to assume a T-pose where they outstretch their hands, or to go through the motions of the action they will perform to make sure that there is no camera view in which a limb moves out of frame. 

== Background
The background should, to the extent that is possible, be free of clutter. Primarily, this is because pose estimation algorithms are imperfect and sometimes prone to what we colloquially term the "ghost skeleton" problem - which is when the pose estimation software detects joint center keypoints on something that is distinctly not a human. We find this issue to especially be prevalent when the participant is further from a given camera. Keeping the recording area free of as much clutter as possible can help mitigate this problem. Strong framing of the participant as discussed above can also help here. 

== Number of cameras

Research describing the best number of cameras can be a little contradictory. Theia3D requires an absolute minimum of six cameras, but suggests at least eight. Uhlrich et al. found minimal benefits when moving from two to five cameras with OpenCap @uhlrichOpenCapHumanMovement2023, while Yang et al. found substantial decrease in error using an OpenPose-based motion capture system @yangEvaluationCameraConfigurations2025. 

The number of cameras used for our data collection (six cameras) was based on the maximum number of USB ports available to use. Generally, we recommend at least three cameras for data collection. However, this is also dependant on the space available and task given to the participant. Overground gait, for example, might require using more cameras to achieve visual coverage of the space, though Darici et al. still reported accurate metrics for overground gait over a 6 meter walkway using a 3 camera FreeMoCap setup @dariciLowCostMarkerlessMotion2025. 

== Positioning of cameras

We found camera positioning to be a critical part of gathering good data. Recently, Thomas et al. found changing camera configuration (including camera placement and camera count) altered Theia3D kinematic estimates @thomasLightsCamerasAction2026. An example of the camera viewpoints in our setup can be seen in @fig-treadmill. We chose two cameras to cover planar views from the front and back, while for the other four we chose to use oblique views such that each camera, even though primarily focused on one side of the body, was still able to provide data on the opposing side. 



#figure(
    image("practicals/treadmill.png", width:80%),
    caption: [Positioning of six cameras around a treadmill to capture data for our validation study]
) <fig-treadmill>


Camera positioning is also highly task dependent, and that task is ultimately the most important factor in where cameras are positioned. 

For tasks where the participant moves across a wide area, such as overground gait, the camera positioning strategy shifts. Rather than framing the participant tightly as one would around a treadmill, the goal becomes covering the space itself. One should consider the full area the participant might move through, identify the regions they care about most, and position the cameras so that at any given point within that area, at least two cameras have the participant in view for triangulation. @fig-overground shows a five-camera overground gait setup we tried as an example. Two cameras were placed at opposite ends of the walkway in portrait orientation, angled to look down the full length of the path - the reasoning being that as the participant moved far enough from one end camera to leave its field of view, they would be approaching the other. The remaining three cameras were positioned along the side of the walkway in landscape orientation to maximize lateral coverage. Between the five cameras, the goal was to ensure that no matter where the participant was on the walkway, at least two cameras could see them. Note in this case, the mixed use of portrait and landscape orientations to maximize ground coverage. 

#figure(
    image("practicals/overground.png"),
    caption: [Five camera setup for overground gait capture. Two cameras at opposite ends of the walkway are oriented in portrait mode to view the full length of the path, providing overlapping coverage as the participant moves between them. Three cameras along the side are oriented in landscape mode to maximize lateral coverage. ]
    
) <fig-overground>


To provide another example, when once recorded participants on a stationary row machine, and due to the occlusions from the machine that purely frontal planes would cause, we used purely sagittal views instead (@fig-bike).

#figure(
    image("practicals/stationary_row.png"),
    caption: [Camera views to record participants on a stationary row machine]
) <fig-bike>

We have found that ultimately, camera positioning will be limited by the environment, and to the extent possible should be configured according to the task involved. A given task (e.g., squatting, jumping, one-leg balance) may have its own optimal camera setup, requiring testing and iteration in order to produce the best results. 

As you may now surmise, the ultimate answer is that there
is no exact answer as to where the cameras should be positioned. Each activity (e.g., squatting, jumping, one-leg balance) will require its own necessary camera setup. What it requires is a bit of patience, tinkering, and iteration to find what results in the best data - hence, markerless motion capture is a technique.  

