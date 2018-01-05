% This implementation is for AM-DR Approach algorithm proposed in
% Y.Fathy, P. Barnaghi and R. Tafazolli, An Adaptive Method for Data 
% Reduction in the Internet of Things, In Proceedings of the IEEE 4th 
% World Forum on Internet of Things (WF-IoT), Feb 2018
 
%% Load data
load_data
len_x = length(x);

%% Initialisation Phase
w_s = 10; % no of previous samples to take it into account (slow filter's length)
w_f = 5;% no of previous samples to take it into account (fast filter's length)
alpha = 1.0e-007;          % step size/ learning rate 
emax = 0.5;              % user defined error budget

w =  zeros(len_x, 1);     % weights

lambda = zeros(len_x, 1); % weight for each observation
y = zeros(len_x,1);     % filter output
e = zeros(len_x,1);     % error = desired/real_value - estimated_value
e_max = zeros(len_x, 1); % store indx at which data should be trasmitted

N = w_s; 
x_e= zeros(len_x, 1);     % available x to be used for prediction
x_e(1:N)= x(1:N);         
e_max(1:N)= 1;

e(1:N) = ones(N, 1);     % Error is 1 as I send the first N observations
start = 1; 
k_f = w_f-1;

% Calculate the fast filter. We assume that the fast filter values 
% are calculated on parallel with the slow filter
% Note: w_s (for slow filter) is always larger than w_f (for fast filter),
% so w_f should be calculated until no of samples of w_s reached
% and then both filters (slow and fast) should start working/running 
% on parallel

for k = w_f: N
        moving_avg_f(k) = mean(x(k-w_f+1:k)); % moving average fixed window
end

for k = N + 1 : len_x
    
     % We assume that the fast filter values are calculated on parallel 
     % with the slow filter
     moving_avg_f(k) = mean(x_e(k-w_f+1:k-1)); % moving average fixed window
     
     moving_avg_s(k) = mean(x_e(start:k-1));% moving average increasing window
     % estimated signal: output of overall filters (fast and slow filters)
     % y(k) is the total weight
     y(k) = (lambda(k) * moving_avg_f(k)) + ((1-lambda(k)) * moving_avg_s(k)); 
     e(k) = x(k) - y(k);
     % weight is the diff between the two moving average
     w = moving_avg_f(k) -  moving_avg_s(k);

    % State: e - use predicition
    if  all(abs(e(k - w_f + 1: k)) < emax) 
            x_e(k)= y(k);
            lambda(k+1) = lambda(k);

    % State: communication => send real-data  
    else    
         e_max(k) = 1; 
         x_e(k)= x(k);
         % estimation of the mixing parameter of two filters in on-line fashion
         lambda(k+1) = lambda(k) + (alpha * e(k) * w);
         start = k;
    end
        %weight is normalised to be independent of the data streams scale.
%      if lambda(k) > 1
%           lambda(k) = 1;      
%      end
%      if lambda(k) < 0
%         lambda(k) = 0;
%      end
    %start
end

%% Evaluation
% get where data has to be transmitted 
% nd_idx: indexes at which data should be transmitted
% find is to get indices that have only 1 which t values.
nd_idx=find(e_max==1);
 
data_length= length(x)
transmission_length = length(nd_idx)
saving_perecentage = ((data_length - transmission_length) * 100)/data_length
transmit_precentage = 100 - saving_perecentage
 

%% plot Figure 3. AM-DR: real and predicted sensor readings of mote 11
results_directory ='plot_results/';

% create a new figure
figure;

plot(x,'-');
hold on
plot(y,'-');
grid;

% xlimit
set(gca,'XLim',[1540 1640])
set(gca,'XTick',(1540:10:1640))

%ylimit
set(gca,'YLim',[21 23])
set(gca,'YTick',(21:0.5:23))

% e_max = 1 when i have to send observation, otherwise if it is based on 
% prediction e_max = 0
err = e_max.*(y); 
err(err == 0) = NaN;
plot(1:len_x, err,'rx')
legend('real data', 'filter output')
xlabel('samples'),
ylabel('temperature [°c]');

% save pdf
print(strcat(results_directory,'AMDR_mote11_filterout'),'-dpdf')
%% plot Figure 5. AM-DR: prediction error of mote 11

% create a new figure
figure;

%%plot error e
plot(e);
hold on

%x/y limits for plot
xlim([1540 1640]);
set(gca,'YLim',[-0.6 0.6])
set(gca,'YTick',(-0.6:0.2:0.6))
err = e_max.*(e);% in order to have only the indices where data has to tranmitted
err(err == 0) = NaN; 
plot(1:len_x, err,'rx')
%plot(1:len_x,e_max.*(e))
grid on,
xlabel('samples'),
ylabel('prediction error [°c]');

% save pdf
print(strcat(results_directory,'AMDR_mote11_error'),'-dpdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
