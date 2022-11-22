
Vbsl1_start=4000;
Vbsl1_end=7000;
Vstds1_start=35000;
Vstds1_end=38000;
Ibsl1_start=4000;
Ibsl1_end=9000;
Istds1_start=33000;
Istds1_end=39000;

sampling_rate=20000;
N=size(V,1);
time=([1:N]/sampling_rate)-0.5;

num_traces=size(I,2);
RES_DV=[]; %empty array for deltaV
RES_DI=[];

for iTrace=[2:num_traces]
    V1=V(:,iTrace);




    V_bsl1=mean(V1(Vbsl1_start:Vbsl1_end));
    V_stds1=mean(V1(Vstds1_start:Vstds1_end));
    V_step1=-(V_bsl1-V_stds1); %Voltage step

    I1=I(:,iTrace);


    I_bsl1=mean(I1(Ibsl1_start:Ibsl1_end));
    I_stds1=mean(I1(Istds1_start:Istds1_end));
    I_step1=(I_stds1-I_bsl1); %Current step

    RES_DV=[RES_DV V_step1];
    RES_DI=[RES_DI I_step1];
    
    subplot(2,2,1)
    plot(time,I1,'color',[0 0 0 0.5])
    hold on
    subplot(2,2,2)
    plot(time,V1,'color',[0 0 0 0.5])
    hold on
    subplot(2,2,[3,4])
    plot(I_step1,V_step1,'ok','MarkerFaceColor','k') %should show one point
    hold on
end


subplot(2,2,1)
ylabel('I[pA]')
xlabel('time[s]')
set(gca,'FontSize',16)
box off

subplot(2,2,2)
ylabel('V[mv]')
xlabel('time[s]')
set(gca,'FontSize',16)
box off

subplot(2,2,[3,4])
ylabel('\DeltaV[mV]')
xlabel('\DeltaI[pA]')
grid on
set(gca,'FontSize',16)
box off
% 
% 
% V2=V(:,3);
% plot(V2)
% 
% Vbs2_start= 4000;
% Vbs2_end=9000;
% V_bs2=mean(V2(Vbs2_start:Vbs2_end));
% 
% Vstds2_start= 32000;
% Vstds2_end=40000;
% V_stds2=mean(V1(Vstds2_start:Vstds2_end));
% 
% V_step2=-(V_bs2-V_stds2)
% 
% 
% I2=I(:,3)
% plot(I2)
% 
% Ibs2_start=4000
% Ibs2_end=9000
% I_bsl2=mean(I1(Ibsl_start:Ibsl_end))
% 
% Istds2_start=33000
% Istds2_end=39000
% I_stds2=mean(I1(Istds_start:Istds_end))
% 
% I_step2=(I_stds2-I_bsl2) %Current step
% 



%plot(




