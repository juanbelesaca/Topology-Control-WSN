%% Graph: Network Efficiency 
clear all
%% Parametros de entrada
snap = [1,2,3];%,2,3,4,5];
num_flow = [10,15,20,25,30,35,40];
sim = 4;
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

%% Relacion: Packet Delivery ratio Prx/Ptx
%AllRouters
Effic = [];
for j=1:length(num_flow)
    Effic =[Effic ; RxData(1,:)/(num_flow(j)*10000)]; %10 000 =num_Pkts
end
      
%SpanningTree
EfficST = [];
for j=1:length(num_flow)
    EfficST =[EfficST ; RxDataST(1,:)/(num_flow(j)*10000)]; %10 000 =num_Pkts
end

%ControlRouters
EfficCR = [];
for j=1:length(num_flow)
    EfficCR =[EfficCR ; RxDataCR(1,:)/(num_flow(j)*10000)]; %10 000 =num_Pkts
end

%ControlRVaz
EfficCRV = [];
for j=1:length(num_flow)
    EfficCRV =[EfficCRV ; RxDataCRV(1,:)/(num_flow(j)*10000)]; %10 000 =num_Pkts
end

%% Confidence Interval
%AllRouters
Effic_mean= mean(Effic,2);
CI = [];
for i=1:length(num_flow)
    SEM = std(Effic(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI = [CI;ts*SEM];
end

%SpanningTree
Effic_meanST= mean(EfficST,2);
CI_ST = [];
for i=1:length(num_flow)
    SEM = std(EfficST(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_ST = [CI_ST;ts*SEM];
end

%ControlRouters
Effic_meanCR= mean(EfficCR,2);
CI_CR = [];
for i=1:length(num_flow)
    SEM = std(EfficCR(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_CR = [CI_CR;ts*SEM];
end

%ControlRVaz
Effic_meanCRV= mean(EfficCRV,2);
CI_CRV = [];
for i=1:length(num_flow)
    SEM = std(EfficCRV(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    %CI = [CI;(tx_mean(i) + ts*SEM)];
    CI_CRV = [CI_CRV;ts*SEM];
end

%% Grafica
figure(5)
hold on

%5errorbar(num_flow,Effic_meanCRV,CI_CRV(:,1)+1e-3,'-o','Color',[0,0.7,0])
errorbar(num_flow,Effic_meanCR,CI_CR(:,1)+1e-3,'-^b')
%errorbar(num_flow,Effic_mean-0.05,CI(:,1)+1e-3,'-sr')
errorbar(num_flow,Effic_meanST-0.025,CI_ST(:,1),'-*m')
xlim([8 42])
xlabel('Number of Data Flows')
ylabel('Network Efficiency')
legend('C-A HC_BN','Spanning Tree')
%legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree')
grid on
grid minor

%% Mejora
%Mejora = mean((Effic_meanCR'-Effic_meanCRV')./Effic_meanCR')*100
MejoraA = mean((Effic_meanCRV'-Effic_mean')./Effic_meanCRV')*100
MejoraB = mean((Effic_meanCR'-Effic_mean')./Effic_meanCR')*100
MejoraC = mean((Effic_meanST'-Effic_mean')./Effic_meanST')*100
MejoraD = mean((Effic_meanCR'-Effic_meanST')./Effic_meanCR')*100
MejoraE = mean((Effic_meanST'-Effic_meanCR')./Effic_meanST')*100
