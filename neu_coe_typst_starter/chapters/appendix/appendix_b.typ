= Supplementary Balance Data
#import "../../template.typ": flex-caption


#figure(
  image("agreement_all_trackers.png"),
  caption: flex-caption([Trial-level agreement between markerless and marker-based reference center of mass path length (n = 12) per pose estimation backend (Top: Mediapipe; Middle: ViTPose; Bottom: RTMPose). Left: Identity plot with identity line (dashed) and line of best fit (red). Right: Bland-Altman plot of differences between tracker-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition.],
  [Trial-level agreement between markerless and marker-based center of mass path length (all pose estimation backends)])) <fig-agreement-all>

#figure(
  image("sensitivity_all_trackers.png"),
  caption: flex-caption([Sensitivity of markerless system center of mass path length to condition-dependent perturbations across all pose estimation backends (Top: MediaPipe; Middle: RTMPose; Bottom: ViTPose). Identity plots are shown with identity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Proprioceptive perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Proprioceptive Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).],
  [Sensitivity of markerless system center of mass path length to condition-dependent perturbations (all pose estimation backends)]) ) <fig-sensitivity-all>
