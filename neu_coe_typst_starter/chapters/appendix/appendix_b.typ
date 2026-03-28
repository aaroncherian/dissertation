= Supplementary Balance Data

#figure(
  image("agreement_all_trackers.png"),
  caption: [Trial-level agreement between markerless and marker-based reference center of mass path length (n = 12) per tracker (Top: Mediapipe; Middle: ViTPose; Bottom: RTMPose). Left: Identity plot with unity line (dashed) and line of best fit (red). Right: Bland-Altman plot of differences between tracker-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition.]) <fig-agreement-all>

#figure(
  image("sensitivity_all_trackers.png"),
  caption: [Sensitivity of markerless system COM path length to condition-dependent perturbations across all trackers (Top: MediaPipe; Middle: RTMPose; Bottom: ViTPose). Identity plots are shown with unity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Proprioceptive perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Proprioceptive Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).] ) <fig-sensitivity-all>
)