== Synchronous Video Recording

Synchronous video recording refers to the acquisition and temporal alignment of video streams. When reconstructing 3D data, it is critical that each set of frames from cameras represents the exact same moment in time. Without proper synchronization, time lags between cameras can result in incorrect 3D reconstruction. 

Of note is that the method of video synchronization is often tied to the camera hardware that can be used by the system. For example, OpenCap synchronizes videos from cameras connected to a web app, specifically from iOS devices (e.g. iPhones, iPads) and requires internet connection @uhlrichOpenCapHumanMovement2023. Theia Markerless supports specific camera systems (e.g. Qualisys Miqus, Vicon Vue) with a minimum requirement of six cameras. As such, the method of synchronization can often be a limiting system requirement for the user. For example, for a wide capture area access to enough iOS devices to record data could quickly become costly.

A core directive of our software for synchronized video acquisition is to provide high quality methods of synchronization that allow users to scale their setups to their available financial or infrastructure resources. Our core synchronized acquisition software termed `skellycam`, enable users to use, at minimum, off-the-shelf USB webcams to record synchronized videos with sub-millisecond precision for up to 8 cameras. The data presented in Chapter 3 and 4 were collected using six \~\$20 USB webcams (1280 x 720, 30 FPS) that can be purchased off of Amazon. This means that users, at the base level, can create their own motion capture system for \$40 with two USB webcams. 

Additionally, the software has light and audio-based synchronization methods available. This allows users to collect data from a set of external cameras (e.g. GoPros or smartphone cameras) and import and synchronize them within the software. Finally, users can also import already-synchronized videos into the software for processing. 


* Single camera reconstruction *

While it is possible to reconstruct 3D data from a single image, monocular 3D data tends to fall well-short of the accuracy that reconstructions from multiple cameras can provide @wadeApplicationsLimitationsCurrent2022 @nogueiraMarkerlessMultiview3D2025. Multi-camera viewpoints provide additional information about joint center locations that can improve accuracy of reconstruction while also mitigating the effect of occlusions, which are a significant barrier to single camera reconstruction. 

The FreeMoCap software is capable of simple reconstruction from single camera data, but we highly recommend multi-camera setups for recording. 
