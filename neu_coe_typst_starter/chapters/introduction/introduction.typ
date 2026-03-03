== Introduction
In writing the chapters of this dissertation, there emerged a common theme that seems apt to name at the start: the ability to obtain quantitative kinematic data would benefit a great many fields, but the tools that would allow this to be done at a widespread scale remain out of reach of many practitioners. The following chapters span the development and validation of one potential solution to make motion analysis accessible to all. 


== Quantitative Motion Analysis

Human movement is an adaptive, complex mechanism. Quantitative motion analysis looks to find measurable terms from this complexity (i.e. joint angles, acceleration profiles) so that they can be studied and interpreted. While at a glance, quantitative motion analysis may seem chiefly useful to researchers and clinicians, methods of quantitative movement analysis are embedded in daily living and most of us are familiar with some form of it. Smartphones and wearable health devices routinely measure and present motion data in user-friendly and interpretable ways. Users may use the information given to them (e.g. step count, daily fitness level) in a variety of ways, including informal feedback for the curious user or as a more serious indicator in trends of health and mobility (particularly when combined with sensors EKG or pulse ox sensors often integrated into wearable smart devices). We can consider quantitative motion analysis at a clinical level to have a similar level of impact.  Highly detailed quantitative motion analysis can also be used across a spectrum of biomechanical research. [insert some sentences about biomechanics/walking, pathology, rehabilitation and all that.]

== Mention of clinical measures of mvoement? 
https://pmc.ncbi.nlm.nih.gov/articles/PMC3566464/
https://pmc.ncbi.nlm.nih.gov/articles/PMC6406749/ ("The main consideration when deciding the best approach is the need to balance the requirement for better granularity, sensitivity, specificity, measurement accuracy, and minimal rater bias, with the complexity and feasibility of using such methods in clinics, communities, and clinical trials (Table 1).")

== Marker-based motion capture
Marker-based motion capture has found use across a multitude of domains: clinical gait analyses and diagnosis and treatment of rehabilitation in healthcare, film and animation in the entertainment industry, and across robotics as well@menolottoMotionCaptureTechnology2020. Marker-based motion capture systems reconstruct three-dimensional joint positions by tracking reflective markers placed on anatomical landmarks using multiple calibrated cameras. Marker-based motion capture is highly accurate and tends to be considered a gold-standard for comparison against other motion analysis techniques@colyerReviewEvolutionVisionBased2018. [something about specific use in clinical and research field]. These systems still have limitations to consider in both research and clinical use, however. From an accuracy standpoint, marker-based motion capture systems are prone to soft tissue artifacts - where the movement of skin relative to bone introduces error into marker trajectories and subsequent kinematic tracking@camomillaHumanMovementAnalysis2017. Additionally, exact placement of markers on anatomical landmarks requires training and the experience level of the researcher can impact the reliability and accuracy of marker placement @sinclairInfluenceTesterExperience2014, which can significantly impact both research and clinical settings. 

From a research standpoint, the involved preparation and setup time can limit sample sizes of research studies. Studies are constrained to a lab environment at a time when being able to capture activities of daily living is become more and more relevant (CHECK MOESLAND SURVEY FOR THIS). Additionally, even the presence of markers on a subject has been shown to alter their natural behavior. 

From a clinical standpoint, marker-based motion capture requires specialized hardware and space and requires skilled users to be able to operate and clean the data @parksCurrentLowCostVideoBased2019, which limits adoption in clinical spaces@buckleyRoleMovementAnalysis2019. Marker-placement may not be appropriate or convenient for certain patient populations. 

For many research labs and clinics, the financial cost of acquiring the specialized hardware for such a system is the first barrier to entry [CITATION]. However even beyond that, marker-based motion capture inherently has an infrastructure cost - by necessity it usually requires a large, open space to collect the best data. As such, these systems typically remain accessible to clinics and labs with high funding or access to institutional resources, while smaller labs or everyday clinics are prevented from making use of them. 



== Biplanar videoradiography 
It should be noted that while marker-based motion capture will be referred to through this work as the 'gold-standard', one of the most accurate methods of measuring and evaluating joint function to date is biplanar videoradiography. Biplanar videography is a method of mapping the pose of 3D bone models using synchronized x-ray image sequences of motions @kesslerDirectComparisonBiplanar2019 with sub-millimeter accuracy. One study by Miranda et al. finding joint tracking errors ranging from .25-.30mm for the foot @mirandaStaticDynamicError2011. Despite high accuracy, cost, lack of whole-body kinematics and complicated setup make biplanar videoradiography impractical for widespread adoption @wadeApplicationsLimitationsCurrent2022. 



== Accelerometers
Accelerometers are sensors that can detect a variety of accelration changes, including those due to gravity (constant acceleration), vibration (time-varying acceleration) or tilt (quasi-static acceleration)@mohammedMonolithicMultiDegree2018. Accelerometers, with the development and widespread use of smartphones, have become nearly ubiquitous. Several studies have found reliability and success in using smartphone accelerometers for gait analysis@grouiosAccelerometersOurPocket2022@nishiguchiReliabilityValidityGait2012.

== Markerless motion capture 
Recent advances in computer vision have facilitated the development of software that can reconstruct motion data using only RGB cameras - eliminating the need for specialized hardware and marker placement. This method of reconstruction is known as markerless motion capture. Some of the earliest methods for markerless motion capture from the early 2000's operated by trying to find the body through motion, using optical flow tracking and model fitting to help reconstruct data @marzani3DMarkerfreeSystem2001@calaisNewTrendsMarkerfree2000. 
Later advancements moved to performing silhouette extraction and fitting articulated models to the data @rosenhahnSystemMarkerlessMotion2006 @moeslundSurveyAdvancesVisionbased2006 @gavrila3DModelbasedTracking1996. Interestingly, the pipeline by Rosenhahn in particular operates at the inverse of how most markerless motion capture pipelines operate today. Instead of reconstructed 3D data from 2D views, a pre-built model with known structure and geometry (essentially a handcrafted articulated human model) was projected onto the 2D camera images and compared to the observed silhouette, and the model was readjusted until it matched the 2D observations @rosenhahnSystemMarkerlessMotion2006. However, these were computationally intensive and not ideal for clinical use. The Andriachi lab at Stanford tried for the application of the silhouette extraction idea for clinical gait analysis @corazzaMarkerlessMotionCapture2006. Silhouette extraction came from an era where the methods for detecting anatomical landmarks with deep-learning did not exist, and therefore the most accurate way to estimate them were to use the shape of the body itself. Move into talking about Deep CNN's (DeepPose, OpenPose). Mention the Kinect in demonstrating appetite for affordable, available motion capture sources. 




significance of movement diagnoses: Use of movement system diagnoses in the management of patients with neuromuscular conditions: a multiple-patient case report

for collecting movement over time (Parks): Current Low-Cost Video-Based
Motion Analysis Options for Clinical
Rehabilitation: A Systematic Review