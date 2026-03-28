== Methods

=== Participants

6 participants (5 male, 1 female) were recruited in this study. All participants were healthy adults with no reported musculoskeletal or neurological impairments affecting gait. The participants provided informed consent and the protocol was approved by the Northeastern University IRB (\#19-08-27).

=== Experimental setup
The experimental setup for the marker-based and markerless motion capture systems follows the protocol written out in Chapter 5: Methods.


*Data Collection*

Participants were asked to complete the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M) @ModifiedClinicalTest2013. This test consists of four 60-second conditions that vary participant visual condition (i.e., standing with eyes open vs. eyes closed) and standing surface (i.e., standing on a solid surface vs. a foam pad; ProsourceFit Exercise Balance Pad): (1) Eyes Open/Solid Ground; (2) Eyes Closed/Solid Ground; (3) Eyes Open/Foam Pad; (4) Eyes Closed/Foam Pad. Participants stood with hands at their sides. To minimize camera occlusions, participants were asked to place feet shoulder-width apart. This placement has been shown to have little effect on CTSIB-M scoring @wrisleyEffectFootPosition2004.

The CTSIB-M was selected because: 1) Static balance tasks present minimal body movement, providing a method of measuring system sensitivity to small-amplitude kinematics; 2) The graded condition structure allows evaluation of whether particular postural challenges affect system accuracy.

Participants were given a visual fixation target during eyes-open conditions and a floor mark to standardize starting position. Participants completed two trials of the full protocol, each recorded simultaneously by both the marker-based and markerless motion capture systems.

=== Data Processing

Data processing for marker-based and markerless data, including temporal synchronization and alignment procedures follow the protocol written out in Chapter 5: Methods. 

Markerless and marker-based joint trajectories were filtered using a zero-lag, 4th-order Butterworth low-pass filter with a 6 Hz cutoff frequency.

=== Data Analysis

*Center-of-mass (COM) calculation*

For the reference system and each pose estimation backend, body segments were defined with segment mass fractions and COM locations according to the anthropometric tables reported by Winter @winterBiomechanicsMotorControl2009. Anthropometric data was used to calculate segment COM position. Total-body COM was calculated as the mass-weighted average of all segment COM coordinates. 

*Center of mass path length*

Using a custom-built viewer (available at: https://github.com/aaroncherian/nih_balance_analyses), each trial was annotated with the start and stop frame numbers for each of the four conditions. 1600 frames were analyzed per condition (6400 per trial, two trials per participant). Within each condition, COM path length was calculated as the cumulative sum of the Euclidean distance between consecutive 3D COM positions. 

* Postural metrics *

The 95% confidence ellipse area is the area that is expected to enclose approximately 95% of the points on the COM path @prietoMeasuresPosturalSteadiness1996. Area was computed from the 2D covariance matrix of the mean-centered mediolateral and anteroposterior COM positions. The covariance matrix was eigendecomposed to obtain the principal axes of the position distribution, and the semi-axis lengths were scaled by $chi^2_(0.95, 2) approx 5.991$ to define the boundary enclosing 95% of the data under a bivariate normal assumption@schubertEllipseAreaCalculations2014. Ellipse area was then calculated as $pi a b$, where $a$ and $b$ are the scaled semi-axis lengths.

COM velocity was calculated per axis as the frame-to-frame displacement of COM position divided by the sampling interval. Mean 2D COM velocity in the horizontal plane was then calculated as the trial-level mean of the magnitude of the mediolateral and anteroposterior velocity components.


*Noise characterization*

During quiet standing, vertical COM displacement is expected to be minimal, making vertical velocity a useful indicator of measurement noise. Trial-wise standard deviations of vertical COM velocity were calculated for the Eyes Open/Solid Ground condition and summarized across participants (mean ± SD) to characterize the baseline noise floor of each pose estimation backend and the marker-based reference system under minimal-movement conditions.


*Sensitivity analysis* 
 
For markerless and marker-based systems, we calculated within-participant COM path length differences between conditions representing specific perturbations: 1) Visual perturbation using the path length difference between the Eyes Open/Solid Ground and Eyes Closed/Solid Ground conditions; 2) Proprioceptive perturbation using the path length difference between Eyes Open/Solid Ground and Eyes Open/Foam conditions; 3) Combined visual/proprioceptive perturbation using the path length difference between Eyes Open/Solid Ground and Eyes Closed/Foam conditions. For each perturbation, markerless path length differences were regressed against marker-based path length differences, and we report slope alongside r².

*Statistical analyses*
 
Statistical analyses were performed using Python `v3.11`. To assess accuracy between the markerless and marker-based reference systems, we calculated Bland-Altman statistics with bias and 95% limits of agreement (LoA) @blandStatisticalMethodsAssessing1986 alongside intraclass correlation coefficients (ICC (2,1)) using the `pingouin` package @shroutIntraclassCorrelationsUses1979. ICC values were interpreted as: poor (\<0.50), moderate (0.50-0.75), good (0.75-0.90), and excellent (\>0.90) @kooGuidelineSelectingReporting2016.

