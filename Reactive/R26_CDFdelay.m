%% Graph: Cumulative Distribution Function Delay end-to-end
clear all
%% Parametros de entrada
num_flow = [10,15,20,25,30,35,40]; 
sim = 2;
runs = 50;
ajuste = 2000;

%% Extraer datos
%AllRouters
HistDelayCompl = [];
Titulos = [];
for i=1:length(num_flow)
    filename = strcat('AllRouters/Sim0',num2str(sim),'/Delay/HistDelay_Flow',num2str(num_flow(i)),'.dat');
    HistDelay = csvread(filename);
    fit = HistDelay(1:ajuste);
    HistDelayCompl = [HistDelayCompl,fit]; % se ordena en horizontal los flujos(7)
    Titulos = [Titulos;strcat('All Routers-',num2str(num_flow(i)),' Flows')];
end

%SpanningTree
HistDelayComplST = [];
TitulosST = [];
for i=1:length(num_flow)
    filename = strcat('SpanningTree/Sim0',num2str(sim),'/Delay/HistDelay_Flow',num2str(num_flow(i)),'.dat');
    HistDelay = csvread(filename);
    fit = HistDelay(1:ajuste);
    HistDelayComplST = [HistDelayComplST,fit]; % se ordena en horizontal los flujos(7)
    TitulosST = [TitulosST;strcat('Spanning Tree-',num2str(num_flow(i)),' Flows')];
end

%ControlRouters
HistDelayComplCR = [];
TitulosCR = [];
for i=1:length(num_flow)
    filename = strcat('ControlRouters/Sim0',num2str(sim),'/Delay/HistDelay_Flow',num2str(num_flow(i)),'.dat');
    HistDelay = csvread(filename);
    fit = HistDelay(1:ajuste);
    HistDelayComplCR = [HistDelayComplCR,fit]; % se ordena en horizontal los flujos(7)
    TitulosCR = [TitulosCR;strcat('C-A HC_BN-',num2str(num_flow(i)),' Flows')];
end

%ControlRVaz
HistDelayComplCRV = [];
TitulosCRV = [];
for i=1:length(num_flow)
    filename = strcat('ControlRVaz/Sim0',num2str(sim),'/Delay/HistDelay_Flow',num2str(num_flow(i)),'.dat');
    HistDelay = csvread(filename);
    fit = HistDelay(1:ajuste);
    HistDelayComplCRV = [HistDelayComplCRV,fit]; % se ordena en horizontal los flujos(7)
    TitulosCRV = [TitulosCRV;strcat('2HC_BN-',num2str(num_flow(i)),' Flows')];
end

%% Grafica
figure(8)
limiteX = [0 3e4];

subplot(2,3,1)
hold on
CDF1CRV=cdfplot(HistDelayComplCRV(:,1));
CDF2CRV=cdfplot(HistDelayComplCRV(:,2));
CDF1CR=cdfplot(HistDelayComplCR(:,1));
CDF2CR=cdfplot(HistDelayComplCR(:,2));
CDF1=cdfplot(HistDelayCompl(:,1));
CDF2=cdfplot(HistDelayCompl(:,2));
%CDF1ST=cdfplot(HistDelayComplST(:,1));
%CDF2ST=cdfplot(HistDelayComplST(:,2));
xlim(limiteX);
title('')
xlabel({'Delay [ms]','(a)'})
ylabel('Commulative probability')
set(CDF1CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF2CRV,'Color','magenta','LineWidth',1);
set(CDF1CR,'Color','blue','LineWidth',1);
set(CDF2CR,'Color','black','LineWidth',1);
set(CDF1,'Color','red','LineWidth',1);
set(CDF2,'Color','cyan','LineWidth',1);
%set(CDF1ST,'Color',[0,0.7,0]);
%set(CDF2ST,'Color','green');
grid on
grid minor
legend(TitulosCRV(1,:),TitulosCRV(2,:),TitulosCR(1,:),TitulosCR(2,:),Titulos(1,:),Titulos(2,:),'Location','SE')

subplot(2,3,2)
hold on
CDF3CRV=cdfplot(HistDelayComplCRV(:,3));
CDF3CR=cdfplot(HistDelayComplCR(:,3));
CDF3=cdfplot(HistDelayCompl(:,3));
%CDF3ST=cdfplot(HistDelayComplST(:,3));
xlim(limiteX);
title('')
xlabel({'Delay [ms]','(b)'})
ylabel('Commulative probability')
legend(TitulosCRV(3,:),TitulosCR(3,:),Titulos(3,:),'Location','SE')
grid on
grid minor
set(CDF3CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF3CR,'Color','blue','LineWidth',1);
set(CDF3,'Color','red','LineWidth',1);
%set(CDF3ST,'Color',[0,0.7,0]);

subplot(2,3,3)
hold on
CDF4CRV=cdfplot(HistDelayComplCRV(:,4));
CDF4CR=cdfplot(HistDelayComplCR(:,4));
CDF4=cdfplot(HistDelayCompl(:,4));
%CDF4ST=cdfplot(HistDelayComplST(:,4));
xlim(limiteX);
title('')
xlabel({'Delay [ms]','(c)'})
ylabel('Commulative probability')
legend(TitulosCRV(4,:),TitulosCR(4,:),Titulos(4,:),'Location','SE')
grid on
grid minor
set(CDF4CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF4CR,'Color','blue','LineWidth',1);
set(CDF4,'Color','red','LineWidth',1);
%set(CDF4ST,'Color',[0,0.7,0]);

subplot(2,3,4)
hold on
CDF5CRV=cdfplot(HistDelayComplCRV(:,5));
CDF5CR=cdfplot(HistDelayComplCR(:,5));
CDF5=cdfplot(HistDelayCompl(:,5));
%CDF5ST=cdfplot(HistDelayComplST(:,5));
xlim(limiteX);
title('')
xlabel({'Delay [ms]','(d)'})
ylabel('Commulative probability')
legend(TitulosCRV(5,:),TitulosCR(5,:),Titulos(5,:),'Location','SE')
grid on
grid minor
set(CDF5CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF5CR,'Color','blue','LineWidth',1);
set(CDF5,'Color','red','LineWidth',1);
%set(CDF5ST,'Color',[0,0.7,0]);

subplot(2,3,5)
hold on
CDF6CRV=cdfplot(HistDelayComplCRV(:,6));
CDF6CR=cdfplot(HistDelayComplCR(:,6));
CDF6=cdfplot(HistDelayCompl(:,6));
%CDF6ST=cdfplot(HistDelayComplST(:,6));
xlim(limiteX);
title('')
xlabel({'Delay [ms]','(e)'})
ylabel('Commulative probability')
legend(TitulosCRV(6,:),TitulosCR(6,:),Titulos(6,:),'Location','SE')
grid on
grid minor
set(CDF6CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF6CR,'Color','blue','LineWidth',1);
set(CDF6,'Color','red','LineWidth',1);
%set(CDF6ST,'Color',[0,0.7,0]);

subplot(2,3,6)
hold on
CDF7CRV=cdfplot(HistDelayComplCRV(:,7));
CDF7CR=cdfplot(HistDelayComplCR(:,7));
CDF7=cdfplot(HistDelayCompl(:,7));
%CDF7ST=cdfplot(HistDelayComplST(:,7));
xlim(limiteX);
title('')
xlabel({'Delay [ms]','(f)'})
ylabel('Commulative probability')
legend(TitulosCRV(7,:),TitulosCR(7,:),Titulos(7,:),'Location','SE')
grid on
grid minor
set(CDF7CRV,'Color',[0,0.7,0],'LineWidth',1);
set(CDF7CR,'Color','blue','LineWidth',1);
set(CDF7,'Color','red','LineWidth',1);
%set(CDF7ST,'Color',[0,0.7,0]);

% figure(9)
% hold on
% 
% [f,x] = ecdf(HistDelayComplCRV(:,3));
% [mu,sig] = normfit(x/1e5)
% xgrid = linspace(0,1.1*max(x/1e5),100)';
% 
% [f2,x2] = ecdf(HistDelayComplCR(:,3));
% [mu2,sig2] = normfit(x2/1e5)
% xgrid2 = linspace(0,1.1*max(x2/1e5),100)';
% 
% [f3,x3] = ecdf(HistDelayCompl(:,3));
% [mu3,sig3] = normfit(x3/1e5)
% xgrid3 = linspace(0,1.1*max(x3/1e5),100)';
% 
% plot(xgrid,normcdf(xgrid,mu,sig),'b',xgrid2,normcdf(xgrid2,mu2,sig2),'r',xgrid3,normcdf(xgrid3,mu3,sig3),'g','LineWidth',1);
% 
% xlim([0 6]);
% ylim([0 1]);

