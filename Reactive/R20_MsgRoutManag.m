%% Graph: Routing Management Messages
clear all
%% Parametros de entrada
snap = [1,2,4];%,2,3,4,5];
num_flow = [10,15,20,25,30,35,40];
sim = 7;
runs = 50;


%% Extraer datos
%AllRouters
txMgt = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('AllRouters/Sim0',num2str(sim),'/MsgRout_FwdData/hwmp_txMgt_Rout_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];     
    end
    txMgt = [txMgt,temp];
end

%SpanningTree
txMgtST = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('SpanningTree/Sim0',num2str(sim),'/MsgRout_FwdData/hwmp_txMgt_Rout_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];     
    end
    txMgtST = [txMgtST,temp];
end

%ControlRouters
txMgtCR = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('ControlRouters/Sim0',num2str(sim),'/MsgRout_FwdData/hwmp_txMgt_Rout_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];     
    end
    txMgtCR = [txMgtCR,temp];
end

%ControlRVaz
txMgtCRV = [];
for snp=1:length(snap)
    temp = [];
    for flow=1:length(num_flow)
        filename = strcat('ControlRVaz/Sim0',num2str(sim),'/MsgRout_FwdData/hwmp_txMgt_Rout_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output = csvread(filename);
        temp = [temp;output'];     
    end
    txMgtCRV = [txMgtCRV,temp];
end

%% Confidence Interval
%AllRouters
tx_mean= mean(txMgt,2);
CI = [];
for i=1:length(num_flow)
    SEM = std(txMgt(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI = [CI;ts*SEM];
end

%SpanningTree
tx_meanST= mean(txMgtST,2);
CI_ST = [];
for i=1:length(num_flow)
    SEM = std(txMgtST(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI_ST = [CI_ST;ts*SEM];
end

%ControlRouters
tx_meanCR= mean(txMgtCR,2);
CI_CR = [];
for i=1:length(num_flow)
    SEM = std(txMgtCR(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI_CR = [CI_CR;ts*SEM];
end

%ControlRVaz
tx_meanCRV= mean(txMgtCRV,2);
CI_CRV = [];
for i=1:length(num_flow)
    SEM = std(txMgtCRV(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI_CRV = [CI_CRV;ts*SEM];
end

%% Grafica
figure(1)
hold on
%errorbar(num_flow,tx_meanCRV,CI_CRV(:,1),'-o','Color',[0,0.7,0])
errorbar(num_flow,tx_meanCR,CI_CR(:,1),'-^b')
%errorbar(num_flow,tx_mean,CI(:,1),'-sr')
errorbar(num_flow,tx_meanST,CI_ST(:,1),'-*m')
xlim([8 42])
xlabel('Number of Data Flows')
ylabel('Rate of Routing Management Messages [bps]')
legend('C-A HC_BN','Spanning Tree','Location','NW')
%legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree','Location','NW')
grid on
grid minor

%% Mejora
%Mejora = mean((tx_meanCRV'-tx_meanCR')./tx_meanCRV')*100
%MejoraA = mean((tx_mean'-tx_meanCRV')./tx_mean')*100
MejoraB = mean((tx_mean'-tx_meanCR')./tx_mean')*100
MejoraC = mean((tx_mean'-tx_meanST')./tx_mean')*100
MejoraD = mean((tx_meanST'-tx_meanCR')./tx_meanST')*100
MejoraE = mean((tx_meanCR'-tx_meanST')./tx_meanCR')*100