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

#figure(
  image("figures/joint_angles_with_spm.svg")
)

#include "tables/joint_angle_rmse_table.typ"




[Heel strike]
   MediaPipe: μ=+8.6±15.5
   RTMPose: μ=+4.7±13.8
   ViTPose: μ=+6.1±14.7

[Toe off]
   MediaPipe: μ=+14.0±17.2
   RTMPose: μ=+6.4±14.9
   ViTPose: μ=+4.9±14.5

#figure(
  image("figures/gait_events_histogram.svg", width: 100%),
  caption:  [Histogram of heel strike and toe-off timing differences from freemocap backends and the reference system ]
)
