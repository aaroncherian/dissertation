== Synchronous Video Recording

Synchronous video recording refers to the acquisition and temporal alignment of video streams. For accurate 3D reconstruction, each set of frames must correspond to the same moment in time. Without proper synchronization, time lags between cameras can result in inaccurate 3D data. 

The method used to achieve synchronization can directly constrain the camera hardware that can be used, and as such is a critical design component of any markerless system. OpenCap for instance, relies on cloud-based synchronization through a web app, requiring networked iOS devices to collect data. Theia3D synchronizes at the camera hardware level, which requires buying one of their dedicated multi-camera systems (e.g., Qualisys Miqus or Vicon Vue). 

As such, synchronization can be one of the primary cost drivers of a markerless system. 

=== SkellyCam

A core directive of `SkellyCam`, the synchronized video acquisition component of FreeMoCap, is to provide high quality synchronous recording methods that enable the usage of low-cost hardware - specifically consumer-grade, off-the-shelf webcams. The data presented in the later chapters of this work were all collected using six \~\$20 USB webcams (1280 x 720, 30 FPS) purchased from Amazon. 

However, these cameras may not be suitable for all research needs. For example, capturing athletic performance may necessitate higher frame rate cameras, while outdoor recordings may require non-USB cameras. The software accommodates these use cases in two ways: 1) Videos collected from a set of external cameras (e.g., GoPros or smartphone cameras) can be synchronized using light and audio-based methods; 2) A pre-synchronized set of videos can be directly imported into the software for processing. 

*Research Significance*

From a research standpoint, this means the system does not constrain users to low-cost hardware. Researchers with access to specialized camera systems or established synchronization workflows can integrate those resources directly into the pipeline, while the ground-level user can still record motion capture data with as few as two low-cost webcams. This flexibility reduces dependency on specific hardware configurations and allows data collection protocols to be adapted to the needs of the study, rather than constrained by the system itself.


=== Single Camera vs. Multi-Camera Recording

While it is possible to reconstruct 3D data from a single image, monocular 3D data tends to fall well-short of the accuracy that reconstructions from multiple cameras can provide @wadeApplicationsLimitationsCurrent2022 @nogueiraMarkerlessMultiview3D2025. Multi-camera viewpoints provide additional information about joint center locations that can improve accuracy of reconstruction while also mitigating the effect of occlusions, which are a significant barrier to single camera reconstruction. 

The FreeMoCap software is capable of simple reconstruction from single camera data, but we highly recommend multi-camera setups for recording. 
