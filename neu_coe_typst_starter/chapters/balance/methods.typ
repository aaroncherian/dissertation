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

Participants followed the protocol of the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M) @ModifiedClinicalTest2013. The CTSIB-M was selected because static balance tasks involve minimal body movement, providing a test of system sensitivity to small-amplitude kinematics, and because the graded condition structure allows evaluation of whether system accuracy varies with increasing postural challenge.

Participants stood with hands at their sides and completed four 60-second conditions: (1) firm surface, eyes open; (2) firm surface, eyes closed; (3) foam pad, eyes open; (4) foam pad, eyes closed. Feet were placed shoulder-width apart to minimize camera occlusions; this foot position has been shown to have little effect on CTSIB-M scoring @wrisleyEffectFootPosition2004. 

Participants were given a visual fixation target during eyes-open conditions and a floor mark to standardize starting position. A hand clap at the start of each condition provided a visual synchronization reference in the video recordings. Participants completed two trials of the full protocol, each recorded simultaneously by both the marker-based and markerless motion capture systems.

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

*Center of mass path length*

Using a custom-built viewer (cite NIH), each trial was annotated with the start and stop frame numbers for each of the four conditions. The same number of frames was used for each condition, for every trial. Within each condition, COM path length was calculated as the sum of the Euclidean distance between consecutive 3D COM position. 

*Center of mass velocity distributions*

COM velocity was calculated as the frame-to-frame displacement of COM position divided by the sampling rate. Mean 2D COM velocity in the horizontal plane was calculated as the trial-level mean of the magnitude of mediolateral and anteroposterior velocity components. Vertical velocity SD on firm ground during the Eyes Open/Solid Ground conditions was used as an estimate of system measurement noise. 

*Sensitivity analysis* 
 
For each system and the marker-based reference, we calculated within-participant COM path length differences between conditions representing specific perturbations:visual perturbation using the difference between the Eyes Open/Solid Ground and Eyes Closed/Solid Ground conditions, proprioceptive perturbation using the difference between Eyes Open/Solid Ground and Eyes Open/Foam conditions, and combined visual/proprioceptive perturbation using the difference between Eyes Open/Solid Ground and Eyes Closed/Foam conditions. We then fit a regression line and report slope alongside $r^2$.

*Statistical analyses*
 
Statistical analyses were performed using Python `v3.11`. To assess accuracy between the markerless and marker-based reference, we calculated Bland-Altman statistics with bias and 95% limits of agreement (LoA) @blandStatisticalMethodsAssessing1986 alongside intraclass correletion coefficients (ICC (2,1)) using the `pingouin` package @shroutIntraclassCorrelationsUses1979. ICC values were interpreted as: poor (\<0.50), moderate (0.50-0.75), good (0.75-0.90), and excellent (\>0.90) @kooGuidelineSelectingReporting2016. We also fit a regression line and report slope. 

