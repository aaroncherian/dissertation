= The Landscape of Markerless Motion Capture

Markerless motion capture, as might be surmised by the name, is extraction of kinematic data from videos without the use of physical markers or specialized equipment. In the previous chapter, I discuss the main limitations of marker-based motion capture that keep it from widespread clinical use, among them: cost, ease of use, and adaptability to non-laboratory environments. Markerless approaches have often been proposed as a potential solution to this problem: providing comparable kinematic information while reducing experimental burden.

== Early markerless motion capture 
Looking back as far as 1983, we can see David Hogg examined markerless modeling of humans, publishing a seminal world mapping a model of a series of hierarchical cylinders into an image of a person walking @hoggModelbasedVisionProgram1983. In 1996 Larry Davis and Dorin Gavrila published on one of the earliest multi-markerless motion capture systems in 1996, mapping an articulated generalized cylindrical models onto images of a human @gavrila3DModelbasedTracking1996.  

While today, markerless motion capture this has generally become synonymous with using computer vision and machine learning, many early methods relied on explicitly fitting geometric models of the human body to image data. Without the ability to directly extract anatomical features from an image, these systems would measure kinematic data by working with the data they could extract, which was often the shape of the body itself. Early systems used techniques such as edge detection @gavrila3DModelbasedTracking1996, optical flow tracking @marzani3DMarkerfreeSystem2001, silhouette extraction @rosenhahnSystemMarkerlessMotion2006, and 3D visual hull reconstruction @corazzaMarkerlessMotionCapture2006. 

A fundamental shift towards the technology as we are familiar with it occurred with the introduction of deep learning-based pose estimation. 
The release of DeepPose in 2014 @toshevDeepPoseHumanPose2014 and OpenPose in 2017 @caoOpenPoseRealtimeMultiPerson2019 marked a transition point of no longer needing to reconstruct body shape explicity - now there were methods that could learn to infer joint locations directly. With this, deep-learning methods became state-of-the-art and an available, accessible method for researchers to utilize and build on @nagornyComprehensiveReviewRealTime2025. 

== Modern markerless motion capture 

Today, markerless tracking of humans has rapidly become the domain of computer vision. In the entertainment space, commercial options are widely accessible (MoveAI, Rokoko Vision, Remocapp). 

In the research space, multi-camera markerless motion capture systems are typically implemented in one of three forms, reflecting trade-offs in adaptability, accuracy and accessibility.

The first is custom-built workflows. Some studies describe the building and implementation of custom markerless workflows @nakanoEvaluation3DMarkerless2020 @needhamDevelopmentEvaluationFully2022 @Validation3DMarkerless. While these can be built to research-specific needs, they may often be difficult for other researchers to build and implement themselves without the required computer vision and programming understanding.

The second is available open-source systems. These systems are designed to be used by other researchers. Most notable here is OpenCap @uhlrichOpenCapHumanMovement2023, a software that allows for the calculation of kinematic data from two (or more) iPhones, but also includes software such as Pose2Sim @pagnonPose2SimEndtoEndWorkflow2022 or PosePipe @cottonPosePipeOpenSourceHuman2022. However, these systems may lack the flexibility to adapt to specific research needs depending on the underlying architecture.

The third and final form is in commercial, proprietary systems. Theia3D (Theia Markerless Inc., Kingston, ON, Canada) is a notable example here. These systems are often extremely accurate @kankoAssessmentSpatiotemporalGait2021 and offer a variety of analysis pipelines, but are also extremely expensive. Additionally, their proprietary and closed-source nature can limit transparency and flexibility. 

=== Remaining Challenges

As such, when we consider the landscape of quantitative motion analysis tools as a whole, there is a persistent tradeoff between accuracy, adaptability, and accessibility restricts the broader impact of motion capture technology - highlighting a critical need for a system that can address these limitations.

This work encompasses the development and validation of FreeMoCap, a free open-source motion capture software designed to simultaneously achieve accuracy through advanced computer vision, accessibility through use of low-cost hardware, and adaptability through modular software design. The following chapter introduces the software and will examine how the design choices made are meant to provide an accurate, adaptable and accessible research solution. 

== Conclusion

When discussing FreeMoCap, I have found that there are two questions I am often asked. 

The first is: "Who are your competitors?"  Ultimately, I believe the goal of this software is better described by a different question - not "What motion capture systems are we competing with?", but instead "Who has not been able to access motion capture, and how can we make it possible?". The aim of this work is to lower the barriers to collecting 3D movement data, enabling use across a range of contexts, from research to education and creative applications.

But accessibility and accuracy are not separate concerns — as the following chapter will argue, the design choices that make a system more accessible can also directly shape the quality of the data it produces. This leads to the second question I am often asked: "How accurate is your system?" Rather than providing a single summary metric, the following chapters characterize system performance across different movement domains, including dynamic gait, postural stability, and a more complex applied clinical scenario. This approach reflects the view that accuracy is not a single value, but a property that depends on context, task, and the underlying processing choices made available by the system's design.

