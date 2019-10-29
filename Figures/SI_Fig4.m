function [ output_args ] = SI_Fig4( input_args )
close all
%% Load Panel B
B=load('SI_Fig4BCD.mat');
tB=B.tB;
tfitB=B.tfitB;
IB=B.IB;
IfitB=B.IfitB;
tmaxB=B.tmaxB;
%% Load Panel A
A=load('SI_Fig4A.mat');
Ebdat=A.Ebdat;
EbA=Ebdat(1,1:131);
EbfA=Ebdat(2,:);
edcA=A.edcA;
edcfA=A.edcfA;
pk1A=A.pk1A;
pk2A=A.pk2A;
pk3A=A.pk3A;
pk4A=A.pk4A;
%% Load Panel C
EbC=B.EbC;
ojdosC=B.ojdosC;
%% Load Panel D
EbD=B.EbD;
ojdosD=B.ojdosD;
%% Figure set up
figure(1)
CM2=lines(5);
fs=22;
set(gcf,'color','white')
set(gcf,'WindowStyle','normal','units','inches','Position',[0.1,0.1,12,8])
dW=0.1;
Left1 = dW/2;
Bottom1 = 0.1;
Width1 = 0.24;
Height1 = 0.85;   
ax1=axes('position',[Left1 Bottom1 Width1 Height1]);

Left2 = Left1+Width1+dW;
Bottom2 = Bottom1;
Width2 = Width1;
Height2 = Height1; 
ax2=axes('position',[Left2 Bottom2 Width2 Height2]);

Left5=Left2+Width2+dW;
Bottom5=Bottom1;
Width5=Width1;
Height5=0.4;
ax5=axes('position',[Left5 Bottom5 Width5 Height5]);

Left6=Left5;
Bottom6=Bottom5+Height5+dW/2;
Width6=Width5;
Height6=Height5;
ax6=axes('position',[Left6 Bottom6 Width6 Height6]);
%% Panel A
%% Panel C
axes(ax1)
hold on
box on
CM=copper(6);
Offset2=[0 2e4, 5e4 8e4];
for i=1:4
    plot(EbA,edcA(i,:)*0.65+Offset2(i),'color',CM(i,:),'marker','.','markersize',7)
    plot(EbfA, edcfA(i,:)*0.65+Offset2(i),'color',CM(i,:),'linestyle','-','linewidth',2)
end
for j=1:5
    plot(EbA,pk1A(j,:)*0.65+Offset2(1),'-','linewidth',2,'color',CM2(j,:))
    plot(EbA,pk2A(j,:)*0.65+Offset2(2),'-','linewidth',2,'color',CM2(j,:))
    plot(EbA,pk3A(j,:)*0.65+Offset2(3),'-','linewidth',2,'color',CM2(j,:))
    plot(EbA,pk4A(j,:)*0.65+Offset2(4),'-','linewidth',2,'color',CM2(j,:))
end
xlim([0.15,0.71])
ylim([0,1.05e5])
set(gca,'fontsize',20)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
%% Panel B
axes(ax2)
offset=[0 1 0 1 1.5];
lim=[0, 1; 1, 1.5; 0, 1; 1, 1.5 ; 1.5, 2];
box on
for i=1:5
    hold on
    plot(tfitB,IfitB(i,:)+offset(i),'.-','linewidth',2,'color',CM2(i,:),'markersize',2)
    ylim([lim(i,:)])
    k1=vline(tmaxB(i));
    set(k1,'linestyle','-','color',CM2(i,:),'linewidth',2)
end

for i =1:5
    hold on
    plot(tB,IB(i,:)+offset(i),'o','color',CM2(i,:),'markerfacecolor',CM2(i,:),'markersize',8,'linewidth',2);
end
xlabel('Delay (fs)','fontsize',fs+2,'interpreter','latex')
ylabel('Intensity (norm.)','fontsize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
axis tight
%% Panel C
axes(ax6)
hold on
box on
ylim([0,0.8])
plot(EbC,ojdosC,'k-','linewidth',2)
xlim([0.1,0.7])
ylabel('OJDOS')
xlabel('$$E-E_F (\mathrm{eV})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
%% Panel D
axes(ax5)
hold on
box on
ylim([0,0.8])
plot(EbD,ojdosD,'k-','linewidth',2)
xlim([0.1,0.7])
ylabel('OJDOS')
xlabel('$$E-E_F (\mathrm{eV})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
end

