== Methods

=== Participants

6 participants (5 male, 1 female) were recruited in this study. All participants were healthy adults with no reported musculoskeletal or neurological impairments affecting gait. The participants provided informed consent and the protocol was approved by the Northeastern University IRB (\#19-08-27).

=== Experimental setup
*Marker-based motion capture*

The marker-based system consisted of 9 Miqus M3 and 2 Oqus 700+ cameras (300Hz) and tracked the positions of 48 markers. Four markers were affixed to a head cap (top, front, left right). An additional marker was placed on the C7 vertebra. Trunk markers were placed on the sternum, right lower back, and bilaterally on the acromion processes and on the anterior and posterior aspects of the shoulders. Upper extremity markers were placed bilaterally on the medial and lateral humeral epicondyles and the ulnar and radial styloid processes and dorsum of the hands. Pelvic markers were placed bilaterally on the anterior superior iliac spines (ASIS), iliac crests, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the left and right posterior superior iliac spines (PSIS) and the sacrum. Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles, medial and lateral malleoli, calcanei, 1st and 5th metatarsal heads, and dorsal aspect of the second metatarsal. 
 
*Markerless motion capture*

The markerless system consisted of six consumer-grade cameras (USB webcams, \~\$20, 1280x720 resolution, 30Hz) arranged in a circle around the capture volume. Cameras were positioned to maximize multi-view coverage of the participant. Two cameras were aligned with the frontal plane, positioned anterior and posterior to the participant. The remaining four cameras were placed at approximately 45° oblique angles relative to the sagittal plane. Camera positions were standardized across participants using floor markers, while camera height and orientation were adjusted for each participant to optimize visibility and reduce occlusion. 

All cameras were connected to a single acquisition computer. Video capture was performed using the FreeMoCap software. Because both FreeMoCap and Qualisys recordings were acquired on the same computer, timestamps from each system were referenced to a shared system clock, enabling temporal alignment between datasets.

Prior to recording, cameras were calibrated using a ChArUco calibration board (square size: 126mm, board size: XXX). Intrinsic and extrinsic camera parameters were estimated using a modified implementation of the Anipose calibration pipeline (see Chapter 3: Calibration for details). At the start of each recording, the board was placed flat on the floor within view of all cameras to define the reference frame of the reconstruction (ground plane alignment). The origin of the capture volume was set using the board, and the reconstructed 3D data were aligned such that the vertical axis corresponded to the Z-axis, with the horizontal plane defined as $Z = 0$.   

*Data Collection*

Participants walked on a treadmill at progressively increasing speeds. The treadmill increased in 0.50 m/s increments every 30 seconds, starting from rest until 2.5 m/s. Prior to data collection, participants were given time to familiarize themselves with the treadmill and each speed condition.

Each participant completed two trials, with all trials recorded simultaneously using both marker-based and markerless motion capture systems. At the start of each trial, participants held an "A-pose", a neutral position with feet slightly apart, head up, and arms angled downward at roughly 45 degrees. 

=== Data Processing
*Marker-based motion capture data*

Marker-based data was tracked, labeled and processed in QTM. Missing trajectories were interpolated using linear or relational gap-filling. The labeled and cleaned marker positions were exported as a `.tsv` file containing system timestamps. Head, elbow, wrist, knee and ankle joint centers were defined as the midpoint of their respective medial and lateral markers. Shoulder joint centers were defined as the midpoint of the anterior and posterior markers. The hip joint centers were estimated using the Bell method @bellPredictionHipJoint1989. Raw kinematic data was filtered using a zero-lag, 4th order, 6Hz Butterworth filter. 

*Markerless motion capture data*

Synchronized videos were processed using the FreeMoCap (v.XX) pipeline described in Chapter X. 2D body keypoints were detected using MediaPipe (v0.10.14),  (`rtmposelib`, v0.0.14) and ViTPose pose estimation software. Corresponding keypoints were triangulated into 3D space. 3D data was filtered using a zero-lag, 4th order, 6Hz Butterworth filter.  

*Data synchronization and alignment*

Joint center trajectories from marker-based and markerless systems were temporally aligned using recorded Unix timestamps from both systems, which were generated on the same acquisition computer. Marker-based data were resampled to match the markerless sampling rate (30Hz). Residual temporal offsets were further refined using cross-correlation of joint trajectories, followed by manual inspection. 

Markerless data were spatially aligned to the marker-based reference frame using a least-squares optimized transformation that minimized joint center errors between systems. To identify a transformation that was consistent over the full recording, candidate transformations were estimated from randomly sampled subsets of frames and evaluated across the entire dataset. 

=== Data Analysis

*Joint Angles*

Joint angles were calculated as the Cardan XYZ decomposition of the relative rotation between adjacent segments. Sagittal-plane lower-body kinematics were extracted and analyzed across gait-normalized strides. Joint angles were offset-corrected by subtracting the mean angle measured during the neutral A-pose stance at the start of each trial.


*Gait Event Detection*

Heel-strike and toe-off events were identified based on anterior-posterior velocity zero-crossings of the foot, using the methods described by Zeni et al. @zeniTwoSimpleMethods2008a. Marker-based gait events were used as the reference for time-normalizing both trajectory and joint angle data across the gait cycle for data derived from all pose estimation backends.

*Gait Parameters*

Spatiotemporal parameters were calculated for each system using their respective gait events. The following gait parameters were calculated:

1) *Stance time:* The time from heel strike to subsequent toe off of the same foot in milliseconds (ms)

2) *Swing time:* Time from toe off to subsequent heel strike of the same foot in milliseconds (ms)

3) *Step length:* The anterior-posterior distance between the contralateral ankle at contralateral heel strike and the ipsilateral foot at the subsequent ipsilateral heel strike, reported in millimeters (mm). The ankle joint center was used to represent foot position. To account for the treadmill the distance traveled by the belt, step length was corrected by adding the distance traveled by the belt, computed from treadmill speed and the time between heel strikes.

4) *Stride length:* The anterior-posterior distance between the ipsilateral ankle at ipsilateral heel strike and the same ankle at the subsequent ipsilateral heel strike, reported in millimeters (mm). To account for the treadmill the distance traveled by the belt, step length was corrected by adding the distance traveled by the belt, computed from treadmill speed and the time between heel strikes.

*Scaling* 

To assess systematic scaling bias, we also estimated the scaling factor that would be required to align markerless reconstructions with the marker-based reference.


*Statistical Analyses*

Statistical analyses were performed using Python `v3.11`. Root mean squared error (RMSE) was calculated across all time-normalized joint center trajectories and joint angles. RMSE was calculated for each stride, averaged across strides within each trial to calculate a per-trial RMSE and then averaged across all trials to produce a single summary RMSE and standard deviation.

To identify regions of significant difference between the marker-based reference and each pose estimation backend, statistical parametric mapping (SPM) two-tailed t-tests were performed using the `spm1d` package. SPM{t} statistics were computed across the gait cycle, and statistical significance was assessed at $alpha = 0.05$. SPM extends hypothesis testing to an entire timeseries, identifying continuous regions where differences exceed a critical threshold. 

For each gait parameter, Bland-Altman plots with bias and 95% limits of agreement (LOA) were created @blandStatisticalMethodsAssessing1986. Intraclass correlation coefficients (ICC(2,1)) using the `pingouin` package were calculated to assess agreement @shroutIntraclassCorrelationsUses1979. ICC values under 0.5 were interpreted as poor agreement, 0.5-0.75 interpreted as moderate agreement, 0.75-0.90 as good agreement, and greater than 0.90 as excellent agreement @kooGuidelineSelectingReporting2016.  


