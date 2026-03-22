== Introduction
Most of us are familiar with quantitative motion analysis, whether we realize it or not. If you've ever checked your step count on your phone, that's quantitative motion analysis coming from the accelerators and gyrscopes in your phone. Human movement is an adaptive, complex mechanism, and quantitative motion analysis finds measurable terms (i.e. joint kinematics, gait parameters, acceleration profiles) from this complexity. 

Researchers and clinicians often make use of quantitative motion analysis as well, though often at more detailed levels with more sophisticated equipment. The following sections examine the use of quantitative motion analysis in both research and clinical work and existing gaps. 


== Quantitative motion analysis in research
Quantitative motion analysis is critical to furthering understanding of the biomechanics of human movement. From further understanding gait to examining athletic performance, laboratories tend to employ sophisticated equipment such as force place and instrumented treadmills to accurately measure human movement. Of these, one commonly used tool is marker-based motion capture. 

*Marker-based motion capture*

 Marker-based motion capture systems reconstruct three-dimensional joint positions by tracking reflective markers placed on anatomical landmarks using multiple calibrated cameras.  Marker-based motion capture has found use across a multitude of domains: clinical gait analyses and diagnosis and treatment of rehabilitation in healthcare, film and animation in the entertainment industry, and across robotics as well@menolottoMotionCaptureTechnology2020. While marker-based motion capture systems are highly accurate and tend to be considered a gold-standard for comparison against other motion analysis techniques @colyerReviewEvolutionVisionBased2018, there are still important limitations that prevent its widespread adoption. 

 *Limitations of marker-based motion capture*

From an accuracy standpoint, marker-based systems are prone to soft tissue artifacts - where the movement of the skin relative to bone introduces error into marker trajectories and subsequent kinematic tracking @camomillaHumanMovementAnalysis2017. Additionally, exact placement of markers on anatomical landmarks requires training, and the experience level of the researcher can impact placement reliability and accuracy.@sinclairInfluenceTesterExperience2014. Beyond accuracy, involved preparation and setup time can limit sample sizes of research studies. 

*Marker based motion capture is not well-suited to capture activities of daily living* 

Today, there is focus on understanding natural human behavior, particularly in activities of daily living. Marker-based motion capture, though the current gold standard, is not well-suited to this task. The nature of the technology means it is usually limited to indoor laboratory environments. The placement of markers has been shown to potentially alter behavior. Additionally, even conducting tests in a lab setting may alter behavior - laboratory tests of gait for example, may impose pressure or limitations that may influence behavior in a way that may not reflect day-to-day functionality @AnalyzingGaitReal@ojedaInfluenceContextualTask2015.

Thus, there is a need for technology that can returned detailed kinematic data while also being able to observe humans during activities of daily living. 


*A brief aside on 'gold-standards' for measuring movement*

I will note here that while marker-based motion capture will be referred to through this work as the 'gold-standard', one of the most accurate methods of measuring and evaluating joint function to date is biplanar videoradiography. Biplanar videography is a method of mapping the pose of 3D bone models using synchronized x-ray image sequences of motions @kesslerDirectComparisonBiplanar2019 with sub-millimeter accuracy, with joint tracking errors ranging from .25-.30mm for the foot @mirandaStaticDynamicError2011. Despite high accuracy, cost, lack of whole-body kinematics and complicated setup make biplanar videoradiography impractical for widespread adoption in both research and clinical contexts@wadeApplicationsLimitationsCurrent2022.

== Quantitative analysis in clinical work
In a clinical space, quantifying movement can inform diagnosis, understanding of disease progression and severity, and examine rehabilitation or therapy efficacy @buckleyRoleMovementAnalysis2019@vanierselSystematicReviewQuantitativeclinical2004@vergheseQuantitativeGaitDysfunction2007@SummaryMeasuresClinical2014 @kerrAdoptionStrokeRehabilitation2018 (see Chapter 3: Introduction and Chapter 4: Introduction for examples specific to gait and posture). 

*Current methods of clinical motion analysis are largely observational*

 Many clinicians tend to use subjective methods to analyze patient motion, often involving self-reporting or observation @sharmaFactorsInfluencingClinical2024. The Berg Balance Scale @bergMeasuringBalanceElderly1989 for example, is a test that assesses dynamic and static balance. It has has been used in assessing stroke patients as well as fall risk and involves grading 14 tasks on a 5-point scale dependent on factors such as dependence on external supervision or assistance and time to complete the task @mirandaBergBalanceTesting2026. Another example is the Tinetti test @tinettiPerformanceOrientedAssessmentMobility1986 which assesses both posture and gait to identify fall risk in populations such as the elderly, stroke, and PD patients. 
 
 However, while observational analysis can be reliable, accuracy can be dependant on a variety of factors, such as clinician experience @nishiguchiReliabilityValidityGait2012 and movement observed @maclachlanOBSERVERRATINGTHREEDIMENSIONAL2015. 

*Quantitative methods in clinical analysis*


https://pmc.ncbi.nlm.nih.gov/articles/PMC6615543/ - talks about being able to use smartphones in place of stopwatches so patients can test themselves


STATEMENT ABOUT QUANTITATIVE METHODS THEY DO USE (goniometers etc.) 


There is a large disparity between the methods used for analysis of human motion in a laboratory and what can be feasibly used in a clinic @vanierselSystematicReviewQuantitativeclinical2004 @buckleyRoleMovementAnalysis2019. While some clinics may make use of gait mats, for many assessments (such as the Timed Up and Go test), quantitative motion analysis is as simple as using a stopwatch. There has been exploration of inexpensive methods to expand kinds of methods uesd in everyday clinical environments. Accelerometers, for example, are sensors that can detect a variety of accelration changes, including those due to gravity (constant acceleration), vibration (time-varying acceleration) or tilt (quasi-static acceleration)@mohammedMonolithicMultiDegree2018. Accelerometers, with the development and widespread use of smartphones, have become nearly ubiquitous. Several studies have found reliability and success in using smartphone accelerometers for gait analysis@grouiosAccelerometersOurPocket2022@nishiguchiReliabilityValidityGait2012. However, the extractions of meaningful data such signals can be difficult @ClinicalApplicationsSensors

*Marker-based motion capture is not suited for widespread clinical use* 

The level of kinematic detail provided by marker-based motion capture could be useful in clinical work, but it is currently ill-suited to the task. Marker-based motion capture is expensive @parksCurrentLowCostVideoBased2019 @sharmaFactorsInfluencingClinical2024, and the cost alone is usually enough of a barrier to prevent adoption. Marker-based motion capture requires specialized hardware and space and requires skilled users to be able to operate and clean the data @parksCurrentLowCostVideoBased2019, which limits adoption in clinical spaces@buckleyRoleMovementAnalysis2019 @ClinicalApplicationsSensors. Marker-placement also may not be suitable for certain patient populations. As such, these systems typically remain accessible only to specialized hospitals and research groups with the financial resources and infrastructure to support it. A tool to augment clinicians with quantitative data could help them with precise measurements of care, and also help provide justification to insurance for reimbursement@CurrentLowCostVideoBased. 


Thus, there is a need for accessible technology that can be accurate and feasible to use in a clinical setting. 


== Mention of clinical measures of mvoement? 

feasibility based on patient population - @sharmaFactorsInfluencingClinical2024

Future steps - making data interpretable @sharmaFactorsInfluencingClinical2024

informing/augment clinicians
@sharmaFactorsInfluencingClinical2024

Acess, ease of use, and value for cost are considered important needs (by stroke rehab) @kerrAdoptionStrokeRehabilitation2018

https://pmc.ncbi.nlm.nih.gov/articles/PMC3566464/
https://pmc.ncbi.nlm.nih.gov/articles/PMC6406749/ ("The main consideration when deciding the best approach is the need to balance the requirement for better granularity, sensitivity, specificity, measurement accuracy, and minimal rater bias, with the complexity and feasibility of using such methods in clinics, communities, and clinical trials (Table 1).")


== The need 

In examining the research and clinical space, we see different yet related needs emerge. For research spaces, the need is not necessarily to replace the existing methods of quantitative analysis for researchers to have access to it, but to expand access to this kind of research - both for research groups that may not have the financial resources or infrastructure to use marker-based motion capture, and also to expand its use outside of the laboratory into the real world. 

In clinical spaces, we see a gap where more detailed methods of quantitative motion analysis could augment clinical decision making, but the need is specific for a system that is affordable and accessible and could feasibly be used for everday clinical use. 

There emerges a common theme here, where something to fill this need is not necessarily meant to replace the existing technologies used by either of these fields, but instead to democratize it into something that is simply more accessible to the ground-level user. The following chapters span the development and validation of one potential solution to make motion analysis accessible to all. 





significance of movement diagnoses: Use of movement system diagnoses in the management of patients with neuromuscular conditions: a multiple-patient case report

for collecting movement over time (Parks): Current Low-Cost Video-Based
Motion Analysis Options for Clinical
Rehabilitation: A Systematic Review

