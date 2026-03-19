== Discussion

*Accuracy in joint kinematics*

Average joint position error generally tended to be under 30mm, with the lowest error in the medio-lateral direction and highest in the anterior-posterior direction. These differences are comparable to results from previous studies. Nakano et al. found RMSE's generally under 30. Both trajectories and kinematic errors were similar to and under the findings by Ripic et al. @ComparisonThreedimensionalKinematics2023. Kinematic findings were on par with Theia (though we had lower for the hip and ankle) @kankoConcurrentAssessmentGait2021. We're also on par with OpenCap @uhlrichOpenCapHumanMovement2023. 
McGinley et al. suggest that kinematic errors between 2-5 degrees are suitable for clinical use @mcginleyReliabilityThreedimensionalKinematic2009. Needham et al. also observed systematic differences at the knee and hip @needhamAccuracySeveralPose2021.

(cite other freemocap validations?) (find some stuff regarding error acceptable limits)

Joint angle SPM testing also reports consist phase-specific error. During loading response after initial contact, the knee undergoes transient flexion is it absorbs shock and the ankle plantarflexes slightly (heel rocker). For the ankle, these regions correspond to the ankle plantarflexion that occurs during the loading response as it absorbs shock. Across all speeds, consistent suprathreshold clusters are noted for the knee and angle during this flexion and plantarflexion respectively. This suggests that the loading response in in gait is a period of higher reconstruction error. One possible explanation is that for a camera with a given sagittal (or close to sagittal view) of a participant, when the contralateral foot is in loading response, the ipsilateral foot closer to the camera is swinging past the contralateral leg, occluding it and potentially contributing to reconstruction error. Additionally, heel strike causes skin surface movement that propogates throughout the lower limb @painSoftTissueMotion2002 which could lead to soft tissue artifacts, a known limitation of marker-based software, meaning the reference might not be entirely accurate here as well. 

Some kinematic error appeared to be speed-dependent, decreasing as walking speed increased. This was most commonly seen in MediaPipe - particularly before and after peak hip extension and peek knee flexion. MediaPipe, in it's 'video' mode uses a one-euro filter @casiez1FilterSimple2012, an adaptive low pass filter than adapts cutoff frequency according to speed. Low speeds use a lower-cutoff frequency to reduce jitter at the expense of lag, while high speeds cutoff increases to reduce lag. The larger MediaPipe errors at slower walking speeds could be an artifact of the lag introduced by the one-euro filter adapting to slow movement with a lower-cutoff frequency, while error decreases as walking speed increases due to the filter iontroducing less temporal lag. 

Kinematic error at the angle was also heavily driven by tracker-dependent differences. MediaPipe consistently underestimated peak plantarflexion while ViTPose overestimated it. RTMPose slightly overestimated plantarflexion but was generally the most accurate. Systematic behavior differences can be seen in late swing of the ankle. MediaPipe plantarflexes rapidly while ViTPose dorsiflexes. Overall, RTMPose is the most accurate at tracking ankle kinematics. The ankle segment is relatively small, and therefore small positional errors could propogate into joint kinematics.   



*Spatiotemporal gait parameters*

Generally, temporal and spatial parameters measured by the markerless system were reported with minimal bias and strong agreement. As a whole, ViTPose showed the least bias and excellent agreement across parameters of each pose estimation backend. 

Limits of agreement (LoA) for spatial metrics generally increased with speed while remaining stable for temporal metrics. However, agreement across all parameters tended to drop with speeds, with sharp declines for step length and swing duration. Generally, spatial resolution is limited by the framerate of the cameras (30Hz). Higher framerate cameras might provide better capture of positioning of spatial limbs. Additionally, while temporal data was general table, metrics are were discretized to be within .33ms of each other. Thus, higher framerate might also allow for more detailed analysis of temporal metrics. 

Our gait parameter findings match well with others. Kanko et al. found that swing time also showed the least agreement (ICC =.39), LoA for step and stride length were found to be within ± 70mm, stance time within -40 - 70ms, and swing time within -70 to 40ms @kankoAssessmentSpatiotemporalGait2021. This is similar to and within the limits of our pooled data, and our data up to 1.5m/s for spatial metrics, and our data up to 2.5m/s for temporal metrics.  Vafadar et al. found LoA within approximately ±16mm for stride and steplength, and ±15ms for stance and swing time for participants walking at a self-selected comfortable speed @vafadarAssessmentNovelDeep2022. This is way better than what we had. Idk what to make of that. The only comparable parts are potentially our spatial metrics at 0.5m/s. 

Clinically, we can compare bland-altman to minimal detectable change values to assess whether our markerless setup would have the resolution to dscriminate between impaired and healthy populations. add some notes about some mdcs from papers. 


*Tracker Comparison*
something about how ViTPose is worse with scaling, but seems to have the lowest bias for parameters. That might be a bit weird because with scaling we might expect the spatial metrics to also suffer - but looking at the trajectory rmses, most obvious 'VitPose is different than the rest' error is in the Z direction - and these psatial metrics are in the A-P direction. If we look at something like minimum toe clearance however, it might be affected. The ankle joint kinematics for ViTPose however, might be so different because the Z error for the toe is noticeably higher, which would affect the angle as the segment is pretty small, so those errors propogate. MediaPipe has the high error issues in joint kinematics, and the widest LoA in gait parameters. Overall, RTMPose shows the most accurate ankle kinematics while also having accurate spatiotemporal parameters and still having 'true-to-scale' reconstruction - so this might be the best wholecale reconstruction option for gait? 







-- redo

*Joint center and joint kinematic accuracy*

Reconstructed joint centers were generally under 30mm, with lowest error across the mediolateral axes. The hip joint center was generally the biggest source of error, with an RMSE of ~20mm in the anterior-posterior and vertical axes across speed. Kinematic error tended to be under 5°, with error errors only occurring for the ViTPose-tracked ankle angle at higher speeds. 

These metrics sit well within the limits found by other studies, with errors similar to and under what was found by Ripic et al. @ripicComparisonThreedimensionalKinematics2023. The hip is generally a known point of difficult to track, with Kanko et al. noting a 3D Euclidean error of 36mm in the hip position and an 11° difference in hip/flexion extension @kankoConcurrentAssessmentGait2021 and Needham et al. noting systemic differences in hip and knee position tracking (~30-50mm) @needhamAccuracySeveralPose2021. Marker-based motion capture can also have an error range of about 25-30mm (find sources).  McGinley et al. also suggest that errors between 2-5° are suitable for clinical use @mcginleyReliabilityThreedimensionalKinematic2009.  

*Gait parameter accuracy*

