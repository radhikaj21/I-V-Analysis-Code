%% Input resistance from one recording of cell 20220819B
clear all
close all
clc
%% Data information %%
cell_name = ('cell_20220819B');
file_name = ('LongPulses_0000.abf');

%% Calling the loading function
[data,sampling_interval,infos] = abfload(file_name);
sampling_frequency = 1/sampling_interval*1000; % convert sampling interval (in us) to frequency (in kHz)

%% Make time axis, plot data 
        
time_axis = linspace(0,length(data(:,1))*sampling_interval*1E-3,length(data(:,1)))';

voltage = squeeze(data(:,1,:));
current = squeeze(data(:,2,:));
    
twoSubplot_voltageAndCurrent_linkAxesPlot(voltage,current,time_axis,cell_name);

title(file_name(1:end-4));


%get user input on whether data should be saved
    worthSaving = input('is this a good data file? Press 0 for no, 1 for yes');
    if worthSaving == 1
       
    rawData_traces.voltage = voltage;
    rawData_traces.current = current;
    rawData_traces.time_axis = time_axis;
    rawData_traces.infos = infos;

    save(strcat(cell_name,'_',file_name(1:end-4)),'rawData_traces')

    else rawData_traces = [];
    end
%% Plot V-I

%Average samples in the steady state range of the pulse

    % For Current Pulse
Iss_start = 1200*sampling_frequency;
Iss_end = 2200*sampling_frequency;
range_Iss = current(Iss_start:Iss_end,:);
mean_range_Iss = mean(range_Iss);
pulse_mean_Iss = mean(mean_range_Iss);

    % For Voltage
Vss_start=2100*sampling_frequency;
Vss_end=2500*sampling_frequency;
range_Vss = voltage(Vss_start:Vss_end,:);
mean_range_Vss = mean(range_Vss);
pulse_mean_Vss= mean(mean_range_Vss);


%Build IV curve 
figure;
plot(mean_range_Iss,mean_range_Vss,'. k ', 'MarkerSize', 10) %plots current (moltiplied by 1000 to get pA) vs voltages with a style of dots black
title("I-V Plot")
xlabel('I (pA)')
ylabel('V (mV)')

%% Calculate input resitance

Input_R = (mean_range_Vss/mean_range_Iss) %Input resistance is the quotient of voltage divided by current thhis gives nanoohm we want mega oh, so multiply by 10^15




















