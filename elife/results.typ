// results.typ — a body part. NOT compiled on its own; #included by paper.typ.
// The one required line: import the helpers, since included files do not
// inherit definitions from paper.typ.
#import "elife.typ": *

= Results

== Reconstruction and comparison of 3D motion capture data

Participants completed both a gait and balance assessment while being simultaneously recorded by the markerless and marker-based motion capture systems to characterize the ability of the markerless system to capture both dynamic and subtle movements (@fig-overview). Joint centers calculated from the marker-based data served as the reference for comparison. The markerless data were produced using a single FreeMoCap pipeline in which 2D pose estimation (the detection of body keypoints within each camera view) was treated as an interchangeable module. Each trial was processed separately using three pose estimation backends: MediaPipe @lugaresiMediaPipeFrameworkBuilding2019, RTMPose @jiangRTMPoseRealTimeMultiPerson2023, and ViTPose @xuViTPoseSimpleVision2022. All other stages of the pipeline, including multi-camera synchronization, calibration, and triangulation, were held constant. Each trial therefore yielded three sets of 3D markerless data that differed only in the pose estimator used to generate the underlying 2D keypoints.

#figure(
         image("figures/elife_methods.png", width:100%),
  caption: [Overview of the study design and validation analyses. *A.* Markerless and marker-based motion capture data were acquired simultaneously using six consumer webcams and a reference marker-based system. *B.* Participants completed two complementary movement assessments: treadmill walking across increasing speeds to evaluate dynamic gait performance and the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M) to evaluate subtle postural adjustments under progressively more challenging sensory conditions. *C.* Markerless data were reconstructed using three pose estimation backends: MediaPipe, ViTPose, and RTMPose, and compared with the marker-based reference. *D.* Gait validity was evaluated across increasing walking speeds using 3D joint trajectories, joint kinematics, and spatiotemporal gait parameters. Analyses included error metrics, statistical parametric mapping, Bland-Altman analysis, and intraclass correlation coefficients. *E.* Balance validity was evaluated during the CTSIB-M using whole-body center-of-mass trajectories, path length, 95% confidence ellipse area, and mean horizontal velocity. Analyses assessed both agreement with the marker-based reference and sensitivity to visual, proprioceptive, and combined sensory perturbations.]
) <fig-overview>

== Reconstructing dynamic motion with gait
Participants completed two treadmill walking trials in which walking speed was progressively increased (from 0.5 to 2.5 m/s at 0.5 m/s increments), with simultaneous recording by the markerless and marker-based motion capture systems. Representative 3D reconstructions from each pose estimation backend are shown alongside the marker-based reference in @fig-gait-reconstruction.

#figure(
  image("figures/gait/example_gait.png", width: 100%),
  caption: [Example of markerless motion capture data using each pose estimation backend. *Left*: MediaPipe (blue); *Middle*: RTMPose (orange); *Right*: ViTPose (green). The marker-based reference skeleton is displayed in black on each panel.]
) <fig-gait-reconstruction>

== Gait: Joint kinematics error 
Sagittal-plane lower-body joint kinematics were calculated from gait cycle-normalized strides for each pose estimation backend and walking speed. Regions of significant difference between the markerless and marker-based joint angle trajectories were identified using statistical parametric mapping (SPM) two-tailed t-tests and are shown in @fig-joint-ang-spm. We also quantified joint angle error across joints, pose estimation backends, and walking speed using RMSE. 

SPM paired t-tests ($ alpha = 0.05$) revealed common suprathreshold clusters during early stance at all three joints, with on backends. At the ankle, ViTPose-derived angles exhibited widespread differences spanning much of the gait cycle. At the hip and knee, MediaPipe-derived angles exhibited suprathreshold clusters whose magnitude and duration decreased as walking speed increased.
 
#figure(
  image("figures/gait/joint_angles_with_spm.svg", width: 100%),
  caption: [Comparison of sagittal hip, knee, and ankle joint angles across walking speeds (0.50-2.50 m/s). Angles derived from MediaPipe (blue), RTMPose (orange), and ViTPose (green) are shown alongside the marker-based reference (grey). Shaded error bars indicate ±1 SD across strides and the gait cycle is normalized to 0-100%. Statistical parametric mapping (SPM) results are shown in the lower panels. Dashed lines indicate the critical threshold (t\*), and shaded regions denote time intervals where differences from the marker-based reference are statistically significant (p < .05). ])
 <fig-joint-ang-spm>


Sagittal-plane joint angle RMSE remained below 5° for most conditions, with the primary exception of ViTPose-derived ankle angles at higher walking speeds (@tbl-joint-angle-rmse). These errors increased with speed at the knee and ankle, while hip angle error remained relatively stable. ViTPose produced the lowest hip and knee errors overall but showed a consistent plantarflexed offset at the ankle, whereas RTMPose produced the most accurate ankle angles.

#include "tables/gait/joint_angle_rmse_table.typ"

== Gait: Joint position error

Reconstructed joint center position errors for each lower-limb joint, walking speed, axis, and pose estimation backend are summarized in @fig-rmse-grid. Full joint center trajectories for every joint, backend, and walking speed are shown along the mediolateral (#suppref("traj-x")), anteroposterior (#suppref("traj-y")), and vertical (#suppref("traj-z")) axes. Corresponding RMSE values are provided in #appendixtableref("rmse-x"), #appendixtableref("rmse-y"), and #appendixtableref("rmse-z").

Joint-center RMSE was generally below 30 mm and was lowest in the mediolateral (ML) direction. Across joints, the hip exhibited the largest overall error, with an RMSE of approximately 20 mm in both the anteroposterior (AP) and vertical directions. However, hip error was largely unaffected by walking speed.

At more distal joints, error generally increased with walking speed, particularly in the AP and vertical directions, although this pattern varied across joints, axes, and pose estimation backends. For example, AP knee error decreased with speed for RTMPose and ViTPose-derived trajectories, while vertical ankle error remained relatively stable across speeds for all three backends.

Across pose estimation backends, RTMPose generally produced the lowest joint center trajectory error, whereas ViTPose produced the highest, particularly in the vertical direction. These differences were most pronounced at the ankle and toe, where ViTPose-derived trajectories showed a consistent vertical offset relative to the marker-based reference.


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

Heel-strike and toe-off events were identified and used to calculate stance duration, swing duration, stride duration, stride length, and step length. Agreement with the marker-based reference was assessed for each parameter using Bland-Altman bias and 95% limits of agreement (LoA), together with intraclass correlation coefficients (ICC). ICC values below 0.50 were interpreted as poor agreement, values from 0.50 to 0.75 as moderate, values from 0.75 to 0.90 as good, and values above 0.90 as excellent.

When pooled across walking speeds, spatiotemporal gait parameters showed minimal bias and excellent agreement with the marker-based reference (ICC > 0.90; @tbl-ba-gait-pooled). Across pose estimation backends, ViTPose-derived data produced near-zero bias for all parameters. RTMPose and ViTPose-derived data both showed relatively narrow LoA, whereas MediaPipe-derived data showed larger deviations and wider LoA.

#include "tables/gait/ba_gait_pooled.typ"

Agreement for spatial parameters was speed dependent, with LoA widening markedly as walking speed increased (e.g., ViTPose step length: ±19 to ±88 mm). Step length ICC decreased from strong agreement at slow speeds to moderate agreement at the fastest speed, whereas stride length remained excellent across speeds. Temporal parameters showed a different pattern: bias and limits of agreement remained relatively consistent across speeds, with differences clustering at multiples of the 33 ms frame interval (@fig-gait-ba), but ICC still declined at higher speeds, most sharply for stance duration. Across spatial and temporal parameters, MediaPipe-derived data produced the widest LoA and lowest ICC values, consistent with the pooled results (@tbl-ba-gait-pooled). Full speed-stratified Bland–Altman and ICC results are provided for spatial parameters in #appendixtableref("ba-spatial") and temporal parameters in #appendixtableref("ba-temporal").

#figure(
  image("figures/gait/ba_stride_both.png", width: 100%),
  caption: [Bland-Altman plots of stride duration (left) and stride length (right) agreement between markerless and marker-based systems. Rows correspond to each pose estimation backend (MediaPipe, RTMPose, ViTPose), and colors indicate walking speed (0.50-2.50 m/s). Dashed lines represent bias, and dash-dot lines indicate 95% limits of agreement. Stride duration differences are reported in milliseconds and stride length differences in millimeters.],
  )
 <fig-gait-ba>

== Balance: Analyzing postural stability using center of mass

We next evaluated whether the same markerless reconstructions captured differences in postural stability during standing balance tasks. Participants completed two trials of the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M). During each trial, participants stood for 60 seconds under four conditions that varied visual input and support surface stability: 1) eyes open on a firm surface, 2) eyes closed on a firm surface, 3) eyes open on a foam surface, and 4) eyes closed on a foam surface. Center of mass (COM) trajectories were estimated from each pose estimation backend and from the marker-based reference. Postural stability was then quantified using COM path length, 95% confidence ellipse area, and mean three-dimensional COM velocity. Representative COM trajectories projected onto the ground plane for each mCTSIB condition are shown in @fig-xy-plane.

#figure(
  image(
    "figures/balance/com_xy_plane.png", width: 100%,),
    caption: [
    Center-of-mass trajectories in the horizontal plane for a representative trial across the four CTSIB-M conditions. Rows show trajectories derived from the marker-based reference and each pose estimation backend; columns show the eyes open/solid, eyes closed/solid, eyes open/foam, and eyes closed/foam conditions. Dashed lines indicate the 95% confidence ellipse for each trajectory. Although the overall spatial extent of sway was broadly similar across systems, RTMPose and ViTPose-derived trajectories exhibited greater frame-to-frame variability than the reference and MediaPipe-derived trajectories. AP = anteroposterior; ML = mediolateral; EO = eyes open; EC = eyes closed.
    ]) <fig-xy-plane>

== Balance: Comparing postural stability 

Mean posturographic metrics and individual trial values for each balance condition and 3D dataset are shown in @fig-posturography. Exact values are provided in #appendixtableref("balance-metrics").

Although 95% confidence ellipse area was comparable across pose-estimation backends and the marker-based reference, only MediaPipe-derived COM path length and mean horizontal velocity closely matched the reference and preserved the expected separation across progressively more challenging balance conditions. In contrast, RTMPose- and ViTPose-derived path length and velocity overestimated the reference and did not clearly differentiate among conditions.


#figure(
  image("figures/balance/balance_sway_metrics.svg", width: 100%),
  caption:
  [Center-of-mass balance metrics across CTSIB-M conditions for the marker-based reference and each pose-estimation backend. Rows show path length, 95% confidence ellipse area, and mean horizontal COM velocity; columns show the reference, MediaPipe, RTMPose, and ViTPose-derived results. Gray lines represent individual trials, and colored lines with error bars represent the group mean and variability. MediaPipe-derived path length and mean horizontal velocity closely followed the reference and preserved the progressive separation among balance conditions, whereas RTMPose and ViTPose produced elevated estimates with less distinct condition separation. Ellipse area was comparatively similar across systems.]) <fig-posturography>

== Balance: Agreement and sensitivity of MediaPipe-derived 3D data
We further examined the validity of MediaPipe-derived COM path length by evaluating two complementary properties: agreement, defined as the correspondence between absolute path-length values from the two systems, and sensitivity, defined as the ability to reproduce the change in path length associated with three sensory perturbations. These comprised removal of visual information (Eyes Closed/Solid Ground minus Eyes Open/Solid Ground), altered proprioceptive information (Eyes Open/Foam minus Eyes Open/Solid Ground), and combined visual and proprioceptive perturbation (Eyes Closed/Foam minus Eyes Open/Solid Ground) (@fig-sensitivity-and-agreement).

#figure(
  image("figures/balance/com_agreement_and_sensitivity.svg", width: 100%),
  caption: [Agreement and sensitivity of MediaPipe-derived center of mass path length relative to the marker-based reference. *A.* Absolute agreement between MediaPipe-derived and reference path length across all balance conditions; the dashed line indicates identity and the solid line shows the fitted regression. ICC and regression slope summarize absolute agreement. *B.* Bland-Altman analysis of absolute path length, with points colored by balance condition; the central dashed line indicates the mean difference between systems, and the outer dotted lines indicate the 95% limits of agreement. *C-E.* Sensitivity to removal of visual information (C: Eyes Closed/Solid Ground minus Eyes Open/Solid Ground), altered proprioceptive information (D: Eyes Open/Foam minus Eyes Open/Solid Ground), and combined visual and proprioceptive perturbation (E: Eyes Closed/Foam minus Eyes Open/Solid Ground). Positive values indicate an increase in path length under the perturbed condition. The dashed lines indicate identity and the solid lines show the fitted regression. $r^2$ and regression slope summarize sensitivity.]) <fig-sensitivity-and-agreement>


MediaPipe-derived path length demonstrated excellent agreement with the reference system  (ICC = 0.985). Mean bias was small (1.25 mm) with 95% limits of agreement at approximately ±66 mm. A slope of 0.90 indicated proportional underestimation of the path length, and the condition-stratified Bland-Altman results showed that this underestimation became more apparent in the more challenging balance conditions. By comparison, ViTPose and RTMPose-derived data showed poor agreement (ICC < 0.10), large positive biases of 726 and 1052 mm, respectively, and wide limits of agreement. Agreement statistics for all three backends are provided in #appendixtableref("pl-agreement"), with identity and Bland–Altman plots for RTMPose and ViTPose shown in #appendixfigref("agreement-all").

MediaPipe also reproduced the condition-induced changes in COM path length. Across sensory perturbations, changes derived from MediaPipe were strongly associated with changes in the reference (r#super[2] = 0.83-0.96), and regression slopes were close to the ideal value of one (0.89-1.06). This indicates that MediaPipe captured not only absolute differences among participants and trials, but also the magnitude of the postural response to altered visual and surface conditions. A slight underestimation was observed for the visual perturbation. In contrast, changes derived from ViTPose and RTMPose showed weak correspondence with the reference (r#super[2] = 0.01–0.33), with slopes ranging from −5.48 to 1.45. Sensitivity statistics for all backends are provided in #appendixtableref("pl-sensitivity"), and the corresponding RTMPose and ViTPose identity plots are shown in #appendixfigref("sensitivity-all").

COM velocity provided an additional view of backend-specific measurement behavior. MediaPipe and the marker-based reference showed similar mediolateral and anteroposterior velocity distributions, although the MediaPipe distributions had consistently longer tails. Differences were larger in the vertical direction during solid-ground conditions (#suppref("com-velocity")). Because little true vertical COM movement is expected while standing on a firm surface, variability in vertical velocity provides an indication of measurement noise. In the eyes-open, solid-ground condition, the across-trial standard deviation was 0.90 ± 0.26 mm/s for the reference, 2.40 ± 0.42 mm/s for MediaPipe, 9.60 ± 1.94 mm/s for ViTPose, and 14.25 ± 1.99 mm/s for RTMPose.

#figsupp(
  key: "com-velocity",
  caption: [Center-of-mass velocity distributions by direction and balance condition, MediaPipe-derived versus the marker-based reference. Distributions match closely in the mediolateral and anteroposterior directions, with a consistently longer tail in the MediaPipe data; the largest discrepancy is in the vertical direction during solid-ground conditions.],
)[
  #image("figures/balance/com_velocity_violin.png", width: 100%)
]


== Pose-estimation dependent scaling 

To evaluate global differences in reconstructed body size, we examined the uniform scale factor required to align each markerless reconstruction with the marker-based reference across trials from both tasks (@fig-scaling). A scale factor below 1 indicates that the markerless reconstruction was larger than the reference and therefore required downscaling. ViTPose showed a consistent scaling offset, with a median scale factor of 0.98 (range: 0.96-0.98), corresponding to reconstructions approximately 2-4% larger than the marker-based reference. By contrast, MediaPipe and RTMPose scale factors were centered near 1, indicating little systematic global scaling bias (MediaPipe median: 1.00, range: 0.98-1.01; RTMPose median: 1.00, range: 0.99-1.01).


 #figure(
  image("figures/scaling/scaling_factor_boxplot.svg", width: 70%),
  caption: [Uniform scale factors estimated for each trial during spatial
  alignment of the markerless reconstructions to the marker-based reference.
  Values are shown for RTMPose (orange), MediaPipe (blue), and ViTPose
  (green). A scale factor below 1 indicates that the markerless reconstruction
  was larger than the reference and required downscaling. The dashed horizontal
  line indicates a scale factor of 1, corresponding to no global difference
  in reconstructed size.],)
 <fig-scaling>


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
