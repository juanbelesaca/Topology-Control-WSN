%% Graph: Energy Consumption per node and CDF
clear all
%% Parametros de entrada
snap = [1,2,4];
num_flow = 20 ;%,15,20,25,30,35,40; only one  
sim = 7;
runs = 50;

%% Extraer datos
%AllRouters
DistAllR = []; %horizontal Dist de cada snap
for snp=1:length(snap)
    filename = strcat('DistanciasVecinos/AllR/Sim_0',num2str(sim),'_Snap_',num2str(snap(snp)),'.dat');
    out = csvread(filename);
    DistAllR = [DistAllR, out];
end
Txbytes = []; %horizontal cada 50 es el siguiente snap
Rxbytes = [];
for snp=1:length(snap)
    for flow=1:length(num_flow)
        filename1 = strcat('AllRouters/Sim0',num2str(sim),'/Energ_BytesTxRx/Tx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output1 = csvread(filename1);
        Txbytes = [Txbytes, output1];
        filename2 = strcat('AllRouters/Sim0',num2str(sim),'/Energ_BytesTxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output2 = csvread(filename2);
        Rxbytes = [Rxbytes, output2];
    end
end

%SpannTree
DistST = []; %horizontal Dist de cada snap
for snp=1:length(snap)
    filename = strcat('DistanciasVecinos/SpannTree/Sim_0',num2str(sim),'_Snap_',num2str(snap(snp)),'.dat');
    out = csvread(filename);
    DistST = [DistST, out];
end
TxbytesST = []; %horizontal cada 50 es el siguiente snap
RxbytesST = [];
for snp=1:length(snap)
    for flow=1:length(num_flow)
        filename1 = strcat('SpanningTree/Sim0',num2str(sim),'/Energ_BytesTxRx/Tx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output1 = csvread(filename1);
        TxbytesST = [TxbytesST, output1];
        filename2 = strcat('SpanningTree/Sim0',num2str(sim),'/Energ_BytesTxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output2 = csvread(filename2);
        RxbytesST = [RxbytesST, output2];
    end
end

%ControlRVaz
DistCRV = []; %horizontal Dist de cada snap
for snp=1:length(snap)
    filename = strcat('DistanciasVecinos/Vazquez/Sim_0',num2str(sim),'_Snap_',num2str(snap(snp)),'.dat');
    out = csvread(filename);
    DistCRV = [DistCRV, out];
end
TxbytesCRV = []; %horizontal cada 50 es el siguiente snap
RxbytesCRV = [];
for snp=1:length(snap)
    for flow=1:length(num_flow)
        filename1 = strcat('ControlRVaz/Sim0',num2str(sim),'/Energ_BytesTxRx/Tx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output1 = csvread(filename1);
        TxbytesCRV = [TxbytesCRV, output1];
        filename2 = strcat('ControlRVaz/Sim0',num2str(sim),'/Energ_BytesTxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output2 = csvread(filename2);
        RxbytesCRV = [RxbytesCRV, output2];
    end
end


%ControlRouters
DistCR = []; %horizontal Dist de cada snap
for snp=1:length(snap)
    filename = strcat('DistanciasVecinos/ControlR/Sim_0',num2str(sim),'_Snap_',num2str(snap(snp)),'.dat');
    out = csvread(filename);
    DistCR = [DistCR, out];
end
TxbytesCR = []; %horizontal cada 50 es el siguiente snap
RxbytesCR = [];
for snp=1:length(snap)
    for flow=1:length(num_flow)
        filename1 = strcat('ControlRouters/Sim0',num2str(sim),'/Energ_BytesTxRx/Tx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output1 = csvread(filename1);
        TxbytesCR = [TxbytesCR, output1];
        filename2 = strcat('ControlRouters/Sim0',num2str(sim),'/Energ_BytesTxRx/Rx_Snap',num2str(snap(snp)),'Flow',num2str(num_flow(flow)),'.dat');
        output2 = csvread(filename2);
        RxbytesCR = [RxbytesCR, output2];
    end
end

%% Calculo de consumo
% AllRouters
longsnap=1:1:length(snap);
for node=1:100 
    i = 1; %indicador de flujo
    for snp_run=1:length(snap)*runs
       E_Tx(snp_run) = 50e-9*Txbytes(node,snp_run)*8+100e-12*Txbytes(node,snp_run)*8*(DistAllR(node,longsnap(i))^2);
       E_Rx(snp_run) = 50e-9*Rxbytes(node,snp_run)*8;
       if snp_run==runs*snap(i)
           i = i+1;
       end
    end
    Energy(node) = mean(E_Tx)+mean(E_Rx);
end

% SpannTree
for node=1:100 
    i = 1; %indicador de flujo
    for snp_run=1:length(snap)*runs
       E_Tx(snp_run) = 50e-9*TxbytesST(node,snp_run)*8+100e-12*TxbytesST(node,snp_run)*8*(DistST(node,longsnap(i))^2);
       E_Rx(snp_run) = 50e-9*RxbytesST(node,snp_run)*8;
       if snp_run==runs*snap(i)
           i = i+1;
       end
    end
    EnergyST(node) = mean(E_Tx)+mean(E_Rx);
end

% ControlRVaz
for node=1:100 
    i = 1; %indicador de flujo
    for snp_run=1:length(snap)*runs
       E_Tx(snp_run) = 50e-9*TxbytesCRV(node,snp_run)*8+100e-12*TxbytesCRV(node,snp_run)*8*(DistCRV(node,longsnap(i))^2);
       E_Rx(snp_run) = 50e-9*RxbytesCRV(node,snp_run)*8;
       if snp_run==runs*snap(i)
           i = i+1;
       end
    end
    EnergyCRV(node) = mean(E_Tx)+mean(E_Rx);
end

% ControlRouters
for node=1:100 
    i = 1; %indicador de flujo
    for snp_run=1:length(snap)*runs
       E_Tx(snp_run) = 50e-9*TxbytesCR(node,snp_run)*8+100e-12*TxbytesCR(node,snp_run)*8*(DistCR(node,longsnap(i))^2);
       E_Rx(snp_run) = 50e-9*RxbytesCR(node,snp_run)*8;
       if snp_run==runs*snap(i)
           i = i+1;
       end
    end
    EnergyCR(node) = mean(E_Tx)+mean(E_Rx);
end

%% Grafica
%Grafico de barras
figure(1)
hist([EnergyCR',EnergyST'],20);
%hist([EnergyCRV',EnergyCR'],20);
h = findobj(gca,'Type','patch');
%set(h(2),'FaceColor',[0,0.7,0])
%set(h(1),'FaceColor','blue')
set(h(2),'FaceColor','blue')
set(h(1),'FaceColor','magent')
xlabel('Energy Consumption [J]')
ylabel('Number of Nodes')
legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree')
grid on
grid minor

%Grafico CDF
figure(7)
hold on 
%CDF_CRV = cdfplot(EnergyCRV);
CDF_CR = cdfplot(EnergyCR);
%CDF =cdfplot(Energy);
CDF_ST = cdfplot(EnergyST);
title('')
xlabel('Energy Consumption [J]')
ylabel('Commulative probability')
legend('C-A HC_BN','Spanning Tree','Location','SE')
%legend('2HC_BN','C-A HC_BN','All Routers','Spanning Tree','Location','SE')
%set(CDF_CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF_CR,'Color','blue','LineWidth',1);
%set(CDF,'Color','red','LineWidth',1);
set(CDF_ST,'Color','magent','LineWidth',1);
grid on
grid minor

%% Mejora
%sum(EnergyCRV)
%sum(EnergyCR)
%sum(Energy)
%Mejora = (sum(EnergyCRV)-sum(EnergyCR))/sum(EnergyCRV)*100
MejoraB = (sum(Energy)-sum(EnergyST))/sum(Energy)*100
MejoraC = (sum(EnergyST)-sum(EnergyCR))/sum(EnergyST)*100
MejoraD = (sum(EnergyCR)-sum(EnergyST))/sum(EnergyCR)*100