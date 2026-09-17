// appendix_practical.typ — practical considerations appendix.
// NOT compiled on its own; #included by appendices.typ.
// Appendix numbering follows include order, so moving the #include in
// appendices.typ is all that is needed to reorder it.

#import "elife.typ": *

#appendix(title: "Practical Considerations for Markerless Motion Capture")[

A key limitation of characterizing and validating a markerless motion capture system, from our experience with assembling and recording with them is that the accuracy of a motion capture session is shaped by a confluence of factors: hardware, environment, camera positioning, participant characteristics, and the choices made by the person collecting the data. In any validation study of a markerless system (this one included) *the reported metrics of accuracy are not fixed properties of the software package or system*. The reported metrics reflect what that system was able to achieve under the specific conditions that it was in. 

Consider, for example, our laboratory environment. The data in this work were collected in a space that is optimized for motion analysis: a wide, open room with sufficient space for multi-camera setups, controllable window shades to fix lighting conditions, minimal visual clutter, and clean backgrounds. These conditions are not representative of many real-world environments, particularly in-home or clinical settings, and should not be assumed as a baseline expectation.

Markerless motion capture is perhaps better understood then not simply as a tool, but as a measurement technique. While these systems can be used out-of-the-box to produce usable data, collecting research-quality data requires iteration and experimentation. A good way to consider it is that good markerless motion capture is akin to good videography or photography: producing high quality images requires more than just a capable camera, it requires attention to lighting, consideration of framing, the background, and experience. Markerless motion capture operates on the same principles. The raw data are the recorded videos, and the quality of those videos directly constrains the quality of the reconstructed motion.

The following sections outline the key factors that we found important in the collection of our validation datasets. 

== Clothing

Clothing should generally be form-fitting, although prior work suggests that clothing alone may not have a major impact on tracking accuracy @horsakRepeatabilityMinimalDetectable2024 @augustineEffectsTightLoosefitting2023. However, we found that an important factor to consider is contrast, and the particular consideration of these two questions: 

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

We found lighting to be a critical consideration. Similar effects have been reported elsewhere; Thomas et al. found that room lighting conditions could influence frontal- and transverse-plane kinematics @thomasLightsCamerasAction2026. Participants should therefore be well lit, particularly because reducing motion blur often requires shorter exposure times, which in turn darken the recorded image. Participant skin color is also a factor here, as darker skin tones against a dark environment compound the contrast challenges. The goal is even, sufficient illumination across the full body, with particular attention to whatever body regions are most relevant to the analysis.

@fig-clothing illustrates this point. During initial pilot testing, we used a single spotlight placed at ground level and directed upward toward the participant’s upper body. For gait analysis, however, the lower limbs are the primary region of interest, and this configuration left both the treadmill belt and lower extremities comparatively underlit. In the final validation setup, we instead used three stage lights directed downward toward the treadmill surface to improve lower-limb illumination. This arrangement approximated the three-point lighting approach commonly used in film and photography and helped reduce shadows cast by the participant onto the treadmill belt.

== Framing 

Framing the participant fully within each camera view is important. When participants remain largely in place during a recording, they should occupy as much of the image as possible while still remaining fully visible throughout the movement. Camera height and tilt should therefore be adjusted for each participant. During setup, we often asked participants to assume a T-pose with the arms outstretched, or to rehearse the movement to be recorded, to verify that no limb moved outside the field of view in any camera.

== Background

The recording background should be kept as free of visual clutter as possible. Pose estimation algorithms are imperfect and can occasionally produce what we colloquially refer to as “ghost skeletons,” in which keypoints are detected on objects or regions that are clearly not part of the participant. We have found this issue to be more common when the participant occupies a smaller portion of the camera view or is farther from a given camera. Keeping the recording area visually simple can help reduce these false detections. Careful participant framing, as discussed above, can also help by ensuring that the person remains the dominant human-like feature in the image.

== Number of cameras

Recommendations for the number of cameras required for markerless motion capture vary across systems and applications. Theia3D requires a minimum of six cameras and recommends at least eight, whereas Uhlrich et al. reported relatively little improvement when increasing OpenCap from two to five cameras @uhlrichOpenCapHumanMovement2023. In contrast, Yang et al. found a substantial reduction in error as camera number increased in an OpenPose-based motion-capture system @yangEvaluationCameraConfigurations2025.

Our data collection used six cameras, corresponding to the maximum number of USB cameras that could be connected to the acquisition computer. As a general practical recommendation, we suggest using at least three cameras, although the appropriate number depends on the available space and the movement being recorded. Tasks that span a larger capture volume, such as overground gait, may require additional cameras to maintain sufficient multi-view coverage. However, Darici et al. reported accurate overground gait metrics across a 6 m walkway using a three-camera FreeMoCap setup @dariciLowCostMarkerlessMotion2025, illustrating that useful performance can still be achieved with relatively few cameras when coverage is adequate.

== Positioning of cameras

Camera positioning is a critical component of markerless motion capture. Thomas et al. recently showed that changes in camera configuration, including both camera placement and camera count, can alter Theia3D kinematic estimates @thomasLightsCamerasAction2026. An example of the camera viewpoints used in our validation setup is shown in @fig-treadmill. We positioned two cameras approximately in the frontal plane, one anterior and one posterior to the participant, while the remaining four cameras were placed at oblique angles. This allowed each oblique camera to emphasize one side of the body while still maintaining visibility of the contralateral side.

#figure(
    image("practicals/treadmill.png", width:80%),
    caption: [Positioning of six cameras around a treadmill to capture data for our validation study.]
) <fig-treadmill>

Camera positioning is highly task dependent, and the movement being recorded should ultimately determine the arrangement. For tasks in which the participant moves through a larger capture volume, such as overground gait, the objective shifts from tightly framing the participant to maintaining sufficient coverage of the space itself. The full region through which the participant may move should be considered, with cameras positioned so that the participant remains visible to at least two cameras throughout the portions of the capture volume required for triangulation.

@fig-overground shows a five-camera overground gait setup that we tested as one example. Two cameras were placed at opposite ends of the walkway in portrait orientation and angled along its length. As the participant moved farther from one end camera and toward the limits of its field of view, they approached the opposite camera. Three additional cameras were positioned along the side of the walkway in landscape orientation to maximize lateral coverage. The combination of portrait and landscape orientations was used to extend coverage of the capture volume while maintaining overlapping views.

#figure(
    image("practicals/overground.png"),
    caption: [Five-camera setup for overground gait capture. Two cameras at opposite ends of the walkway are oriented in portrait mode to view the full length of the path, providing overlapping coverage as the participant moves between them. Three cameras along the side are oriented in landscape mode to maximize lateral coverage.]
) <fig-overground>

The optimal arrangement can change substantially when the task introduces occlusions. For example, when recording participants on a stationary rowing machine, frontal views were frequently obstructed by the equipment. We therefore prioritized sagittal viewpoints instead (@fig-bike).

#figure(
    image("practicals/stationary_row.png"),
    caption: [Camera views used to record participants on a stationary rowing machine.]
) <fig-bike>

In practice, camera placement is constrained by both the environment and the task. Activities such as squatting, jumping, balance, treadmill gait, and overground gait may each benefit from different arrangements. There is therefore no single camera configuration that is optimal for all markerless motion capture applications. Instead, positioning should be treated as part of the measurement technique itself, with testing and iteration used to identify a configuration that provides adequate visibility and multi-view coverage for the movement of interest.
]