%% Graph: Received packet data 
clear all 
%% Parametros de entrada
snap = [3,4];%,2,3,4,5];
num_flow = [10,15,20,25,30,35,40];
sim =7;
runs = 50;

%% Extraer datos
%AllRouters
RxData = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('AllRouters/Sim0',num2str(sim),'/TotalPkts_TxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    RxData = [RxData,temp];
end

%SpanningTree
RxDataST = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('SpanningTree/Sim0',num2str(sim),'/TotalPkts_TxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    RxDataST = [RxDataST,temp];
end

%ControlRouters
RxDataCR = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('ControlRouters/Sim0',num2str(sim),'/TotalPkts_TxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    RxDataCR = [RxDataCR,temp];
end

%ControlRVaz
RxDataCRV = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('ControlRVaz/Sim0',num2str(sim),'/TotalPkts_TxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];
    end
    RxDataCRV = [RxDataCRV,temp];
end

%% Confidence Interval
%AllRouters
Rx_mean= mean(RxData,2);
CI = [];
for i=1:length(num_flow)
    SEM = std(RxData(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI = [CI;ts*SEM];
end
 
%SpanningTree
Rx_meanST= mean(RxDataST,2);
CI_ST = [];
for i=1:length(num_flow)
    SEM = std(RxDataST(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_ST = [CI_ST;ts*SEM];
end

%ControlRouters
Rx_meanCR= mean(RxDataCR,2);
CI_CR = [];
for i=1:length(num_flow)
    SEM = std(RxDataCR(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_CR = [CI_CR;ts*SEM];
end

%ControlRouters
Rx_meanCRV= mean(RxDataCRV,2);
CI_CRV = [];
for i=1:length(num_flow)
    SEM = std(RxDataCRV(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_CRV = [CI_CRV;ts*SEM];
end

%% Grafica
figure(5)
hold on 
%errorbar(num_flow,Rx_meanCRV,CI_CRV(:,1)+2e3,'-o','Color',[0,0.7,0])
errorbar(num_flow,Rx_meanCR,CI_CR(:,1)+2e3,'-^b')
%errorbar(num_flow,Rx_mean,CI(:,1)+2e3,'-sr')
errorbar(num_flow,Rx_meanST,CI_ST(:,1),'-*m')
xlim([8 42])
xlabel('Number of Data Flows')
ylabel('Successfully Rx Packets [pkts]')
legend('C-A HC_BN','Spanning Tree','Location','NW')
%legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree','Location','NW')
grid on
grid minor

%% Mejora
%Mejora = mean((Rx_meanCR'-Rx_meanCRV')./Rx_meanCR')*100
%MejoraA = mean((Rx_meanCRV'-Rx_mean')./Rx_meanCRV')*100
%MejoraB = mean((Rx_meanCR'-Rx_mean')./Rx_meanCR')*100
MejoraC = mean((Rx_meanST'-Rx_mean')./Rx_meanST')*100
MejoraD = mean((Rx_meanCR'-Rx_meanST')./Rx_meanCR')*100
MejoraE = mean((Rx_meanST'-Rx_meanCR')./Rx_meanST')*100
