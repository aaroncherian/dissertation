== Results

I refer to each FreeMoCap configuration by its pose estimation backend (MediaPipe, RTMPose, ViTPose) for brevity.

=== Trajectories 
Reconstructed joint centers were generally under 30mm, with lowest error across the mediolateral (ML) axes (@fig-traj-x, @tbl-traj-rmse-x). The hip joint center exhibited the most error, with RMSEs of \~20mm in the anterior-posterior (AP) (@fig-traj-y, @tbl-traj-rmse-y) and vertical axes (@fig-traj-z, @tbl-traj-rmse-z) across all speeds.  

Increases in trajectory error across speed were primarily observed at distal joints in the AP and vertical directions - although exceptions occurred (e.g. knee AP error decreased with speed for RTMPose and ViTPose, and vertical ankle error remained stable across all speeds.) Hip joint error was largely unaffected by speed across all three axes. 

Generally RTMPose-derived data showed the lowest joint trajectory error. ViTPose error tended to be the highest, particularly in the vertical axis with larger errors and consistent underestimation of ankle and toe trajectories (@fig-traj-z). 


#figure(
  image("figures/trajectories_x.svg", width: 100%),
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the mediolateral (X) direction across walking speeds (0.5-2.5 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0–100%.]
) <fig-traj-x>

#include "tables/trajectory_rmse_x.typ"

#figure(
  image("figures/trajectories_y.svg", width: 100%),
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the anterior-posterior (Y) direction across walking speeds (0.5-2.5 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0–100%.],
) <fig-traj-y>

#include "tables/trajectory_rmse_y.typ"

#figure(
  image("figures/trajectories_z.svg", width: 100%),
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the vertical (Z) direction across walking speeds (0.5-2.5 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0–100%.],
) <fig-traj-z>


#include "tables/trajectory_rmse_z.typ"

=== Joint Kinematics

Kinematic error tended to be under 5°, with errors exceeding 5° only exhibited at higher speeds for the ViTPose-tracked ankle (@tbl-joint-angle-rmse). Similar to the joint trajectories, angles for distal joints (knee and ankle) increased with speed. ViTPose error was smallest for hip and knee angles, while RTMPose error was smallest for the ankle. ViTPose exhibits a consistent plantarflexion offset in comparison to the reference data (@fig-joint-ang-spm)

Statistical parametric mapping (SPM) shows common suprathreshold clusters (critical thresholds ranged from t\* = 3.41 to 4.56 across conditions and trackers) for all three joints in early stance. MediaPipe in particular exhibits suprathreshold clusters for hip and knee angles that decrease with speed. At the ankle, ViTPose showed the most extensive deviation, with suprathreshold clusters spanning much of the gait cycle at higher speeds, while RTMPose showed the fewest. 

#figure(
  image("figures/joint_angles_with_spm.svg"),
  caption: [Comparison of sagittal hip, knee and ankle joint angles across walking speeds (0.5-2.5 m/s). Angles derived from MediaPipe (blue), RTMPose (orange) and ViTPose (green) are shown alongside the marker-based reference (gray). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0–100%. Statistical parametric mapping (SPM) results are shown in the lower panels for each joint and speed for each set of 3D data. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the reference are statistically significant (p < .05). ]
) <fig-joint-ang-spm>


#include "tables/joint_angle_rmse_table.typ"

=== Gait Event Timing

Gait event timing errors were low across all trackers, with heel-strike timing errors ranging from +5.4 to +9.3 ms and toe-off errors from +6.1 to +15.4 ms (@fig-timing-error). The majority of errors fell within one frame (33ms) of timing error, with a slight positive bias that indicates slightly delayed detection. Heel-strike detection was more tightly clustered than toe-off, which showed more errors at one frame of delay. 

#figure(
  image("figures/gait_events_histogram.svg", width: 100%),
  caption:  [Distribution of gait event timing errors across all trials relative to the marker-based reference for data derived from MediaPipe (blue), RTMPose (orange) and ViTPose (green). Left: Heel strike; Right: Toe off. Positive values indicate delayed detection relative to the reference.]
) <fig-timing-error>

== Gait Parameters

Spatiotemporal gait parameters pooled across all walking speeds showed minimal bias and excellent agreement with the reference (@tbl-ba-gait-pooled). Limits of agreement (LoA) for stride and step length were within approximately ±70mm for all pose estimation backends. LoA for stance and swing duration were within ±40ms for RTMPose and ViTPose and within ±70ms for MediaPipe. Across all parameters, the lowest agreement was in swing phase duration (ICC = \~.90). 

Bias was generally small across trackers, with ViTPose showing near-zero bias (-0.93 - 0.81ms), while MediaPipe showed larger deviations (-5.35 - 4.78ms). MediaPipe also exhibited wider limits of agreement, while RTMPose and ViTPose showed more consistent agreement with the reference system. 

#include "tables/ba_gait_pooled.typ"


Spatial gait parameters (step and stride length) demonstrated clear speed-dependent changes (@fig-gait-ba). When stratified by speed, spatial metric LoA widened with increasing walking speed (i.e. ViTPose step length LoA widened from ±19 mm to ± 88mm across speed). While stride length maintained strong agreement across speed (ICC \> 0.90 across all speeds ), step length agreement decreased substantially at higher speeds (ICC≈ 0.78 at high speeds). Across trackers, RTMPose and ViTPose showed more consistent agreement, while MediaPipe exhibited wider limits of agreement. Speed-stratified Bland-Altman statistics and ICC for spatial parameters can be found in Appendix A (@tbl-ba-gait-by-speed-spatial)

In contrast, bias and LoA for temporal metrics (swing and stance duration) remained consistent across walking speed. Stance duration agreement remained strong at lower and moderate speeds, but dropped sharply at the highest speed (ICC ≈ 0.65-0.72 across trackers). In contrast, swing duration showed a more progressive decline in agreement with increasing speed, decreasing to moderate agreement at higher speeds (ICC ≈ 0.57-0.66). Across all conditions, MediaPipe showed lower agreement compared to RTMPose and ViTPose.Speed-stratified Bland-Altman statistics and ICC for temporal parameters can be found in Appendix A (@tbl-ba-gait-by-speed-temporal).


#figure(
  image("figures/ba_stride_length.png", width: 88%),
  caption: [Bland-Altman plot of stride length differences between markerless and marker-based reference estimates, plotted against the mean of the measurements. Panels correspond to data from each pose estimation backend (MediaPipe, RTMPose, ViTPose), and colors indicate walking speed (0.5-2.5 m/s). Dashed lines represent bias, and dash-dot lines indicate 95% limits of agreement. ]
  )
 <fig-gait-ba>

=== Tracker-specific scaling

ViTpose showed a median scaling factor of 0.98 (range: 0.96-0.98), indicating that unscaled ViTPose reconstructions were approximately 2-3% larger than the marker-based reference (@fig-scaling). RTMPose and MediaPipe-derived data closely match the reference system (MediaPipe median: 1.00, range: 0.98-1.01; RTMPose median: 1.00, range: 0.99-1.01)


 #figure(
  image("figures/scaling_factor_boxplot.svg", width: 80%),
  caption: [Box plot of scaling factors required to align markerless estimates with the marker-based reference for data derived from RTMPose (orange), MediaPipe (blue), and ViTPose (green). Dashed line indicates a scaling factor of 1 (perfect agreement).]
 )
 <fig-scaling>


