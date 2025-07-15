%% Graph: Forwarding per Received packet  
clear all
%% Parametros de entrada
snap = [1,2]%,2,3,4,5];
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
%% Relacion: suma de fwd de todos los nodos para el total de pkts Rx
%AllRouters
[x,y]= find(RxData==0);
if find(RxData==0)>0
    [x,y]= find(RxData==0);
    for j=1:length(x)
        RxData(x(j),y(j))=RxData(x(j),y(j)-1); % si hay error cambiar +o-
    end
end
Fwd_Rx = fwdData./RxData;

%SppaningTree
[x,y]= find(RxDataST==0);
if find(RxDataST==0)>0
    [x,y]= find(RxDataST==0);
    for j=1:length(x)
        RxDataST(x(j),y(j))=RxDataST(x(j),y(j)-1);
    end
end
Fwd_RxST = fwdDataST./RxDataST;

%ControlRouters
[x,y]= find(RxDataCR==0);
if find(RxDataCR==0)>0
    [x,y]= find(RxDataCR==0);
    for j=1:length(x)
        RxDataCR(x(j),y(j))=RxDataCR(x(j),y(j)-1);
    end
end
Fwd_RxCR = fwdDataCR./RxDataCR;

%ControlRVaz
[x,y]= find(RxDataCRV==0);
if find(RxDataCRV==0)>0
    [x,y]= find(RxDataCRV==0);
    for j=1:length(x)
        RxDataCRV(x(j),y(j))=RxDataCRV(x(j),y(j)-1);
    end
end
Fwd_RxCRV = fwdDataCRV./RxDataCRV;

%% Confidence Interval
%AllRouters
FwdRx_mean= mean(Fwd_Rx,2);
CI = [];
for i=1:length(num_flow)
    SEM = std(Fwd_Rx(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI = [CI;ts*SEM];
end
 
%SpanningTree
FwdRx_meanST= mean(Fwd_RxST,2);
CI_ST = [];
for i=1:length(num_flow)
    SEM = std(Fwd_RxST(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI_ST = [CI_ST;ts*SEM];
end

%ControlRouters
FwdRx_meanCR= mean(Fwd_RxCR,2);
CI_CR = [];
for i=1:length(num_flow)
    SEM = std(Fwd_RxCR(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI_CR = [CI_CR;ts*SEM];
end

%ControlRoutersVaz
FwdRx_meanCRV= mean(Fwd_RxCRV,2);
CI_CRV = [];
for i=1:length(num_flow)
    SEM = std(Fwd_RxCRV(i,:))/sqrt(runs);        %Standar Error
    ts = tinv([0.025 0.975], runs-1);         %0.025=1-(1-95%)/2
    CI_CRV = [CI_CRV;ts*SEM];
end

%% Grafica
figure(4)
hold on 

%errorbar(num_flow,FwdRx_meanCRV,CI_CRV(:,1),'-o','Color',[0,0.7,0])
errorbar(num_flow,FwdRx_meanCR,CI_CR(:,1),'-^b')
%errorbar(num_flow,FwdRx_mean,CI(:,1),'-sr')
errorbar(num_flow,FwdRx_meanST,CI_ST(:,1),'-*m')
xlim([8 42])
xlabel('Number of Data Flows')
ylabel('Total Forwardings per Rx Packet [pkts]')
legend('C-A HC_BN','Spanning Tree','Location','NW')
%legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree','Location','NW')
grid on
grid minor

%% Mejora
%Mejora = mean((FwdRx_meanCRV'-FwdRx_meanCR')./FwdRx_meanCRV')*100
%MejoraA = mean((FwdRx_mean'-FwdRx_meanCRV')./FwdRx_mean')*100
%MejoraB = mean((FwdRx_mean'-FwdRx_meanCR')./FwdRx_mean')*100
MejoraC = mean((FwdRx_mean'-FwdRx_meanST')./FwdRx_mean')*100
MejoraD = mean((FwdRx_meanST'-FwdRx_meanCR')./FwdRx_meanST')*100
MejoraE = mean((FwdRx_meanCR'-FwdRx_meanST')./FwdRx_meanCR')*100
