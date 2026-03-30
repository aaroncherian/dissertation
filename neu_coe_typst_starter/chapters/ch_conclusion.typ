= Conclusion

The work examined the development and use of a low-cost, markerless motion capture system using the FreeMoCap software. In particular, I examined the accuracy and sensitivity of a six camera setup across a variety of tasks and characterized the performance of different pose estimation software. Key findings are summarized below.

== Key Findings

_FreeMoCap showed sufficient accuracy and sensitivity in measuring gait and balance._ In Chapters 5 and 6, a six-webcam system using the FreeMoCap software reported low metrics of error in dynamic movements and high sensitivity to subtle postural adjustment (when using a MediaPipe backend). 

_FreeMoCap is capable of adapting to research specific needs._ In Chapter 7, through integration of DeepLabCut, our system was able to adapt to a population that current out-of-the-box solutions are largely unsuited for. Beyond demonstrated a potential use case in prosthetic alignment evaluation, this study also shows how our integration with DLC allows for custom training of models to adapt a variety of research needs.

_Pose estimation impact on reconstruction accuracy warrants further comparison and benchmarking._ Pose estimation behavior varied across tasks and metrics of sensitivity and accuracy. RTMPose, the most consistent and accurate backend for gait analysis, performed poorly in postural analysis. MediaPipe's One-Euro filter caused significant differences from the reference during major movements, particularly in slow walking speeds, but also helped preserve changes in postural stability during subtle movements. ViTPose exhibited scaling differences from the reference that are crucial to consider when examining its accuracy metrics. 

Each of these behaviors was uncovered through rigorous comparison not just from gait or posture analysis along, but instead examining them in context of both. However, these are just two of many the tasks for which markerless motion capture is used. These results point to two needs: first, for more standardized datasets comparing pose estimation software across varied tasks, and second, that there is a need that the FreeMoCap software is positioned to fulfill in allowing for the benchmarking of pose estimation software across those tasks. 

== Key Contributions

The markerless motion capture validation field is not small. This work joins a growing body of markerless system validation literature, but makes several contributions that I believe extend beyond the specific results reported here.

First, in _reporting speed-stratified metrics of accuracy_ in gait analysis. Though prior work has examined markerless motion capture capture during walking or running, to my knowledge there is no body of work that examines metrics of accuracy across progressive increases in speed. This experimental structure revealed trends and patterns of accuracy across speed that may be useful for future markerless studies. Notably, the results show that speed does not tend of have a global effect on accuracy across joints or axes of motion, suggesting that its influence is not simple to characterize.

Second, in _evaluating sensitivity to postural subtle differences_. To my knowledge, no multi-camera markerless motion capture study has been tested on the CTSIB-M. The results of this test suggest that it could also be a valid method by which the sensitivity of other markerless motion systems can be characterized as well. 

Third, in _examining how architectural differences in pose estimation software may affect accuracy_. Metrics of accuracy between pose estimation software have been reported in many studies, but sources of error between algorithms are often attributed primarily to training data. While this is certainly a factor, this work proposes that implementation differences that may also cause systematic issues - most notably exemplified by MediaPipe's One Euro filter and the scaling discrepancy with ViTPose-reconstructed data. While all of these results warrant further investigation, they are a reminder that there is more to pose estimation algorithms than the data they are trained on, and further characterization of these algorithms, perhaps in collaboration with machine learning experts, is warranted.

Finally, in introducing a fully open-source _validation pipeline_. The pipeline developed to run every analysis in this work, across every tracker, is fully open-source and available online, in the effort of promoting reproducibility and transparency. I hope to continue to format and implement this pipeline into something that other researchers can use, contribute to, and improve. 



== Future Directions

The most immediate future direction is continued development of the FreeMoCap software. Many of the potential benefits described in this work (modular pose estimation, open-source benchmarking, adaptability through custom model integration) require continued iteration to make these components easily accessible to researchers across domains and experience levels. This includes packaging the gait and balance analyses developed here into a toolbox that other researchers can freely use, extend and improve. 

More broadly, I believe the field would benefit from shared, standardized validation datasets that allow direct comparison across markerless systems and pose estimation backends. FreeMoCap, as a free and open-source platform, is well-positioned to support that effort.

