%% Building I_V curve & charcaterise Ih %%%

%% Step1: plot traces of V and I without time scale

% figure; % this function creates a figure, in this way the second figure doesnt delete the previous/ The command "hold" overwrites thesecond figure.
% plot(I);
% 
%figure;
%plot(V);

%% Step2: Average samples in the range preceding the pulse

    % Step2a: define a range of I that goes from a start point to an end point before pulse 

I_start = 10; % hardcoded values for start and end here I can change them
I_end = 800;
range_I = I(I_start:I_end,:); % 0 and 800 are sample values coming before the pulse
                
    % Step2b: Calculate the average of the values in the range of I 

mean_range_I = mean(range_I); % this gives me a vector
prepulse_mean_I = mean(mean_range_I); % one mean value of current before injection


    % Step2c: define a range of V that goes from a start point to an end point before pulse + Calculate the average of the values in the range of V 
V_start = 10; % hardcoded values for start and end here I can change them
V_end = 800;
range_V = V(V_start:V_end,:);

mean_range_V = mean(range_V); % this gives me a vector
prepulse_mean_V = mean(mean_range_V);

%% Step3: Average samples in the steady state range of the pulse

% For Current Pulse
Iss_start = 5000;
Iss_end = 20000;
range_Iss = I(Iss_start:Iss_end,:);
mean_range_Iss = mean(range_Iss);
pulse_mean_Iss = mean(mean_range_Iss);

% For Voltage
Vss_start=6500;
Vss_end=20000;
range_Vss = V(Vss_start:Vss_end,:);
mean_range_Vss = mean(range_Vss);
pulse_mean_Vss= mean(mean_range_Vss);

%% Step4: Build IV curve 
figure;
plot(mean_range_Iss*1000,mean_range_Vss,'. k ') %plots current (moltiplied by 1000 to get pA) vs voltages with a style of dots black
title("I-V Plot")
xlabel('I (pA)')
ylabel('V (mV)')

%% Step 5: Calculate input resitance

Input_R= (mean_range_Vss/mean_range_Iss) %Input resistance is the quotient of voltage divided by current

% Transofrm in MOhm

%% Step 6: Calculate Sag

    % Step 6a: Create a range of hyperoplarising pukses to look at 

Hyperpol()
























