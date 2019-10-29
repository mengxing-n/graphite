function [ output_args ] = SI_Fig3( input_args )
close all
A=load('SI_Fig3AB.mat');
%% Load Panel A
DatA1=A.DatA1;
EbA=DatA1(1,:);
EDCA=DatA1(2,:);
DatA2=A.DatA2;
EbfitA=DatA2(1,:);
bkgdfitA=DatA2(2,:);
pkposA=A.pkposA;
%% Load Panel B
DatB1=A.DatB1;
EbB=DatB1(1,:);
EDCB=DatB1(2,:);
DatB2=A.DatB2;
EbfitB=DatB2(1,:);
bkgdfitB=DatB2(2,:);
pkposB=A.pkposB;
%% Load Panel C
C=load('SI_Fig3CD.mat');
EbC=EbA;
EDCdiffC=C.EDCdiffC;
EbfitC=EbfitA;
EDCdiff_fitC=C.EDCdiff_fitC;
pkposC=pkposA;
pkfitC=C.pkfitC;
resC=C.resC;
%% Load Panel D
EbD=EbA;
EDCdiffD=C.EDCdiffD;
EbfitD=EbfitA;
EDCdiff_fitD=C.EDCdiff_fitD;
pkposD=pkposB;
pkfitD=C.pkfitD;
resD=C.resD;
%% Load Panel E
E=load('SI_Fig3EF.mat');
EbE=EbA;
EDC_totE=E.EDC_totE;
EbfitE=EbfitA;
EDCfit_totE=E.EDCfit_totE;
%% Load Panel F
EbF=EbA;
EDCdiffF=E.EDCdiffF;
pkposF=pkposA;
pkfitF=E.pkfitF;
%% Figure set up
figure(1)
set(gcf,'color','white')
fs=16;
CM2=lines(5);
%% Panel A
subplot(2,3,1)
hold on
box on
plot(EbA,EDCA,'ko','markersize',3,'markerfacecolor','k')
plot(EbfitA, bkgdfitA,'k-','linewidth',1)
xlim([0.15,0.71])
ylim([5e3,6.5e4])
set(gca,'fontsize',fs)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
for j=1:5
    k1=vline(pkposA(j));
    set(k1,'linestyle',':','color',CM2(j,:),'linewidth',2)
end
%% Panel C
subplot(2,3,2)
hold on
box on
plot(EbC,EDCdiffC,'ko','markersize',3,'markerfacecolor','k','linestyle',':')
plot(EbfitC,EDCdiff_fitC,'k-','linewidth',1)
plot(EbC,resC,'ko','markersize',3)
axis tight
ylim([-4e3,1.4e4])
xlim([0.15,0.71])
for i=1:5
    plot(EbC,pkfitC(i,:),'-','linewidth',2,'color',CM2(i,:))
    k1=vline(pkposC(i));
    set(k1,'linestyle',':','color',CM2(i,:),'linewidth',2)
end
set(gca,'fontsize',fs)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
%% Panel B
subplot(2,3,4)
hold on
box on
plot(EbB,EDCB,'ko','markersize',3,'markerfacecolor','k')
plot(EbfitB, bkgdfitB,'k-','linewidth',1)
xlim([0.15,0.71])
ylim([5e3,6.5e4])
set(gca,'fontsize',fs)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
for j=1:3
    k1=vline(pkposB(j));
    set(k1,'linestyle',':','color',CM2(j,:),'linewidth',2)
end
%% Panel D
subplot(2,3,5)
hold on
box on
plot(EbD,EDCdiffD,'ko','markersize',3,'markerfacecolor','k','linestyle',':')
plot(EbfitD,EDCdiff_fitD,'k-','linewidth',1)
plot(EbD,resD,'ko','markersize',3)
axis tight
ylim([-4e3,1.4e4])
xlim([0.15,0.71])
CM2=lines(5);
for i=1:3
    plot(EbD,pkfitD(i,:),'-','linewidth',2,'color',CM2(i,:))
end
for j=1:3
    k1=vline(pkposB(j));
    set(k1,'linestyle',':','color',CM2(j,:),'linewidth',2)
end
set(gca,'fontsize',fs)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
%% Panel E
subplot(2,3,3)
hold on
box on
plot(EbE, EDC_totE,'ko','markersize',4);
plot(EbfitE, EDCfit_totE, 'r-','linewidth',2);
xlim([min(EbE),max(EbE)])
ylim([0,1])
set(gca,'fontsize',fs)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
%% Panel F
subplot(2,3,6)
box on
hold on
plot(EbF,EDCdiffF,'ko','markerfacecolor','k','markersize',3)
axis tight
for j=1:5
    plot(EbF,pkfitF(j,:),'-','linewidth',2,'color',CM2(j,:))
    k1=vline(pkposF(j));
    set(k1,'linestyle',':','color',CM2(j,:),'linewidth',2)
end
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs) 