# AM_DR_IoT

This is an implementaion "An Adaptive Method for Data Reduction in the Internet of Things"

We propose an Adaptive Method for Data Reduction (AM-DR). Our method is a prediction-based data reduction that exploits LMS adaptive filters. More specifically, our method is based on a convex combination of two decoupled LMS windowed filters with differing sizes for estimating the next measured values both at the source and the sink node such that sensor nodes have to transmit only their immediate sensed values that deviate significantly (> emax, a pre-defined threshold ) from the predicted values.

The implementation of our approach is included in "AMDR_dual_prediction.m"

The baseline approach is "dual_prediction.m" that includes implementation of the following paper:
"An adaptive strategy for quality-based data reduction in wireless sensor networks. In Proceedings of the 3rd international 
conference on networked sensing systems (INSS 2006) (pp. 29-36)." 

The first line of both files has "load data" requires "data.m" file. "data.m" has a large size and can't be uploaded here, so please download it from this link:

