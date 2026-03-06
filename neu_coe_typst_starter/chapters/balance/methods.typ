== Methods

=== Participants

6 participants (5 male, 1 female) were recruited in this study. Prior to the experiments, participants signed an informed consent form approved by the IRB. Participants wore tight-fitting clothing and were equipped with the full-body marker set after arrival. 

=== Experimental setup
*Marker-based motion capture*
The marker-based system consisted of X Qualisys Miqus/X cameras (300Hz) and tracked the positions of 48 markers. Four markers were affixed to a head cap (top, front, left right). An additional marker was placed on the C7 vertebra. Trunk markers were placed on the sternum, right lower back, and bilaterally on the acromion processes and on the anterior and posterior aspects of the shoulders. Upper extremity markers were placed bilaterally on the medial and lateral humeral epicondyles and the ulnar and radial styloid processes and dorsum of the hands. Pelvic markers were placed bilaterally on the anterior superior iliac spines (ASIS), iliac crests, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the left and right posterior superior iliac spines (PSIS) and the sacrum. Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles, medial and lateral malleoli, calcanei, 1st and 5th metatarsal heads, and dorsal aspect of the second metatarsal. 
 

*Markerless motion capture*

The markerless system consisted of 6 consumer-grade cameras (USB webcams, \~\$20, 1080x720 resolution, 30Hz) arranged in a circle around the capture volume. Cameras were positioned to optimize capture of the particpant from... Cameras were plugged into the main computer. Multi-camera, synchronized video acquisition was performed using the FreeMoCap software.

Multi-camera calibration was performed prior to recording using a ChArUco calibration board. Intrinsic and extrinsic camera parameters were estimated with bundle adjustment using a modified implementation of the Anipose toolkit@AniposeToolkitRobust2021. FreeMoCap includes an option for ground-plane orientation of the data. The board was laid flat at the start of the recording. The origin was set using the board, and 3D data was rotated to match the axes, with Z pointing up in the vertical and the horizontal plane being at the floor (Z = 0). 

*Data Collection*

Participants followed the protocol of the NIH Standing Balance Test @StandingBalanceTest, which itself is based on the Modified Clinical Test of Sensory Interaction on Balance @ModifiedClinicalTest2013. Participants were instructed to stand with their hands at their sides and perform the following four conditions for 60 seconds:

1) Stand on firm surface with eyes open

2) Stand on firm surface with eyes closed

3) Stand on a foam pad with eyes open

4) Stand on a foam pad with eyes closed

To reduce occlusions in camera views when tracking the body, participants were instructed to keep feet shoulder width apart. Participants were also given a visual mark to maintain focus on. Foot position has previously been shown to have little effect on the scoring of the test @wrisleyEffectFootPosition2004. Participants were given a line to step up to at the start of each condition and would step back at the end. They would also clap at the start to provide a visual reference in the software to look for condition start. 

Participants completed two trials of the test, each being recorded simultaneously by both marker-based and markerless motion capture systems. 

=== Data Processing
*Marker-based motion capture data*

Marker-based data was tracked, labeled and processed in QTM. Missing trajectories were interpolated using linear or relational gap-filling. The labeled and cleaned marker positions were exported as a `.tsv` file containing system timestamps. Joint centers were calculated as part of the analysis pipeline (detailed below). Head, elbow, wrist, knee and ankle joint centers were defined as the midpoint of their respective medial and lateral markers. Shoulder joint centers were defined as the midpoint of the anterior and posterior markers. The hip joint centers were estimated using the Bell method @bellPredictionHipJoint1989. Raw kinematic data was filtered using a zero-lag, 4th order, 6Hz Butterworth filter. 

*Markerless motion capture data*

Synchronized videos were processed using the FreeMoCap (v.XX) pipeline described in Chapter X. 2D body keypoints were detected using MediaPipe, RTMPose and ViTPose pose estimation software. Corresponding keypoints were triangulated into 3D space. 3D data was filtered using a zero-lag, 4th order, 6Hz Butterworth filter.  

*Data synchronization and alignment*

Marker-based and markerless data joint center trajectories were temporally aligned using recorded Unix timestamps from both systems, generated from the same acquisition computer. Marker-based data were resampled to match the markerless system sampling rate (30Hz), with additional cross-correlation of joint trajectories and manual inspection used for final refinement of small residual temporal offsets. 

Markerless data were spatially aligned to the marker-based reference frame using a least-squares optimized transformation that minimized joint center errors between systems. To identify a transformation that was consistent over the full recording, candidate transformations were estimated from randomly sampled subsets of frames and evaluated across the entire dataset. 

=== Data Analysis

*Center-of-mass (COM) calculation*

For the reference system and each pose estimation backend, body segments were defined with segment mass fractions and COM locations according to the anthropometric tables reported by Winter @winterBiomechanicsMotorControl2009. Segment COM position was calculated along each segment using these definitions, and total-body COM was calculated as the mass-weighted average of all segment COM coordinates. 

*Path length analysis*

Using a custom-built viewer (cite NIH), each trial was annotated with the start and stop frame numbers for each of the four conditions. The same number of frames was used for each condition, for every trial. Within each condition, COM path length was calculated as the sum of the Euclidean distance between consecutive 3D COM position. COM was also normalized by the frame duration in seconds. 


