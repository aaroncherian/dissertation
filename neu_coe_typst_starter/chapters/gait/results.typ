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
