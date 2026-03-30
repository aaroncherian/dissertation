== Conclusion

The work examined the development and use of a low-cost, markerless motion capture system using the FreeMoCap software. In particular, I examined the accuracy and sensitivity of a six camera setup across a variety of tasks and characterized the performance of different pose estimation software. Key findings are summarized below.

*FreeMoCap showed sufficient accuracy, sensitivity, and adaptability to be used for research purposes*

The six-webcam system using the FreeMoCap software reported low metrics of error in dynamic movements and high sensitivity to subtle postural adjustment (when using a MediaPipe backend). Additionally, through integration of DeepLabCut, our system was able to adapt to a population that current out-of-the-box pose estimation software would be unable to track. 

*Pose estimation impact on reconstruction accuracy warrants further comparison and benchmarking*

Pose estimation behavior varied across tasks and metrics of sensitivity and accuracy. RTMPose, which was the most consistent and accurate backend for gait analysis, performed poorly in postural analysis. While the One-Euro filter implemented in MediaPipe caused significant differences from the reference during major movements, particularly in slow walking speeds, it also helped preserve changes in postural stability during subtle movements. ViTPose exhibited scaling differences from the reference that are crucial to consider when examining its accuracy metrics. 

Each of these behaviors was uncovered through rigorous comparison not just from gait or posture analysis along, but instead examining them in context of both. However, these are just two of many tasks for which markerless motion capture is used. 

We should consider these results in two contexts: First, that there is a need to build more standardized datasets comparing the results of pose estimation software across varied tasks, and second, that there is a need the FreeMoCap software is positioned to fulfill in allowing for the benchmarking of pose estimation software across those tasks. 


Validation pipeline? 

*Key contributions of this work*

The markerless motion capture validation field is not small, and this work joins one of many validation studies that exist in the literature. However, in the course of writing this I feel that there are a few novel contributions worth noting:

First, in *reporting speed-stratified metrics of accuracy* in gait analysis. Though there is work that covers markerless motion capture capture of behavior during walking or running, to my knowledge, there is no body of work that examines metrics of accuracy across progressive increases in speed. This experimental structure revealed trends and patterns of accuracy across speed that may be useful for researchers in conducting future validation studies. Notably, the results show that speed does not tend of have a global effect on accuracy across joints or axes of motion, suggesting that it is not simple to characterize.

Second, in *evaluating sensitivity to postural subtle differences*. To my knowledge, no markerless motion capture study has been tested on the CTSIB-M, or in examining changes in COM metrics from changes as subtle as standing still with eyes open to eyes closed. The results of this test suggest that it could also be a valid method by which other markerless motion systems can be characterized as well. 

Third, in *examining how architectural differences in pose estimation software* may affect accuracy. Metrics of accuracy between pose estimation software have been reported in many studies, but sources of error between algorithms are often attributed to the dataset they are trained on. While this is certainly true, this work proposes there are also implementation differences that may cause systematic issues - most notably exemplified by MediaPipe's One Euro filter use, or the scaling different with ViTPose-reconstructed data. While all of these results warrant further investigation, I believe it is a reminder that there is more to pose estimation algorithms than the data they are trained on, and further characterization of these algorithms is warranted. 

Finally, in introducing a fully open-source *validation pipeline*. The pipeline develped to run every analysis in this work, across every tracker, is fully open-source and available online, in the effort of promoting reproducibility and transparency. I hope to continue to format and implement this pipeline into something that other researchers can use, contribute to, and improve. 