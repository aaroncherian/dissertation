== Results 

=== Center-of-Mass (COM) Path Length
FreeMoCap using a MediaPipe backend was able to accurately capture both the relative path length and direction of sway across conditions (@fig-path-length-comparison). This preservation was seen not only on a mean level, but also on a participant level. Our system with an RTMPose and VITPose backend were much worse at accurately tracking balance. The path lengths are much higher than Qualisys. Even if the means seem to preserve order, a look at participant level data shows pretty substantial differences, so those aren't necessarily reliable. 

#figure(
  image("com_path_length.png", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-path-length-comparison>


=== FMC-MediaPipe Accuracy and Sensitivity
FMC-MediaPipe is pretty accurate.

#figure(
  image("com_path_length_agreement_ba.svg", width: 100%),
  caption: [Placeholder agreement]
) <fig-path-length-agreement>
FMC-MediaPipe is also pretty sensitive. 

#figure(
  image("com_sensitivity.svg", width: 100%),
  caption: [Placeholder sensitivity],
) <fig-path-length-sensitivity>
