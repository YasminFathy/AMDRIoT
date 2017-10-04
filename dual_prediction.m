% This implementation is for algorithm in
% Santini, S., & Romer, K. (2006, June). 
% An adaptive strategy for quality-based data reduction in 
% wireless sensor networks. In Proceedings of the 3rd international 
% conference on networked sensing systems (INSS 2006) (pp. 29-36).
 
%% Load data
load_data
len_x = length(x);

%% Initialisation Phase
N = 4; % no of previous samples to take it into account (filter's length)

Ex = (1/(mean(x(1:N).^2)));
mu = 1.0e-005;          % step size/ learning rate 

emax = 4.0;              % user defined error budget

w =  zeros(len_x, N);     % weights
y =  zeros(len_x, 1);     % filter output
x_e= zeros(len_x, 1);     % available x used for prediction


e_max = zeros(len_x, 1); % store indx at which data should be trasmitted

% I need to transmit the first N values at the begining from node to sink
e_max(1:N) = 1; % because I have to send the first N observations 

                
y(1:N) =  x(1:N); 
x_e(1:N)= x(1:N);

e = zeros(len_x, 1);     % error = desired/real_value - estimated_value
e(1:N) = ones(N, 1);     % Error is 1 as I send the first N observations

start =  N + 1;         % start index

%% start Dual Prediction

for k =start : len_x
         
    y(k) = sum(fliplr(w(k,:)') .* x_e(k-N:k-1));
    e(k) = x(k) - y(k);
    
    % State: No communication - use predicition
    if  all(abs(e(k - N + 1: k)) < emax) 
            x_e(k)= y(k);
            w(k+1,:) = w(k,:);

    % State: communication => send real-data  
    else    
         e_max(k) = 1; 
         x_e(k)= x(k);
         for i = 1:N
               w(k+1,i) = w(k,i) + (mu * x_e(k-N+i-1) * e(k)); 
         end 
    end
    
end
% get where data has to be transmitted 
% nd_idx: indexes at which data should be transmitted
% find is to get indices that have only 1 which t values.
nd_idx=find(e_max==1);

 
data_length= length(x)
transmission_length = length(nd_idx)
saving_perecentage = ((data_length - transmission_length) * 100)/data_length
transmit_precentage = 100 - saving_perecentage
 

%% plot x and y 
% figure
% plot(x);
% hold on
% plot(y);
% xlim([1540 1640]);
% set(gca,'YLim',[21 23])
% set(gca,'YTick',(21:0.5:23))
% %set(gca,'YLim',[22 24])
% %set(gca,'YTick',(22:0.5:24))
% err = e_max.*(x);
% err(err == 0) = NaN;
% plot(1:len_x, err,'rx')


%%plot error e
plot(e);
hold on

%% x/y limits for plot error
err = e_max.*(e);
err(err == 0) = NaN;
plot(1:len_x, err,'rx')
%plot(1:len_x,e_max.*(e))


%x/y limits for plot
xlim([1540 1640]);
set(gca,'YLim',[-0.6 0.6])
set(gca,'YTick',(-0.6:0.2:0.6))


grid on,
xlabel('samples'),
ylabel('temperature [°c]');
ylabel('prediction error [°c]');
%legend('real data', 'filter output')
