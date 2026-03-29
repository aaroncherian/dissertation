= The Landscape of Markerless Motion Capture


== Early markerless motion capture 

Markerless motion capture (the extraction of kinematic data from video without using physical markers) has a longer history than one might expect. As early as 1983, David Hogg examined markerless modeling of humans, publishing a seminal work mapping a model of a series of hierarchical cylinders into an image of a person walking @hoggModelbasedVisionProgram1983. In 1996 Davis and Gavrila published one of the earliest multi-camera markerless motion capture systems, mapping an articulated generalized cylindrical models onto images of a human @gavrila3DModelbasedTracking1996. 

Early markerless systems shared a common constraint: without the ability to directly identify anatomical features in an image, they had to work with the data they could extract: the shape of the body itself using techniques such as edge detection @gavrila3DModelbasedTracking1996, optical flow tracking @marzani3DMarkerfreeSystem2001, silhouette extraction @rosenhahnSystemMarkerlessMotion2006, and 3D visual hull reconstruction @corazzaMarkerlessMotionCapture2006. While these methods could estimate body position in space, they were complex, often computationally intensive methods that required significant expertise to implement. 

A fundamental shift towards modern markerless motion capture occurred with the introduction of deep learning-based pose estimation. 
The release of DeepPose @toshevDeepPoseHumanPose2014 in 2014 and OpenPose@caoOpenPoseRealtimeMultiPerson2019 in 2017 marked a transition point, giving researchers access to methods that could learn to infer joint locations directly. With this, deep-learning methods became state-of-the-art and the dominant approach to markerless motion capture @nagornyComprehensiveReviewRealTime2025. 

== Modern markerless motion capture 

Modern markerless motion capture is now largely defined by  machine learning-based pose estimation. Commercial tools such as MoveAI, Rokoko Vision, and Remocapp have made the technology widely accessible for entertainment and animation use, but in research, multi-camera markerless systems are typically implemented in one of three forms, reflecting trade-offs in adaptability, accuracy, and accessibility.

The first of these are custom-built workflows, developed by researchers for their specific studies @nakanoEvaluation3DMarkerless2020 @needhamDevelopmentEvaluationFully2022 @Validation3DMarkerless @yangEvaluationCameraConfigurations2025. These pipelines are described methodologically in their respective publications, but the underlying code is typically not shared, leaving other researchers to reimplement them from scratch. While custom workflows can be tailored to specific research needs, they require significant programming and computer vision expertise to build, limiting their reproducibility and adoption.

The second is open-source systems and software, designed to be used by other researchers. The most prominent example in this space is OpenCap @uhlrichOpenCapHumanMovement2023, a software that allows for the calculation of kinematic data from two (or more) iPhones, but also includes software such as Pose2Sim @pagnonPose2SimEndtoEndWorkflow2022 and PosePipe @cottonPosePipeOpenSourceHuman2022. While these systems lower the barrier to entry, they may be limited in how easily they can be adapted (e.g., swapping out the underlying pose estimation model or modifying the processing pipeline to suit a specific study design). 

The third and final form is commercial, proprietary systems, most notably, Theia3D (Theia Markerless Inc., Kingston, ON, Canada). These systems are often accurate and widely validated @kankoAssessmentSpatiotemporalGait2021 and offer a variety of analysis pipelines, but are also expensive. Additionally, their proprietary and closed-source nature can limit transparency and flexibility. 

Across these approaches, a consistent pattern emerges: improvements in accuracy, accessibility, or adaptability are typically achieved at the expense of the others

== Conclusion

We can look at the history of markerless motion capture as, in many ways, a history of shifting barriers. Early model-fitting approaches required specialized expertise and significant computational resources, limiting who could use them. The release of commercial systems such as the Kinect (see Preface for more) showed what the impact of accessible markerless technology could be on research, and advancements in deep-learning dramatically lowered the technical barrier to implementing a markerless motion capture system. However, even current systems still force compromises between accessibility, accuracy, and adaptability of the system, restricting the broader impact of motion capture technology. There is a need then for a system that can address these limitations. 

The following chapter presents FreeMoCap, a free, open-source markerless motion capture system developed to make high-detail kinematic data available to users through low-cost hardware. 