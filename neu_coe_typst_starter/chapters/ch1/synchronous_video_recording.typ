== Synchronous Video Recording

While there it is possible to reconstruct 3D data from a single image, monocular 3D data tends to fall well-short of the accuracy that reconstructions from multiple cameras can provide (some kinect/single camera citations). Multi-camera viewpoints provide additional information about joint center locations that can improve accuracy of reconstruction while also mitigating the effect of occlusions, which are a significant barrier to single camera reconstruction. 

Accordingly, when using multiple cameras it is crucial to synchronize the resulting video streams. For a given point in time the observed body positions from each frame, from each camera, should correspond to the same phase of motion. 
3D reconstruction from poorly synchronized videos can lead to significant errors in reconstruction accuracy. 

*Methods for Synchronized Video Recording*

Different motion capture software tend to have different methods of video acquisition. OpenCap, for example, uses iPhones connected to a web app to record synchronized videos, while Theia uses proprietary camera hardware and software.

A core directive of our software is to make it as accessible to users on the ground-level as possible, while also making it adaptable to specific research needs. For that reason, we have built our software to both synchronize and take in pre-synchronized videos. The core software includes the package `skellycam`, which allows users to use affordable (minimum cost \~\$20) USB webcams to record synchronized videos in the software with sub-millisecond precision. Additionally, we offer light and audio-based synchronization methods for videos recorded externally of the software. We also allow the import of a set of pre-synchronized videos. This allows for recording using higher quality or framerate cameras, such as phones or GoPro's, allowing ground-level testing or usage with affordable cameras, while still allowing for the motion capture setup to scale based on budget and research need. 