== Methods

=== Participants

6 participants (5 male, 1 female) were recruited in this study. Prior to the experiments, participants signed an informed consent form approved by the IRB. Participants wore tight-fitting clothing and were equipped with the full-body marker set after arrival. 

=== Experimental setup
*Marker-based motion capture*
The marker-based system consisted of 9 Miqus M3 and 2 Oqus 700+ cameras (300Hz) and tracked the positions of 48 markers. Four markers were affixed to a head cap (top, front, left right). An additional marker was placed on the C7 vertebra. Trunk markers were placed on the sternum, right lower back, and bilaterally on the acromion processes and on the anterior and posterior aspects of the shoulders. Upper extremity markers were placed bilaterally on the medial and lateral humeral epicondyles and the ulnar and radial styloid processes and dorsum of the hands. Pelvic markers were placed bilaterally on the anterior superior iliac spines (ASIS), iliac crests, and greater trochanters. Posterior pelvic motion was tracked using a rigid sacral plate containing markers positioned over the left and right posterior superior iliac spines (PSIS) and the sacrum. Lower extremity markers were placed bilaterally on the medial and lateral femoral epicondyles, medial and lateral malleoli, calcanei, 1st and 5th metatarsal heads, and dorsal aspect of the second metatarsal. 
 

*Markerless motion capture*

The markerless system consisted of 6 consumer-grade cameras (USB webcams, \~\$20, 1080x720 resolution, 30Hz) arranged in a circle around the capture volume. Cameras were positioned to optimize capture of the particpant from... Cameras were plugged into the main computer. Multi-camera, synchronized video acquisition was performed using the FreeMoCap software.

Multi-camera calibration was performed prior to recording using a ChArUco calibration board. Intrinsic and extrinsic camera parameters were estimated with bundle adjustment using a modified implementation of the Anipose toolkit@AniposeToolkitRobust2021. FreeMoCap includes an option for ground-plane orientation of the data. The board was laid flat at the start of the recording. The origin was set using the board, and 3D data was rotated to match the axes, with Z pointing up in the vertical and the horizontal plane being at the floor (Z = 0). 

*Data Collection*

Participants walked on a treadmill at increasing speeds. The treadmill increased by .5m/s increments every 30 seconds, starting from rest until 2.5m/s. To familiarize participants with the treadmill and each speed, participants walked on the treadmill at each speed before recording

Participants completed two trials of the test, each being recorded simultaneously by both marker-based and markerless motion capture systems. 

=== Data Processing
*Marker-based motion capture data*

Marker-based data was tracked, labeled and processed in QTM. Missing trajectories were interpolated using linear or relational gap-filling. The labeled and cleaned marker positions were exported as a `.tsv` file containing system timestamps. Joint centers were calculated as part of the analysis pipeline (detailed below). Head, elbow, wrist, knee and ankle joint centers were defined as the midpoint of their respective medial and lateral markers. Shoulder joint centers were defined as the midpoint of the anterior and posterior markers. The hip joint centers were estimated using the Bell method @bellPredictionHipJoint1989. Raw kinematic data was filtered using a zero-lag, 4th order, 6Hz Butterworth filter. 

*Markerless motion capture data*

Synchronized videos were processed using the FreeMoCap (v.XX) pipeline described in Chapter X. 2D body keypoints were detected using MediaPipe, RTMPose and ViTPose pose estimation software. Corresponding keypoints were triangulated into 3D space. 3D data was filtered using a zero-lag, 4th order, 6Hz Butterworth filter.  

*Data synchronization and alignment*

Marker-based and markerless data joint center trajectories were temporally aligned using recorded Unix timestamps from both systems, generated from the same acquisition computer. Marker-based data were resampled to match the markerless system sampling rate (30Hz), with additional cross-correlation of joint trajectories and manual inspection used for final refinement of small residual temporal offsets. 

Markerless data were spatially aligned to the marker-based reference frame using a least-squares optimized transformation that minimized joint center errors between systems. To identify a transformation that was consistent over the full recording, candidate transformations were estimated from randomly sampled subsets of frames and evaluated across the entire dataset. 

As part of the above optimization, an optional scaling factor was introduced to identify the proper scaling needed to fit the reconstructed 3D data from each pose estimation software to the reference marker-based data. 

=== Data Analysis

*Joint Angles*

Joint angles were calculated as the Cardan XYZ decompositions of the relative rotation between adjacent segments. Lower-body kinematics (hip flexion/extension, knee flexion/extension, ankle dorsiflexion/plantarflexion) were extracted and analyzed across gait-normalized strides. 


*Gait Event Detection*

Heel-strike and toe-off events were identified based on anterior-posterior velocity zero-crossings of the foot, using the methods described by Zeni et al. @zeniTwoSimpleMethods2008a. Marker-based gait events were used as the reference for time-normalizing trajectory and joint angles across the gait cycle for marker-based data and markerless data for all pose estimation backends. 

*Gait Parameters*

Spatiotemporal parameters were calculated for each system using their respective gait events. The following gait parameters were calculated:

1) *Stance time:* The time from a given foot's heel strike event to toe off event in milliseconds (ms)

2) *Swing time:* The elapsed time from a given foot's toe off event to its next heel strike event in milliseconds (ms)

3) *Step length:* The anterior-posterior distance between the contralateral ankle at contralateral heel strike to the subsequent ipsilateral foot at the ipsilateral heel strike, reported in millimeters (mm). The ankle joint center was used to represent foot position. To account for the treadmill the distance traveled by the belt, step length was corrected by adding the distance traveled by the belt, computed from treadmill speed and the time between heel strikes.

4) *Stride length:* The anterior-posterior distance between the ipsilateral ankle at ipsilateral heel strike to the ipsilateral ankle at the subseuquent ipsilateral heel strike, reported in millimeters (mm). To account for the treadmill the distance traveled by the belt, step length was corrected by adding the distance traveled by the belt, computed from treadmill speed and the time between heel strikes.

*Statistical Analyses*

Root mean squared error (RMSE) was calculated across all gait-normalized joint center trajectories and joint angles. RMSE was calculated for each stride, averaged across strides within each trial to calculate a per-trial RMSE and then averaged across all trials to produce a single summary RMSE and standard deviation.

To test for regions of signficance difference between the marker-based reference and each pose estimation backend, SPM two-tailed t-tests performed. For each test, the SPM{t} statistics were calculated.   

For each gait parameter, Bland-Altman plots with bias and 95% limits of agreement (LOA) were created @blandStatisticalMethodsAssessing1986. Intraclass correlation coefficients (ICC2) were calculated to assess agreement @shroutIntraclassCorrelationsUses1979. ICC values under 0.5 were interpreted as poor agreement, 0.5-0.75 interpreted as moderate agreement, 0.75-0.90 as good agreement, and greater than 0.90 as excellent agreement @kooGuidelineSelectingReporting2016.  



