
The aim of this work was to determine whether a markerless motion capture system is sensitive to small postural balance changes using center of mass (COM) measures, and accurate in postural measurement when compared to a marker-based reference. We evaluated three pose estimation backends from which 3D data were reconstructed. 

Our results show that MediaPipe-derived data preserved condition-dependent ordering in COM path length across progressively more difficult conditions and demonstrated strong agreement with the reference system. MediaPipe-derived data also showed strong sensitivity to the effects of visual, proprioceptive, and combined visual/proprioceptive perturbations on balance. In contrast, both RTMPose- and ViTPose-derived data exhibited poorer agreement with the reference system and reduced sensitivity to changes in balance across conditions. 

Because vertical center-of-mass motion during quiet standing is minimal, the eyes-open, firm-surface condition can serve as a practical lower bound on detectable motion. Variability in this condition therefore provides insight into the baseline noise characteristics of the system. Variability for both RTMPose- and ViTPose-derived data was substantially higher than that of the reference and MediaPipe-derived data, suggesting increased measurement noise that may contribute to their reduced sensitivity and agreement.

As previously discussed (Chapter 3 Discussion), MediaPipe make use of the One-Euro filter for temporal smoothing @casiez1FilterSimple2012. The One-Euro filter adaptively adjusts cutoff frequency based on signal velocity, applying stronger smoothing when velocity is low. In contrast, RTMPose and ViTPose-derived data may be more susceptible to frame-to-frame landmark noise, which could obscure small postural changes of interest, particularly in conditions where movement amplitudes are minimal.. Future work could evaluate the implementation of similar temporal filtering to these backends' 2D keypoints prior to 3D reconstruction in order to improve their suitability for balance assessments. These findings suggest that temporal stability in landmark tracking may be critical for detecting subtle balance changes.  

Few markerless motion capture studies have examined static balance using CoM metrics. 
Eveleigh et al. @eveleighPrincipalComponentAnalysis2023 and Federolf et al. @federolfValidationMarkerlessTheia3D2025 both validate Theia Markerless for balance and postural assessment using principal component analysis (PCA) to extract whole-body movement patterns. While thorough, we adopted a COM approach because it might be inherently more understandable for clinicians. 

Chaumeil et al. (2024) previously demonstrated that COM position estimated from a commercial markerless system (Theia3D) agreed with marker-based estimates to within approximately 1 cm during dynamic balance tasks @chaumeilAgreementMarkerlessMarkerbased2024, suggesting that markerless-derived COM is sufficiently accurate for balance research. The present findings are consistent with this conclusion: the strong ICCs observed across conditions (0.760-0.97) indicate that open-source markerless systems similarly preserve the relative structure of COM-based balance measures.

Mean velocity between systems showed close agreement, with both systems capturing progressive increases in velocity over more difficult conditions. Sway velocity, typically calculated from COP, is regarded as one of the most reliable and clinically sensitive parameters in posturography @paillardTechniquesMethodsTesting2015, @jancovavseteckovaWHATROLEBODY2013. Center of mass and center of pressure are biomechanically coupled @winterStiffnessControlBalance1998, with center of pressure moving to constrain movement of center of mass. The agreement in COM velocity observed here suggests that markerless-derived sway velocity may serve a similar clinical role to COP velocity.

Accordingly, one limitation of this study is lack of center of pressure, which is most often used in posturography, to use as a reference, as behavior between COM and COP in quiet standing can vary @panzerBiomechanicalAssessmentQuiet1995. However, the NIH Toolbox uses an implementation of the CTSIB-M called the Standing Balance Test, which uses a smartphone accelerometer worn as a waist to detect postural sway, calculating path length metrics from that @StandingBalanceTest, which has also been validated in use for balance studies @pellerValidityReliabilityNIH2023. Ferrari et al. also found use in using an IMU to discriminate between eyes open and closed on solid ground balance conditions, finding moderate to strong agreement with a force plate @ferrariConstructValidityWearable2024. Both these were able to get results using a proxy COM, and our work essentially does this. 

Gonzalez et al. (2021) found that COM-based displacement parameters from the Kinect v2 could not discriminate between eyes-open and eyes-closed conditions during quiet standing, attributing this to the limited sensitivity of COM to increased corrective activity during visual deprivation. In contrast, the present study found that COM path length derived from FreeMoCap distinguished all four Romberg conditions, suggesting that modern pose estimation systems may offer sufficient resolution to detect condition-dependent changes in COM sway that earlier markerless devices could not @gonzalezComparisonBodySway2021.

wrt to force plates that do COP, COM may be more reflective of real body movement due to joint strategies, but has been relatively hard to achieve clinically w/o accessible tech

". Indeed, the
mean velocity is considered a parameter with good power of
discrimination between different sensorial situations, aging,
or neurological disease (Paillard and Noé, 2015; Raymakers et al., 2005) and with better reproducibility (Raymakers
et al., 2005)." https://link.springer.com/article/10.1007/s42600-021-00161-4 Kinect standing test 


PCA/theia: https://www.sciencedirect.com/science/article/pii/S0021929023001252?casa_token=zbV_VIAykxEAAAAA:EZIhK8U1XisN0agUW2Es9ar9xJJFj0xXvOMD52AoHQKth2WlfiCoHLgK7oIg3fS2WyVs9u49uA

another theia PCA: https://www.sciencedirect.com/science/article/pii/S0021929025003434?via%3Dihub#b0100


balance but in lean (some notes on there being 'few' papers to reference): https://www.sciencedirect.com/science/article/pii/S0021929024000952?casa_token=r8IvW6jRSGoAAAAA:yXA0uItF7kdAwnYQg8w8T76qTgL8y3RUYl_uDEGjEDYfKADwoGUW0wdrWR3H5X7pA0G_nDwsMA#b0135



https://www.sciencedirect.com/science/article/pii/S0966636212001208?via%3Dihub#bib0085: path length is a valid outcome mesure

A previous study found that an IMU sensor was able to discriminate between eyes open and closed balance assessments relative to a force plate, finding significant difference with moderate to strong agreement @ferrariConstructValidityWearable2024. Studies using motion capture to find values such as path length and mean velocity are limited. 

- there aren't many markerless motion capture validations related to posture, necessarily, a lot for gait
- previous studies are a bit different than ours


https://www.archives-pmr.org/article/S0003-9993(95)80024-7/pdf COG path length 