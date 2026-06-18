// results.typ — a body part. NOT compiled on its own; #included by paper.typ.
// The one required line: import the helpers, since included files do not
// inherit definitions from paper.typ.
#import "elife.typ": *

= Results

== Reconstruction and comparison of 3D motion capture data
An overview of tasks and analyses are presented in @fig-overview. 
During all tasks, participants were simultaneously recorded by the markerless and marker-based motion capture system, with synchronized videos from the markerless system processed and triangulated using three different pose estimation software: MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, RTMPose @jiangRTMPoseRealTimeMultiPerson2023, and ViTPose @xuViTPoseSimpleVision2022, resulting in three sets of 3D markerless motion capture data per trial                                                                      .

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

Reconstructed joint-center position errors for each lower-limb joint across
speed, axis, and pose estimation backend are summarized in @fig-rmse-grid. Full
trajectories - for every joint, backend, and walking speed -7 are shown along the
mediolateral (#suppref("traj-x")), anteroposterior (#suppref("traj-y")), and
vertical (#suppref("traj-z")) axes, with the corresponding RMSE values
tabulated in #appendixtableref("rmse-x"), #appendixtableref("rmse-y"), and
#appendixtableref("rmse-z").

Joint center errors were generally under 30 mm, with the lowest error observed in the mediolateral (ML) direction. Across joints, the hip exhibited the largest overall RMSE, with approximately 20 mm of error in both the anteroposterior (AP)and vertical directions, although the magnitude of this error was largely unaffected by walking speed. 

Error increased with walking speed at distal joints (particularly in the AP and vertical directions). However, this pattern was not uniform across joints and axes. For example, AP error at the knee decreased with speed for RTMPose and ViTPose-derived trajectories. Additionally, across all trackers, vertical error at the ankle remained relatively consistent.

Across trackers, RTMPose generally exhibited the lowest trajectory error, while ViTPose exhibited the highest, particularly in the vertical direction. These differences were most apparent at the ankle and toe, where ViTPose demonstrated a consistent vertical offset relative to the marker-based reference. 




#figure(
  image("figures/gait/trajectory_rmse_grid.png", width: 100%),
  caption: [Trajectory RMSE (mm) across joints, axes, and walking speeds for each pose estimation backend. RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Rows correspond to joint centers (hip, knee, ankle, toe) and columns to pose estimation backends (MediaPipe, RTMPose, ViTPose). Error is shown separately for the mediolateral (blue), anteroposterior (orange), and vertical (green) directions. Points represent mean RMSE across all trials; error bars indicate ±1 SD.]) <fig-rmse-grid>

#figsupp(
  key: "traj-x",
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *mediolateral (X) direction* across walking speeds (0.50-2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
)[
  #image("figures/gait/trajectories_x.svg")
]

#figsupp(
  key: "traj-y",
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *anteroposterior (Y) direction* across walking speeds (0.50-2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
)[
  #image("figures/gait/trajectories_y.svg")
]

#figsupp(
  key: "traj-z",
  caption: [Comparison of lower-limb (hip, knee, ankle, toe) joint center trajectories in the *vertical (Z) direction* across walking speeds (0.50-2.50 m/s). Trajectories derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100%.],
)[
  #image("figures/gait/trajectories_z.svg")
]


== Gait: Spatiotemporal parameter agreement

We identified heel strike and toe off events and then calculated spatiotemporal gait parameters including: stance duration, swing duration, stride duration, stride length, and step length. For each gait parameter, we found Bland-Altman analyses with bais and 95% limits of agreement (LOA), and quantified agreement using intraclass correlation coefficients (ICC).  ICC values under 0.5 were interpreted as poor
agreement, 0.5-0.75 interpreted as moderate agreement, 0.75-0.90 as good agreement, and
greater than 0.90 as excellent agreement.

Spatiotemporal gait parameters, pooled across all walking speeds, showed minimal bias and excellent agreement (ICC > 0.90) with the marker-based reference (@tbl-ba-gait-pooled). Across trackers, ViTPose demonstrated near-zero bias across all parameters. RTMPose and ViTPose both exhibited tight limits of agreement (LoA), while MediaPipe showed larger deviations and wider LoA.

#include "tables/gait/ba_gait_pooled.typ"

Spatial parameters showed speed-dependent agreement, with limits of agreement widening markedly as walking speed increased (e.g., ViTPose step length: ±19 to ±88 mm). Step-length ICC decreased from strong agreement at slow speeds to moderate agreement at the fastest speed, whereas stride length remained strong across speeds (ICC > 0.90). Temporal parameters behaved differently: bias and limits of agreement remained relatively consistent across speeds, with differences clustering at multiples of the 33 ms frame interval (@fig-gait-ba), but ICC still declined at higher speeds, most sharply for stance duration. Across spatial and temporal outcomes, MediaPipe-derived parameters showed the widest limits of agreement and lowest agreement, consistent with the pooled results (@tbl-ba-gait-pooled). Full speed-stratified Bland-Altman and ICC values for spatial and temporal parameters are provided in #appendixtableref("ba-spatial") and #appendixtableref("ba-temporal") respectively. 

#figure(
  image("figures/gait/ba_stride_both.png", width: 100%),
  caption: [Bland-Altman plots of stride duration (left) and stride length (right) agreement between markerless and marker-based systems. Rows correspond to each pose estimation backend (MediaPipe, RTMPose, ViTPose), and colors indicate walking speed (0.50-2.50 m/s). Dashed lines represent bias, and dash-dot lines indicate 95% limits of agreement. Stride duration differences are reported in milliseconds and stride length differences in millimeters.],
  )
 <fig-gait-ba>

== Balance: Analyzing postural stability using center of mass

Participants completed two trials of the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M), where they stood for sixty seconds in four different conditions, each of which varied visual and standing conditions. These included standing with/on: 1) Eyes Open/Solid Ground; 2) Eyes Closed/Solid Ground; 3) Eyes Open/Foam Pad; 4) Eyes Closed/Foam Pad. We calculated center of mass (COM) for each set of pose estimation-derived 3D data and the reference system and calculated metrics often relevant to posturography including: center of mass path length, the 95% confidence ellipse area, and mean 3D COM velocity. @fig-xy-plane shows a representative example of the COM movement during each CTSIB-M condition plotted on the ground plane. 

#figure(
  image(
    "figures/balance/com_xy_plane.png", width: 100%,),
    caption: [
    Center of mass trajectories in the horizontal plane (X = mediolateral, Y = anteroposterior) for a representative trial across all conditions and trackers. 95% confidence ellipses are overlaid for each condition. EO = Eyes Open, EC = Eyes Closed.
    ]) <fig-xy-plane>

== Balance: Comparing postural stability 

@fig-posturography shows mean and trial postural metrics per condition, for each set of 3D data. Exact values can be found in the appendix in #appendixtableref("balance-metrics"). Although ellipse area across all trackers was comparable, path length and mean velocity exhibited tracker-dependent behavior. MediaPipe-derived COM path length closely matched the reference and preserved separation across progressively more challenging conditions. In contrast, RTMPose and ViTPose-derived data overestimated path length and failed to clearly differentiate between balance conditions. Similarly, MediaPipe-derived mean velocity (in the horizontal plane) was similar to the reference, though slight underestimation was observed, while RTMPose and ViTPose-derived velocity was substantially higher.

#figure(
  image("figures/balance/balance_sway_metrics.svg", width: 100%),
  caption:
  [Center of mass path group-level and trial-level mean path length comparison]) <fig-posturography>

== Balance: Agreement and sensitivity of MediaPipe-derived 3D data
We assess the agreement of MediaPipe-derived center-of-mass path length against the reference using Bland–Altman analysis, and evaluate the sensitivity of MediaPipe-derived postural sway to the perturbations induced during the CTSIB-M (@fig-sensitivity-and-agreement).

#figure(
  image("figures/balance/com_agreement_and_sensitivity.svg", width: 100%),
  caption: [placeholder]
) <fig-sensitivity-and-agreement>


MediaPipe-derived path length demonstrated strong agreement with the reference system  (ICC = 0.985). Systematic bias was small (1.25 mm) with limits of agreement at approximately ± 66 mm. A slope of 0.90 indicated a proportional underestimation of the path length with Bland-Altman analyses showing progressive underestimation in harder conditions. In contrast, VitPose and RTMPose demonstrated poor agreement (ICC < 0.10), high positive bias (726 mm and 1052 mm respectively), and wide limits of agreement. Summary metrics for comparisons across systems are shown in #appendixtableref("pl-agreement"), and identity and Bland-Altman plots for RTMPose and ViTPose derived data can be found in #appendixfigref("agreement-all").

MediaPipe-derived COM changes exhibited good-to-excellent sensitivity to different perturbations (_r_#super[2] = 0.83 - 0.96) with slope of the fitted regression line showing near one-to-one agreement (0.89 - 1.06), though slight underestimation of path length was observed under visual perturbation. ViTPose and RTMPose-derived COM changes demonstrated poor sensitivity (_r_#super[2] = 0.01 to 0.33, with proportional bias differing substantially (slope = -5.48 to 1.45) from the ideal. Summary metrics for comparisons across systems are shown in #appendixtableref("pl-sensitivity"). Identity plots per perturbation for RTMPose and ViTPose-derived data can be found in #appendixfigref("sensitivity-all").

COM velocity distributions matched closely between MediaPipe and the reference in the mediolateral and anteroposterior directions, with a consistently longer tail in the MediaPipe data; vertical-direction differences were larger during solid-ground conditions (#suppref("com-velocity")). Because little true vertical COM movement is expected on solid ground, the across-trial SD of vertical velocity indexes per-system measurement noise: in the eyes-open/solid-ground condition it was 0.90 ± 0.26 mm/s (reference), 2.40 ± 0.42 mm/s (MediaPipe), 9.60 ± 1.94 mm/s (ViTPose), and 14.25 ± 1.99 mm/s (RTMPose).

#figsupp(
  key: "com-velocity",
  caption: [Center-of-mass velocity distributions by direction and balance condition, MediaPipe-derived versus the marker-based reference. Distributions match closely in the mediolateral and anteroposterior directions, with a consistently longer tail in the MediaPipe data; the largest discrepancy is in the vertical direction during solid-ground conditions.],
)[
  #image("figures/balance/com_velocity_violin.png", width: 100%)
]


== Pose-estimation dependent scaling 



// Auto-detects parent = Figure 1 and self-numbers, even though this file is
// separate from paper.typ.
// #figsupp(
//   short: [Per-backend RMSE broken out by joint and task.],
//   caption: [Per-backend RMSE by joint and task, disaggregated.],
//   data: ([Per-joint RMSE values underlying this panel (CSV).],),
// )[
//   #placeholder(h: 6cm, label: "Figure 1—figure supplement 1")
// ]

// #figdata[Reconstructed keypoint and marker trajectories (CSV).]

// #tabledata[Trial-level values underlying Table 1 (CSV).]
