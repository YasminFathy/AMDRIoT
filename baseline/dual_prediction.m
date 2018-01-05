% This implementation is for algorithm in the article of
% Santini, S., & Romer, K. (2006, June), 
% An adaptive strategy for quality-based data reduction in 
% wireless sensor networks, In Proceedings of the 3rd international 
% conference on networked sensing systems (INSS 2006) (pp. 29-36).
 
%% Load data
load_data
%x= x(1540:1640);
%x= x(1:16);
%len_x = length(x) -1;
len_x = length(x);
%% Initialisation Phase
N = 5; % no of previous samples to take it into account (filter's length)

mu = 0.00001; %1.0e-005;          % step size/ learning rate 

emax = 0.5;              % user defined error budget

w =  zeros(len_x, N);     % weights
y =  zeros(len_x, 1);     % filter output
x_e= zeros(len_x, 1);     % available x used for prediction


e_max = zeros(len_x, 1); % store indx at which data should be trasmitted

%%%%%%%%%%%%%%%%%%%%%%%
% Initialization mode:
%%%%%%%%%%%%%%%%%%%%%%%
% I need to transmit the first N values at the begining of running 
% the algorithm from node to sink, so I have to send the first N observations

e_max(1:N) = 1;      

y(1:N) =  x(1:N); % first N obseravations of actual x are required 
x_e(1:N)= x(1:N); % available x used for prediction

e = zeros(len_x, 1);     % error = desired/real_value - estimated_value
e(1:N) = ones(N, 1);     % Error is 1 as I need to send the first N observations

start =  N + 1;         % start index

%% start Dual Prediction

for k =start : len_x
    % w = (w_6,1 , w_6,2 , w_6,3 , w_6,4 , w_6,5)
    % x_e = (x_e_1, x_e_2, x_e_3, x_e_4, x_e_5)
    
    % y(6) = sum(w_i[k] * x(k-i)) => i =1...N
    % y(6) = w_1 * x(5) +  w_2 * x(4) + w_3 * x(3) + w_4 * x(2) + w_5 * x(1)
    % so flipping w (to be w5, w4,w3,w2,w1) and leave x as it is in order x1,x2,x3,x4,x5
    % y(5) = sum(fliplr(w) * x_e)
    y(k) = sum(fliplr(w(k,:)') .* x_e(k-N:k-1));
    e(k) = x(k) - y(k);
    
    % State: No communication (Sink nodes use predicited values)=>
    % stand-alone mode
    if  all(abs(e(k - N + 1: k)) < emax) 
            x_e(k) = y(k);
            w(k+1,:) = w(k,:);

    % State: Communication => (Sink nodes receives real data values from 
    %                           sensor nodes) 
    % normal mode
    else    
         e_max(k) = 1; 
         x_e(k)= x(k);
         for i = 1:N
               w(k+1,i) = w(k,i) + (mu * x_e(k-N+i-1) * e(k)); 
               %w(k+1,i) = w(k,i) + (mu * x_e(k-1) * e(k));
               %w(k+1,i) = w(k,i) + (mu * x_e(k+1-i) * e(k));
         end 
    end

    
end
% get where data has to be transmitted 
% nd_idx: indexes at which data should be transmitted
% find is to get indices that have only 1 which t values.
nd_idx=find(e_max==1);
%nd_idx = nd_idx(2:end);
 
data_length= length(x)
transmission_length = length(nd_idx)
saving_perecentage = ((data_length - transmission_length) * 100)/data_length
transmit_precentage = 100 - saving_perecentage
 

%% figure to plot Fig 3 (a) for mote_id =11 in dataset\load_data.m
%figure
figure('Name','Reproducible experiement for mote_id =11','NumberTitle','off')

subplot(3,1,1)
title('Fig3 (a)');
hold on
plot(x)
grid on,

% xlimit
set(gca,'XLim',[1 3000]);
set(gca,'XTick',(0:500:3000));


% ylimit
set(gca,'YLim',[16 26]);
set(gca,'YTick',(16:2:26));

xlabel('samples'),
ylabel('temperature [°c]');
%% plot x and y 
% figure to plot Fig 3 (b) for mote_id =11 in dataset\load_data.m
subplot(3,1,2)
title('Fig3 (b)');
hold on
% plot(x,'.-');
% plot(y,'.-');
plot(x,'-');
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
err = e_max.*(x); 
err(err == 0) = NaN;
plot(1:len_x, err,'rx')
legend('real data', 'filter output')
xlabel('samples'),
ylabel('temperature [°c]');

%% figure to plot Fig 3 (c) for mote_id =11 in dataset\load_data.m
subplot(3,1,3)
hold on
title('Fig3 (c)');
%plot(e,'.-');
plot(e,'-');

% xlimit
set(gca,'XLim',[1540 1640])
set(gca,'XTick',(1540:10:1640))

%ylimit
set(gca,'YLim',[-0.6 0.6])
set(gca,'YTick',(-0.6:0.2:0.6))

%plot(1:len_x,e_max.*(e))

err = e_max.*(e); 
err(err == 0) = NaN;
plot(1:len_x, err,'rx')

grid on,
xlabel('samples'),
ylabel('prediction error [°c]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save pdf
results_directory ='plot_results/';
print(strcat(results_directory,'baseline_mote11'),'-dpdf')
