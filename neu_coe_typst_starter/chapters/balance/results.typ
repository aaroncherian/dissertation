== Results 

=== Center-of-Mass (COM) Path Length

MediaPipe-derived COM path length closely matched the reference and preserved separation across progressively more challenging conditions (@Center-of-mass-path-length). In contrast, RTMPose and ViTPose-derived data overestimated path length and failed to clearly differentiate between conditions. 

#figure(
  image("com_path_length.svg", width: 100%),
  caption: [
  Trial-level and group-level center of mass path length plotted across balance assessment conditions for the reference system and each markerless pose estimation backend. Black lines represent group level mean and standard deviation, while grey lines represent trial level path length (n = 12). EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad
  ],
) <Center-of-mass-path-length>


=== FMC-MediaPipe Accuracy

MediaPipe-derived path length demonstrates strong agreement with the reference system (@fig-path-length-agreement) (ICC = 0.985). Systematic bias was small (1.25 mm) with limits of agreement at approximately ± 68 mm. A slope of 0.90 indicated a proportional underestimation of the path length with Bland-Altman analyses showing more underestimation in progressively harder conditions. In contrast, RTMPose and ViTPose demonstrated low ICC values (ICC < 0.10), high positive bias (726 mm and 1052 mm respectively), and wide limits of agreement. Summary metrics for comparisons across systems are shown in @tbl-path-length-agreement.  


#figure(
  image("com_path_length_agreement_ba.svg", width: 100%),
  caption: [Trial-level agreement between MediaPipe-derived and reference center of mass path length (n = 12). Left: Identity plot with unity line (dashed) and line of best fit (red). Right: Bland–Altman plot of differences between MediaPipe-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition. ]
) <fig-path-length-agreement>

#include "path_length_agreement_table.typ"

=== FMC-MediaPipe Sensitivity

The MediaPipe-based markerless system tracked COM changes due to different perturbations with strong fit to the regression line (_r_#super[2] = 0.83 - 0.96) and slopes near unity (0.89 - 1.06). Slight underestimation was observed in the visual perturbation condition. ViTPose and RTMPose-derived data demonstrated generally (_r_#super[2] = 0.03 to 0.45), with proportional bias differing substantially (slope = -6.46 to 1.58) from the ideal. 

#figure(
  image("com_sensitivity.svg", width: 100%),
  caption: [Sensitivity of MediaPipe-derived COM path length to condition-dependent perturbations. Identity plots are shown with unity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Mechanical perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Mechanical Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).],
) <fig-path-length-sensitivity>

#include "path_length_sensitivity_table.typ"   