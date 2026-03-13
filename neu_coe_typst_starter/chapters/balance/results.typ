== Results 

=== Center-of-Mass (COM) Path Length
When using a MediaPipe backend, our system preserve both the magnitude and relative ordering of COM path length across balance conditions(@fig-path-length-comparison). Group means and trial-level means were similar between the reference system and FMC-MediaPipe, with clear differentiation between progressively more challenging conditions. In contrast, using RTMPose and ViTPose backends showed elevated group means and poor contrast between conditions.

#figure(
  image("com_path_length.svg", width: 100%),
  caption: [Placeholder center of mass path length caption. EO = Eyes Open; EC = Eyes Closed; S = Solid Ground; F = Foam Pad],
) <fig-path-length-comparison>


=== FMC-MediaPipe Accuracy

FMC-MediaPipe demonstrated strong agreement with the reference system (@fig-path-length-agreement). A ICC of 0.986 indicated excellent agreement with the reference. Systematic bias was small (1.23 mm) with limits of agreement at approximately ± 1.2 mm/s. Proportional bias of about 0.90 indicated a tendency towards underestimation of the path length. Underestimation was most apparent in trials with higher path lengths, which primarily occurred in foam conditions. In contrast, RTMPose and ViTPose demonstrated low ICC values (ICC <.10), high positive bias (14.37 and 20.49 mm/s respectively), and wide limits of agreement.  Summary metrics for comparisons across systems are shown in @tbl-path-length-agreement.  


#figure(
  image("com_path_length_agreement_ba.svg", width: 100%),
  caption: [Placeholder agreement]
) <fig-path-length-agreement>

#include "path_length_agreement_table.typ"
FMC-MediaPipe is also pretty sensitive. 

=== FMC-MediaPipe Sensitivity

FMC-MediaPipe tracked within-subject changes in COM path length across different perturbations (_r_#super[2] = 0.92, 0.84, and 0.96 for visual, mechanical, and combined perturbations respectively). Sensitivity to visual perturbations exhibited about an 11% underestimation of path length change , while sensitivity to mechanical and combined perturbations exhibited slight overestimation (4% and 7% respectively). RTMPose and ViTPose demonstrated generally poor fits (_r_#super[2] = 0.03 to 0.45), with proportional bias differing substantially (slope = -6.46 to 1.58.) from the ideal. 

#figure(
  image("com_sensitivity.svg", width: 100%),
  caption: [Placeholder sensitivity],
) <fig-path-length-sensitivity>

#include "path_length_sensitivity_table.typ"   