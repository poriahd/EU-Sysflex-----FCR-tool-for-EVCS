function PD_Plot(FCRDis,OptProfile)
% Plot the results


%% Plot CDF

% CDF FCRN
%        Reduce the rsolution;
MaxP_n = size(FCRDis.nCDF,1);
MaxP = FCRDis.nEdges(1,MaxP_n);
Sp = floor(MaxP_n/100);
Step = [1:4 5:Sp:MaxP_n MaxP_n];
Temp =FCRDis.nCDF(Step,:);
TempSize = size(Temp,1);
[X,Y] = meshgrid(1:96,1:TempSize);

Fig_CDFn = figure('InvertHardcopy','off','Color',[1 1 1]);
Axes_CDFn = axes('Parent',Fig_CDFn);
colorbar('peer',Axes_CDFn,'FontWeight','bold');
title('a)')
xlabel('Time (h)','FontWeight','bold')
ylabel('Power (kW)','FontWeight','bold')
zlabel('FCR-N CDF','FontWeight','bold')
set(Axes_CDFn,'FontSize',12,'FontWeight','bold','XTick',...
    [0 16 32 48 64 80 96],'XTickLabel',{'0','4','8','12','16','20','24'},...
    'YTick',[0 ceil(TempSize/4) ceil(TempSize/2) ceil(TempSize*3/4)...
    ceil(TempSize)],'YTickLabel',{'0',num2str(ceil(MaxP/4)),...
    num2str(ceil(MaxP/2))...
    ,num2str(ceil(MaxP*3/4)),num2str(ceil(MaxP))});
ylim(Axes_CDFn,[0 TempSize]);
view(Axes_CDFn,[4.5 -27]);

surface(X,Y,Temp);

% CDF FCRND
%        Reduce the rsolution;
MaxP_n = size(FCRDis.dnCDF,1);
MaxP = FCRDis.dnEdges(1,MaxP_n);
Sp = floor(MaxP_n/100);
Step = [1:4 5:Sp:MaxP_n MaxP_n];
Temp =FCRDis.dnCDF(Step,:);
TempSize = size(Temp,1);
[X,Y] = meshgrid(1:96,1:TempSize);

Fig_CDFdn = figure('InvertHardcopy','off','Color',[1 1 1]);
Axes_CDFdn = axes('Parent',Fig_CDFdn);
colorbar('peer',Axes_CDFdn,'FontWeight','bold');
title('c)')
xlabel('Time (h)','FontWeight','bold')
ylabel('Power (kW)','FontWeight','bold')
zlabel('FCR-Dn CDF','FontWeight','bold')
set(Axes_CDFdn,'FontSize',12,'FontWeight','bold','XTick',...
    [0 16 32 48 64 80 96],'XTickLabel',{'0','4','8','12','16','20','24'},...
    'YTick',[0 ceil(TempSize/4) ceil(TempSize/2) ceil(TempSize*3/4)...
    ceil(TempSize)],'YTickLabel',{'0',num2str(ceil(MaxP/4)),...
    num2str(ceil(MaxP/2))...
    ,num2str(ceil(MaxP*3/4)),num2str(ceil(MaxP))});
ylim(Axes_CDFdn,[0 TempSize]);
view(Axes_CDFdn,[4.5 -27]);

surface(X,Y,Temp);

% CDF FCRD
%        Reduce the rsolution;
MaxP_n = size(FCRDis.dCDF,1);
MaxP = FCRDis.dEdges(1,MaxP_n);
Sp = floor(MaxP_n/100);
Step = [1:4 5:Sp:MaxP_n MaxP_n];
Temp =FCRDis.dCDF(Step,:);
TempSize = size(Temp,1);
[X,Y] = meshgrid(1:96,1:TempSize);

Fig_CDFd = figure('InvertHardcopy','off','Color',[1 1 1]);
Axes_CDFd = axes('Parent',Fig_CDFd);
colorbar('peer',Axes_CDFd,'FontWeight','bold');
title('b)')
xlabel('Time (h)','FontWeight','bold')
ylabel('Power (kW)','FontWeight','bold')
zlabel('FCR-D CDF','FontWeight','bold')
set(Axes_CDFd,'FontSize',12,'FontWeight','bold','XTick',...
    [0 16 32 48 64 80 96],'XTickLabel',{'0','4','8','12','16','20','24'},...
    'YTick',[0 ceil(TempSize/4) ceil(TempSize/2) ceil(TempSize*3/4)...
    ceil(TempSize)],'YTickLabel',{'0',num2str(ceil(MaxP/4)),...
    num2str(ceil(MaxP/2))...
    ,num2str(ceil(MaxP*3/4)),num2str(ceil(MaxP))});
ylim(Axes_CDFd,[0 TempSize]);
view(Axes_CDFd,[4.5 -27]);

surface(X,Y,Temp);

%% Expected FCR
    
Fig_Exp = figure('InvertHardcopy','off','Color',[1 1 1]);
axis_Exp = axes('Parent',Fig_Exp);
hold(axis_Exp,'on');
grid(axis_Exp,'on');
box on
plot(1:96,FCRDis.nExpect,'LineWidth',2,'Color',[0 0 0],'DisplayName','FCR-N');
plot(1:96,FCRDis.dnExpect,'LineWidth',2,'Color',[1 0 0],...
    'LineStyle','--','DisplayName','FCR-Dn');
plot(1:96,FCRDis.dExpect,'LineWidth',2,'Color',[0 0 1],...
    'LineStyle','-.','DisplayName','FCR-D');
legend(axis_Exp,'show');
xlabel('Time (h)');
ylabel('Expected FCR(kW)','FontWeight','bold');
set(axis_Exp,'FontSize',12,'FontWeight','bold','XTick',[0 16 32 48 64 80 96],...
    'XTickLabel',{'0','4','8','12','16','20','24'});

%% Optimum FCR
    
Fig_Opt = figure('InvertHardcopy','off','Color',[1 1 1]);
axis_Opt = axes('Parent',Fig_Opt);
hold(axis_Opt,'on');
grid(axis_Opt,'on');
box on
plot(1:96,OptProfile.n,'LineWidth',2,'Color',[0 0 0],'DisplayName','FCR-N');
plot(1:96,OptProfile.dn,'LineWidth',2,'Color',[1 0 0],...
    'LineStyle','--','DisplayName','FCR-Dn');
plot(1:96,OptProfile.d,'LineWidth',2,'Color',[0 0 1],...
    'LineStyle','-.','DisplayName','FCR-D');
legend(axis_Opt,'show');
xlabel('Time (h)');
ylabel('Optimum FCR(kW)','FontWeight','bold');
set(axis_Opt,'FontSize',12,'FontWeight','bold','XTick',[0 16 32 48 64 80 96],...
    'XTickLabel',{'0','4','8','12','16','20','24'});

