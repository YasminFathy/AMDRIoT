# AMDRIoT

This is an implementaion "An Adaptive Method for Data Reduction in the Internet of Things"

We propose an Adaptive Method for Data Reduction (AM-DR). Our method is a prediction-based data reduction that exploits LMS adaptive filters. More specifically, our method is based on a convex combination of two decoupled LMS windowed filters with differing sizes for estimating the next measured values both at the source and the sink node such that sensor nodes have to transmit only their immediate sensed values that deviate significantly (> emax, a pre-defined threshold ) from the predicted values.

The implementation of our approach is included in "AMDR_dual_prediction.m"

The baseline approach is "dual_prediction.m" that includes implementation of the following paper:
"An adaptive strategy for quality-based data reduction in wireless sensor networks. In Proceedings of the 3rd international 
conference on networked sensing systems (INSS 2006) (pp. 29-36)." 

The first line of both files has "load data" that requires "data.m" file. "data.m" has a large size and can't be uploaded here, so please download it from this link:
https://www.dropbox.com/s/2vvpyx1r6spl9fn/data.mat?dl=0


ReadME.txt contains the description of each directory/folder:

=>dataset directory:
It contains the dataset. To load dataset, use load_data.m 
and change any parameter values if required (e.g. mote_id, start/end 
date range).

--------------------------------------------------------------------------
=>baseline:
It contains the implementation of the algorithm proposed by Santini, S., 
& Romer, K. (2006, June), In paper entitled "An adaptive strategy for 
quality-based data reduction in wireless sensor networks", published
In Proceedings of the 3rd international Conf. on networked sensing systems 
(INSS 2006) (pp. 29-36).
The paper can be accessed from here:
http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.437.9242&rep=rep1&type=pdf

--------------------------------------------------------------------------
=>myapproach_AMDR:
It contains the implmentation of my proposed approch that is presented in
my paper "An Adaptive Method for Data Reduction in 
the Internet of Things", Yasmin Fathy, Payam Barnaghi,
and Rahim Tafazolli, the Proceedings of IEEE World Forum on Internet 
of Things, Feb. 2018, Singapore. 

--------------------------------------------------------------------------
=>plot_results:
It constains all the results of running both of baseline and AMDR algorithms.
It has "plot_datav.m" script to reproduce the results in my paper "An Adaptive 
Method for Data Reduction in the Internet of Things", 
Yasmin Fathy, Payam Barnaghi, and Rahim Tafazolli, the Proceedings of IEEE World Forum 
on Internet of Things, Feb. 2018, Singapore. 

--------------------------------------------------------------------------


