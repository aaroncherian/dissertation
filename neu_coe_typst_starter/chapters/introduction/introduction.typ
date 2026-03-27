== Introduction

*The Microsoft Kinect: A case study in accessibility*

In 2010, Microsoft released the Kinect, a gaming peripheral for the Xbox 360 that, unlike other gaming consoles, did not require any controllers to use. Instead, the Kinect used dual infrared emitters/sensors and RBG cameras to create a 3D depth map in real-time @shottonRealTimeHumanPose. Or more simply, the person _was_ the controller. Initially, the Kinect was a commercial success. Over the years however, a myriad of factors caused the Kinect to be faded out of use, until it was officially discontinued in 2017 @pandeSlowPainfulDeath2023. 

One could tell this story and ultimately, call the Kinect a failure. That story however, would not account for how a gaming device changed the research landscape. 

While today there is an abudnance of software to track human movement for the curious user, this was not the case in the pre-deep learning era. Devices that could provide this kind of data typically cost tens of thousands of dollars, well out of hand for the everyday hobbyist and consumer. Then suddenly, for the first time, that same technology was available for a tidy sum of \$150.

Many developers saw the potential in this software, if only it were freed from its proprietary, closed-source chains. The day the Kinect released, Adafruit, an open-source hardware manufacturer and vendor, posted a \$3000 bounty to be awarded to the first person to open-source the drivers for the connect. The Kinect was hacked within 6 days and its first open-source driver produced. Of note here, interesting note here is that this contest was actually proposed to Adafruit and funded by a core developer on the Kinect team who had been frustrated with Microsoft's reluctance to offer any PC support @KinectDeveloperClaims. 

Pushed by the widespread response and usage by the art and robotics usage, Microsoft gave way through their initial reluctance and released a developer kit in 2012 - and the Kinect saw sudden widespread use in biomehanical research. 

There are numerous studyes that detail usage of the Kinect for clinical and research use @ValidityMicrosoftKinect2012 @jebeliStudyValidatingKinectV22017 @yeungEvaluationMicrosoftKinect2014. Even though several limitations @pfisterComparativeAbilitiesMicrosoft2014 (e.g. occlusion causing major issues due to the single camera view point) were identified, the cost and availability of the system made it one of the first available-to-researchers systems to take something very costly and do it for much less. Even after Microsoft discontinued the Kinect for gaming, they released it under the Azure Development Kit for a few years after. Eventually however, this was discontinued as well.

I take a moment to walk through the story of a now defunct system because more than any postulations or speculations I can make, history has already shown is the impact that cheap hardware combined with open-source software can have on academic work, clinical work, and beyond. 


== Quantitative motion analysis 

Human movement is an adaptive, complex mechanism, and quantitative motion analysis finds measurable terms (i.e. joint kinematics, gait parameters, acceleration profiles) from this complexity. Most of us are familiar with quantitative analysis in some form. For example, reading one's daily step count on their phone is an example of extracting kinematic data from accelerometers and gyroscopes. Researchers and clinicians often make use of quantitative motion analysis as well, though often at more detailed levels with more sophisticated equipment. The following sections examine the use of quantitative motion analysis in both research and clinical work and existing gaps. 


== Quantitative motion analysis in research
Quantitative motion analysis is critical to furthering understanding of the biomechanics of human movement. From further understanding gait to examining athletic performance, laboratories tend to employ sophisticated equipment to accurately measure human movement. Relevant to understanding this work is the use of marker-based motion capture. 

These systems reconstruct 3D joint positions by tracking reflective markers placed on anatomical landmarks using multiple calibrated cameras. We can look at the relatively broad use of marker-based motion capture as demonstrating the utility of 3D data across a multitude of domains: in the entertainment industry, 3D data is retargeted to models for film and animation use; in robotics, 3D data might provide orientation information or help with reinforcement learning @menolottoMotionCaptureTechnology2020. Our chief focus is the use of marker-based motion capture in the research and healthcare fields, where it is often considered a gold-standard for collecting kinematic data and for comparison against other motion analysis techniques @colyerReviewEvolutionVisionBased2018. However, its widespread adoption in these fields can be limited by a few factors. These systems are costly, and involved preparation and setup time can be limited factors in participant data collection (i.e., the population studied or the sample size of a research study.)

From an accuracy standpoint, there are also important considerations for research use. Accuracy is dependent on the exact placement of markers on anatomical landmarks - this requires training, and the experience level of the researcher placing the markers can impact placement reliability and accuracy @sinclairInfluenceTesterExperience2014. Markers are also prone to what are known as soft tissue artifacts, where the movement of skin over the bone itself introduces errors into kinematic tracking @camomillaHumanMovementAnalysis2017. 

Additionally, these systems, which depend on infrared light, are usually limited to indoor environments.
As such, marker-based motion capture is also not well-suited to capturing activities of daily living.  Behavior in a lab environment (e.g, gait analysis) can impose pressure of or limitations that influence behavior in a way that may not reflect day-to-day functionality @AnalyzingGaitReal@ojedaInfluenceContextualTask2015 @rantakokkoGaitFeaturesDifferent2024 @hahmInhomeHealthMonitoring2022. Additionally, markers themselves can alter or limit natural behavior @colyerReviewEvolutionVisionBased2018. More and more, importance is being placed on the importance of monitoring activities of daily living, particularly in assessing independence and health risks in the elderly @yangRemoteMonitoringAssessment2012. Motion data could provide insight on behavior to facilitate change and intervention, yet there is a gap between methods for tracking data and their use in the real world @weiMotionTrackingDaily2024. Thus, there is a need for technology that can returned detailed kinematic data while also being able to observe humans during activities of daily living. 


*(A brief aside on 'gold-standards' for measuring movement)*

While throughout this work, marker-based motion capture will be referred as a 'gold-standard', it should be noted that one of the most accurate methods of measuring and evaluating joint function to date is biplanar videoradiography. Biplanar videography is a method of mapping the pose of 3D bone models using synchronized x-ray image sequences of motions @kesslerDirectComparisonBiplanar2019 with sub-millimeter accuracy, with joint tracking errors ranging from 0.25-0.30mm for the foot @mirandaStaticDynamicError2011. Despite high accuracy, cost, lack of whole-body kinematics and complicated setup make biplanar videoradiography impractical for widespread adoption in both research and clinical contexts@wadeApplicationsLimitationsCurrent2022.


== Quantitative analysis in clinical work
In a clinical space, quantifying movement can inform diagnosis, increase understanding of disease progression and severity, and examine rehabilitation or therapy efficacy @buckleyRoleMovementAnalysis2019@vanierselSystematicReviewQuantitativeclinical2004@vergheseQuantitativeGaitDysfunction2007@SummaryMeasuresClinical2014 @kerrAdoptionStrokeRehabilitation2018 (see Chapter 3: Introduction and Chapter 4: Introduction for examples specific to gait and posture). 

*Current methods of clinical motion analysis are largely observational*

Many clinicians tend to use subjective methods to analyze patient motion, often involving self-reporting or observation @sharmaFactorsInfluencingClinical2024. The Berg Balance Scale @bergMeasuringBalanceElderly1989 for example, is a test that assesses dynamic and static balance. It has has been used in assessing stroke patients as well as fall risk and involves grading 14 tasks on a 5-point scale dependent on factors such as dependence on external supervision or assistance and time to complete the task @mirandaBergBalanceTesting2026. Another example is the Tinetti Test @tinettiPerformanceOrientedAssessmentMobility1986 which assesses both posture and gait to identify fall risk in populations such as the elderly, stroke, and PD patients. While these tests are widely used and reliable, accuracy can be dependent on clinician experience @nishiguchiReliabilityValidityGait2012 and the kind of movement being observed@maclachlanOBSERVERRATINGTHREEDIMENSIONAL2015. 

*Quantitative methods in clinical analysis*

There is a large disparity between the methods used for analysis of human motion in a laboratory and what can be feasibly used in a clinic @vanierselSystematicReviewQuantitativeclinical2004 @buckleyRoleMovementAnalysis2019. Some clinics may use gait mats or force plates, but for many clinics and assessments (e.g., the Timed Up and Go Test), tools for quantitative motion analysis may be as simple as using a stop watch. Use of tools in a clinic is largely a practical choice, with Kerr et al. describing access, ease of use and value for money as key needs in adopting technology for clinical use @kerrAdoptionStrokeRehabilitation2018 and Buckley et al. describing the tradeoff between wanting more detailed methods of analysis and the complexity of using such software in a clinic @buckleyRoleMovementAnalysis2019. 

Augmenting clinician care with quantitative data could help trend trends over time, provide precise feedback on care, and also help provide justification to insurance for reimbursement @parksCurrentLowCostVideoBased2019. Often times, research into quantitative use for clinical use examines adopting practical everyday technology to provide data, such as using smartphone accelerometers for gait analyses @grouiosAccelerometersOurPocket2022@nishiguchiReliabilityValidityGait2012. While accelerometers are relatively inexpensive and easy to use, extractions of meaningful data from their signals can be difficult @ClinicalApplicationsSensors. Augmenting d

Although marker-based motion capture does provide detailed, meaningful kinematic data, it is ill-suited to the task of everyday clinical use. Marker-based motion capture is expensive @parksCurrentLowCostVideoBased2019 @sharmaFactorsInfluencingClinical2024, and the cost alone is usually enough of a barrier to prevent adoption. Marker-based motion capture requires specialized hardware and space and requires skilled users to be able to operate and clean the data @parksCurrentLowCostVideoBased2019, which limits adoption in clinical spaces@buckleyRoleMovementAnalysis2019 @ClinicalApplicationsSensors. Marker-placement also may not be suitable for certain patient populations. As such, these systems typically remain accessible only to specialized hospitals and research groups with the financial resources and infrastructure to support it. 

Thus, there is a need for accessible technology that can be accurate and feasible to use in a clinical setting. 

*Marker-based motion capture is not suited for widespread clinical use* 

As an example of tradeoffs, while the level of kinematic detail provided by marker-based motion capture could be useful in clinical workl but is currently ill-suited to the task. Marker-based motion capture is expensive @parksCurrentLowCostVideoBased2019 @sharmaFactorsInfluencingClinical2024, and the cost alone is usually enough of a barrier to prevent adoption. Marker-based motion capture requires specialized hardware and space and requires skilled users to be able to operate and clean the data @parksCurrentLowCostVideoBased2019, which limits adoption in clinical spaces@buckleyRoleMovementAnalysis2019 @ClinicalApplicationsSensors. Marker-placement also may not be suitable for certain patient populations. As such, these systems typically remain accessible only to specialized hospitals and research groups with the financial resources and infrastructure to support it. A tool to augment clinicians with quantitative data could help them with precise measurements of care, and also help provide justification to insurance for reimbursement@CurrentLowCostVideoBased @parksCurrentLowCostVideoBased2019. 


== The need: a more accessible method of measuring kinematic data

In examining the research and clinical space, we see different, yet related, needs emerge. For research spaces, there is a need to facilitate research use quantitative motion analysis in ways that are less time consuming, are more accessible, and can be used to more reliably measure natural human behavior.  

the need is not necessarily to replace the existing methods of quantitative analysis for researchers to have access to it, but to expand access to this kind of research (i.e., for research groups that may not have the financial resources or infrastructure to use marker-based motion capture) and to expand its use outside of the laboratory into the real world. 

In clinical spaces, we see a gap where more detailed methods of quantitative motion analysis could augment clinical decision making, but the need is specific for a system that is affordable and accessible and could feasibly be used for everyday clinical use. 

There is a key theme here: something to fill these needs is not necessarily meant to replace the existing technologies used in either of these fields, but instead to present an option that democratizes a method for detailed yet non-invasive quantitative motion analysis and makes it more accessible to the ground-level user. The following chapter explores the current landscape of markerless motion capture technology, a solution that has often been proposed to fill these needs. 

