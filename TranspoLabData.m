%% Initialize:

clear all;
close all;
clc;
warning('off', 'MATLAB:table:ModifiedAndSavedVarnames')

%% Identify all CSV files in the Current folder.

NoOfFiles = 46; %Number of trajectory files in the directory (set manually)
d = (1:NoOfFiles);

%% Function to read trajectories from vehicle ID 

function [time, space, speed] = lab1_vehicle_data(vehID)
%%% DESCRIPTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads the data of one vehicle directly from its .CSV file.
%   Obs.: .CSV file must be in the current path.
%   Usage:
%       [time, space, speed] = load_vehicle_data(vehID)
% 
%%% INPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   vehID   ID of the vehicle we want the data.
% 
%%% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   time    Instants of time with data for the specified vehicle.
%   space   Instantaneous positions for the specified vehicle.
%   speed   Instantaneous positions for the specified vehicle.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');    % Turn off the warning for the format of data on the table.

data=readtable(['trajectory' num2str(vehID) '.csv'],'ReadVariableNames',true);  % Read file.
time=data.Time_s_;      % Get time.
space=data.Distance_m_; % Get space.
speed=data.Speed_km_H_; % Get speeds.

% Clear empty (NaN) data points (last points in the table).
time(isnan(time))=[];
space(isnan(space))=[];
speed(isnan(speed))=[];

end


%% Function used to plot the time space diagram

 function lab1_plot_TS_diag(time,space,speed)
%%% DESCRIPTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generates the Time-Space diagram of a vehicle using its data.
% 
%%% INPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   time    Instants of time with data for the specified vehicle.
%   space   Instantaneous positions for the specified vehicle.
%   speed   Instantaneous positions for the specified vehicle.
% 
%%% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% An unformated plot.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% xx=time;
% yy=space;
% zz=zeros(size(xx,1));
% cc=speed;
xx=[time time];
yy=[space space];
zz=zeros(size(xx));
cc =[speed speed];

surf(xx,yy,zz,cc,'EdgeColor','interp','FaceColor','none') ;
 end

 
%% Function used to format plot created for better reading 
 function lab1_format_TS_diag()
%%% DESCRIPTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corrects the format of the Time-Space diagram. Mus be called after
% generating the Time-Space diagram with all vehicles.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colormap(flip(jet));
view(2);
xlim([0 900]);
ylim([0 360]);
h = colorbar;
ylabel(h, 'Speed (km/h)')
xlabel('Time (seconds)');
ylabel('Space (meters)');

 end


%% Generate Space x Time diagram for all vehicles 
%Here a space x time diagram is created using all trajectories in the central lane. 

for i = 1:NoOfFiles
    [time, space, speed] = lab1_vehicle_data(i); 
    lab1_plot_TS_diag(time,space,speed)
    hold on
end 
lab1_format_TS_diag()