== Synchronous Video Recording

Synchronous video recording refers to the acquisition and temporal alignment of video streams. When reconstructing 3D data, it is critical that each set of frames from cameras represents the exact same moment in time. Without proper synchronization, time lags between cameras can result in incorrect 3D reconstruction. 

* Hardware limitations *

Of note is that the method of video synchronization is often tied to the system's required camera hardware. For example, OpenCap synchronizes videos from iOS devices (e.g. iPhones, iPads) connected to a web app (requiring internet connection for use). Theia Markerless supports specific camera systems (e.g. Qualisys Miqus, Vicon Vue) with a minimum requirement of six cameras. As such, the method of synchronization can often be a limiting system requirement for the user. For example, for a wide capture area access to enough iOS devices to record data could quickly become costly.

* Design motivations * 

A core directive of our synchronized video acquisition software, `SkellyCam` is to provide high quality methods of synchronization for affordable cameras. This software enables users to use, at a base level, off-the-shelf USB webcams (as low as \$20) to record synchronized videos with sub-millisecond precision for up to 8 cameras. This means that feasibly, users can create their own minimal motion capture setup with two USB webcams for \~\$40. The data presented in later chapters this work were collected using six \~\$20 USB webcams (1280 x 720, 30 FPS) purchased from Amazon. 

The software is not only limited to USB webcams, however . Certain research needs may require cameras with higher resolution, field of view, or frame rate specifications. For these purposes, the software also has 
light and audio-based synchronization methods available. Users can collect data from a set of external cameras (e.g. GoPros or smartphone cameras) and import and synchronize them within the software. Beyond that, if users already have a set of pre-synchronized videos, these can also be imported into the software for processing. 

As such, the software is not constrained by camera hardware as a limitation, which also allows users to scale their setup to their financial or infrastructural resources and research needs. 


* Single camera reconstruction *

While it is possible to reconstruct 3D data from a single image, monocular 3D data tends to fall well-short of the accuracy that reconstructions from multiple cameras can provide @wadeApplicationsLimitationsCurrent2022 @nogueiraMarkerlessMultiview3D2025. Multi-camera viewpoints provide additional information about joint center locations that can improve accuracy of reconstruction while also mitigating the effect of occlusions, which are a significant barrier to single camera reconstruction. 

The FreeMoCap software is capable of simple reconstruction from single camera data, but we highly recommend multi-camera setups for recording. 
