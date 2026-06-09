#import "../template.typ": flex-caption
= Results

== Gait Trajectories

The reconstructed 3D data from each pose estimation backend are shown alongside the marker-based reference in @fig-gait-reconstruction. Gait cycle-normalized joint trajectories in the X (mediolateral), Y (anteroposterior), and Z (vertical) directions are shown in @fig-traj-x, @fig-traj-y, and @fig-traj-z, respectively. 

#figure(
  image("results/figures/example_gait.png", width: 100%),
  caption: flex-caption([Example of markerless motion capture data using each pose estimation backend. *Left*: MediaPipe (blue); *Middle*: RTMPose (orange); *Right*: ViTPose (green). The marker-based reference skeleton is displayed in black on each panel.],
  [Example of markerless motion capture data using each pose estimation backend])
) <fig-gait-reconstruction>

Reconstructed joint center errors for each lower-limb joint across speed, axis, and pose estimation backend are summarized in @fig-rmse-grid. Joint center errors were generally under 30 mm, with the lowest error observed in the mediolateral (ML) direction (@tbl-traj-rmse-x). Across joints, the hip exhibited the largest overall RMSE, with approximately 20 mm of error in both the anteroposterior (AP) (@tbl-traj-rmse-y) and vertical directions (@tbl-traj-rmse-z), although the magnitude of this error was largely unaffected by walking speed.

Error increased with walking speed at distal joints (particularly in the AP and vertical directions). However, this pattern was not uniform across joints and axes. For example, AP error at the knee decreased with speed for RTMPose and ViTPose-derived trajectories. Additionally, across all trackers, vertical error at the ankle remained relatively consistent.

Across trackers, RTMPose generally exhibited the lowest trajectory error, while ViTPose exhibited the highest, particularly in the vertical direction. These differences were most apparent at the ankle and toe, where ViTPose demonstrated a consistent vertical offset relative to the marker-based reference. 

#figure(
  image("results/figures/trajectory_rmse_grid.png", width: 100%),
  caption: flex-caption([Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend. RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Rows correspond to joint centers (hip, knee, ankle, toe) and columns to pose estimation backends (MediaPipe, RTMPose, ViTPose). Error is shown separately for the mediolateral (blue), anteroposterior (orange), and vertical (green) directions. Points represent mean RMSE across all trials; error bars indicate ±1 SD. Values correspond to Tables 5.1-5.3.],
  [Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend])
) <fig-rmse-grid>

#figure(
  image("results/figures/trajectories_x.svg", width: 85%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *mediolateral (X) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Mediolateral lower-limb joint center trajectories across walking speeds])
) <fig-traj-x>

#include "results/tables/trajectory_rmse_x.typ"

#figure(
  image("results/figures/trajectories_y.svg", width: 85%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *anteroposterior (Y) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Anteroposterior lower-limb joint center trajectories across walking speeds])
) <fig-traj-y>

#include "results/tables/trajectory_rmse_y.typ"

#figure(
  image("results/figures/trajectories_z.svg", width: 85%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *vertical (Z) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Vertical lower-limb joint center trajectories across walking speeds])
) <fig-traj-z>


#include "results/tables/trajectory_rmse_z.typ"

== Gait Kinematics


Sagittal joint angle error was below 5° across most conditions, with the primary exception being ViTPose-derived ankle angles at higher speeds (@tbl-joint-angle-rmse). These errors increased with speed at the knee and ankle, while hip angle error remained relatively stable. Across trackers, ViTPose-derived angles exhibited the lowest error for hip and knee angles but displayed a consistent plantarflexion offset at the ankle (@fig-joint-ang-spm). RTMPose-derived ankle angles were most accurate.

Statistical parametric mapping (SPM) paired t-tests ($ alpha = 0.05$) revealed common suprathreshold clusters ($t\*$ = 3.41 - 4.56 across conditions and trackers) at all joints in early stance. At the ankle, ViTPose-derived angles exhibited widespread differences spanning much of the gait cycle. At the hip and knee, MediaPipe-derived angles exhibited suprathreshold clusters whose magnitude and duration decreased with speed. 

#figure(
  image("results/figures/joint_angles_with_spm.svg"),
  caption: flex-caption([Comparison of sagittal hip, knee, and ankle joint angles across walking speeds (0.50-2.50 m/s). Angles derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides and the gait cycle is normalized to 0-100%. Statistical parametric mapping (SPM) results are shown in the lower panels. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the marker-based reference are statistically significant (p < .05). ],
  [Lower-limb kinematics and SPM across walking speeds])
) <fig-joint-ang-spm>


#include "results/tables/joint_angle_rmse_table.typ"

== Gait Event Timing

Timing errors in heel strike and toe off detection were small across all trackers. Mean heel strike timing error ranged from +5.4 to +9.3 ms and mean toe-off error from +6.1 to +15.4 ms (@fig-timing-error), with the largest errors observed for MediaPipe-derived gait events. The majority of errors fell within a single frame (33 ms), with a small positive bias indicating slightly delayed detection.  


#figure(
  image("results/figures/gait_events_histogram.svg", width: 100%),
  caption:  flex-caption([Distribution of gait event timing errors across all trials relative to the marker-based reference for data derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green). *Left*: Heel strike; *Right*: Toe off. Positive values indicate delayed detection relative to the marker-based reference.],
  [Distribution of gait event timing errors])
) <fig-timing-error>

== Gait Parameters

Spatiotemporal gait parameters, pooled across all walking speeds, showed minimal bias and excellent agreement (ICC > 0.90) with the marker-based reference (@tbl-ba-gait-pooled). Across trackers, ViTPose demonstrated near-zero bias across all parameters. RTMPose and ViTPose both exhibited tight limits of agreement (LoA), while MediaPipe showed larger deviations and wider LoA.


#include "results/tables/ba_gait_pooled.typ"


Spatial gait parameters (step and stride length) demonstrated clear speed-dependent changes compared to temporal gait parameters (@fig-gait-ba). 
LoA increased with walking speed (e.g., ViTPose step length: ±19 mm to ±88 mm).

Stride length agreement remained strong across speeds (ICC \> 0.90), while step length agreement decreased at higher speeds (ICC ≈ 0.78 at the fastest speed). Across trackers, RTMPose and ViTPose-derived spatial parameters showed more consistent agreement, while MediaPipe-derived parameters exhibited wider LoA, consistent with pooled results above. Speed-stratified Bland-Altman statistics and ICC for spatial parameters can be found in Appendix A (@tbl-ba-gait-by-speed-spatial).

In contrast to spatial parameters, bias and LoA for temporal metrics (swing, stance, and stride duration) remained consistent across speeds, with differences clustering at multiples of the 33 ms frame interval (@fig-gait-ba), though ICC declined at higher speeds. Stance duration agreement remained strong at low to moderate speeds, but dropped sharply at the highest speed (ICC ≈ 0.65-0.72 across trackers). Swing duration, in contrast, showed a more progressive decline in agreement with increasing speed, decreasing to moderate agreement at higher speeds (ICC ≈ 0.57-0.66). Across all conditions, MediaPipe-derived metrics exhibited the lowest agreement. Speed-stratified Bland-Altman statistics and ICC for temporal parameters can be found in Appendix A (@tbl-ba-gait-by-speed-temporal).


#figure(
  image("results/figures/ba_stride_both.png", width: 100%),
  caption: flex-caption([Bland-Altman plots of stride duration (left) and stride length (right) agreement between markerless and marker-based systems. Rows correspond to each pose estimation backend (MediaPipe, RTMPose, ViTPose), and colors indicate walking speed (0.50-2.50 m/s). Dashed lines represent bias, and dash-dot lines indicate 95% limits of agreement. Stride duration differences are reported in milliseconds and stride length differences in millimeters.],
  [Bland-Altman plots of stride duration and stride length differences])
  )
 <fig-gait-ba>

== Postural Stability Metrics


Postural stability metrics are summarized in @tbl-postural-metrics. Average ellipse area showed comparable values over all trackers with respect to the reference. @fig-xy-plane shows COM trajectories in the horizontal plane with a 95% confidence ellipse overlay for a representative trial. 

#include ("results/tables/balance_metrics_table.typ")

#figure(
  image(
    "results/figures/com_xy_plane.png", width: 100%,),
    caption: flex-caption( [
    Center of mass trajectories in the horizontal plane (X = mediolateral, Y = anteroposterior) for a representative trial across all conditions and trackers. 95% confidence ellipses are overlaid for each condition. EO = Eyes Open, EC = Eyes Closed.
    ],
    [Center of mass trajectories on the horizontal plane] )
) <fig-xy-plane>


Although ellipse area across all trackers was comparable, path length and mean velocity exhibited tracker-dependent behavior. 
MediaPipe-derived COM path length closely matched the reference and preserved separation across progressively more challenging conditions (@Center-of-mass-path-length). In contrast, RTMPose and ViTPose-derived data overestimated path length and failed to clearly differentiate between balance conditions. Similarly, MediaPipe-derived mean velocity (in the horizontal plane) was similar to the reference, though slight underestimation was observed, while RTMPose and ViTPose-derived velocity was substantially higher.

#figure(
  image("results/figures\com_path_length.svg", width: 100%),
  caption: flex-caption([
  Trial-level and group-level center of mass path length plotted across balance assessment conditions for the reference system and each markerless pose estimation backend. Black lines represent group level mean and standard deviation, while grey lines represent trial level path length (n = 12). EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad
  ],
  [Center of mass path group-level and trial-level mean path length comparison])
) <Center-of-mass-path-length>


== Posture: COM Velocity Distributions
COM velocity distributions between MediaPipe-derived and marker-based reference data closely matched in the ML and AP directions, though MediaPipe-derived COM velocity distributions had a consistently longer tail (@fig-violin). Larger differences were seen in the vertical direction, particularly during the solid ground conditions. As we expect little vertical movement in the COM on solid ground, this largely reflects measurement noise for each system rather than true postural movement. In the Eyes Open/Solid Ground condition, mean vertical velocity SD across trials was 0.90 ± 0.26 mm/s for the marker-based reference, 2.40 ± 0.42 mm/s for MediaPipe-derived data, 9.60 ± 1.94 mm/s for ViTPose-derived data, and 14.25 ± 1.99 mm/s for RTMPose-derived data.

#figure(
  image(
    "results/figures/com_velocity_violin.png", width: 85%),
    caption: flex-caption([Frame-level distribution of center of mass (COM) velocity data per condition for marker-based reference data (gray) and markerless MediaPipe-derived data (blue) for mediolateral (top), anteroposterior (middle) and vertical directions (bottom).],
    [Comparison of frame-level distribution of center of mass (COM) velocity data per condition])
) <fig-violin>



== Posture: Markerless system agreement
MediaPipe-derived path length demonstrated strong agreement with the reference system (@fig-path-length-agreement) (ICC = 0.985). Systematic bias was small (1.25 mm) with limits of agreement at approximately ± 68 mm. A slope of 0.90 indicated a proportional underestimation of the path length with Bland-Altman analyses showing progressive underestimation in harder conditions. In contrast, RTMPose and ViTPose demonstrated poor agreement (ICC < 0.10), high positive bias (726 mm and 1052 mm respectively), and wide limits of agreement. Summary metrics for comparisons across systems are shown in @tbl-path-length-agreement, and identity and Bland-Altman plots for RTMPose and ViTPose derived data can be found in Appendix B ( @fig-agreement-all).  


#figure(
  image("results/figures/com_path_length_agreement_ba.svg", width: 100%),
  caption: flex-caption([Trial-level agreement between MediaPipe-derived and reference center of mass path length (n = 12). Left: Identity plot with identity line (dashed) and line of best fit (red). Right: Bland-Altman plot of differences between MediaPipe-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition.],
  [Center of mass path length agreement between systems])
) <fig-path-length-agreement>

#include "results/tables/path_length_agreement_table.typ"


== Posture : Markerless system sensitivity
MediaPipe-derived COM changes exhibited good-to-excellent sensitivity to different perturbations (_r_#super[2] = 0.83 - 0.96) with slope of the fitted regression line showing near one-to-one agreement (0.89 - 1.06), though slight underestimation of path length was observed under visual perturbation (@fig-path-length-sensitivity). ViTPose and RTMPose-derived COM changes demonstrated poor sensitivity (_r_#super[2] = 0.03 to 0.45), with proportional bias differing substantially (slope = -6.46 to 1.58) from the ideal. Identity plots per perturbation for RTMPose and ViTPose-derived data can be found in Appendix B (@fig-sensitivity-all).

#figure(
  image("results/figures/com_sensitivity.svg", width: 100%),
  caption: flex-caption([Sensitivity of MediaPipe-derived center of mass path length to condition-dependent perturbations. Identity plots are shown with identity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Proprioceptive perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Proprioceptive Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).],
  [Sensitivity of markerless system to condition-dependent perturbations])
) <fig-path-length-sensitivity>

#include "results/tables/path_length_sensitivity_table.typ"   


== Tracker-specific error
