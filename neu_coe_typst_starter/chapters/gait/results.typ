#import "../../template.typ": flex-caption

== Results

=== Trajectories 

The reconstructed 3D data from each pose estimation backend are shown alongside the marker-based reference in @fig-gait-reconstruction. Gait cycle-normalized joint trajectories in the X (mediolateral), Y (anteroposterior), and Z (vertical) directions are shown in @fig-traj-x, @fig-traj-y, and @fig-traj-z, respectively. 

#figure(
  image("figures/example_gait.png", width: 100%),
  caption: flex-caption([Example of markerless motion capture data using each pose estimation backend. *Left*: MediaPipe (blue); *Middle*: RTMPose (orange); *Right*: ViTPose (green). The marker-based reference skeleton is displayed in black on each panel.],
  [Example of markerless motion capture data using each pose estimation backend])
) <fig-gait-reconstruction>

Reconstructed joint center errors for each lower-limb joint across speed, axis, and pose estimation backend are summarized in @fig-rmse-grid. Joint center errors were generally under 30 mm, with the lowest error observed in the mediolateral (ML) direction (@tbl-traj-rmse-x). Across joints, the hip exhibited the largest overall RMSE, with approximately 20 mm of error in both the anteroposterior (AP) (@tbl-traj-rmse-y) and vertical directions (@tbl-traj-rmse-z), although the magnitude of this error was largely unaffected by walking speed.

Error increased with walking speed at distal joints (particularly in the AP and vertical directions). However, this pattern was not uniform across joints and axes. For example, AP error at the knee decreased with speed for RTMPose and ViTPose-derived trajectories. Additionally, across all trackers, vertical error at the ankle remained relatively consistent.

Across trackers, RTMPose generally exhibited the lowest trajectory error, while ViTPose exhibited the highest, particularly in the vertical direction. These differences were most apparent at the ankle and toe, where ViTPose demonstrated a consistent vertical offset relative to the marker-based reference. 

#figure(
  image("figures/trajectory_rmse_grid.png", width: 100%),
  caption: flex-caption([Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend. Rows correspond to joint centers (hip, knee, ankle, toe) and columns to pose estimation backends (MediaPipe, RTMPose, ViTPose). Error is shown separately for the mediolateral (blue), anteroposterior (orange), and vertical (green) directions. Points represent mean RMSE across all trials; error bars indicate ±1 SD. Values correspond to Tables 5.1-5.3.],
  [Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend])
) <fig-rmse-grid>

#figure(
  image("figures/trajectories_x.svg", width: 75%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *mediolateral (X) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Mediolateral lower-limb joint center trajectories across walking speeds])
) <fig-traj-x>

#include "tables/trajectory_rmse_x.typ"

#figure(
  image("figures/trajectories_y.svg", width: 75%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *anteroposterior (Y) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Anteroposterior lower-limb joint center trajectories across walking speeds])
) <fig-traj-y>

#include "tables/trajectory_rmse_y.typ"

#figure(
  image("figures/trajectories_z.svg", width: 75%),
  caption: flex-caption([Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *vertical (Z) direction* across walking speeds (0.50 - 2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
  [Vertical lower-limb joint center trajectories across walking speeds])
) <fig-traj-z>


#include "tables/trajectory_rmse_z.typ"


=== Joint Kinematics

Sagittal joint angle error was below 5° across most conditions, with the primary exception being ViTPose-derived ankle angles at higher speeds (@tbl-joint-angle-rmse). These errors increased with speed at the knee and ankle, while hip angle error remained relatively stable. Across trackers, ViTPose-derived angles exhibited the lowest error for hip and knee angles but displayed a consistent plantarflexion offset at the ankle (@fig-joint-ang-spm). RTMPose-derived ankle angles were most accurate.

Statistical parametric mapping (SPM) paired t-tests ($ alpha = 0.05$) revealed common suprathreshold clusters ($t\*$ = 3.41 - 4.56 across conditions and trackers) at all joints in early stance. At the ankle, ViTPose-derived angles exhibited widespread differences spanning much of the gait cycle. At the hip and knee, MediaPipe-derived angles exhibited suprathreshold clusters whose magnitude and duration decreased with speed. 

#figure(
  image("figures/joint_angles_with_spm.svg"),
  caption: flex-caption([Comparison of sagittal hip, knee, and ankle joint angles across walking speeds (0.50-2.50 m/s). Angles derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides and the gait cycle is normalized to 0-100%. Statistical parametric mapping (SPM) results are shown in the lower panels. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the marker-based reference are statistically significant (p < .05). ],
  [Lower-limb kinematics and SPM across walking speeds])
) <fig-joint-ang-spm>


#include "tables/joint_angle_rmse_table.typ"

=== Gait Event Timing

Timing errors in heel strike and toe off detection were small across all trackers. Mean heel strike timing error ranged from +5.4 to +9.3 ms and mean toe-off error from +6.1 to +15.4 ms (@fig-timing-error), with the largest errors observed for MediaPipe-derived gait events. The majority of errors fell within a single frame (33 ms), with a small positive bias indicating slightly delayed detection.  


#figure(
  image("figures/gait_events_histogram.svg", width: 100%),
  caption:  flex-caption([Distribution of gait event timing errors across all trials relative to the marker-based reference for data derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green). *Left*: Heel strike; *Right*: Toe off. Positive values indicate delayed detection relative to the marker-based reference.],
  [Distribution of gait event timing errors])
) <fig-timing-error>

=== Gait Parameters

Spatiotemporal gait parameters, pooled across all walking speeds, showed minimal bias and excellent agreement (ICC > 0.90) with the marker-based reference (@tbl-ba-gait-pooled). Across trackers, ViTPose demonstrated near-zero bias across all parameters. RTMPose and ViTPose both exhibited tight limits of agreement (LoA), while MediaPipe showed larger deviations and wider LoA.


#include "tables/ba_gait_pooled.typ"


Spatial gait parameters (step and stride length) demonstrated clear speed-dependent changes (@fig-gait-ba). 
LoA increased with walking speed (e.g., ViTPose step length: ±19 mm to ±88 mm).

Stride length agreement remained strong across speeds (ICC \> 0.90), while step length agreement decreased at higher speeds (ICC ≈ 0.78 at the fastest speed). Across trackers, RTMPose and ViTPose-derived spatial parameters showed more consistent agreement, while MediaPipe-derived parameters exhibited wider LoA, consistent with pooled results above. Speed-stratified Bland-Altman statistics and ICC for spatial parameters can be found in Appendix A (@tbl-ba-gait-by-speed-spatial).

In contrast to spatial parameters, bias and LoA for temporal metrics (swing and stance duration) remained consistent across speeds, though ICC declined at higher speeds. Stance duration agreement remained strong at low to moderate speeds, but dropped sharply at the highest speed (ICC ≈ 0.65-0.72 across trackers). Swing duration, in contrast, showed a more progressive decline in agreement with increasing speed, decreasing to moderate agreement at higher speeds (ICC ≈ 0.57-0.66). Across all conditions, MediaPipe-derived metrics exhibited the lowest agreement. Speed-stratified Bland-Altman statistics and ICC for temporal parameters can be found in Appendix A (@tbl-ba-gait-by-speed-temporal).


#figure(
  image("figures/ba_stride_length.png", width: 75%),
  caption: flex-caption([Bland-Altman plot of stride length differences between markerless and marker-based reference estimates, plotted against the mean of the measurements. Panels correspond to data from each pose estimation backend (*Top:* MediaPipe; *Middle:* RTMPose; *Bottom:* ViTPose), and colors indicate walking speed (0.50 - 2.50 m/s). Dashed lines represent bias, and dash-dot lines indicate 95% limits of agreement. ],
  [Bland-Altman plot of stride length difference])
  )
 <fig-gait-ba>

=== Tracker-specific scaling

To assess whether pose estimation choice introduced systematic scaling, scale factors between each tracker's reconstruction and the marker-based reference were computed for each trial (@fig-scaling). ViTPose demonstrated a consistent deviation, with a median scale factor of 0.98 (range: 0.96-0.98), indicating that ViTPose reconstructions were approximately 2-4% larger than the marker-based reference. 

In contrast, MediaPipe and RTMPose showed scale factors centered near 1.0, indicating minimal global scaling bias relative to the reference (MediaPipe median: 1.00, range: 0.98-1.01; RTMPose median: 1.00, range: 0.99-1.01). 


 #figure(
  image("figures/scaling_factor_boxplot.svg", width: 60%),
  caption: flex-caption([Box plot of per-trial uniform scaling factors estimated during spatial alignment to the marker-based reference for RTMPose (orange), MediaPipe (blue), and ViTPose (green). The scaling factor $s$ represents the isotropic scaling required to minimize joint center error. Dashed line indicates a scaling factor of 1 (perfect agreement).],
  [Box plot of per-trial uniform scaling factors])
 )
 <fig-scaling>


