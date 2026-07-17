#import "elife.typ": *

= Materials and Methods

== FreeMoCap Software
FreeMoCap @queenFreeMoCapFreeOpen2024 is a fully open-source markerless motion capture framework designed to maximize accessibility across the entire workflow. It operates with consumer-grade webcams, requires neither physical markers nor a specialized recording environment, and supports the full process from synchronized video acquisition to 3D kinematic reconstruction (@fig-fmc-pipeline). Its modular, tracker-agnostic architecture allows different pose estimation backends to be incorporated according to the needs of a given application.

FreeMoCap is organized as a polyrepo, with major components of the motion capture workflow maintained in separate repositories. The following sections describe the principal stages of the system: synchronized video acquisition, camera calibration, 2D pose estimation, and 3D reconstruction.


#figure(
  image("figures/methods/freemocap_pipeline.png", width: 110%),
  caption: [*PLACEHOLDER* - Figure needs adjustment. Maybe add some text to it? seems a bit empty. ]
) <fig-fmc-pipeline>

=== *Synchronized Video Acquisition*
Synchronous video recording refers to the acquisition and temporal alignment of video
streams. For accurate 3D reconstruction, each set of frames must correspond to the same
moment in time. Without proper synchronization, time lags between cameras can result in
inaccurate 3D data.

In FreeMoCap, synchronous recording is handled primarily by `SkellyCam`, a software package to provide high quality synchronous recording methods that enable the use of low-cost hardware - specifically consumer-grade, off-the-shelf webcams. However, these cameras may not be suitable for all research needs (e.g., capturing athletic performance which may necessitate higher frame rate cameras or outdoor recordings, which may require non-USB cameras). The software accommodates these use cases in two ways: 1) Videos collected from a set of external cameras (e.g., GoPros or smartphone cameras) can be synchronized within the main software using light and audio-based synchronization methods; 2) A pre-synchronized set of videos can be directly imported into the software for processing. We aim to reduce dependency on specific hardware configurations and allow data collection protocols to be adapted to the needs of the study, rather than constrained by the system itself. 

=== *Camera Calibration*
In order to reconstruct 3D data from the 2D camera images, it is necessary to determine how each camera observes the world and where it is positioned within it. The former describes
intrinsic parameters (i.e., how each camera maps light onto its image sensor). The latter describes extrinsic parameters (i.e., the position and orientation of each camera relative to a common world reference frame). Camera calibration is the process of calculating the intrinsic and extrinsic parameters of a set of cameras and establishing the geometric relationships required to project 2D image features into a shared 3D coordinate system (@fig-calibration-math).

#figure(
  image("figures/methods/calibration_math_elife.png", width: 110%),
  caption: [*A.* Estimation of camera intrinsic and extrinsic parameters using a ChArUco calibration board. Each ArUco marker has a unique identifier, allowing the intervening chessboard corners to be detected and assigned known locations within the board coordinate system. The board origin is defined at the first ChArUco corner, and the 3D coordinates of the remaining corners are determined from the known printed square size. Across multiple views of the board, correspondences between these known 3D corner locations, ($X_i$), and their detected 2D pixel coordinates, ($x_i$), are used to estimate the camera intrinsics, ($K$), and the board-to-camera extrinsics, ($[R|t]$). Together, these form the camera projection matrix ($P=K[R|t]$). *B.* Estimation of each camera's position and orientation, collectively referred to as its pose, within a shared coordinate system. The extrinsic parameters estimated for each camera are first written as homogeneous transformation matrices, $T_i$. Camera 1 is then selected as the reference frame, and the pose of Camera 2 relative to Camera 1 is obtained by composing the two transforms: $T_(2 -> 1) = T_1 T_2^(-1)$. Repeating this process for the remaining cameras establishes the geometric relationships among all cameras in the system.]
) <fig-calibration-math>


Calibration and 3D reconstruction are implemented in FreeMoCap using a modified implementation of the Anipose toolkit @karashchukAniposeToolkitRobust2021. The calibration tool is a ChArUco board, a hybrid calibration target consisting of a checkerboard pattern overlaid with uniquely identifiable ArUco markers. This board can be printed on standard paper and mounted to a rigid surface, or printed directly onto a rigid board.

During calibration, the ChArUco board is moved throughout the intended capture volume and presented to multiple cameras simultaneously. Each shared observation establishes a geometric relationship between the cameras that can see the board. By moving the board through different regions of the capture space, additional overlapping camera pairs are linked together, forming a connected calibration network (@fig-calibration-method). Consequently, two cameras that never observe the board at the same time can still be related through one or more intermediate cameras. As long as all cameras belong to the same connected network, their poses can be expressed within a common 3D coordinate system.

#figure(
  image("figures/methods/calibration_methods_elife.png", width: 100%),
  caption: [*A.* A ChArUco calibration board detected in a single video frame. Each ArUco marker has a unique identifier, allowing the intervening ChArUco corners to be detected and matched across images. The detected corner IDs are shown in blue. *B.* Establishing a shared 3D capture volume. When two or more cameras simultaneously observe the calibration board, their relative poses can be estimated. Moving and rotating the board through the capture space creates additional pairwise calibration links, progressively connecting all cameras into a common 3D reference frame, including camera pairs that do not directly observe the board at the same time.]
) <fig-calibration-method>

[*PLACEHOLDER: Maybe link a video of an example calibration here from the data collection?*]

The board should be observed across a range of positions and orientations. In particular, variation in depth and tilt provides stronger constraints for estimating camera intrinsic and extrinsic parameters than observations confined to a single plane or orientation. The board must remain rigid, as bending or flexing changes the assumed geometry of the calibration target and can introduce parameter-estimation errors. Glare should also be minimized because reflections can obscure markers and corners; we therefore recommend printing the target on matte, non-glossy material.

At the start of a recording, the ChArUco board may be placed flat on the floor within the shared field of view of the cameras, a procedure we refer to as ground-plane calibration. The detected board pose is then used to define the reconstruction coordinate system: the plane of the board is assigned to $Z = 0$, and the coordinate axes are aligned with the board orientation. As a result, reconstructed 3D kinematic data are expressed directly in a physically meaningful, ground-aligned reference frame, reducing the need for post hoc translation or rotation.

=== *Pose Estimation*

Pose estimation converts each camera's video frames into 2D anatomical keypoints for subsequent 3D reconstruction (@fig-pose-examples). The default FreeMoCap pipeline uses MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, a free and open-source framework incorporating the BlazePose convolutional neural network @bazarevskyBlazePoseOndeviceRealtime2020. MediaPipe was selected as the default backend primarily for its accessibility: it is straightforward to install and use through Python, is computationally lightweight, and can run without a dedicated GPU. These characteristics allow the complete FreeMoCap pipeline to operate on a broad range of consumer hardware.

#figure(
  image( "figures/methods/pose_estimation_examples.png", width: 100%),
  caption: [Examples of landmarks estimated on a human body from three different pose estimation algorithms. *Left*: MediaPipe; *Middle*: RTMPose; *Right*: ViTPose.],
) <fig-pose-examples>


However, the choice of pose estimation model can substantially affect the resulting motion-capture data. Errors in 2D keypoint localization propagate into reconstructed 3D trajectories and derived kinematic measures, and performance varies across pose estimation algorithms @needhamAccuracySeveralPose2021 @ceriolaComparativeAnalysisMarkerless2024 @washabaughComparingAccuracyOpensource2022. Moreover, many general-purpose models are trained on datasets that were not designed specifically for movement-science applications and may provide limited representation of particular movements, environments, or populations @seethapathiMovementScienceNeeds2019 @needhamAccuracySeveralPose2021. No single pose estimation model is therefore likely to be optimal across all applications.

To accommodate alternative models, FreeMoCap separates pose estimation from the remainder of the processing pipeline through SkellyTracker, its pose estimation management framework. SkellyTracker defines a standardized interface through which a model receives video frames and returns keypoint coordinates in a consistent format. New pose estimation backends can therefore be added by implementing this interface, without requiring corresponding changes to camera calibration, 3D reconstruction, post-processing, or data export. This avoids the need to construct a new motion-capture pipeline whenever a different pose estimation model is required.

This modular design also supports controlled comparisons among pose estimation algorithms. Different backends can be applied to the same synchronized videos while holding the camera configuration, calibration, reconstruction, and post-processing procedures constant. Differences in the resulting 3D estimates can therefore be more directly attributed to the pose estimation stage, supporting the systematic benchmarking of markerless pose estimation algorithms identified as a need within the movement-science community @needhamAccuracySeveralPose2021.

=== *3D Reconstruction*
The 2D keypoints detected independently in each camera view are combined to reconstruct their positions in three dimensions (@fig-reconstruction). For each frame and keypoint, the detected pixel coordinate in each camera defines a line of sight extending from that camera into the calibrated capture volume. The corresponding 3D position is estimated by triangulating across these observations using the camera projection matrices obtained during calibration. FreeMoCap performs this reconstruction using direct linear transformation (DLT) through a modified implementation of the Anipose toolkit @karashchukAniposeToolkitRobust2021.

#figure(
image("figures/methods/reconstruction.png", width: 110%),
caption: [3D reconstruction through multi-view triangulation. Each camera observes the same anatomical keypoints, shown here as $P_1$ and $P_2$, at different 2D pixel locations. Together with the calibrated camera projection matrices, each detection defines a line of sight from the camera into the shared 3D coordinate system. The position of each keypoint is estimated from the convergence of the corresponding lines of sight across camera views.]
) <fig-reconstruction>


Corresponding 2D keypoints from the synchronized camera views were triangulated into 3D coordinates using the calibrated camera projection matrices and direct linear transformation. 

In multiview markerless motion capture, a camera view that is generally informative may nevertheless produce erroneous 2D detections during particular movements or periods of occlusion. These localized errors can substantially degrade the triangulated 3D trajectory. One approach is to exclude the affected camera from the entire recording; however, this also removes the many valid observations contributed by that camera at other frames and keypoints. To retain these usable observations, we implemented an optional progressive outlier-rejection procedure that excluded individual camera observations locally during triangulation rather than removing a camera view globally.

For each keypoint and frame, an initial 3D position was estimated using all available camera views, and the mean reprojection error was calculated. When this error exceeded a specified threshold, the keypoint was retriangulated using each possible subset formed by omitting one camera. The leave-one-camera-out solution with the lowest mean reprojection error was compared with the original all-camera solution. When excluding one camera produced a sufficiently large reduction in reprojection error, the refined estimate was used; for intermediate improvements, the original and refined estimates were blended to reduce abrupt transitions between reconstruction solutions.

Outlier rejection was enabled only for recordings in which the default reconstruction contained substantial artifacts attributable to a camera view. Each recording's default (all-camera) reconstruction was visually inspected alongside the annotated 2D videos from each camera view. The procedure was enabled when artifacts in the 3D trajectories (e.g., abrupt spatial discontinuities or anatomically implausible excursions) could be traced to visibly erroneous 2D keypoint estimates in a specific camera view, rather than being attributed to 2D estimation failure by inference alone. This determination was based solely on the quality of the markerless reconstruction and was made independently of agreement with the marker-based reference.

When enabled for a recording, the same procedure was applied to MediaPipe, RTMPose, and ViTPose reconstructions. In these cases, the procedure recovered usable reconstructions that would otherwise have required exclusion while preserving valid observations from the affected camera views.

The reconstructed trajectories were subsequently processed using SkellyForge, FreeMoCap's post-processing package. Short gaps are interpolated when no acceptable triangulation solution is available for a frame, after which the coordinate trajectories are low-pass filtered using a Butterworth filter to attenuate high-frequency noise. The resulting data consist of temporally continuous 3D keypoint trajectories expressed in the shared coordinate system established during calibration.

== Validation Procedure

A broad overview of the procedure is found in @fig-methods-overview.

#figure(
  image("figures/methods/validation_procedure_elife.png", width:100%),
  caption: [Overview of experimental design and data processing methods. *A.* Six generic USB webcams were placed circularly around the treadmill and connected to a single PC, with the FreeMoCap software used for video acquisition. The cameras were calibrated using a ChArUco board measuring 1016 x 698.5 mm (40 x 27.5 in), with a square size of 126 mm. *B.* Participants completed two trials each of the gait and balance assessments while being recorded simultaneously by the markerless and marker-based motion capture systems. *C.* Markerless video data were processed using three pose estimation backends: MediaPipe, RTMPose, and ViTPose. The resulting 2D keypoint detections were triangulated into 3D joint-center trajectories using the FreeMoCap pipeline. *D.* Marker-based trajectories were labeled and cleaned, and anatomical joint centers were calculated from the marker trajectories. *E.* Markerless and marker-based trajectories were temporally aligned using cross-correlation and transformed into a common spatial coordinate system. *F.* The aligned markerless and marker-based joint-center trajectories were used for task-specific comparisons and statistical analyses.]
) <fig-methods-overview>

=== *Participants*

6 participants (5 male, 1 female) were recruited in this study. All participants were healthy adults with no reported musculoskeletal or neurological impairments affecting gait. The participants provided informed consent and the protocol was approved by the Northeastern University IRB (\#19-08-27).

=== *Experimental Setup*

==== *Marker-based motion capture*

The marker-based system consisted of 9 Miqus M3 and 2 Oqus 700+ cameras (300 Hz) and tracked the positions of 48 markers. Four markers were affixed to a head cap (top, front, left, right). An additional marker was placed on the C7 vertebra. Trunk markers were placed on the sternum, right lower back, and bilaterally on the acromion processes and on the anterior and posterior aspects of the shoulders. Upper extremity markers were placed bilaterally on the medial and lateral humeral epicondyles, the ulnar and radial styloid processes, and dorsum of the hands. Pelvic markers were placed bilaterally on the anterior superior iliac spines (ASIS), iliac crests, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the left and right posterior superior iliac spines (PSIS) and the sacrum. Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles, medial and lateral malleoli, calcanei, 1st and 5th metatarsal heads, and dorsal aspect of the second metatarsal. 

==== *Markerless motion capture*

The markerless system consisted of six consumer-grade cameras (\$20 USB webcams,  1280x720 resolution, 30Hz) arranged in a circle around the capture volume. Cameras were positioned to maximize multi-view coverage of the participant. Two cameras were aligned with the frontal plane, positioned anterior and posterior to the participant. The remaining four cameras were placed at approximately 45° oblique angles relative to the sagittal plane. Camera positions were standardized across participants using floor markers, while camera height and orientation were adjusted for each participant to optimize visibility and reduce occlusion. 

All cameras were connected to a single acquisition computer. Video capture was performed using the FreeMoCap software. Because both FreeMoCap and Qualisys recordings were acquired on the same computer, timestamps from each system were referenced to a shared system clock, enabling temporal alignment between datasets.

Prior to recording, cameras were calibrated using a ChArUco calibration board (square size: 126 mm, board size: 1016 x 698.5 mm). At the start of each recording, the board was placed flat on the floor within view of all cameras to define the reference frame of the reconstruction (ground plane alignment). The origin of the capture volume was set using the board, and the reconstructed 3D data were aligned such that the vertical axis corresponded to the Z-axis, with the horizontal plane defined as $Z = 0$.   

=== *Data Collection
*
Each participant completed two trials of both the gat and balance tasks. At the start of each trial, participants assumed an "A-pose", a neutral position with feet slightly apart, head up, and arms angled downward at roughly 45 degrees for a few seconds. 

==== *Gait*
Participants walked on a treadmill at progressively increasing speeds. The treadmill increased in 0.50 m/s increments every 30 seconds, starting from rest until 2.50 m/s. Prior to data collection, participants were given time to familiarize themselves with the treadmill and each speed condition.

==== *Balance*
Participants were asked to complete the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M) @ModifiedClinicalTest2013. This test consists of four 60-second conditions that vary participant visual condition (i.e., standing with eyes open vs. eyes closed) and standing surface (i.e., standing on a solid surface vs. a foam pad; ProsourceFit Exercise Balance Pad): (1) Eyes Open/Solid Ground; (2) Eyes Closed/Solid Ground; (3) Eyes Open/Foam Pad; (4) Eyes Closed/Foam Pad. Participants stood with hands at their sides. To minimize camera occlusions, participants were asked to place feet shoulder-width apart. This placement has been shown to have little effect on CTSIB-M scoring @wrisleyEffectFootPosition2004.

The CTSIB-M was selected because: 1) Static balance tasks present minimal body movement, providing a method of measuring system sensitivity to small-amplitude kinematics; 2) The graded condition structure allows evaluation of whether particular postural challenges affect system accuracy.

Participants were given a visual fixation target during eyes-open conditions and a floor mark to standardize starting position. Participants completed two trials of the full protocol, each recorded simultaneously by both the marker-based and markerless motion capture systems.

=== *Data Processing*

==== *Marker-based motion capture data*

Marker-based data were tracked, labeled and processed in QTM. Missing trajectories were interpolated using linear or relational gap-filling. The labeled and cleaned marker positions were exported as a `.tsv` file containing system timestamps. Head, elbow, wrist, knee and ankle joint centers were defined as the midpoint of their respective medial and lateral markers. Shoulder joint centers were defined as the midpoint of the anterior and posterior markers. The hip joint centers were estimated using the methods described by Bell et al. @bellPredictionHipJoint1989. Raw kinematic data were filtered using a zero-lag, fourth-order Butterworth filter with a 6 Hz cutoff frequency. 

==== *Markerless motion capture data*

_Pose estimation_

Synchronized videos were processed using the FreeMoCap pipeline (v1.7.4). Two-dimensional keypoints were estimated using MediaPipe @lugaresiMediaPipeFrameworkBuilding2019 (mediapipe v0.10.14), RTMPose @jiangRTMPoseRealTimeMultiPerson2023 (rtmlib v0.0.14), and ViTPose @xuViTPoseSimpleVision2022, implemented using the easy_ViTPose repository. RTMPose was run using its WholeBody configuration (mode = `performance`), with RTMDet used for person detection. ViTPose used the ViTPose-H WholeBody model (vitpose-h-wholebody.pth), with YOLOv8 medium (yolov8m.pt) used to detect person bounding boxes in every frame. Both models produced the COCO-WholeBody 133-keypoint topology. MediaPipe was implemented using the Holistic solution with the heavy pose model. MediaPipe Holistic jointly estimated body, hand, and facial landmarks. Although all three backends produced keypoints beyond those required for the present study, only body keypoints were retained for subsequent reconstruction and analysis.

The backends also differed in their temporal processing. RTMPose and ViTPose estimated poses independently in each frame, whereas MediaPipe was run in video mode (static_image_mode = false) with landmark smoothing enabled (smooth_landmarks = true). In the legacy MediaPipe Holistic solution, temporal landmark smoothing is conditional on both settings: it is disabled either when static-image mode is enabled or when landmark smoothing is turned off. Thus, settings that may appear to be minor implementation details can alter the temporal characteristics of the resulting trajectories and, consequently, their validation against a reference system. Complete model and inference configurations for all three pose-estimation backends are therefore reported in #appendixtableref("tracker-config").

_Triangulation and post-processing_

Corresponding 2D keypoints from the synchronized camera views were triangulated into 3D coordinates using the calibrated camera projection matrices and direct linear transformation. 

In multiview markerless motion capture, a camera view that is generally informative may nevertheless produce erroneous 2D detections during particular movements or periods of occlusion. These localized errors can substantially degrade the triangulated 3D trajectory. One approach is to exclude the affected camera from the entire recording; however, this also removes the many valid observations contributed by that camera at other frames and keypoints. To retain these usable observations, we implemented an optional progressive outlier-rejection procedure that excluded individual camera observations locally during triangulation rather than removing a camera view globally.

For each keypoint and frame, an initial 3D position was estimated using all available camera views, and the mean reprojection error was calculated. When this error exceeded a specified threshold, the keypoint was retriangulated using each possible subset formed by omitting one camera. The leave-one-camera-out solution with the lowest mean reprojection error was compared with the original all-camera solution. When excluding one camera produced a sufficiently large reduction in reprojection error, the refined estimate was used; for intermediate improvements, the original and refined estimates were blended to reduce abrupt transitions between reconstruction solutions.

Outlier rejection was enabled only for recordings whose default reconstruction contained substantial 3D artifacts. Each recording's default (all-camera) reconstruction was visually inspected alongside the annotated 2D videos from each camera view. The procedure was enabled when artifacts in the 3D trajectories (e.g., abrupt spatial discontinuities or anatomically implausible excursions) could be traced to visibly erroneous 2D keypoint estimates in a specific camera view, rather than being attributed to 2D estimation failure by inference alone. This determination was based solely on the quality of the markerless reconstruction and was made independently of agreement with the marker-based reference.

When enabled for a recording, the same procedure was applied to MediaPipe, RTMPose, and ViTPose reconstructions. In these cases, the procedure recovered usable reconstructions that would otherwise have required exclusion while preserving valid observations from the affected camera views.

Following reconstruction, gaps in the 3D trajectories were interpolated, and the trajectories were low-pass filtered using a zero-phase, fourth-order Butterworth filter with a cutoff frequency of 6 Hz.

==== *Data synchronization and alignment*

Joint center trajectories from marker-based and markerless systems were temporally aligned using recorded Unix timestamps from both systems, which were generated on the same acquisition computer. Marker-based data were resampled to match the markerless sampling rate (30 Hz). Residual temporal offsets were further refined using cross-correlation of joint trajectories, followed by manual inspection. 

Markerless data were spatially aligned to the marker-based reference frame using a least-squares optimized rigid transformation that minimized joint center errors between systems. The transformation consisted of three rotational $(r_x, r_y, r_z)$ and three translation $(t_x, t_y, t_z)$ parameters. 

To identify a transformation that was consistent over the full recording, candidate transformations were estimated from randomly sampled subsets of frames  and evaluated across the entire dataset. The transformation that minimized the global joint center error across all frames was selected for each trial.

=== *Data Analysis: Gait*
==== *Joint angles*

Joint angles were calculated as the Cardan XYZ decomposition of the relative rotation between adjacent segments. Sagittal-plane lower-body kinematics were extracted and analyzed across gait cycle-normalized strides. Joint angles were offset-corrected by subtracting the mean angle measured during the neutral A-pose stance at the start of each trial.

==== *Gait event detection*

Heel strike and toe off events were identified based on anteroposterior velocity zero-crossings of the foot, using the methods described by Zeni et al. @zeniTwoSimpleMethods2008a. Marker-based gait events were used as the reference for time-normalizing to 0-100% of the gait cycle for all pose-estimated derived trajectories and joint angles.

==== *Gait parameters*

Spatiotemporal parameters were calculated for each system using their respective gait events. The following gait parameters were calculated: [UPDATE]

1) *Stance duration:* The time from *heel strike to subsequent toe off* of the same foot in milliseconds (ms).

2) *Swing duration:* The time from *toe off to subsequent heel strike* of the same foot in milliseconds (ms).

3) *Stride duration:* The time from *heel strike to subsequent heel strike* of the same foot in milliseconds (ms).

4) *Step length:* The *anteroposterior distance between the contralateral ankle at contralateral heel strike and the ipsilateral ankle at the subsequent ipsilateral heel strike*, reported in millimeters (mm). To account for the treadmill, step length was corrected using the distance traveled by the belt. Distance traveled by the belt was computed using the treadmill speed and the time between heel strikes.

5) *Stride length:* The *anteroposterior distance between the ipsilateral ankle at ipsilateral heel strike and the same joint at the subsequent ipsilateral heel strike*, reported in millimeters (mm). To account for the treadmill, stride length was corrected using the distance traveled by the belt. Distance traveled by the belt was computed using the treadmill speed and the time between heel strikes.

==== *Statistical analyses*

Statistical analyses were performed using Python `v3.11`. Root mean squared error (RMSE) was calculated across all gait cycle-normalized joint center trajectories and joint angles. Per-trial RMSE was obtained by averaging across strides within a trial, and mean ± SD were then computed across all trials.

To identify regions of significant difference between the marker-based reference and each pose estimation backend, statistical parametric mapping (SPM) two-tailed paired t-tests were performed on gait cycle-normalized joint angles using the `spm1d` package. SPM extends hypothesis testing to an entire timeseries, identifying continuous regions where differences exceed a critical threshold. SPM{t} statistics were computed across the gait cycle, and statistical significance was assessed at $alpha = 0.05$. 

For each gait parameter, Bland-Altman plots with bias and 95% limits of agreement (LOA) were created @blandStatisticalMethodsAssessing1986. Intraclass correlation coefficients (ICC(2,1)) were calculated using the `pingouin` package to assess agreement @shroutIntraclassCorrelationsUses1979. ICC values under 0.5 were interpreted as poor agreement, 0.5-0.75 interpreted as moderate agreement, 0.75-0.90 as good agreement, and greater than 0.90 as excellent agreement @kooGuidelineSelectingReporting2016. Bland-Altman and ICC values were calculated across all speeds as well as per walking speed.

=== *Data Analysis: Balance*

==== *Center of mass (COM) calculation*

For the reference system and each pose estimation backend, body segments were defined with segment mass fractions and COM locations according to the anthropometric tables reported by Winter @winterBiomechanicsMotorControl2009. Anthropometric data were used to calculate segment COM position. Total-body COM was calculated as the mass-weighted average of all segment COM coordinates. 

==== *Center of mass path length*

Using a custom-built viewer (available at: https://github.com/aaroncherian/nih_balance_analyses), each trial was annotated with the start and stop frame numbers for each of the four conditions. 1600 frames were analyzed per standing condition within a trial. Within each condition, COM path length was calculated as the cumulative sum of the Euclidean distance between consecutive 3D COM positions. 


==== 

* Postural metrics *

The 95% confidence ellipse area, a measure often used in posturography, is the area that is expected to enclose approximately 95% of the points on the COM path @prietoMeasuresPosturalSteadiness1996. The ellipse axes were derived from the decomposition of the 2D position covariance matrix. Semi-axis lengths were scaled to enclose 95% of the data. The scaling factor ($chi^2_(0.95, 2) approx 5.991$) is derived from the chi-squared distribution with two degrees of freedom @schubertEllipseAreaCalculations2014.  Ellipse area was then calculated as $pi a b$, where $a$ and $b$ are the scaled semi-axis lengths.

COM velocity was calculated per axis as the frame-to-frame displacement of COM position divided by the sampling interval. Mean 2D COM velocity in the horizontal plane was then calculated as the trial-level mean of the magnitude of the mediolateral and anteroposterior velocity components.

==== *Noise characterization*

During quiet standing, vertical COM displacement is expected to be minimal, making vertical velocity a useful indicator of measurement noise. Trial-wise standard deviations of vertical COM velocity were calculated for the Eyes Open/Solid Ground condition and summarized across participants (mean ± SD) to characterize the baseline noise floor of each pose estimation backend and the marker-based reference system under minimal-movement conditions.

==== *Sensitivity analysis* 
 
For markerless and marker-based systems, we calculated within-participant COM path length differences between conditions representing specific perturbations: 1) *Visual perturbation* using the path length difference between the Eyes Open/Solid Ground and Eyes Closed/Solid Ground conditions; 2) *Proprioceptive perturbation* using the path length difference between Eyes Open/Solid Ground and Eyes Open/Foam conditions; 3) *Combined visual/proprioceptive perturbation* using the path length difference between Eyes Open/Solid Ground and Eyes Closed/Foam conditions. For each perturbation, markerless path length differences were compared to marker-based path length differences using linear regression, and we report slope alongside r².

==== *Statistical analyses*
To assess accuracy between the markerless and marker-based reference systems, we calculated Bland-Altman statistics with bias and 95% limits of agreement (LoA) alongside intraclass correlation coefficients (ICC (2,1)), using the packages and interpretations described above. 

=== *Data Analysis: Scaling
*
To assess whether systematic scaling differences were present between pose estimation outputs and the marker-based reference, we extended our spatial optimization to include an additional uniform scaling parameter ($s$). In this formulation, the transformation consisted of rotation, translation, and a single global scale factor applied isotropically across all spatial dimensions. 

For each trial, the optimal scale factor was estimated alongside the rigid transformation parameters by minimizing joint center error. These scale factors were not applied to the data used in downstream analyses but instead were recorded as a diagnostic measure of potential scale bias between systems.

A scale factor of $s = 1.0$ indicates no global scaling difference between systems, whereas deviations from 1.0 reflect a uniform expansion or contraction of the reconstructed markerless skeleton relative to the reference.