== Results

I refer to each FreeMoCap configuration by its pose estimation backend (MediaPipe, RTMPose, ViTPose) for brevity.

=== Trajectories 
Reconstructed joint centers were generally under 30mm, with lowest error across the mediolateral (ML) axes (@fig-traj-x, @tbl-traj-rmse-x). The hip joint center exhibited the most error, with RMSEs of \~20mm in the anterior-posterior (AP) (@fig-traj-y, @tbl-traj-rmse-y) and vertical axes (@fig-traj-z, @tbl-traj-rmse-z) across all speeds.  

Increases in trajectory error across speed were primarily observed at distal joints in the AP and vertical directions - although exceptions occurred (e.g. knee AP error decreased with speed for RTMPose and ViTPose, and vertical ankle error remained stable across all speeds.) Hip joint error was largely unaffected by speed across all three axes. 

Generally RTMPose-derived data showed the lowest joint trajectory error. ViTPose error tended to be the highest, particularly in the vertical axis with larger errors and consistent underestimation of ankle and toe trajectories (@fig-traj-z). 


#figure(
  image("figures/trajectories_x.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-traj-x>

#include "tables/trajectory_rmse_x.typ"

#figure(
  image("figures/trajectories_y.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-traj-y>

#include "tables/trajectory_rmse_y.typ"

#figure(
  image("figures/trajectories_z.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-traj-z>


#include "tables/trajectory_rmse_z.typ"

=== Joint Kinematics

Kinematic error tended to be under 5°, with errors exceeding 5° only exhibited at higher speeds for the ViTPose-tracked ankle (@tbl-joint-angle-rmse). Similar to the joint trajectories, angles for distal joints (knee and ankle) increased with speed. ViTPose error was smallest for hip and knee angles, while RTMPose error was smallest for the ankle. ViTPose exhibits a consistent plantarflexion offset in comparison to the reference data (@fig-joint-ang-spm)

Statistical parametric mapping (SPM) shows common suprathreshold clusters (critical thresholds ranged from t\* = 3.41 to 4.56 across conditions and trackers) for all three joints in early stance. MediaPipe in particular exhibits suprathreshold clusters for hip and knee angles that decrease with speed. At the ankle, ViTPose showed the most extensive deviation, with suprathreshold clusters spanning much of the gait cycle at higher speeds, while RTMPose showed the fewest. 

#figure(
  image("figures/joint_angles_with_spm.svg"),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-joint-ang-spm>


#include "tables/joint_angle_rmse_table.typ"

=== Gait Event Timing

Gait event timing errors were low across all trackers, with heel-strike timing errors ranging from +5.4 to +9.3 ms and toe-off errors from +6.1 to +15.4 ms (@fig-timing-error). The majority of errors fell within one frame (33ms) of timing error, with a slight positive bias that indicates slightly delayed detection. Heel-strike detection was more tightly clustered than toe-off, which showed more errors at one frame of delay. 

#figure(
  image("figures/gait_events_histogram.svg", width: 100%),
  caption:  [Histogram of heel strike and toe-off timing differences from freemocap backends and the reference system ]
) <fig-timing-error>

== Gait Parameters

Spatiotemporal gait parameters, pooled across all walking speeds, showed excellent agreement with the reference system (ICC \> 0.90 ; @tbl-ba-gait-pooled). Spatial parameters (stride length, step length) demonstrated excellent reliability (ICC = 0.972 - 0.993) with bias magnitudes ranging from 0.07mm (ViTPose) to 0.70mm (MediaPipe) and limits of agreement within ± 70mm across all trackers. Temporal parameters also showed high reliability for stance duration (0.991 - 0.997), with lower but still strong reliability for swing duration (0.90 - 0.932). Bias was generally small across trackers, with ViTPose showing near-zero bias (-0.93 - 0.81ms), while MediaPipe showed larger deviations (-5.35 - 4.78ms). MediaPipe and RTMPose showed a slight positive bias in stance duration and slight negative bias in swing duration, while ViTPose showed the opposite. Across trackers, MediaPipe tended to have wider limits of agreement, while RTMPose and ViTPose showed more consistent agreement with the reference system. 


#include "tables/ba_gait_pooled.typ"

Spatiotemporal gait parameters demonstrated clear speed-dependent changes in agreement (@fig-gait-ba). For spatial metrics, limits of agreement widen with increasing walking speed. For example, ViTPose LoA widen from approximately ±19mm at 0.5 m/s to approximately ±88mm at 2.5 m/s, with similar trends observed across all trackers. Despite increasing variability, stride length maintained strong relative agreement across speeds (ICC ≈ 0.99 at .5m/s to ≈ 0.90 at 2.5m/s). In contrast, step length showed greater sensitivity to speed, with substantial decrease in ICC at higher speeds (ICC ≈ 0.99 at .5m/s to ≈ .78 at 2.5m/s). Generally, ViTPose and RTMPose both exhibited strongest agreement, with ViTPose tending to show lowest bias. MediaPipe tended to show the widest limits of agreement. Speed-stratified Bland-Altman statistics and ICC for spatial parameters can be found in Appendix A (@tbl-ba-gait-by-speed-spatial)

In contrast to the systematic widening observed for spatial parameters, limits of agreement for temporal metrics remained relatively consistent. For stance duration, agreement was strong at lower and moderate speeds (0.5 - 2.0m/s), with ICC \> .90 for ViTPose and RTMPose and ICC \> 0.85 for MediaPipe. However, agreement dropped sharply at the highest speed (2.5m/s), where ICC dropped to 0.650-0.724 across trackers. Swing duration showed a more progressive decline in agreement with increasing speed. ICC decreased from good agreement at 0.5m/s (0.84-0.93) to moderate agreement at higher speeds (0.57-0.66) Across all speeds, MediaPipe tended to show the lowest agreement with the reference system across all speeds. Speed-stratified Bland-Altman statistics and ICC for temporal parameters can be found in Appendix A (@tbl-ba-gait-by-speed-temporal).

#figure(
  image("figures/ba_stride_length.png", width: 75%),
  caption: [placeholder]
  )
 <fig-gait-ba>

=== Tracker-specific scaling

Spatial scaling factors from spatial alignment reveal that MediaPipe and RTMPose produce 3D reconstructions closely matching the reference system (median for both ≈ 1.00; ranges 0.98-1.01 and 0.99-1.01 respectively) (@fig-scaling). ViTPose exhibited spatial contraction, with a median scaling factor of 0.98 (range: 0.96 - 0.98), indicated that ViTPose reconstructions were approximately 2-3% smaller than the marker-based reference. This pattern was consistent across all participants. 


 #figure(
  image("figures/scaling_factor_boxplot.svg", width: 80%),
  caption: [placeholder]
 )
 <fig-scaling>
