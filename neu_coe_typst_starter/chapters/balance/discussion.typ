
== Discussion

This work aimed to evaluate the sensitivity of a low-cost markerless motion capture to small balance changes during the Modified Clinical Test of Sensory Interaction on Balance (CTSIB-M) using postural stability metrics calculated from the center of mass (COM), specifically using three different pose estimation backends in comparison to a marker-based reference. 

To my knowledge, no markerless motion capture studies to date have validated the CTSIB-M. However the use of COM to measure path length has been validated in other systems. Ferrari et al. found that an IMU could discriminate between eyes open and closed conditions on solid ground, with moderate to strong agreement with a force plate @ferrariConstructValidityWearable2024. Gonzalez et al., notably, found that the Kinect V2 sensitivity was too low to discriminate between these conditions in quiet standing @gonzalezComparisonBodySway2021. 

In contrast, in the present study MediaPipe-derived data were able to distinguish between the different balance conditions. MediaPipe-derived COM path length showed strong agreement with the marker-based reference (ICC = 0.985). MediaPipe-derived data also showed strong sensitivity to the effects of visual, proprioceptive, and combined visual/proprioceptive perturbations on balance. Mean horizontal velocity was comparable between systems across all conditions, a notable finding given that sway velocity is regarded as one of the most reliable and clinically sensitive posturographic parameters @paillardTechniquesMethodsTesting2015 @jancovavseteckovaWHATROLEBODY2013.

Both RTMPose and ViTPose-derived data exhibited poor agreement with the reference system and lacked the sensitivity necessary to consistently distinguish between balance conditions. Poor performance in RTMPose and ViTPose is more likely attributable to frame-to-frame landmark jitter than model architecture-related error. Vertical COM variability for both RTMPose and ViTPose-derived data was substantially higher than that of the reference and MediaPipe-derived data, suggesting increased landmark jitter at rest. Despite this, the average ellipse area for RTMPose and ViTPose-derived data were comparable to the reference. As such, while the spatial distribution of COM position was preserved, the magnitude and dynamics of COM movement were elevated, further supporting that increased path length and velocity primarily reflect frame-to-frame landmark jitter.

MediaPipe's strong performance likely reflects its built-in One-Euro filter. As discussed previously (Chapter 5: Discussion), the One-Euro filter adaptively adjusts cutoff frequency based on signal velocity, applying stronger smoothing when velocity is low. As such, the One-Euro filter may suppress the frame-to-frame landmark jitter that degraded RTMPose and ViTPose results and obscured small postural shifts. These findings suggest that temporal stability in landmark tracking may be critical for detecting subtle balance changes. Future work could evaluate the implementation of similar temporal filtering to these backends' 2D keypoints prior to 3D reconstruction in order to improve their suitability for balance assessments. 

*Limitations*

In posturography, measures of body sway and path length are typically calculated from center of pressure (COP). This work uses COM as a means to calculate these metrics, which should be taken into consideration. While COM and COP are biomechanically coupled @winterBiomechanicsMotorControl2009 (i.e., COP moves to constrain the movement of COM in balance), Panzer et al. found that COP detected changes in eyes closed balance that COM could not @panzerBiomechanicalAssessmentQuiet1995. As such, future work could compare COM changes to COP using a force plate as a reference. 

*Significance* 

The NIH Toolbox Standing Balance Test, a widely used clinical implementation of the CTSIB-M, relies on a smartphone accelerometer worn at the waist to estimate postural sway @StandingBalanceTest. While validated for clinical use @pellerValidityReliabilityNIH2023, accelerometer-derived metrics capture only local acceleration at a single body point. Markerless motion capture could complement or extend such approaches by providing full-body kinematic data, enabling richer characterization of postural control strategies.


