== Synchronous Video Recording

Synchronous video recording refers to the acquisition and temporal alignment of video streams. For accurate 3D reconstruction, each set of frames must correspond to the same moment in time. Without proper synchronization, time lags between cameras can result in inaccurate 3D data. 

The method used to achieve synchronization is a critical design component of any markerless motion capture system, as it directly constrains the camera hardware that can be used. Systems such as OpenCap rely on networked mobile devices (e.g., iOS smartphones) and cloud-based synchronization, while others, such as Theia Markerless, utilize dedicated multi-camera systems (e.g., Qualisys Miqus or Vicon Vue) with hardware-level synchronization. These approaches offer differing levels of temporal precision, but also introduce trade-offs in cost, scalability, and ease of use.

In practice, synchronization can be one of the primary cost drivers of a motion capture system. Each additional camera increases both hardware expense and requirements for specific devices or ecosystems can further limit accessibility. These cost constraints often limit the number of cameras that can be deployed, reducing the number of available viewpoints. Fewer viewpoints increase the likelihood of occlusion, reduce spatial coverage, and weaken triangulation geometry, all of which can degrade reconstruction accuracy. As a result, synchronization strategies not only affect temporal alignment, but indirectly shape spatial accuracy by constraining system scalability and camera configuration.


* Design motivations * 

A core directive of our synchronized video acquisition software package, `SkellyCam` was to provide high quality synchronization and recording methods that enable the usage of low-cost hardware (i.e., consumer-grade, "off-the-shelf" webcams). The data presented in the later chapters of this work were all collected using six \~\$20 USB webcams (1280 x 720, 30 FPS) purchased from Amazon. Consider that even six iOS devices with OpenCap would cost, if using the cheapest available iPhones, approximately \$1000 - \$1500 in hardware. By lowering the cost barrier, we could scale our system to include more cameras. 

Scalability was an additional consideration in the software design. Different applications may require specifications beyond those provided by low-cost webcams. For example, capturing athletic performance may necessitate higher frame rate cameras, while outdoor recordings may require non-USB devices. To accomodate these use cases, the software includes light and audio-based synchronization methods, allowing users toc collect data from a set of external cameras (e.g. GoPros or smartphone cameras) and synchronize them within the software. Additionally, pre-synchronized video data can be directly imported for processing.

As such, while the system is designed to operate with highly accessible hardware, it does not impose an upper limit on hardware quality. Instead, it supports a range of configurations, allowing users to balance cost, performance, and experimental requirements based on available resources.


* Single camera reconstruction *

While it is possible to reconstruct 3D data from a single image, monocular 3D data tends to fall well-short of the accuracy that reconstructions from multiple cameras can provide @wadeApplicationsLimitationsCurrent2022 @nogueiraMarkerlessMultiview3D2025. Multi-camera viewpoints provide additional information about joint center locations that can improve accuracy of reconstruction while also mitigating the effect of occlusions, which are a significant barrier to single camera reconstruction. 

The FreeMoCap software is capable of simple reconstruction from single camera data, but we highly recommend multi-camera setups for recording. 
