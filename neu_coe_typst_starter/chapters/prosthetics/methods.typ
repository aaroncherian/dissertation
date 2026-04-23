#import "../../template.typ": flex-caption

== Methods

#figure(
  image("figures/methods_fig_v2-03.png"),
  caption: flex-caption([ An overview of experiment design and analysis methods. *Setup:* Six generic USB-webcams were placed circularly around the treadmill and connected to a single PC, with the FreeMoCap software used for video acquisition. A ChArUco board (board size: 40" x 27.5", square size: 126 mm) was used to calibrate the cameras. *Data Collection:* Three prosthetic alignment parameters (leg length, sagittal plane alignment of the ankle, and toe-in/toe-out angle) were manipulated across five discrete adjustments. For each adjustment, the participant completed a 1-minute walking trial while being recorded by both a markerless and marker-based motion capture system. *Pose Estimation:* RTMPose was used to detect 2D full-body anatomical keypoints per camera view. A custom DeepLabCut (DLC) model was trained to identify analogous keypoints on the prosthesis. *Triangulation:* For both pose estimation software, 2D keypoints per camera were triangulated to reconstruct 3D joint center trajectories. The two sets of 3D data were spliced together to create a model where a DLC-backend was used to track the prosthesis, while RTMPose-backend was used to track the rest of the body. *Outcome metrics:* Outcome metrics relating to each prosthetic alignment adjustment (leg length, knee and ankle joint angles, pelvic obliquity, foot progression angle, toe clearance, stance and swing duration) were calculated.],
  [Overview of prosthetic alignment experiment design and analysis methods])
) <fig-prosthetic-methods>

=== Participant
One transfemoral prosthesis user participated in this proof-of-concept validation study. A single-participant, within-session repeated-measures design was chosen to isolate the effect of controlled alignment perturbations from inter-individual variability in gait, residual limb morphology, and prosthetic componentry.  The participant provided informed consent, and the protocol was approved by the Northeastern University IRB (\#22-03-07). The participant used their personal prosthesis (knee: Ottobock C-Leg 4; foot: passive carbon fiber device) for the study. 

=== Experimental setup 

* Marker-based motion capture *

3D marker trajectories were acquired using a Qualisys (Qualisys AB, Gothenburg, Sweden) motion capture system consisting of 9 Miqus M3 and 2 Oqus 700+ cameras recording at 300Hz. A modified lower extremity marker set was used, consisting of 36 anatomical markers. Trunk markers were placed on the C7 vertebra and the sternum just below the notch. Shoulder markers were placed bilaterally on the posterior aspect of the acromion and coracoid processes. Pelvic markers were placed bilaterally on the anterior superior iliac spine (ASIS), iliac crest, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the sacrum and bilateral posterior superior iliac spines (PSIS). Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles (knee center on the prosthesis), medial and lateral malleoli (malleoli present on the prosthetic foot shell), 1st, 2nd and 5th metatarsal heads, toe, and three heel markers. A rigid cluster of 4 markers were placed midway on the thigh and shank, bilaterally.

* Marklerless motion capture *

Video data was acquired using 6 generic USB-webcams (approximately \$20 each, 1280x720 pixels) recording at 30Hz. Cameras were connected to a single computer and arranged circularly around the Bertec split belt treadmill (Columbus, Ohio, USA). Multi-camera synchronized video acquisition was performed using the FreeMoCap software. Camera calibration data were collected prior to recording using a ChArUco calibration board printed on a rigid surface (board size: 40" x 27.5", square size: 126 mm). All recorded data, including calibration sequences, were then processed offline using FreeMoCap (v1.7.2) to estimate intrinsic and extrinsic camera parameters, perform 2D pose estimation, and reconstruct 3D kinematics. 

=== Experimental design 

The overall experimental workflow, including data collection, pose estimation, 3D reconstruction, and outcome metric calculation, is illustrated in @fig-prosthetic-methods.

*Trial structure*

The participant completed 15 treadmill walking trials at their self-selected walking speed, each lasting one minute. Three categories of alignment changes were tested with five levels of adjustment per category. At the start of each trial, the participant adopted a neutral A-pose, (standing still with arms abducted slightly, feet shoulder width apart). Due to unfamiliarity with treadmill walking, the participant elected to keep at least one hand on an anterior railing during each trial to maintain balance.

*Alignment conditions*

Three clinically relevant prosthetic alignment parameters were manipulated, each at five discrete levels. Leg length was set to -12.70 mm (-0.5"), -6.35 mm (-0.25"), 0 mm (0"),  +6.35 mm (+0.25"),  +12.70 mm (+0.5") with 0 mm being the height of the participant's prosthesis without any adjustments made. Ankle alignment in the sagittal plane was set to –5.6°, –2.8°, 0°, +2.8°, +5.6°; 0° is the original alignment of the prosthetic ankle, positive is a more dorsiflexed (DF) position and negative is a more plantarflexed (PF) position. The toe-in and toe-out position was set to –6°, –3°, 0°, +3°, +6°; 0°  is the original alignment of the foot, positive is a more toed-out position, and negative is a more toed-in position. 

The evaluated alignment changes in this study are routinely performed in clinical practice. First, leg length is assessed by the prosthetist through bilateral palpation of the patient's iliac crests to determine whether the pelvis is level in the frontal plane during standing. A tilted pelvis, known as pelvic obliquity, can cause immediate gait deviations such as reduced ground clearance during swing phase, and may contribute to hip and back pain over time. Second, sagittal plane alignment of the prosthetic foot (dorsiflexion/plantarflexion) must satisfy several simultaneous biomechanical goals, including appropriate heel-strike mechanics, adequate late stance support, and sufficient toe clearance during swing. For instance, dorsiflexing the foot can increase toe clearance, but excessive dorsiflexion may reduce late-stance support. Third, toe-in/toe-out of the prosthetic foot is typically set to match the patient's sound side foot progression angle, as asymmetric rotation can alter socket reaction moments and gait symmetry @hashimotoProperSequenceDynamic2023. 

Leg length was altered using an adjustable height tube clamp adapter. Sagittal plane alignment at the prosthetic ankle was adjusted using the distal tube clamp adapter's anterior-posterior set screws; one full turn of the set screw is approximately 2.8° @shepherdPatientPreferredProstheticAnkleFoot2021. Toe-in and toe-out was adjusted using the transverse plane component of the tube clamp adapter and pylon; degree change was measured and labeled on the pylon before the data collection. 

=== Data processing 

* Marker-based motion capture* 

Marker trajectories were labeled, gap-filled, and cleaned using Qualisys Track Manager (QTM). Processed marker data was exported as a TSV containing the system start time. Knee and ankle joint centers were defined as the midpoint of their respective medial and lateral markers. Shoulder joint centers were calculated as the midpoints of anterior and posterior markers. The hip joint centers were estimated using the methods described by Bell et al. @bellPredictionHipJoint1989. Kinematic data were interpolated and then filtered using a zero-lag, 4th order, 7Hz Butterworth filter.

*Markerless motion capture*

Synchronized video data were processed using the FreeMoCap pipeline. Of the six camera views, two were excluded due to frequent occlusion of the prosthesis by the contralateral limb during gait. These occlusions made manual annotation and training of the prosthesis-specific DeepLabCut model unreliable. 2D body keypoints were estimated using two pose estimation algorithms: MediaPipe and RTMPose. These algorithms detect full-body anatomical keypoints corresponding to major joint centers. Detected 2D keypoints from each camera view were triangulated using the camera intrinsic and extrinsic parameters estimated during calibration to reconstruct three-dimensional (3D) joint trajectories for each pose estimation backend. Reconstructed trajectories were interpolated to fill short gaps and filtered using a zero-lag, fourth-order Butterworth low-pass filter with a cutoff frequency of 7 Hz. This process produced two independent sets of 3D joint trajectories per trial, for each pose estimation backend. 

*Prosthesis pose estimation*

A custom prosthesis-specific DeepLabCut (DLC) model was developed to improve tracking of prosthetic limb features. The DLC model was trained using frames from neutral alignment trials to estimate the prosthetic knee, ankle, heel and toe joint centers. The trained model was then applied to all recording sessions. Prosthesis-specific annotation and model training for the DLC model were facilitated using a streamlined multi-camera annotation workflow.

DLC-estimated 2D keypoints were reconstructed into 3D trajectories using the FreeMoCap 3D reconstruction pipeline described above. These trajectories were then substituted for the corresponding MediaPipe and RTMPose-derived trajectories in the right leg.

*Data synchronization and alignment*
Markerless and marker-based data were temporally aligned using recorded Unix timestamps from both systems, generated from the same acquisition computer. Qualisys data were resampled to match FreeMoCap timestamps, with cross-correlation of joint trajectories and manual inspection used for final refinement of small residual temporal offsets.

Markerless data were spatially aligned to the marker-based reference frame using a least-squares-optimized transformation that minimized joint center errors between systems. To identify a transformation that was consistent over the full recording, candidate transformations were estimated from randomly sampled subsets of frames and evaluated across the entire dataset.

=== Data analysis

*Gait event detection and normalization* 

Heel strike and toe off events were identified using the velocity-based treadmill gait event detection method described by Zeni et al., based on zero-crossings of the anterior-posterior velocity of the foot @zeniTwoSimpleMethods2008a. Heel strike was defined as the transition from positive to negative velocity of the heel marker, and toe off as the transition from negative to positive velocity of the toe marker. Gait events were used to compute stance and swing duration for both feet. For markerless motion capture, events for the prosthetic limb were calculated from DeepLabCut-based 3D data, while events for the non-prosthetic limb were calculated from RTMPose-based 3D data. Marker-based gait events were used as the reference to define time-normalized gait cycles for trajectory and joint angle comparisons across systems.

*Leg length* 

Leg length was calculated as the 3D distance between the detected prosthetic knee and ankle centers. Leg length was calculated per frame and summarized as the median across all frames in a given recording to reduce the effect of outliers from occasional tracking errors. Variability was calculated as median absolute deviation.

*Joint angles* 

Joint angles were calculated as Cardan XYZ decomposition of the relative rotation between adjacent segments. Knee flexion/extension and ankle plantarflexion/dorsiflexion were extracted and analyzed across time-normalized gait cycles.

Pelvic obliquity was defined as the frontal-plane tilt of the pelvis and computed as:

$ theta_"pelvis" = op("atan2")(v_z, norm(bold(v)_(x y))) $ <eq-pelvis>

where $bold(v) = bold("hip")_R - bold("hip")_L$ is the vector connecting the right and left hip joint centers, $v_z$ is its global vertical component and $bold(v)_(x y)$ is its projection onto the horizontal plane. Positive values indicate that the right hip is higher than the left.

*Minimum toe clearance* 

Minimum toe clearance was defined as the minimum height of the toe from the ground for each system during the swing phase of gait. For each stride, the vertical (Z-axis) toe position was extracted within 70-95% of the gait cycle, corresponding to the mid-to-late swing phase. This specific window was used to exclude stance phase and terminal swing. Minimum toe clearance was then computed and averaged across strides.

*Foot progression angle* 

The effects of toe-in/toe-out adjustments were assessed using foot progression angle (FPA), defined as the angle between the long axis of the foot and the line of progression, projected onto the transverse plane. The line of progression was defined as the laboratory $Y$ (anterior-posterior) axis and the axis of rotation as the laboratory $Z$ (vertical) axis. Both the foot longitudinal axis and line of progression vector were projected onto the plane orthogonal to the axis of rotation as:

$ bold(f)_perp = bold(f) - (bold(f) dot bold(n)) bold(n), quad bold(p)_perp = bold(p) - (bold(p) dot bold(n)) bold(n). $ <eq-projection>

where $bold(f)$ is the foot longitudinal axis, $bold(p)$ the line of progression vector, and $bold(n)$ the unit vector defining the axis of rotation.

$bold(f)_perp$ and $bold(p)_perp$ were normalized and FPA was then calculated as the signed angle between the projected vectors:

$ "FPA" = tan^(-1) ((bold(p)_perp times bold(f)_perp) dot bold(n)) / (bold(p)_perp dot bold(f)_perp) $ <eq-fpa>

FPA was computed across time-normalized gait cycles and averaged across strides. Positive values indicate external rotation (toe-out) and negative values indicate internal rotation (toe-in).

*Root mean squared error (RMSE)* 

Agreement between markerless and marker-based joint center position was quantified using root mean squared error (RMSE). RMSE was calculated across medio-lateral ($X$), anterior-posterior ($Y$) and vertical ($Z$) directions. For each axis, RMSE was calculated per gait-normalized stride and averaged across strides. RMSE was also calculated to compare joint kinematics including knee flexion/extension and ankle dorsiflexion/plantarflexion, and pelvic obliquity, as well as foot progression angle, comparing gait-normalized angle trajectories between systems and averaging across strides. For minimum toe clearance, RMSE was computed between stride-matched values across systems within each condition, subsequently averaged across conditions.