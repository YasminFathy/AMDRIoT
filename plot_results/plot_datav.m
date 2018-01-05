%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file is the result of running AMDR with different parameter values

results_directory ='plot_results/';
%%% plot results for mote 11 with different e_max and window sizes values
emax =[0, 0.5, 1, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

% result: % of transmitted data with window size: w_f = 4, w_s=8 with
% different values of emax as initialzed above.

result_4 = [100, 3.4463 ,1.3902, 0.8879  , 0.3271, 0.3271 , 0.3271 ,0.3271,  0.2804 ];

% result: % of transmitted data with window size: w_f = 8, w_s=16 with
% different values of emax as initialzed above.
result_8 = [ 100  , 6.7173 ,  2.9790 ,1.7757  , 0.6542, 0.6542 , 0.6542  , 0.6542 , 0.5607 ];

% result: % of transmitted data withwindow size: w_f = 10, w_s=20 with
% different values of emax as initialzed above.
result_10 = [100   , 7.9322 ,3.7266  , 2.2196 , 1.0514 ,0.8178  , 0.8178 , 0.8178 ,0.5841  ];

plot(emax,result_4,'bx-')
hold on;
plot(emax,result_8,'k*-')
plot(emax,result_10, 'ro-')
grid on,

set(gca,'YLim',[0 100])
set(gca,'YTick',(0:10:100))

set(gca,'XLim',[0 4.0])
set(gca,'XTick',(0:0.5:4))

xlabel('e_{max}'),

ylabel('% of transmitted data');
legend('w_f=4,w_s=8,\alpha=1.2e-007','w_f=8,w_s=16,\alpha=6.3e-007','w_f=10,w_s=20,\alpha=\alpha=1.2e-007')
print(strcat(results_directory,'AMDR_transmitteddata'),'-dpdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot results for all motes with different e_max values with w_f = 4 and
% w_s = 8
figure
emax =[0, 0.5, 1, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

% result: % of transmitted data for mote 1 with different values of emax 
%as initialzed above.
result_mote1 = [100 ,4.7619 , 2.4829,1.4394,0.8636,0.7197,0.6237,0.3359,0.3359];

% result: % of transmitted data for mote 11 with different values of emax 
%as initialzed above.
result_mote11 = [ 100, 6.7173 ,  2.9790 ,1.7757  , 0.6542, 0.6542 , 0.6542  , 0.6542 , 0.5607 ];

% result: % of transmitted data for mote 13 with different values of emax 
%as initialzed above.
result_mote13 = [100, 4.8538, 2.4113, 1.1823, 0.7467, 0.3734, 0.3734, 0.3734, 0.3734];

% result: % of transmitted data for mote 49 with different values of emax 
%as initialzed above.
result_mote49 = [ 100,8.1593, 4.0657  , 2.8404  , 2.0607  ,1.2810,  1.1696, 0.8354, 0.7797];

plot(emax,result_mote1,'bx-')
hold on;
plot(emax,result_mote11,'kd-')
plot(emax,result_mote13, 'r*-')
plot(emax,result_mote49, 'go-')
grid on,

set(gca,'YLim',[0 100])
set(gca,'YTick',(0:10:100))

set(gca,'XLim',[0 4.0])
set(gca,'XTick',(0:0.5:4))

xlabel('e_{max}'),

ylabel('% of transmitted data');
legend('mote 1:w_f=4, w_s=8,\alpha=1.2e-007', ...
       'mote 11:w_f=4,w_s=8,\alpha=1.2e-007', ...
       'mote 13:w_f=4,w_s=8,\alpha=1.3e-007', ...
       'mote 49:w_f=4,w_s=8,\alpha=1.3e-007');
   
   
print(strcat(results_directory,'AMDR_allmotes'),'-dpdf')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% plot results for mote 50 with different e_max values
figure
emax =[0, 0.5, 1, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

% AMDR: % of trabsmitted data for mote 50 with different values of emax 
%as initialzed above.
result_mote50_AMDR =[100, 9.5763, 4.7444,  3.0812, 2.1008, 1.6106, 1.3305, 1.0504, 0.9104];

% Baseline: % of trabsmitted data for mote 50 with different values of emax 
%as initialzed above.
result_mote50_baseline =[100 ,13.9181, 9.4888, 8.1758, 7.0028,  6.6352, 6.0224, 6.1099,  5.7423];

plot(emax,result_mote50_baseline,'bx-')
hold on;
plot(emax,result_mote50_AMDR,'rd-')

grid on,

set(gca,'YLim',[0 100])
set(gca,'YTick',(0:10:100))

set(gca,'XLim',[0 4.0])
set(gca,'XTick',(0:0.5:4))

xlabel('e_{max}'),

ylabel('% of transmitted data');
legend('Baseline: N = 4,\mu=1.0e-005', ...
       'AM-DR: w_f=4,w_s=8,\alpha=1.2e-007');
 
print(strcat(results_directory,'mote50'),'-dpdf')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot results for mote 30 with different e_max values
figure
emax =[0, 0.5, 1, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

% AMDR: % of trabsmitted data for mote 30 with different values of emax 
%as initialzed above.
result_mote30_AMDR =[100,  13.3672, 7.2431, 4.2523, 3.3367, 2.5229, 2.3601,1.7091,1.3835];

% baseline: % of trabsmitted data for mote 30 with different values of emax 
%as initialzed above.
result_mote30_baseline =[100 , 17.7823, 11.9634, 9.4608, 8.4028, 7.7518, 7.7721,6.8159, 6.2869];

plot(emax,result_mote30_baseline,'bx-')
hold on;
plot(emax,result_mote30_AMDR,'rd-')

grid on,

set(gca,'YLim',[0 100])
set(gca,'YTick',(0:10:100))

set(gca,'XLim',[0 4.0])
set(gca,'XTick',(0:0.5:4))

xlabel('e_{max}'),

ylabel('% of transmitted data');
legend('Baseline: N = 4,\mu=1.0e-005', ...
       'AM-DR: w_f=4,w_s=8,\alpha=1.0e-007');
   
print(strcat(results_directory,'mote30'),'-dpdf')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% learning rate vs error for mote 30
% learning_rate = [1.0e-007, 1.2e-007, 1.4e-007, 1.6e-007, 1.8e-007, 2.0e-007];
% %e_max_30 = 0.5;
% transmitted_data = [13.3672, 13.3672, ];
% plot(learning_rate,transmitted_data,'bx-')
% hold on;
% 
% grid on,
% 
% 
% ylabel('% of transmitted data'),
% set(gca,'YLim',[0 100])
% set(gca,'YTick',(0:10:100))
% 
% 
% xlabel('learning rate \alpha (10{^-7})')
% set(gca,'XLim',[1 2])
% set(gca,'XTick',(1:0.2:2))
% 
% %w_s = 8
% %w_f = 4
% %emax = 0.5; 
% % ylabel('% of transmitted data');
% % legend('Baseline: N = 4,\mu=1.0e-005', ...
% %        'AM-DR: w_f=4,w_s=8,\alpha=1.0e-007');
