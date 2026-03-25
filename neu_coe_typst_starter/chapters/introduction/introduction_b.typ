= The Landscape of Markerless Motion Capture

In the preceding chapter, we discussed the main limitations of marker-based motion capture that keep it from widespread clinical use: cost, ease of use, and adaptability to non-laboratory environments. Markerless motion capture, as can be surmised by the name, is the process of extracting kinematic data from videos without the need for markers or specialized equipment, and has oft been proposed as a potential solution to this problem: providing the similar levels of kinematic data to marker-based motion capture but without the same burden of marker placement and data clean up. 


* Markerless motion capture: then, and now *

Today, markerless motion capture this has generally become synonymous with using computer vision and machine learning. However, research into markerless motion capture stretches much further back. Davis and Gavrila published on one of the earliest multi-markerless motion capture systems in 1996, mapping an articulated generalized cylindrical models onto images of a human @gavrila3DModelbasedTracking1996, while as far back as 1983 examined markerless modeling of humans, publishing a seminal world mapping a model of a series of hierarchical cylinders into an image of a person walking @hoggModelbasedVisionProgram1983. 

Deep-learning methods used today provide the benefit of directly extracting anatomical features (i.e., joint centers) from an image of a human. Markerless motion capture methods from the 90's-late 2000's, lacking this technology, would measure kinematic data by working with the data they could extract, which was often the shape of the body itself, using methods like edge detection @gavrila3DModelbasedTracking1996, optical flow tracking @marzani3DMarkerfreeSystem2001, silhouette extraction @rosenhahnSystemMarkerlessMotion2006, and 3D visual hull reconstruction @corazzaMarkerlessMotionCapture2006. 

The technology as we know it today started coming into being with the development and release of CNN models DeepPose in 2014 @toshevDeepPoseHumanPose2014 and OpenPose in 2017 @caoOpenPoseRealtimeMultiPerson2019. With this, deep-learning methods became state-of-the-art and an available, accessible method for researchers to utilize and build on @nagornyComprehensiveReviewRealTime2025. 

Today, markerless tracking of humans has rapidly become the domain of computer vision and widely accessible to all. Commercial options are widely accessible for entertainment purposes (MoveAI, Rokoko Vision, Remocapp). In the research space, one can find papers describing independent, custom-built research pipelines @nakanoEvaluation3DMarkerless2020 @needhamDevelopmentEvaluationFully2022, open-source software available to researchers for kinematic data collection @uhlrichOpenCapHumanMovement2023 @cottonPosePipeOpenSourceHuman2022 @pagnonPose2SimEndtoEndWorkflow2022, or commerical proprietary software @kankoAssessmentSpatiotemporalGait2021.

* Needs in the markerless motion capture field *

Despite its potential, markerless motion capture does have limitations. Some of these are practical limitations - reconstruction accuracy can be affected by a number of factors (i.e., lighting, environment, clothing). Chapter __ expands on these limitations from a practical standpoint. 

Within the available methods for research and clinical use however, compromises must still be made. Current solutions can be expensive (e.g., Theia Markerless, \$25,000+) or are constrained to particular applications (e.g., OpenCap), making adaptation across diverse research and clinical needs difficult.

As such, when we consider the landscape of quantitative motion analysis tools as a whole, there is a persistent tradeoff between accuracy, adaptability, and accessibility restricts the broader impact of motion capture technology - highlighting a critical need for a system that can address these limitations.

This work encompasses the development and validation of FreeMoCap, a free open-source motion capture software designed to simultaneously achieve accuracy through advanced computer vision, accessibility through use of low-cost hardware, and adaptability through modular software design. The following chapter introduces the software and will examine how the design choices made are meant to provide an accurate, adaptable and accessible research solution. 


*The Microsoft Kinect: A case study in accessibility *

In 2010, Microsoft released the Kinect, a gaming peripheral for the Xbox 360 that, unlike other gaming consoles, did not require any controllers. Instead, the Kinect worked using the dual use of infrared emitters and cameras to provide depth data and RGB cameras to provide color, creating a 3D depth map in real-time @shottonRealTimeHumanPose. Although initially a commercial success, the forced adoption into the XBox platform and lack of games caused the Kinect eventually faded out of use before being officially discontinued in 2017 @pandeSlowPainfulDeath2023. 

One could look at this story and call the Kinect a long-term failure. This however, would not account for the massive impact a gaming device had on the research field. 

In the pre-deep learning revolution era, the Kinect was the first time technology to track human motion, which typically cost tens of thousands of dollars, was available for a neat sum of \$150. Many developers saw the potential in this software. Within days of its release, the Kinect was hacked. Adafruit posted a \$3000 bounty for the first person to do so @adafruitOpenKinectProject2010, and open-source drivers for PC use appeared within weeks (an interesting note: this contest was proposed to Adafruit by a core developer on the Kinect team who was frustrated with Microsoft's reluctance to offer any PC support @KinectDeveloperClaims). Depsite their initial reluctance to embrace this usage, Microsoft eventually released a developer kit in 2012, after which the Kinect saw a sudden widespread of use in biomechanical research. 

Numerous studies exist detailing the use of the Kinect for clinical and research use @ValidityMicrosoftKinect2012 @jebeliStudyValidatingKinectV22017 @yeungEvaluationMicrosoftKinect2014. Even though several limitations @pfisterComparativeAbilitiesMicrosoft2014 (e.g. occlusion causing major issues due to the single camera view point) were identified, the cost and availability of the system made it one of the first available-to-researchers systems to take something very costly and do it for much less. 

Even after Microsoft discontinued the Kinect for gaming, they released it under the Azure Development Kit for a few years after. Eventually however, this was discontinued as well. I go through the history and use of a defunct system here because I believe ultimately, even in its eventually failure continue to be in use, this story neatly illustrates the needs of the research and clinical community. There is a significant need for an available, low-cost system that researchers can use and adapt to their own purposes - one that cannot simply be 'discontinued'. 

