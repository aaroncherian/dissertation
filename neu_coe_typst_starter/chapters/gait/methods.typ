#import "../../template.typ": flex-caption


== Methods

#figure(
  image("figures/methods_gait.png", width: 93%),
  caption: flex-caption([An overview of gait experiment design and analysis methods. *Setup:* Six generic USB-webcams were placed circularly around the treadmill and connected to a single PC, with the FreeMoCap software used for video acquisition. A ChArUco board (board size: 40" x 27.5", square size: 126 mm) was used to calibrate the cameras. *Data Collection:* Participants walked on a treadmill, with speed increasing in increments of 0.5 m/s from 0–2.5 m/s every 30 seconds. Each participant completed two trials while being recorded by both a markerless and marker-based motion capture system. *Processing:* Markerless data were processed using three pose estimation backends (MediaPipe, RTMPose, and ViTPose), each producing a set of reconstructed 3D data. *Analysis and Outcomes:* Errors in joint position and joint angles, as well as agreement between spatiotemporal gait parameters from both systems, were calculated. ],
  [An overview of gait experiment design and analysis methods ])) <fig-gait-methods>


=== Participants

6 participants (5 male, 1 female) were recruited in this study. All participants were healthy adults with no reported musculoskeletal or neurological impairments affecting gait. The participants provided informed consent and the protocol was approved by the Northeastern University IRB (\#19-08-27).

=== Experimental setup

An overview of the experimental design and analysis pipeline is shown in @fig-gait-methods.

*Marker-based motion capture*

The marker-based system consisted of 9 Miqus M3 and 2 Oqus 700+ cameras (300 Hz) and tracked the positions of 48 markers. Four markers were affixed to a head cap (top, front, left, right). An additional marker was placed on the C7 vertebra. Trunk markers were placed on the sternum, right lower back, and bilaterally on the acromion processes and on the anterior and posterior aspects of the shoulders. Upper extremity markers were placed bilaterally on the medial and lateral humeral epicondyles, the ulnar and radial styloid processes, and dorsum of the hands. Pelvic markers were placed bilaterally on the anterior superior iliac spines (ASIS), iliac crests, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the left and right posterior superior iliac spines (PSIS) and the sacrum. Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles, medial and lateral malleoli, calcanei, 1st and 5th metatarsal heads, and dorsal aspect of the second metatarsal. 
 
*Markerless motion capture*

The markerless system consisted of six consumer-grade cameras (\$20 USB webcams,  1280x720 resolution, 30Hz) arranged in a circle around the capture volume. Cameras were positioned to maximize multi-view coverage of the participant. Two cameras were aligned with the frontal plane, positioned anterior and posterior to the participant. The remaining four cameras were placed at approximately 45° oblique angles relative to the sagittal plane. Camera positions were standardized across participants using floor markers, while camera height and orientation were adjusted for each participant to optimize visibility and reduce occlusion. 

All cameras were connected to a single acquisition computer. Video capture was performed using the FreeMoCap software. Because both FreeMoCap and Qualisys recordings were acquired on the same computer, timestamps from each system were referenced to a shared system clock, enabling temporal alignment between datasets.

Prior to recording, cameras were calibrated using a ChArUco calibration board (square size: 126 mm, board size: 40" x 27.5"). Intrinsic and extrinsic camera parameters were estimated using a modified implementation of the Anipose toolkit @AniposeToolkitRobust2021 (see Chapter 3: Calibration). At the start of each recording, the board was placed flat on the floor within view of all cameras to define the reference frame of the reconstruction (ground plane alignment). The origin of the capture volume was set using the board, and the reconstructed 3D data were aligned such that the vertical axis corresponded to the Z-axis, with the horizontal plane defined as $Z = 0$.   

*Data Collection*

Participants walked on a treadmill at progressively increasing speeds. The treadmill increased in 0.50 m/s increments every 30 seconds, starting from rest until 2.50 m/s. Prior to data collection, participants were given time to familiarize themselves with the treadmill and each speed condition.

Each participant completed two trials, with all trials recorded simultaneously using both marker-based and markerless motion capture systems. At the start of each trial, participants assumed an "A-pose", a neutral position with feet slightly apart, head up, and arms angled downward at roughly 45 degrees. For analysis, 600 frames of data (20 seconds) were analyzed from each condition for each trial.

=== Data Processing
*Marker-based motion capture data*

Marker-based data were tracked, labeled and processed in QTM. Missing trajectories were interpolated using linear or relational gap-filling. The labeled and cleaned marker positions were exported as a `.tsv` file containing system timestamps. Head, elbow, wrist, knee and ankle joint centers were defined as the midpoint of their respective medial and lateral markers. Shoulder joint centers were defined as the midpoint of the anterior and posterior markers. The hip joint centers were estimated using the methods described by Bell et al. @bellPredictionHipJoint1989. Raw kinematic data were filtered using a zero-lag, fourth-order Butterworth filter with a 6 Hz cutoff frequency. 

*Markerless motion capture data*

Synchronized videos were processed using the FreeMoCap (v1.7.4) pipeline described in Chapter 3. 2D body keypoints were detected using MediaPipe @lugaresiMediaPipeFrameworkBuilding2019 (`mediapipe`: v0.10.14),  RTMPose @jiangRTMPoseRealTimeMultiPerson2023 (`rtmposelib`: v0.0.14), and ViTPose @xuViTPoseSimpleVision2022 (implemented using the `easy_ViTPose` Github repository) pose estimation software. Corresponding keypoints were triangulated into 3D space. 3D data were filtered using a zero-lag, fourth-order Butterworth filter with a 6 Hz cutoff frequency. 

*Data synchronization and alignment*

Joint center trajectories from marker-based and markerless systems were temporally aligned using recorded Unix timestamps from both systems, which were generated on the same acquisition computer. Marker-based data were resampled to match the markerless sampling rate (30 Hz). Residual temporal offsets were further refined using cross-correlation of joint trajectories, followed by manual inspection. 

Markerless data were spatially aligned to the marker-based reference frame using a least-squares optimized rigid transformation that minimized joint center errors between systems. The transformation consisted of three rotational $(r_x, r_y, r_z)$ and three translation $(t_x, t_y, t_z)$ parameters. 

To identify a transformation that was consistent over the full recording, candidate transformations were estimated from randomly sampled subsets of frames  and evaluated across the entire dataset. The transformation that minimized the global joint center error across all frames was selected for each trial.

=== Data Analysis

*Joint Angles*

Joint angles were calculated as the Cardan XYZ decomposition of the relative rotation between adjacent segments. Sagittal-plane lower-body kinematics were extracted and analyzed across gait cycle-normalized strides. Joint angles were offset-corrected by subtracting the mean angle measured during the neutral A-pose stance at the start of each trial.


*Gait Event Detection*

Heel strike and toe off events were identified based on anteroposterior velocity zero-crossings of the foot, using the methods described by Zeni et al. @zeniTwoSimpleMethods2008a. Marker-based gait events were used as the reference for time-normalizing to 0-100% of the gait cycle for all pose-estimated derived trajectories and joint angles.

*Gait Parameters*

Spatiotemporal parameters were calculated for each system using their respective gait events. The following gait parameters were calculated:

1) *Stance time:* The time from *heel strike to subsequent toe off* of the same foot in milliseconds (ms).

2) *Swing time:* The time from *toe off to subsequent heel strike* of the same foot in milliseconds (ms).

3) *Step length:* The *anteroposterior distance between the contralateral ankle at contralateral heel strike and the ipsilateral ankle at the subsequent ipsilateral heel strike*, reported in millimeters (mm). To account for the treadmill, step length was corrected using the distance traveled by the belt. Distance traveled by the belt was computed using the treadmill speed and the time between heel strikes.

4) *Stride length:* The *anteroposterior distance between the ipsilateral ankle at ipsilateral heel strike and the same joint at the subsequent ipsilateral heel strike*, reported in millimeters (mm). To account for the treadmill, stride length was corrected using the distance traveled by the belt. Distance traveled by the belt was computed using the treadmill speed and the time between heel strikes.

*Scaling Analysis* 

To assess whether systematic scaling differences were present between pose estimation outputs and the marker-based reference, we extended our spatial optimization to include an additional uniform scaling parameter ($s$). In this formulation, the transformation consisted of rotation, translation, and a single global scale factor applied isotropically across all spatial dimensions. 

For each trial, the optimal scale factor was estimated alongside the rigid transformation parameters by minimizing joint center error. These scale factors were not applied to the data used in downstream analyses but instead were recorded as a diagnostic measure of potential scale bias between systems.

A scale factor of $s = 1.0$ indicates no global scaling difference between systems, whereas deviations from 1.0 reflect a uniform expansion or contraction of the reconstructed markerless skeleton relative to the reference.

*Statistical Analyses*

Statistical analyses were performed using Python `v3.11`. Root mean squared error (RMSE) was calculated across all gait cycle-normalized joint center trajectories and joint angles. Per-trial RMSE was obtained by averaging across strides within a trial, and mean ± SD were then computed across all trials.

To identify regions of significant difference between the marker-based reference and each pose estimation backend, statistical parametric mapping (SPM) two-tailed t-tests were performed on gait cycle-normalized joint angles using the `spm1d` package. SPM extends hypothesis testing to an entire timeseries, identifying continuous regions where differences exceed a critical threshold. SPM{t} statistics were computed across the gait cycle, and statistical significance was assessed at $alpha = 0.05$. 

For each gait parameter, Bland-Altman plots with bias and 95% limits of agreement (LOA) were created @blandStatisticalMethodsAssessing1986. Intraclass correlation coefficients (ICC(2,1)) were calculated using the `pingouin` package to assess agreement @shroutIntraclassCorrelationsUses1979. ICC values under 0.5 were interpreted as poor agreement, 0.5-0.75 interpreted as moderate agreement, 0.75-0.90 as good agreement, and greater than 0.90 as excellent agreement @kooGuidelineSelectingReporting2016. Bland-Altman and ICC values were calculated across all speeds as well as per walking speed.


