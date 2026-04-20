
== Design Requirements
The current landscape of quantitative motion analysis methods forces specific tradeoffs. Affordable and portable methods such as accelerometers and IMUs can be deployed in a wide range of settings, but often do not provide the spatial and kinematic detail needed for biomechanical analysis. Marker-based motion capture systems provide this depth, but remain inaccessible to users without substantial funding, dedicated laboratory space, and technical expertise. Existing markerless motion capture alternatives reduce some of these barriers, but often impose hardware constraints that increase cost while remaining tied to fixed pose estimation backends and skeletal models that limit flexibility across research populations and use cases.

This dissertation evaluates the FreeMoCap system against three core design requirements:

1) *Biomechanical utility*: The system should produce measurements whose agreement with reference data is in line with prior markerless validation studies, while capturing biomechanically meaningful patterns across tasks.

2) *Extensibility:* The system should support multiple pose estimation backends and permit task or population-specific modifications when out-of-the-box markerless pipelines are insufficient.

3) *Accessibility:* The system should reduce financial, computational, and methodological barriers to motion capture by supporting low-cost hardware, minimizing specialized software and hardware requirements, and providing openly available, reusable analysis workflows.

