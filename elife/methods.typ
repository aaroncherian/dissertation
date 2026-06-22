#import "elife.typ": *

= Materials and Methods

== FreeMoCap Software
FreeMoCap @queenFreeMoCapFreeOpen2024 is a fully open-source markerless motion capture framework that prioritizes accessibility at every level of the pipeline. It is built to work with consumer-grade webcams, requires no physical markers or specialized recording environment, and provides a complete processing pipeline from synchronized video acquisition through 3D kinematic reconstruction (@fig-fmc-pipeline). The architecture is modular and tracker-agnostic, allowing users to swap between pose estimation backends depending on their needs.

FreeMoCap follows a polyrepo structure, where each component of the motion capture pipeline is handled by an independent repository. We detail below the steps in the FreeMoCap pipeline, including synchronized video acquisition, camera calibration, 2D pose estimation, and 3D reconstruction. 


#figure(
  image("figures/methods/freemocap_pipeline.png", width: 110%),
  caption: [PLACEHOLDER]
) <fig-fmc-pipeline>

=== *Synchronized Video Acquisition*
Synchronous video recording refers to the acquisition and temporal alignment of video
streams. For accurate 3D reconstruction, each set of frames must correspond to the same
moment in time. Without proper synchronization, time lags between cameras can result in
inaccurate 3D data.

In FreeMoCap, synchronous recording is handled primarily by `SkellyCam`, a software package to provide high quality synchronous recording methods that enable the use of low-cost hardware - specifically consumer-grade, off-the-shelf webcams. However, these cameras may not be suitable for all research needs (e.g., capturing athletic performance which may necessitate higher frame rate cameras or outdoor recordings, which may require non-USB cameras). The software accommodates these use cases in two ways: 1) Videos collected from a set of external cameras (e.g., GoPros or smartphone cameras) can be synchronized using light and audio-based methods; 2) A pre-synchronized set of videos can be directly imported into the software for processing. We aim to reduce dependency on specific hardware configurations and allow data collection protocols to be adapted to the needs of the study, rather than constrained by the system itself.

=== *Camera Calibration*
In order to reconstruct 3D data from the 2D camera images, it is necessary to determine how
each camera observes the world and where it is positioned within it. The former describes
intrinsic parameters (i.e., how each camera maps light onto its image sensor). The latter
describes extrinsic parameters (i.e., the position and orientation of each camera relative to a common world reference frame). Camera calibration is the process of calculating the intrinsic and extrinsic parameters of a set of cameras, establishing the geometric relationships required to project 2D image features into a shared 3D coordinate system.

Calibration and 3D reconstruction are implemented in FreeMoCap using a modified implementation of the Anipose toolkit @AniposeToolkitRobust2021. The calibration tool is a ChArUco board, a hybrid calibration target consisting of a checkerboard pattern overlaid with uniquely identifiable ArUco markers (Figure 3.2). This board can be printed on standard paper and mounted to a rigid surface, or printed directly onto a rigid board.

#figure(
  image("figures/methods/calibration_methods.png", width: 100%),
  caption: [*A.* A ChArUco board being  detected during a frame of calibration. Each marker on the board (known as an ArUco marker) has a unique ID that can be detected, and subsequently each corner between a pair of markers also has associated IDs. The detected corner IDs are annotated in blue on the image. *B.* Estimation of intrinsics and extrinsics from a calibration board. The world origin is defined as the first corner of the board, and using the known square size the 3D world coordinates of detected points can be found.]
)

During calibration, the ChArUco board is moved throughout the capture volume while
ensuring visibility to multiple cameras simultaneously. Varying the board’s position and
orientation, particularly introducing changes in depth and tilt, improves the robustness
of intrinsic and extrinsic parameter estimation. The board should be mounted on a rigid
surface, as flexing of the board can cause errors in parameter estimation. Additionally,
during calibration, care should be taken to avoid bright lights that may cause glare on the
board. For this reason we recommend printing on matte (non-glossy) material.

At the start of the recording, the ChArUco board may be placed flat on the ground within
the shared field of view of all cameras, in what we term ground plane calibration. In this
configuration, the plane of the board defines the reference coordinate system for reconstruction. Reconstructed 3D data are expressed in a coordinate frame where the ground plane corresponds to $Z=0$ and the orientation of the axes is aligned with the board. This initialization ensures that reconstructed kinematic data are immediately situated within a physically meaningful coordinate system, reducing the need for post hoc alignment or rotation.

=== *Pose Estimation*

Pose estimation is a computer vision task that identifies meaningful keypoints within an
image. In human pose estimation, these keypoints typically correspond to joint centers.
In practice, pose estimation produces 2D keypoint locations in pixel coordinates for each
camera and frame of a recording. 

#figure(
  image( "figures/methods/pose_estimation_examples.png", width: 100%),
  caption: [Examples of landmarks estimated on a human body from three different pose estimation algorithms. *Left*: MediaPipe; *Middle*: RTMPose; *Right*: ViTPose.],
)

In modern markerless motion capture systems, pose estimation has become a critical aspect of the architecture. However, there are challenges to consider in the choice of pose estimation software. First is accuracy. Errors in 2D keypoint localization propagate directly into 3D kinematic estimates, and accuracy differs between pose estimation algorithms  @needhamAccuracySeveralPose2021 @ceriolaComparativeAnalysisMarkerless2024 @washabaughComparingAccuracyOpensource2022. Many general-purpose algorithms are not optimized for movement science applications, as their underlying datasets may lack biomechanical relevance or sufficient representation of specific populations @seethapathiMovementScienceNeeds2019 @needhamAccuracySeveralPose2021.

This leads to the second challenge: integration. Even when suitable pose estimation models exist, integrating them into motion capture pipelines remains challenging. Many systems are tightly coupled to a single backend. Thus, researchers looking to implement a specific pose estimation model must often implement their own pipelines from the ground up. 

`SkellyTracker`, the pose estimation manager for FreeMoCap, is a framework that decouples pose estimation from the rest of the processing pipeline. The software defines a standardized interface for pose estimation models, allowing new trackers to be integrated by implementing this interface. As a result, different pose estimation algorithms can be used interchangeably within the same pipeline without requiring changes to downstream processing steps. 

The default FreeMoCap pipeline utilizes MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, a free, open-source framework based on the CNN BlazePose @bazarevskyBlazePoseOndeviceRealtime2020. We selected MediaPipe on the basis of practicality and accessibility. MediaPipe is simple to install and interface with using Python scripts. It is also computationally lightweight, and can be run on a CPU-only computer. Thus, of many available options, MediaPipe makes our software the most accessible for the widest range of users.

As the software interface allows pose estimation backends to be swapped without any change to the rest of the pipeline, we can directly compare how different algorithms perform under identical conditions (i.e., using the same cameras, calibration, reconstruction and post-processing). These comparisons can aid in detailed benchmarking of pose estimation algorithms in markerless motion capture, a noted need by the research community @needhamAccuracySeveralPose2021.

=== *3D Reconstruction*

The final key step in the markerless motion capture pipeline is triangulating 2D keypoint
detections into 3D coordinates (@fig-reconstruction). For each frame, the camera projection matrices estimated
during calibration and the 2D keypoint detections from each camera view are used to solve
for the 3D position of each keypoint via direct linear transformation (DLT), using a modified implementation of the Anipose toolkit @AniposeToolkitRobust2021. 

#figure(
  image("figures/methods/reconstruction.png", width: 100%),
  caption: [3D reconstruction via triangulation. Each camera detects points P₁ and P₂ in its image as 2D pixel coordinates. Using each camera's intrinsic and extrinsic parameters, these pixel detections define rays extending from each camera into the world. The 3D position of each point is estimated where the corresponding rays from multiple cameras converge.]) <fig-reconstruction>

Data is post-processed using `SkellyForge`, a post-processing package that applies gap interpolation for frames where no acceptable triangulation solution was found, followed by low-pass Butterworth filtering to attenuate high-frequency noise in the coordinate time series

== Validation Procedure

=== *Participants*

6 participants (5 male, 1 female) were recruited in this study. All participants were healthy adults with no reported musculoskeletal or neurological impairments affecting gait. The participants provided informed consent and the protocol was approved by the Northeastern University IRB (\#19-08-27).

=== *Experimental Setup*

==== *Marker-based motion capture*

The marker-based system consisted of 9 Miqus M3 and 2 Oqus 700+ cameras (300 Hz) and tracked the positions of 48 markers. Four markers were affixed to a head cap (top, front, left, right). An additional marker was placed on the C7 vertebra. Trunk markers were placed on the sternum, right lower back, and bilaterally on the acromion processes and on the anterior and posterior aspects of the shoulders. Upper extremity markers were placed bilaterally on the medial and lateral humeral epicondyles, the ulnar and radial styloid processes, and dorsum of the hands. Pelvic markers were placed bilaterally on the anterior superior iliac spines (ASIS), iliac crests, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the left and right posterior superior iliac spines (PSIS) and the sacrum. Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles, medial and lateral malleoli, calcanei, 1st and 5th metatarsal heads, and dorsal aspect of the second metatarsal. 

==== *Markerless motion capture*

The markerless system consisted of six consumer-grade cameras (\$20 USB webcams,  1280x720 resolution, 30Hz) arranged in a circle around the capture volume. Cameras were positioned to maximize multi-view coverage of the participant. Two cameras were aligned with the frontal plane, positioned anterior and posterior to the participant. The remaining four cameras were placed at approximately 45° oblique angles relative to the sagittal plane. Camera positions were standardized across participants using floor markers, while camera height and orientation were adjusted for each participant to optimize visibility and reduce occlusion. 

All cameras were connected to a single acquisition computer. Video capture was performed using the FreeMoCap software. Because both FreeMoCap and Qualisys recordings were acquired on the same computer, timestamps from each system were referenced to a shared system clock, enabling temporal alignment between datasets.

Prior to recording, cameras were calibrated using a ChArUco calibration board (square size: 126 mm, board size: 40" x 27.5"). At the start of each recording, the board was placed flat on the floor within view of all cameras to define the reference frame of the reconstruction (ground plane alignment). The origin of the capture volume was set using the board, and the reconstructed 3D data were aligned such that the vertical axis corresponded to the Z-axis, with the horizontal plane defined as $Z = 0$.   

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

Synchronized videos were processed using the FreeMoCap pipeline (v1.7.4). 2D body keypoints were detected using MediaPipe @lugaresiMediaPipeFrameworkBuilding2019 (`mediapipe`: v0.10.14),  RTMPose @jiangRTMPoseRealTimeMultiPerson2023 (`rtmposelib`: v0.0.14), and ViTPose @xuViTPoseSimpleVision2022 (implemented using the `easy_ViTPose` Github repository) pose estimation software. Corresponding keypoints were triangulated into 3D space. 3D data were filtered using a zero-lag, fourth-order Butterworth filter with a 6 Hz cutoff frequency.

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

To identify regions of significant difference between the marker-based reference and each pose estimation backend, statistical parametric mapping (SPM) two-tailed t-tests were performed on gait cycle-normalized joint angles using the `spm1d` package. SPM extends hypothesis testing to an entire timeseries, identifying continuous regions where differences exceed a critical threshold. SPM{t} statistics were computed across the gait cycle, and statistical significance was assessed at $alpha = 0.05$. 

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