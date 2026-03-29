== Conclusions

This chapter examined the FreeMoCap pipeline. Additionally, it explored how while many of the design choices made for the software could simply be framed as accessibility features, they also have direct consequences for data quality. A synchronization approach that supports inexpensive cameras makes it practical to deploy more of them, which strengthens triangulation geometry. A tracker-agnostic architecture allows researchers to select the pose estimation backend best suited to their task rather than accepting whatever a system ships with. Lowering the barrier for entry, more than being a concession, is a choice that can directly improve the accuracy and the applicability of the resulting data. 




When discussing FreeMoCap, I have found that there are two questions I am often asked. 

The first is: "Who are your competitors?"  Ultimately, I believe the goal of this software is better described by a different question - not "What motion capture systems are we competing with?", but instead "Who has not been able to access motion capture, and how can we make it possible?". The aim of this work is to lower the barriers to collecting 3D movement data, enabling use across a range of contexts, from research to education and creative applications.

But accessibility and accuracy are not separate concerns - as the following chapter will argue, the design choices that make a system more accessible can also directly shape the quality of the data it produces. This leads to the second question I am often asked: "How accurate is your system?" Rather than providing a single summary metric, the following chapters characterize system performance across different movement domains, including dynamic gait, postural stability, and a more complex applied clinical scenario. This approach reflects the view that accuracy is not a single value, but a property that depends on context, task, and the underlying processing choices made available by the system's design.

There is a key theme here: something to fill these needs is not necessarily meant to replace the existing technologies used in either of these fields, but instead to present an option that democratizes a method for detailed yet non-invasive quantitative motion analysis and makes it more accessible to the ground-level user. The following chapter explores the current landscape of markerless motion capture technology, a solution that has often been proposed to fill these needs. 
