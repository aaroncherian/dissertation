== Results

=== Trajectories 

#figure(
  image("figures/trajectories_x.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-traj-x>

#figure(
  image("figures/trajectories_y.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-traj-y>


#figure(
  image("figures/trajectories_z.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-traj-z>



#include "tables/trajectory_rmse_tables.typ"

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


// #figure(
//   image("figures/ba_gait_phases.svg", ),
//   caption:  [BA of gait]
// )

#figure(
  image("figures/joint_angles_with_spm.svg")
)

#include "tables/joint_angle_rmse_table.typ"