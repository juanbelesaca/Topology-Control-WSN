%% Graph: Data forwarding 
clear all
%% Parametros de entrada
snap = [1,2];%,2,3,4,5];
num_flow = [10,15,20,25,30,35,40];
sim = 6;
runs = 50;

%% Extraer datos
%AllRouters
fwdData = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('AllRouters/Sim0',num2str(sim),'/MsgRout_FwdData/fwdUnicast_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    fwdData = [fwdData,temp];
end

%SpanningTree
fwdDataST = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('SpanningTree/Sim0',num2str(sim),'/MsgRout_FwdData/fwdUnicast_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    fwdDataST = [fwdDataST,temp];
end

%ControlRouters
fwdDataCR = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('ControlRouters/Sim0',num2str(sim),'/MsgRout_FwdData/fwdUnicast_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    fwdDataCR = [fwdDataCR,temp];
end

%ControlRVaz
fwdDataCRV = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('ControlRVaz/Sim0',num2str(sim),'/MsgRout_FwdData/fwdUnicast_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    fwdDataCRV = [fwdDataCRV,temp];
end

%% Confidence Interval
%AllRouters
fwd_mean= mean(fwdData,2);
CI = [];
for i=1:length(num_flow)
    SEM = std(fwdData(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI = [CI;ts*SEM];
end
 
%SpannigTree
fwd_meanST= mean(fwdDataST,2);
CI_ST = [];
for i=1:length(num_flow)
    SEM = std(fwdDataST(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_ST = [CI_ST;ts*SEM];
end

%ControlRouters
fwd_meanCR= mean(fwdDataCR,2);
CI_CR = [];
for i=1:length(num_flow)
    SEM = std(fwdDataCR(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_CR= [CI_CR;ts*SEM];
end

%ControlRVaz
fwd_meanCRV= mean(fwdDataCRV,2);
CI_CRV = [];
for i=1:length(num_flow)
    SEM = std(fwdDataCRV(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_CRV= [CI_CRV;ts*SEM];
end

%% Grafica
figure(2)
hold on
%errorbar(num_flow,fwd_meanCRV,CI_CRV(:,1)+1e4,'-o','Color',[0,0.7,0])
errorbar(num_flow,fwd_meanCR,CI_CR(:,1)+1e4,'-^b')
%errorbar(num_flow,fwd_mean,CI(:,1),'-sr')
errorbar(num_flow,fwd_meanST,CI_ST(:,1),'-*m')
xlim([8 42])
xlabel('Number of Data Flows')
ylabel('Total Data Forwardings [pkts]')
legend('C-A HC_BN','Spanning Tree','Location','NW')
%legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree','Location','NW')
grid on
grid minor


%% Mejora
%Mejora = mean((fwd_meanCRV'-fwd_meanCR')./fwd_meanCRV')*100
%MejoraA = mean((fwd_mean'-fwd_meanCRV')./fwd_mean')*100
%MejoraB = mean((fwd_mean'-fwd_meanCR')./fwd_mean')*100
MejoraC = mean((fwd_mean'-fwd_meanST')./fwd_mean')*100
MejoraD = mean((fwd_meanST'-fwd_meanCR')./fwd_meanST')*100
MejoraE = mean((fwd_meanCR'-fwd_meanST')./fwd_meanCR')*100
