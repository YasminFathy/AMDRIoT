# AM_DR_IoT

This is an implementaion "An Adaptive Method for Data Reduction in the Internet of Things"

We propose an Adaptive Method for Data Reduction (AM-DR). Our method is a prediction-based data reduction that exploits LMS adaptive filters. More
specifically, our method is based on a convex combination of two decoupled LMS windowed filters with differing sizes
for estimating the next measured values both at the source and the sink node such that sensor nodes have to transmit
only their immediate sensed values that deviate significantly (> emax, a pre-defined threshold ) from the predicted values.
