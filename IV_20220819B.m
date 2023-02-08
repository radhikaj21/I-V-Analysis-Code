%% Input resistance from all long pulses recordings of cell 20220819B

clear all
close all
clc

%% Data information %%

cd 'C:\Users\adamici\Desktop\MATLAB\Data_Analysis\20220819B'
cell_name = 'cell_20220819B';
fileList = dir('LongPulses*.abf');

%% Calling the loading function

%Load Files
for i = 1:length(fileList)

        [datalist{i},sampling_interval{i},info{i}] = abfload(fileList(i).name);
end

%% Plotting Raw Data and Saving files as .mat

%Create sampling interval variable to use for time axis(possible assuming all files have same s.i.)  
sampling_interval_1=sampling_interval{1};

for i = 1:length(fileList)
    data=datalist{i}; % data for each file in the fileList is being extracted and stored in the "data" variable. 

    time_axis= linspace(0,length(data(:,1))*sampling_interval_1*1E-3,length(data(:,1)))'; %1E-3 is scientific notation for 10^-3, 1/1000 used to convert uS to mS

    voltage{i} = squeeze(data(:,1,:));
    current{i} = squeeze(data(:,2,:));
    
    twoSubplot_voltageAndCurrent_linkAxesPlot(voltage{i},current{i},time_axis,cell_name);
    title(fileList(i).name(1:end-4));

%get user input on whether data should be saved
    worthSaving = input('is this a good data file? Press 0 for no, 1 for yes');
    if worthSaving == 1
       
    rawData_traces.voltage = voltage{i};
    rawData_traces.current = current{i};
    rawData_traces.time_axis = time_axis;
    rawData_traces.infos = info{i};

   file_name = fileList(i).name(1:end-4);
        save_name = [cell_name '_' file_name];
        save(save_name, 'rawData_traces');

    else rawData_traces = [];
    end
end
%% Plot V-I

for i = 1:length(fileList)

    %Determine sampling frequency
    sampling_frequency = 1/sampling_interval_1*1000; % convert sampling interval (in us) to frequency (in kHz)

    %Average samples in the steady state range of the pulse
        % For Current Pulse
    Iss_start = 1200*sampling_frequency; %setting start and end 
    Iss_end = 2500*sampling_frequency;

    curr=current{i}; % Assign current trace of the current iteration to variable "curr"
    range_Iss = curr(Iss_start:Iss_end,:); %selects part of current data for each recording file
    mean_range_Iss = mean(range_Iss); %makes an average of the current range 
    mrangeIlist{i} = mean_range_Iss % creates a class where it stores the averages of I for each oulses in a cell and repeats it for all reocrdings


        % For Voltage
    Vss_start=2200*sampling_frequency;
    Vss_end=2500*sampling_frequency;
    Volt=voltage{i};
    range_Vss = Volt(Vss_start:Vss_end,:);
    mean_range_Vss = mean(range_Vss);
    mrangeVlist{i}=mean_range_Vss
  
%Build IV curve 
    figure;
    plot(mean_range_Iss,mean_range_Vss,'. k ', 'MarkerSize', 10) %plots current vs voltages for each recording with a style of dots black
    title("I-V Plot")
    xlabel('I (pA)')
    ylabel('V (mV)')
    
    %%Calculate input resitance
   
    Input_R = ((abs(mean_range_Vss)/abs(mean_range_Iss))*1000) %Input resistance is the quotient of voltage divided by current
    Input_R_list(i)= Input_R %gives me a class with the IR of each recording
    

end

figure;
for i = 1:length(fileList)
   
   plot(mrangeIlist{i}, mrangeVlist{i},'. ', 'MarkerSize', 10)      
   title (["I-V Plot "  strrep(cell_name,'_',' ')])
    xlabel('I (pA)')
    ylabel('V (mV)')
    hold on
end
saveas(gcf, [cell_name '.jpg'])
hold off
