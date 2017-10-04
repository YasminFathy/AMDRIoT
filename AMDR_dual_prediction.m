 
% AM-DR Approach

%% Load data
load_data
len_x = length(x);

%% Initialisation Phase
w_s = 8; % no of previous samples to take it into account (slow filter's length)
w_f = 4;% no of previous samples to take it into account (fast filter's length)
mu = 6.0e-001;          % step size/ learning rate 
emax = 0.5;              % user defined error budget

w =  zeros(len_x, 1);     % weights


lambda = zeros(len_x, 1); % weight for each observation
y = zeros(len_x,1);     % filter output
e = zeros(len_x,1);     % error = desired/real_value - estimated_value
e_max = zeros(len_x, 1); % store indx at which data should be trasmitted

%e(1:N) = ones(N, 1);     % Error is 1 as I send the first N observations
N = w_s;
x_e= zeros(len_x, 1);     % available x used for prediction
x_e(1:N)= x(1:N);
e_max(1:N)= 1;

e(1:N) = ones(N, 1);     % Error is 1 as I send the first N observations
start = 1; 
k_f = w_f-1;

for k = w_f: N
        moving_avg_f(k) = mean(x(k-w_f+1:k)); % moving average fixed window
end

for k = N + 1 : len_x

     moving_avg_f(k) = mean(x_e(k-w_f+1:k-1)); % moving average fixed window     
     moving_avg_s(k) = mean(x_e(start:k-1));% moving average increasing window
     % estimated signal:output of overall filters (fast and slow filters)
     % y(k) is the total weight
     y(k) = (lambda(k) * moving_avg_f(k)) + ((1-lambda(k)) * moving_avg_s(k)); 
     e(k) = x(k) - y(k);
     % weight is the diff between the two moving average
     w = moving_avg_f(k) -  moving_avg_s(k);

    if  all(abs(e(k - w_f + 1: k)) < emax) 
            x_e(k)= y(k);
            lambda(k+1) = lambda(k);

    % State: communication => send real-data  
    else    
         e_max(k) = 1; 
         x_e(k)= x(k);
         % estimation of the mixing parameter of two filters in on-line fashion
         lambda(k+1) = lambda(k) + (mu * e(k) * w);
         start = k;
    end
       
end

%% Evaluation
% get where data has to be transmitted 
% nd_idx: indexes at which data should be transmitted
nd_idx=find(e_max==1);

 
data_length= length(x)
transmission_length = length(nd_idx)
saving_perecentage = ((data_length - transmission_length) * 100)/data_length
transmit_precentage = 100 - saving_perecentage
 

%% plot x and y 
% plot(x);
% hold on
% plot(y);
% xlim([1540 1640]);
% set(gca,'YLim',[21 23])
% set(gca,'YTick',(21:0.5:23))
% % set(gca,'YLim',[22 24])
% % set(gca,'YTick',(22:0.5:24))
% err = e_max.*(y);
% err(err == 0) = NaN;
% plot(1:len_x, err,'rx')


%%plot error e
plot(e);
hold on

%x/y limits for plot
xlim([1540 1640]);
set(gca,'YLim',[-0.6 0.6])
set(gca,'YTick',(-0.6:0.2:0.6))
err = e_max.*(e);
err(err == 0) = NaN;
plot(1:len_x, err,'rx')
%plot(1:len_x,e_max.*(e))


grid on,
xlabel('samples'),
ylabel('temperature [°c]');
ylabel('prediction error [°c]');
%legend('real data', 'filter output')


