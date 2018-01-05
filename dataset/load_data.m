clc        % clear command window
clear      % clear all variables
%close all  % close all figures

%%
% The data file (data.txt) is published by Intel Berkeley Research lab
% and can be downloaded from: http://db.lcs.mit.edu/labdata/labdata.html

% data.txt has data for all motes for over wide duration.

% I use "Import Data" in matlab to import data.txt and save it as matrix
% (i.e. data.mat)

% data.mat has data for all motes for the entire duration (i.e. datatime), 
% data.mat has the following headers:
% headers = [date:yyyy-mm-dd, time:hh:mm:ss.xxx, epoch:int, moteid:int, 
% temperature:real,	humidity:real, light:real, voltage:real]

%%

file_name = 'data.mat';
load(file_name);

% mote_id => select the mote_id that you want to load its data and 
% within a date range => dstart and dstop
%1, 11, 13, and 49
mote_id = 11;

% read only data between March 6, 9
dstart = '06-Mar-2004' ; % starting date
dstop  = '09-Mar-2004' ; % end date

dateCol = table2array(data(:,1));

%this contains the indices of the matching dates
idxDateOK = (dateCol >= dstart) & (dateCol <= dstop ) ; 

indx =  find(idxDateOK); % get indices with non zero value 
rows_dateOK = data(indx,:);

% get temperature from table into matrix
%x= table2array(data(:,5));

% get moteid, temperature from table into matrix
x= table2array(data(indx,[4,5]));

% find indices to elements in moteid column of x that satisfy the equality
ind1 = find(x(:,1) == mote_id);

% use the logical indices into x to return required sub-matrice
x = x(ind1,2);

% so now x contains all temperature value of mote_id between dstart and
% dstop duration
