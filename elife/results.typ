// results.typ — a body part. NOT compiled on its own; #included by paper.typ.
// The one required line: import the helpers, since included files do not
// inherit definitions from paper.typ.
#import "elife.typ": *

= Results

== Reconstruction and comparison of 3D motion capture data
An overview of tasks and analyses are presented in @fig-overview. 
During all tasks, participants were simultaneously recorded by the markerless and marker-based motion capture system, with synchronized videos from the markerless system processed and triangulated using three different pose estimation software: MediaPipe , RTMPose @jiangRTMPoseRealTimeMultiPerson2023, and ViTPose@xuViTPoseSimpleVision2022, resulting in three sets of 3D markerless motion capture data per trial                                                                      .

#figure(
         image("figures/elife_methods.png", width:100%),
  caption: [Placeholder caption for big fig]
) <fig-overview>

== Reconstructing dynamic motion with gait
Participants completed two trials of walking on a treadmill at increasing speeds, recorded simultaneously by both the markerless and marker-based motion capture system. An example of reconstructed 3D data using each pose estimation backend is shown alongside the marker-based reference in @fig-gait-reconstruction.

#figure(
  image("figures/gait/example_gait.png", width: 100%),
  caption: [Example of markerless motion capture data using each pose estimation backend. *Left*: MediaPipe (blue); *Middle*: RTMPose (orange); *Right*: ViTPose (green). The marker-based reference skeleton is displayed in black on each panel.]
) <fig-gait-reconstruction>

== Gait: Joint kinematics error 
Sagittal-plane lower-body kinematics were calculated across gait cycle-normalized strides for each pose estimation backend and walking speed. Across the gait cycle, we identified regions of significant difference between the markerless and marker-based systems using statistical parametric mapping (SPM) two-tailed t-tests, displayed in @fig-joint-ang-spm We also calculated joint angle error across joint, pose estimation backend, and walking speed. 

SPM paired t-tests ($ alpha = 0.05$) revealed common suprathreshold clusters ($t\*$ = 3.41 - 4.56 across conditions and trackers) at all joints in early stance. At the ankle, ViTPose-derived angles exhibited widespread differences spanning much of the gait cycle. At the hip and knee, MediaPipe-derived angles exhibited suprathreshold clusters whose magnitude and duration decreased with speed. .
 
#figure(
  image("figures/gait/joint_angles_with_spm.svg", width: 100%),
  caption: [Comparison of sagittal hip, knee, and ankle joint angles across walking speeds (0.50-2.50 m/s). Angles derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides and the gait cycle is normalized to 0-100%. Statistical parametric mapping (SPM) results are shown in the lower panels. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the marker-based reference are statistically significant (p < .05). ])
 <fig-joint-ang-spm>


Sagittal joint angle error was below 5° across most conditions, with the primary exception being ViTPose-derived ankle angles at higher speeds (@tbl-joint-angle-rmse).  These errors increased with speed at the knee and ankle, while hip angle error remained relatively stable. Across trackers, ViTPose-derived angles exhibited the lowest error for hip and knee angles but displayed a consistent plantarflexion offset at the ankle. RTMPose-derived ankle angles were most accurate

#include "tables/gait/joint_angle_rmse_table.typ"

== Gait: Joint position error

Reconstructed joint center position errors for each lower-limb joint across speed, axis, and pose estimation backend are summarized in @fig-rmse-grid. 


#figure(
  image("figures/gait/trajectory_rmse_grid.png", width: 100%),
  caption: [Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend. RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Rows correspond to joint centers (hip, knee, ankle, toe) and columns to pose estimation backends (MediaPipe, RTMPose, ViTPose). Error is shown separately for the mediolateral (blue), anteroposterior (orange), and vertical (green) directions. Points represent mean RMSE across all trials; error bars indicate ±1 SD.]) <fig-rmse-grid>

#figsupp(
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *mediolateral (X) direction* across walking speeds (0.50-2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
)[
  #image("figures/gait/trajectories_x.svg")
]

#figsupp(
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *anteroposterior (Y) direction* across walking speeds (0.50-2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
)[
  #image("figures/gait/trajectories_y.svg")
]

#figsupp(
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *vertical (Z) direction* across walking speeds (0.50-2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
)[
  #image("figures/gait/trajectories_z.svg")
]
)


// Auto-detects parent = Figure 1 and self-numbers, even though this file is
// separate from paper.typ.
// #figsupp(
//   short: [Per-backend RMSE broken out by joint and task.],
//   caption: [Per-backend RMSE by joint and task, disaggregated.],
//   data: ([Per-joint RMSE values underlying this panel (CSV).],),
// )[
//   #placeholder(h: 6cm, label: "Figure 1—figure supplement 1")
// ]

#figsupp(caption: [Sensitivity of agreement to camera count.])[
  #placeholder(h: 6cm, label: "Figure 1—figure supplement 2")
]

#figdata[Reconstructed keypoint and marker trajectories (CSV).]

As shown in @fig-overview, agreement varies systematically by task.

== Task-dependent backend performance

#figure(
  placeholder(h: 6cm, label: "Figure 2 — balance / Bland–Altman"),
  kind: image,
  caption: [Balance sway metrics and Bland–Altman agreement.],
) <fig-balance>

#figsupp(caption: [SPM curves for each balance metric.])[
  #placeholder(h: 6cm, label: "Figure 2—figure supplement 1")
]

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    table.header[Metric][MediaPipe][RTMPose][ViTPose],
    [Gait RMSE (deg)], [3.8], [2.9], [2.7],
    [Balance RMSE (mm)], [4.1], [5.6], [5.8],
    [ICC (gait)], [0.91], [0.95], [0.96],
  ),
  caption: [RMSE and ICC by backend and task.],
) <tab-rmse>

#tabledata[Trial-level values underlying Table 1 (CSV).]
