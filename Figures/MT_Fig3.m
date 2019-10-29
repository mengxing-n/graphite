function [ output_args ] = MTFig3( input_args )
close all
%% Load Panel A
A=load('MT_Fig3A.mat');
EbA=A.EbA;
EDCtotA=A.EDCtotA;
EDCdiffA=A.EDCdiffA;
bkgdA=A.bkgdA;
pkfitA=A.pkfitA;
pkposA=A.pkposA;
%% Load Panel B
B=load('MT_Fig3B.mat');
tB=B.tB;
tfitB=B.tfitB;
IB=B.IB;
IfitB=B.IfitB;
tmaxB=B.tmaxB;
%% Load Panel C
C=load('MT_Fig3C.mat');
EbC=C.EbC;
EbfC=C.EbfC;
edcC=C.edcC;
edcfC=C.edcfC;
pk1C=C.pk1C;
pk2C=C.pk2C;
pk3C=C.pk3C;
pk4C=C.pk4C;
%% Figure window setup ---------------------------------------------------------------------------------%
figure(2)
CM2=lines(5);
fs=16;
set(gcf,'color','white')
set(gcf,'WindowStyle','normal','units','inches','Position',[0.1,0.1,10,10])
dW=0.075;
Left3 = dW;
Bottom3 = 0.575;
Width3 = 0.375;
Height3 = 0.375;
ax3=axes('position',[Left3 Bottom3 Width3 Height3]);

Left4 = Left3+Width3+1.25*dW;
Bottom4 = 0.1;
Width4 = Width3;
Height4 = 0.85;
ax4=axes('position',[Left4 Bottom4 Width4 Height4]);

Left5 = Left3;
Bottom5 = Bottom4;
Width5 = Width3;
Height5 = Height3; 
ax5=axes('position',[Left5 Bottom5 Width5 Height5]);
%% Panel A
axes(ax3)
offset=2e4;
hold on
box on
plot(EbA, EDCtotA+offset,'ko','markersize',5);
plot(EbA, 1.5*EDCdiffA,'ko','markerfacecolor','k','markersize',5);
plot(EbA, bkgdA+offset,'k--','linewidth',1.5);
for j=1:5
    plot(EbA,1.5*pkfitA(j,:),'-','linewidth',2,'color',CM2(j,:))
    k1=vline(pkposA(j));
    set(k1,'linestyle',':','color',CM2(j,:),'linewidth',2)
end
axis tight
ylim([min(EDCdiffA),4e5])
set(gca,'fontsize',fs)
%% Panel B
axes(ax5)
box on
ylim([0,max(IfitB(1,:))])
for i=1:3
    hold on
    plot(tfitB,IfitB(i,:),'.-','linewidth',2,'color',CM2(i,:),'markersize',2)
    k1=vline(tmaxB(i));
    set(k1,'linestyle','-','color',CM2(i,:),'linewidth',2)
end

for i =1:3
    hold on
    plot(tB,IB(i,:),'o','color',CM2(i,:),'markerfacecolor',CM2(i,:),'markersize',8,'linewidth',2);
end
xlabel('Delay (fs)','fontsize',fs+2,'interpreter','latex')
ylabel('Intensity (norm.)','fontsize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
axis tight
%% Panel C
axes(ax4)
hold on
box on
CM=copper(6);
Offset2=[0 2e4, 5e4 8e4];
Offset3=[1e4 3.5e4, 6.5e4 9.5e4];
for i=1:4
    plot(EbC,edcC(i,:)*0.65+Offset2(i),'color',CM(i,:),'marker','.','markersize',7)
    plot(EbfC, edcfC(i,:)*0.65+Offset2(i),'color',CM(i,:),'linestyle','-','linewidth',2)
%     text(0.12,Offset3(i),['t = ',num2str(round(mean(t(M(i)-1:M(i)+1))-tzero_m)),' fs'],'fontsize',fs-2,'color',CM(i,:))
end
for j=1:5
    plot(EbC,pk1C(j,:)*0.65+Offset2(1),'-','linewidth',2,'color',CM2(j,:))
    plot(EbC,pk2C(j,:)*0.65+Offset2(2),'-','linewidth',2,'color',CM2(j,:))
    plot(EbC,pk3C(j,:)*0.65+Offset2(3),'-','linewidth',2,'color',CM2(j,:))
    plot(EbC,pk4C(j,:)*0.65+Offset2(4),'-','linewidth',2,'color',CM2(j,:))
end
xlim([0.375,0.71])
ylim([0,1.05e5])
for i=1:5
    k1=vline(pkposA(i));
    set(k1,'linestyle',':','color',CM2(i,:),'linewidth',2)
end
set(gca,'fontsize',20)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
end

