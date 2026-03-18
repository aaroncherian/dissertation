== Discussion

*Accuracy in joint kinematics*

Average joint position error generally tended to be under 30mm, with the lowest error in the medio-lateral direction and highest in the anterior-posterior direction. These differences are comparable to results from previous studies. Nakano et al. found RMSE's generally under 30. Both trajectories and kinematic errors were similar to and under the findings by Ripic et al. @ComparisonThreedimensionalKinematics2023. Kinematic findings were on par with Theia (though we had lower for the hip and ankle) @kankoConcurrentAssessmentGait2021. We're also on par with OpenCap @uhlrichOpenCapHumanMovement2023. 

(cite other freemocap validations?)

Joint angle SPM testing also reports consist phase-specific error. During loading response after initial contact, the knee undergoes transient flexion is it absorbs shock and the ankle plantarflexes slightly (heel rocker). For the ankle, these regions correspond to the ankle plantarflexion that occurs during the loading response as it absorbs shock. Across all speeds, consistent suprathreshold clusters are noted for the knee and angle during this flexion and plantarflexion respectively. This suggests that the loading response in in gait is a period of higher reconstruction error. One possible explanation is that for a camera with a given sagittal (or close to sagittal view) of a participant, when the contralateral foot is in loading response, the ipsilateral foot closer to the camera is swinging past the contralateral leg, occluding it and potentially contributing to reconstruction error. Additionally, heel strike causes skin surface movement that propogates throughout the lower limb @painSoftTissueMotion2002 which could lead to soft tissue artifacts, a known limitation of marker-based software, meaning the reference might not be entirely accurate here as well. 

Some kinematic error appeared to be speed-dependent, decreasing as walking speed increased. This was most commonly seen in MediaPipe - particularly before and after peak hip extension and peek knee flexion. MediaPipe, in it's 'video' mode uses a one-euro filter @casiez1FilterSimple2012, an adaptive low pass filter than adapts cutoff frequency according to speed. Low speeds use a lower-cutoff frequency to reduce jitter at the expense of lag, while high speeds cutoff increases to reduce lag. The larger MediaPipe errors at slower walking speeds could be an artifact of the lag introduced by the one-euro filter adapting to slow movement with a lower-cutoff frequency, while error decreases as walking speed increases due to the filter iontroducing less temporal lag. 

 Kinematic error at the angle was also heavily driven by tracker-dependent differences. MediaPipe consistently underestimated peak plantarflexion while ViTPose overestimated it. RTMPose slightly overestimated plantarflexion but was generally the most accurate. Systematic behavior differences can be seen in late swing of the ankle. MediaPipe plantarflexes rapidly while ViTPose dorsiflexes. Overall, RTMPose is the most accurate at tracking ankle kinematics. The ankle segment is relatively small, and therefore small positional errors could propogate into joint kinematics.   


*Types of Error*

Theia also reported a systematic offset at the hips that incre


A common source of error for all joints were after or surrounding heel strike. The hip, knee and ankle all show areas of significant difference in early stance, regardless of speed. Heel strike is a violent high-impact event with impacts that propogate up through the kinematic chain. The areas of early stance error are consistent with rapid hip deceleration, the knee loading response, and the ankle first rocker response that come from impact absorption after heel strike. This suggests that there may be some effect of impactful biomechanical events on reconstruction accuracy. 

Rapid changes in acceleration (jerk) may also lead to error. Peak hip extension and peak knee flexion generally showed minimal error, but the surrounding rise and fall towards these major kinematic peaks tended to be regions of significant difference. Notably, these specific errors tended to decrease with higher walking speeds, suggesting that the error may not be to velocity itself, but the change in velocity or acceleration from the existing velocity. Consistent higher velocity movement may provide a stronger signal for pose estimation trackers to hold onto.

There were distinct tracker differences throughout. MediaPipe showed the most sensitivity of all trackers to rapid acceleration change, particularly in hip and knee angles. Tracker-specific differences seem to dominate most of the ankle error. Peak plantarflexion at toe-off show consistent tracker-specific differences across all speeds - MediaPipe appears to underestimate peak plantarflexion while ViTPose consistently overestimates. RTMPose slightly estimates, but is generally the most accurate. Late swing in the ankle also shows some tracker-specific differences - MediaPipe, especially as speed increases, suddenly plantarflexes while ViTPose suddenly dorsiflexes. Overall, RTMPose is the most accurate at tracking ankle kinematics. Generally, the ankle segment is smaller, and small positional errors may contribute to errors in ankle kinematics. 





In the hip, significant differences can be seen surrounding peak extension. During the gait cycle, the hip is decelerating leading to peak extension, and then rapidly accelerates into flexion. Error may be high in periods of rapid acceleration changes (jerk). Error is minimized at peak extension but seems to be high at peak flexion. 

The area around heel-strike in general seems to cause issues as it propogates through the body? For example - hip early stance with rapid extension seems to be error prone, as does the loading response in the knee from heel strike? 

ankle seems to have more consistent offsets (even the starting positions are different between all trackers). RTMPose seems like the clear ankle winner. At late swing, MediaPipe suddenly plantarflexes while VITPose dorsiflexes. Much of the error for the ankle, as opposed to the hip and knee - seems tracker dependent. At the hip, errors are very dynamic (acceleration and impact related). At the knee, it seems to be mostly impact, with some MediaPipe tracker errors flanking peak flexion, potentially due to acceleration. at the ankle, it seems ot be primarily tracker driver with potential impact issues layered on top. The


for gait paramter comparison

https://www.sciencedirect.com/science/article/pii/S0966636222000789?casa_token=t4i736lGOMcAAAAA:2n0cK_0pnlByGGO0cnCMOMQkkC43imJOD2YsjLEw5f20e8H_zKr-CqPS5rD6lDn3LFadnVrmEg