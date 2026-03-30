#import "../../template.typ": flex-caption

== Results 

=== Postural stability metrics

Postural stability metrics are summarized in @tbl-postural-metrics. Average ellipse area showed comparable values over all trackers with respect to the reference. @fig-xy-plane shows COM trajectories in the horizontal plane with a 95% confidence ellipse overlay for a representative trial. 

#include ("tables/balance_metrics_table.typ")

#figure(
  image(
    "figures/com_xy_plane.png", width: 100%,),
    caption: flex-caption( [
    Center of mass trajectories in the horizontal plane (X = mediolateral, Y = anteroposterior) for a representative trial across all conditions and trackers. 95% confidence ellipses are overlaid for each condition. EO = Eyes Open, EC = Eyes Closed.
    ],
    [Center of mass trajectories on the horizontal plane] )
) <fig-xy-plane>


Although ellipse area across all trackers was comparable, path length and mean velocity exhibited tracker-dependent behavior. 
MediaPipe-derived COM path length closely matched the reference and preserved separation across progressively more challenging conditions (@Center-of-mass-path-length). In contrast, RTMPose and ViTPose-derived data overestimated path length and failed to clearly differentiate between balance conditions. Similarly, MediaPipe-derived mean velocity (in the horizontal plane) was similar to the reference, though slight underestimation was observed, while RTMPose and ViTPose-derived velocity was substantially higher.

#figure(
  image("figures\com_path_length.svg", width: 100%),
  caption: flex-caption([
  Trial-level and group-level center of mass path length plotted across balance assessment conditions for the reference system and each markerless pose estimation backend. Black lines represent group level mean and standard deviation, while grey lines represent trial level path length (n = 12). EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad
  ],
  [Center of mass path group-level and trial-level mean path length comparison])
) <Center-of-mass-path-length>


=== Center-of-mass velocity distribution

COM velocity distributions between MediaPipe-derived and marker-based reference data closely matched in the ML and AP directions, though MediaPipe-derived COM velocity distributions had a consistently longer tail (@fig-violin). Larger differences were seen in the vertical direction, particularly during the solid ground conditions. As we expect little vertical movement in the COM on solid ground, this largely reflects measurement noise for each system rather than true postural movement. In the Eyes Open/Solid Ground condition, mean vertical velocity SD across trials was 0.90 ± 0.26 mm/s for the marker-based reference, 2.40 ± 0.42 mm/s for MediaPipe-derived data, 9.60 ± 1.94 mm/s for ViTPose-derived data, and 14.25 ± 1.99 mm/s for RTMPose-derived data.

#figure(
  image(
    "figures/com_velocity_violin.png", width: 85%),
    caption: flex-caption([Frame-level distribution of center of mass (COM) velocity data per condition for marker-based reference data (gray) and markerless MediaPipe-derived data (blue) for mediolateral (top), anteroposterior (middle) and vertical directions (bottom).],
    [Comparison of frame-level distribution of center of mass (COM) velocity data per condition])
) <fig-violin>


=== Markerless system agreement 

MediaPipe-derived path length demonstrated strong agreement with the reference system (@fig-path-length-agreement) (ICC = 0.985). Systematic bias was small (1.25 mm) with limits of agreement at approximately ± 68 mm. A slope of 0.90 indicated a proportional underestimation of the path length with Bland-Altman analyses showing progressive underestimation in harder conditions. In contrast, RTMPose and ViTPose demonstrated poor agreement (ICC < 0.10), high positive bias (726 mm and 1052 mm respectively), and wide limits of agreement. Summary metrics for comparisons across systems are shown in @tbl-path-length-agreement, and identity and Bland-Altman plots for RTMPose and ViTPose derived data can be found in Appendix B ( @fig-agreement-all).  


#figure(
  image("com_path_length_agreement_ba.svg", width: 100%),
  caption: flex-caption([Trial-level agreement between MediaPipe-derived and reference center of mass path length (n = 12). Left: Identity plot with identity line (dashed) and line of best fit (red). Right: Bland-Altman plot of differences between MediaPipe-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition.],
  [Center of mass path length agreement between systems])
) <fig-path-length-agreement>

#include "path_length_agreement_table.typ"

=== Markerless system sensitivity 
MediaPipe-derived COM changes exhibited good-to-excellent sensitivity to different perturbations (_r_#super[2] = 0.83 - 0.96) with slope of the fitted regression line showing near one-to-one agreement (0.89 - 1.06), though slight underestimation of path length was observed under visual perturbation ( @fig-path-length-sensitivity). ViTPose and RTMPose-derived COM changes demonstrated poor sensitivity (_r_#super[2] = 0.03 to 0.45), with proportional bias differing substantially (slope = -6.46 to 1.58) from the ideal. Identity plots per perturbation for RTMPose and ViTPose-derived data can be found in Appendix B (@fig-sensitivity-all).

#figure(
  image("com_sensitivity.svg", width: 100%),
  caption: flex-caption([Sensitivity of MediaPipe-derived COM path length to condition-dependent perturbations. Identity plots are shown with identity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Proprioceptive perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Proprioceptive Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).],
  [Sensitivity of markerless system to condition-dependent perturbations])
) <fig-path-length-sensitivity>

#include "path_length_sensitivity_table.typ"   