== Results

=== Trajectories 

Overall, trajectory error was lowest across the ML direction. The hip was was generally the hardest joint to track, with errors approaching \~20mm in AP and vertical dimensions across all joints. 

Generally RTMPose produced the lowest RMSE, particularly for the vertical axis of the ankle with an RMSE of  \~7mm. Difference in tracked hip trajectories between RTMPose and MediaPipe across axes was minimal. As a whole, ViTPose error was highest, particularly in the vertical axis where consistent underestimation of the trajectory can be seen.

Speed had little impact on trajectory error in the ML direction. Across the AP direction, knee error for RTMPose and ViTPose tended to decrease with higher speed, while MediaPipe remained consistent. For all three trackers, error generally increased for the more distal joints (ankle and toe) as speed increased. In the vertical axis, trajectory error increased across speeds for the knee and toe. 



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

Joint angle error was low across all joints and trackers (RMSE \< 7°, @tbl-joint-angle-rmse). ViTPose showed lowest error for the hip and knee, while RTMPose showed lowest error for the ankle.

While joint angle error was generally low, statistical parametric mapping (SPM) paired t-tests (α = 0.05) revealed phase-dependent difference across the gait cycle (critical thresholds ranged from t\* = 3.41 to 4.56 across conditions) (@fig-joint-ang-spm). At the hip, significant differences were observed in early stance and late swing, particularly for MediaPipe. At the knee, supra-threshold clusters were primarily concentrated during early stance across all trackers. At the ankle, multiple supra-threshold clusters were observed throughout the gait cycle, with ViTPose showing the most frequent deviations and RTMPose the fewest.

Differences across speed were joint-dependent. The extent of significant differences decreased across speed for the hip, remained relatively stable for the knee, and increased across speed for ViTPose at the ankle. 


#figure(
  image("figures/joint_angles_with_spm.svg"),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-joint-ang-spm>


#include "tables/joint_angle_rmse_table.typ"



Gait event timing errors were low across all trackers, with heel-strike timing errors ranging from +5.4 to +9.3 ms and toe-off errors from +6.1 to +15.4 ms (@fig-timing-error). The majority of errors fell within one frame (33ms) of timing error, though a slight positive bias indicates slightly delayed detection. 

#figure(
  image("figures/gait_events_histogram.svg", width: 100%),
  caption:  [Histogram of heel strike and toe-off timing differences from freemocap backends and the reference system ]
) <fig-timing-error>


Spatiotemporal gait parameters, pooled across all walking speeds, showed excellent agreement with the reference system (ICC \> 0.90 ; @tbl-ba-gait-pooled). Spatial parameters (stride length, step length) demonstrated excellent reliability (ICC = 0.972 - 0.993) with bias magnitudes ranging from 0.07mm (ViTPose) to 0.70mm (MediaPipe) and limits of agreement within ± 70mm across all trackers. Temporal parameters also showed high reliability for stance duration (0.991 - 0.997), with lower but still strong reliability for swing duration (0.90 - 0.932). Bias was generally small across trackers, with ViTPose showing near-zero bias (-0.93 - 0.81ms), while MediaPipe showed larger deviations (-5.35 - 4.78ms). MediaPipe and RTMPose showed a slight positive bias in stance duration and slight negative bias in swing duration, while ViTPose showed the opposite. Across trackers, MediaPipe tended to have wider limits of agreement, while RTMPose and ViTPose showed more consistent agreement with the reference system. 


#include "tables/ba_gait_pooled.typ"

Spatiotemporal gait parameters demonstrated clear speed-dependent changes in agreement (@fig-gait-ba). For spatial metrics, limits of agreement widen with increasing walking speed. For example, ViTPose LoA widen from approximately ±19mm at 0.5 m/s to approximately ±88mm at 2.5 m/s, with similar trends observed across all trackers. Despite increasing variability, stride length maintained strong relative agreement across speeds (ICC ≈ 0.99 at .5m/s to ≈ 0.90 at 2.5m/s). In contrast, step length showed greater sensitivity to speed, with substantial decrease in ICC at higher speeds (ICC ≈ 0.99 at .5m/s to ≈ .78 at 2.5m/s). Generally, ViTPose and RTMPose both exhibited strongest agreement, with ViTPose tending to show lowest bias. MediaPipe tended to show the widest limits of agreement. Speed-stratified Bland-Altman statistics and ICC for spatial parameters can be found in Appendix A (@tbl-ba-gait-by-speed-spatial)

In contrast to the systematic widening observed for spatial parameters, limits of agreement for temporal metrics remained relatively consistent. For stance duration, agreement was strong at lower and moderate speeds (0.5 - 2.0m/s), with ICC \> .90 for ViTPose and RTMPose and ICC \> 0.85 for MediaPipe. However, agreement dropped sharply at the highest speed (2.5m/s), where ICC dropped to 0.650-0.724 across trackers. Swing duration showed a more progressive decline in agreement with increasing speed. ICC decreased from good agreement at 0.5m/s (0.84-0.93) to moderate agreement at higher speeds (0.57-0.66) Across all speeds, MediaPipe tended to show the lowest agreement with the reference system across all speeds. Speed-stratified Bland-Altman statistics and ICC for temporal parameters can be found in Appendix A (@tbl-ba-gait-by-speed-temporal).

#figure(
  image("figures/ba_stride_length.png", width: 75%),
  caption: [placeholder]
  )
 <fig-gait-ba>


 #figure(
  image("figures/scaling_factor_boxplot.svg"),
  caption: [placeholder]
 )
 <fig-scaling>
