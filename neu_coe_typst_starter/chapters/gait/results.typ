== Results

=== Trajectories 

The reconstructed 3D data from each pose estimation backend are plotted alongside the marker-based reference in @fig-gait-reconstruction, with trajectories in the X (mediolateral), Y (anteroposterior) and Z (vertical) time normalized to 0-100% of the gait cycle in @fig-traj-x, @fig-traj-y, and @fig-traj-z, respectively.

#figure(
  image("figures/example_gait.png", width: 100%),
  caption: [Example of markerless motion capture with each pose estimation backend. Left: MediaPipe (blue); Middle: RTMPose (orange); Right: ViTPose (green). The marker-based reference is displayed in black for each frame. ]
) <fig-gait-reconstruction>

Reconstructed joint centers were generally under 30mm, with lowest error across the mediolateral (ML) axes (@tbl-traj-rmse-x). Errors were largest at the hip, with RMSE values of approximately 20 mm in both the anteroposterior (AP) axes (@tbl-traj-rmse-y) and vertical axes (@tbl-traj-rmse-z) across all speeds.  

Errors increased with speed primarily at the distal joints in the AP and vertical directions, while the proximal joint (hip) error remained largely stable. Exceptions were observed, including decreased knee AP error with increasing speed for RTMPose and ViTPose and relatively consistent vertical ankle angle across all speeds). 

Across trackers, RTMPose consistently showed the lowest trajectory error, while ViTPose exhibited the highest error, particularly in the vertical axis. These differences were most apparent at the ankle and toe, where ViTPose demonstrated a consistent vertical offset relative to the reference. 

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

Kinematic error remained below 5° across most conditions, with notable deviations emerging primarily at higher speeds in the ViTPose-tracked ankle (@tbl-joint-angle-rmse). Error increased with speed, particularly in distal joints (ankle and hip) while proximal joints remained relatively stable. Across trackers, ViTPose showed the lowest error for hip and knee angles, whereas RTMPose performed best at the ankle. In contrast, ViTPose exhibited consistent plantarflexion offset relative to the reference data (@fig-joint-ang-spm).

Statistical parametric mapping (SPM) revealed common suprathreshold clusters ($t\*$ = 3.41 - 4.56 across conditions and trackers) across all joints in early stance. These deviations were most pronounced at the ankle, where ViTPose exhibited widespread differences spanning much of the gait cycle at higher speeds, while RTMPose showed comparatively little deviation. MediaPipe exhibited suprathreshold clusters for hip and knee angles that decreased with speed

#figure(
  image("figures/joint_angles_with_spm.svg"),
  caption: [Comparison of sagittal hip, knee and ankle joint angles across walking speeds (0.5-2.5 m/s). Angles derived from MediaPipe (blue), RTMPose (orange) and ViTPose (green) are shown alongside the marker-based reference (gray). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0–100%. Statistical parametric mapping (SPM) results are shown in the lower panels for each joint and speed for each set of 3D data. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the reference are statistically significant (p < .05). ]
) <fig-joint-ang-spm>


#include "tables/joint_angle_rmse_table.typ"

=== Gait Event Timing

Timing errors in heel strike and toe off detection were small across all trackers. Heel strike timing ranged from +5.4 to +9.3 ms and toe-off errors from +6.1 to +15.4 ms (@fig-timing-error). The majority of errors fell within a single frame (33 ms) of timing error, with a slight positive bias indicating slightly delayed detection.  


#figure(
  image("figures/gait_events_histogram.svg", width: 100%),
  caption:  [Distribution of gait event timing errors across all trials relative to the marker-based reference for data derived from MediaPipe (blue), RTMPose (orange) and ViTPose (green). Left: Heel strike; Right: Toe off. Positive values indicate delayed detection relative to the reference.]
) <fig-timing-error>

== Gait Parameters

Spatiotemporal gait parameters, pooled across all walking speeds, showed minimal bias and excellent agreement with the reference (@tbl-ba-gait-pooled). Limits of agreement (LoA) for stride and step length were within approximately ±70mm for all pose estimation backends. For stance and swing duration, LoA were within ±40ms for RTMPose and ViTPose and within ±70ms for MediaPipe. 

Agreement was high overall, with the lowest agreement observed in swing phase duration (ICC ≈ 0.90). Bias remained generally small across trackers, with ViTPose showing near-zero bias (-0.93 - 0.81 ms), while MediaPipe showed larger deviations (-5.35 - 4.78 ms). Consistent with this, MediaPipe also exhibited wider LoA, while RTMPose and ViTPose showed more consistent agreement with the reference system. 

#include "tables/ba_gait_pooled.typ"


Spatial gait parameters (step and stride length) demonstrated clear speed-dependent changes (@fig-gait-ba). 
Limits of agreement (LoA) widened with increasing walking speed (e.g., ViTPose step length LoA widened from ±19 mm to ± 88mm across speeds).

Stride length agreement remained strong across speed (ICC \> 0.90 across all speeds ), while step length agreement decreased at higher speeds (ICC ≈ 0.78 at high speeds). Across trackers, RTMPose and ViTPose showed more consistent agreement, while MediaPipe exhibited wider limits of agreement, consistent with pooled results. Speed-stratified Bland-Altman statistics and ICC for spatial parameters can be found in Appendix A (@tbl-ba-gait-by-speed-spatial).

In contrast to spatial parameters, bias and LoA for temporal metrics (swing and stance duration) remained consistent across walking speed. Stance duration agreement remained strong at lower and moderate speeds, but dropped sharply at the highest speed (ICC ≈ 0.65-0.72 across trackers). In comparison, swing duration showed a more progressive decline in agreement with increasing speed, decreasing to moderate agreement at higher speeds (ICC ≈ 0.57-0.66). Across all conditions, MediaPipe showed lower agreement compared to RTMPose and ViTPose.Speed-stratified Bland-Altman statistics and ICC for temporal parameters can be found in Appendix A (@tbl-ba-gait-by-speed-temporal).


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


