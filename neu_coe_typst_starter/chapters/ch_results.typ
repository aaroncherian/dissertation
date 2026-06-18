#import "../template.typ": flex-caption
= Results

== Gait

Participants completed two trials of walking on a treadmill at increasing speeds, recorded simultaneously by both the markerless and marker-based motion capture system. Synchronized videos from the markerless system were processed and triangulated using three different pose estimation software: MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, RTMPose @jiangRTMPoseRealTimeMultiPerson2023, and ViTPose@xuViTPoseSimpleVision2022, resulting in three sets of 3D markerless motion capture data per trial. An example of reconstructed 3D data using each pose estimation backend is shown alongside the marker-based reference in @fig-gait-reconstruction.

#figure(
  image("results/figures/example_gait.png", width: 100%),
  caption: flex-caption([Example of markerless motion capture data using each pose estimation backend. *Left*: MediaPipe (blue); *Middle*: RTMPose (orange); *Right*: ViTPose (green). The marker-based reference skeleton is displayed in black on each panel.],
  [Example of markerless motion capture data using each pose estimation backend])
) <fig-gait-reconstruction>


== Gait: Joint kinematics error

Sagittal-plane lower-body kinematics were calculated across gait cycle-normalized strides for each pose estimation backend and walking speed. Across the gait cycle, we identified regions of significant difference between the markerless and marker-based systems using statistical parametric mapping (SPM) two-tailed t-tests. We also calculated joint angle error across joint, pose estimation backend, and walking speed. 

SPM paired t-tests ($ alpha = 0.05$) revealed common suprathreshold clusters ($t\*$ = 3.41 - 4.56 across conditions and trackers) at all joints in early stance (@fig-joint-ang-spm). At the ankle, ViTPose-derived angles exhibited widespread differences spanning much of the gait cycle. At the hip and knee, MediaPipe-derived angles exhibited suprathreshold clusters whose magnitude and duration decreased with speed. 

#figure(
  image("results/figures/joint_angles_with_spm.svg"),
  caption: flex-caption([Comparison of sagittal hip, knee, and ankle joint angles across walking speeds (0.50-2.50 m/s). Angles derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides and the gait cycle is normalized to 0-100%. Statistical parametric mapping (SPM) results are shown in the lower panels. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the marker-based reference are statistically significant (p < .05). ],
  [Lower-limb kinematics and SPM across walking speeds])
) <fig-joint-ang-spm>




#include "results/tables/joint_angle_rmse_table.typ"

== Gait: Joint position error 

Reconstructed joint center position errors for each lower-limb joint across speed, axis, and pose estimation backend are summarized in @fig-rmse-grid. Joint center errors were generally under 30 mm, with the lowest error observed in the mediolateral (ML) direction. Across joints, the hip exhibited the largest overall RMSE, with approximately 20 mm of error in both the anteroposterior (AP)and vertical directions, although the magnitude of this error was largely unaffected by walking speed. Gait cycle-normalized joint trajectories in the X (mediolateral), Y (anteroposterior), and Z (vertical) directions are shown in @fig-traj-x, @fig-traj-y, and @fig-traj-z, respectively, and specific RMSE values by joint, axis, and pose estimation backend can be found in @tbl-traj-rmse-x, @tbl-traj-rmse-y, @tbl-traj-rmse-z.

#figure(
  image("results/figures/trajectory_rmse_grid.png", width: 100%),
  caption: flex-caption([Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend. RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Rows correspond to joint centers (hip, knee, ankle, toe) and columns to pose estimation backends (MediaPipe, RTMPose, ViTPose). Error is shown separately for the mediolateral (blue), anteroposterior (orange), and vertical (green) directions. Points represent mean RMSE across all trials; error bars indicate ±1 SD. Values correspond to Tables 5.1-5.3.],
  [Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend])
) <fig-rmse-grid>


Error increased with walking speed at distal joints (particularly in the AP and vertical directions). However, this pattern was not uniform across joints and axes. For example, AP error at the knee decreased with speed for RTMPose and ViTPose-derived trajectories. Additionally, across all trackers, vertical error at the ankle remained relatively consistent.

Across trackers, RTMPose generally exhibited the lowest trajectory error, while ViTPose exhibited the highest, particularly in the vertical direction. These differences were most apparent at the ankle and toe, where ViTPose demonstrated a consistent vertical offset relative to the marker-based reference. 


== Gait: Spatiotemporal parameter agreement

We identified heel strike and toe off events and then calculated spatiotemporal gait parameters including: stance duration, swing duration, stride duration, stride length, and step length. For each gait parameter, we found Bland-Altman analyses with bais and 95% limits of agreement (LOA), and quantified agreement using intraclass correlation coefficients (ICC).  ICC values under 0.5 were interpreted as poor
agreement, 0.5-0.75 interpreted as moderate agreement, 0.75-0.90 as good agreement, and
greater than 0.90 as excellent agreement.

Spatiotemporal gait parameters, pooled across all walking speeds, showed minimal bias and excellent agreement (ICC > 0.90) with the marker-based reference (@tbl-ba-gait-pooled). Across trackers, ViTPose demonstrated near-zero bias across all parameters. RTMPose and ViTPose both exhibited tight limits of agreement (LoA), while MediaPipe showed larger deviations and wider LoA.


#include "results/tables/ba_gait_pooled.typ"


Spatial parameters showed speed-dependent agreement, with limits of agreement widening markedly as walking speed increased (e.g., ViTPose step length: ±19 to ±88 mm). Step-length ICC decreased from strong agreement at slow speeds to moderate agreement at the fastest speed, whereas stride length remained strong across speeds (ICC > 0.90). Temporal parameters behaved differently: bias and limits of agreement remained relatively consistent across speeds, with differences clustering at multiples of the 33 ms frame interval (@fig-gait-ba), but ICC still declined at higher speeds, most sharply for stance duration. Across spatial and temporal outcomes, MediaPipe-derived parameters showed the widest limits of agreement and lowest agreement, consistent with the pooled results (@tbl-ba-gait-pooled). Full speed-stratified Bland-Altman and ICC values are provided in Appendix A (@tbl-ba-gait-by-speed-spatial, @tbl-ba-gait-by-speed-temporal).

#figure(
  image("gait/figures/ba_stride_both.png", width: 100%),
  caption: flex-caption([Bland-Altman plots of stride duration (left) and stride length (right) agreement between markerless and marker-based systems. Rows correspond to each pose estimation backend (MediaPipe, RTMPose, ViTPose), and colors indicate walking speed (0.50-2.50 m/s). Dashed lines represent bias, and dash-dot lines indicate 95% limits of agreement. Stride duration differences are reported in milliseconds and stride length differences in millimeters.],
  [Bland-Altman plots of stride duration and stride length differences])
  )
 <fig-gait-ba>


== Postural stability

Participants completed two trials of the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M), where they stood for sixty seconds in four different conditions, each of which varied visual and standing conditions. These included standing with/on: 1) Eyes Open/Solid Ground; 2) Eyes Closed/Solid Ground; 3) Eyes Open/Foam Pad; 4) Eyes Closed/Foam Pad. We calculated center of mass (COM) for each set of pose estimation-derived 3D data and the reference system and calculated metrics often relevant to posturography including: center of mass path length, the 95% confidence ellipse area, and mean 3D COM velocity. @fig-xy-plane shows a representative example of the COM movement during each CTSIB-M condition plotted on the ground plane. 
n
#figure(
  image(
    "results/figures/com_xy_plane.png", width: 100%,),
    caption: flex-caption( [
    Center of mass trajectories in the horizontal plane (X = mediolateral, Y = anteroposterior) for a representative trial across all conditions and trackers. 95% confidence ellipses are overlaid for each condition. EO = Eyes Open, EC = Eyes Closed.
    ],
    [Center of mass trajectories on the horizontal plane] )
) <fig-xy-plane>

@fig-posturography shows mean and trial postural metrics per condition, for each set of 3D data. Exact values can be found in the appendix in @tbl-postural-metrics. Although ellipse area across all trackers was comparable, path length and mean velocity exhibited tracker-dependent behavior. MediaPipe-derived COM path length closely matched the reference and preserved separation across progressively more challenging conditions. In contrast, RTMPose and ViTPose-derived data overestimated path length and failed to clearly differentiate between balance conditions. Similarly, MediaPipe-derived mean velocity (in the horizontal plane) was similar to the reference, though slight underestimation was observed, while RTMPose and ViTPose-derived velocity was substantially higher.

#figure(
  image("results/figures/balance_sway_metrics.svg", width: 100%),
  caption: flex-caption([
  Trial-level and group-level postural metrics plotted across balance assessment conditions for the reference system and each markerless pose estimation backend. Black lines represent group level mean and standard deviation, while grey lines represent trial level path length (n = 12). EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad
  ],
  [Center of mass path group-level and trial-level mean path length comparison])
) <fig-posturography>


== Posture: Markerless system agreement and sensitivity

We examine the agreement of MediaPipe-derived center of mass path length to the reference, and examine differences using a Bland-Altman analysis and also examine the sensitivity of MediaPipe-derived postural sway to the different perturbations induced during the CTSIB-M ((@fig-sensitivity-and-agreement).

MediaPipe-derived path length demonstrated strong agreement with the reference system  (ICC = 0.985). Systematic bias was small (1.25 mm) with limits of agreement at approximately ± 68 mm. A slope of 0.90 indicated a proportional underestimation of the path length with Bland-Altman analyses showing progressive underestimation in harder conditions. In contrast, RTMPose and ViTPose demonstrated poor agreement (ICC < 0.10), high positive bias (726 mm and 1052 mm respectively), and wide limits of agreement. Summary metrics for comparisons across systems are shown in @tbl-path-length-agreement, and identity and Bland-Altman plots for RTMPose and ViTPose derived data can be found in the Appendix( @fig-agreement-all).  

MediaPipe-derived COM changes exhibited good-to-excellent sensitivity to different perturbations (_r_#super[2] = 0.83 - 0.96) with slope of the fitted regression line showing near one-to-one agreement (0.89 - 1.06), though slight underestimation of path length was observed under visual perturbation. ViTPose and RTMPose-derived COM changes demonstrated poor sensitivity (_r_#super[2] = 0.03 to 0.45), with proportional bias differing substantially (slope = -6.46 to 1.58) from the ideal. Identity plots per perturbation for RTMPose and ViTPose-derived data can be found in Appendix B (@fig-sensitivity-all).


#figure(
  image("results/figures/com_agreement_and_sensitivity.svg", width: 100%),
  caption: [placeholder]
) <fig-sensitivity-and-agreement>


#include "results/tables/path_length_agreement_table.typ"

#include "results/tables/path_length_sensitivity_table.typ"


== Tracker-specific error


// =====================================================================
// Supplementary Figures (relocated to end of Results)
// =====================================================================

== Supplementary Figures

#figure(
  image("results/figures/trajectories_x.svg", width: 85%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *mediolateral (X) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Mediolateral lower-limb joint center trajectories across walking speeds])
) <fig-traj-x>

#figure(
  image("results/figures/trajectories_y.svg", width: 85%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *anteroposterior (Y) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Anteroposterior lower-limb joint center trajectories across walking speeds])
) <fig-traj-y>

#figure(
  image("results/figures/trajectories_z.svg", width: 85%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *vertical (Z) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Vertical lower-limb joint center trajectories across walking speeds])
) <fig-traj-z>

// == Gait Event Timing

// Timing errors in heel strike and toe off detection were small across all trackers. Mean heel strike timing error ranged from +5.4 to +9.3 ms and mean toe-off error from +6.1 to +15.4 ms (@fig-timing-error), with the largest errors observed for MediaPipe-derived gait events. The majority of errors fell within a single frame (33 ms), with a small positive bias indicating slightly delayed detection.  


#figure(
  image("results/figures/gait_events_histogram.svg", width: 100%),
  caption:  flex-caption([Distribution of gait event timing errors across all trials relative to the marker-based reference for data derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green). *Left*: Heel strike; *Right*: Toe off. Positive values indicate delayed detection relative to the marker-based reference.],
  [Distribution of gait event timing errors])
) <fig-timing-error>


// == Posture: COM Velocity Distributions
// COM velocity distributions between MediaPipe-derived and marker-based reference data closely matched in the ML and AP directions, though MediaPipe-derived COM velocity distributions had a consistently longer tail (@fig-violin). Larger differences were seen in the vertical direction, particularly during the solid ground conditions. As we expect little vertical movement in the COM on solid ground, this largely reflects measurement noise for each system rather than true postural movement. In the Eyes Open/Solid Ground condition, mean vertical velocity SD across trials was 0.90 ± 0.26 mm/s for the marker-based reference, 2.40 ± 0.42 mm/s for MediaPipe-derived data, 9.60 ± 1.94 mm/s for ViTPose-derived data, and 14.25 ± 1.99 mm/s for RTMPose-derived data.

#figure(
  image(
    "results/figures/com_velocity_violin.png", width: 85%),
    caption: flex-caption([Frame-level distribution of center of mass (COM) velocity data per condition for marker-based reference data (gray) and markerless MediaPipe-derived data (blue) for mediolateral (top), anteroposterior (middle) and vertical directions (bottom).],
    [Comparison of frame-level distribution of center of mass (COM) velocity data per condition])
) <fig-violin>


// #figure(
//   image("results/figures/com_path_length_agreement_ba.svg", width: 100%),
//   caption: flex-caption([Trial-level agreement between MediaPipe-derived and reference center of mass path length (n = 12). Left: Identity plot with identity line (dashed) and line of best fit (red). Right: Bland-Altman plot of differences between MediaPipe-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition.],
//   [Center of mass path length agreement between systems])
// ) <fig-path-length-agreement>


// #figure(
//   image("results/figures/com_sensitivity.svg", width: 100%),
//   caption: flex-caption([Sensitivity of MediaPipe-derived center of mass path length to condition-dependent perturbations. Identity plots are shown with identity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Proprioceptive perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Proprioceptive Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).],
//   [Sensitivity of markerless system to condition-dependent perturbations])
// ) <fig-path-length-sensitivity>
