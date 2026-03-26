== Methods

=== Participants

6 participants (5 male, 1 female) were recruited in this study. Prior to the experiments, participants signed an informed consent form approved by the IRB. Participants wore tight-fitting clothing and were equipped with the full-body marker set after arrival. 

=== Experimental setup
The experimental setup for the marker-based and markerless motion capture systems follows the protocol written out in Chapter XXXX: Methods for gait.


*Data Collection*

Participants followed the protocol of the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M) @ModifiedClinicalTest2013. The CTSIB-M was selected because static balance tasks involve minimal body movement, providing a test of system sensitivity to small-amplitude kinematics, and because the graded condition structure allows evaluation of whether system accuracy varies with increasing postural challenge.

Participants stood with hands at their sides and completed four 60-second conditions: (1) firm surface, eyes open; (2) firm surface, eyes closed; (3) foam pad, eyes open; (4) foam pad, eyes closed. Feet were placed shoulder-width apart to minimize camera occlusions; this foot position has been shown to have little effect on CTSIB-M scoring @wrisleyEffectFootPosition2004. 

Participants were given a visual fixation target during eyes-open conditions and a floor mark to standardize starting position. A hand clap at the start of each condition provided a visual synchronization reference in the video recordings. Participants completed two trials of the full protocol, each recorded simultaneously by both the marker-based and markerless motion capture systems.

=== Data Processing

Data processing for marker-based and markerless data, including temporal synchronization and alignment procedures follows the procotol written out in Chapter XXXX: Methods for gait. 

=== Data Analysis

*Center-of-mass (COM) calculation*

For the reference system and each pose estimation backend, body segments were defined with segment mass fractions and COM locations according to the anthropometric tables reported by Winter @winterBiomechanicsMotorControl2009. Segment COM position was calculated along each segment using these definitions, and total-body COM was calculated as the mass-weighted average of all segment COM coordinates. 

*Center of mass path length*

Using a custom-built viewer (cite NIH), each trial was annotated with the start and stop frame numbers for each of the four conditions. The same number of frames was used for each condition, for every trial. Within each condition, COM path length was calculated as the sum of the Euclidean distance between consecutive 3D COM position. 

*Center of mass velocity distributions*

COM velocity was calculated as the frame-to-frame displacement of COM position divided by the sampling rate. Mean 2D COM velocity in the horizontal plane was calculated as the trial-level mean of the magnitude of mediolateral and anteroposterior velocity components. Trial-wise standard deviations of vertical COM velocity were calculated for the eyes-open, firm-surface condition and summarized across participants (mean ± SD) to estimate baseline variability under minimal-movement conditions.

*Sensitivity analysis* 
 
For each system and the marker-based reference, we calculated within-participant COM path length differences between conditions representing specific perturbations:visual perturbation using the difference between the Eyes Open/Solid Ground and Eyes Closed/Solid Ground conditions, proprioceptive perturbation using the difference between Eyes Open/Solid Ground and Eyes Open/Foam conditions, and combined visual/proprioceptive perturbation using the difference between Eyes Open/Solid Ground and Eyes Closed/Foam conditions. We then fit a regression line and report slope alongside $r^2$.

*Statistical analyses*
 
Statistical analyses were performed using Python `v3.11`. To assess accuracy between the markerless and marker-based reference, we calculated Bland-Altman statistics with bias and 95% limits of agreement (LoA) @blandStatisticalMethodsAssessing1986 alongside intraclass correletion coefficients (ICC (2,1)) using the `pingouin` package @shroutIntraclassCorrelationsUses1979. ICC values were interpreted as: poor (\<0.50), moderate (0.50-0.75), good (0.75-0.90), and excellent (\>0.90) @kooGuidelineSelectingReporting2016. We also fit a regression line and report slope. 

