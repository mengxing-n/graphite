function [ output_args ] = SI_Fig1( ~ )
close all
%% Load Panel A
A=load('MT_Fig2.mat');
B=load('SI_Fig1.mat');
EbA=A.Eb;
kxA=A.kx;
MAPA=A.Unpumped;
MAPB=A.Delay0;
MAPC=B.MAPC;
%% Load Panel B
EbB=EbA;
EDC1B=B.EDC1B;
EDC2B=B.EDC2B;
EfitB=B.EfitB;
yfitB=B.yfitB;
%% Load Panel C
EbC=B.EbC;
EDCdiffC=B.EDCdiffC;
%% Figure 1 set up
hFig=figure;
set(hFig, 'units','normalized','position', [0.1 0.1 0.7 0.8])
set(gcf,'Color','white')
MAP = dlmread('Terrain.txt');
MAP=MAP./max(max(MAP));
MAP=flipud(MAP);
clf
fs=20;

Left1 = 0.08;
Bottom1 = 0.09;
Width1 = 0.25;
Height1 = 0.9;    
ax1=axes('position',[Left1 Bottom1 Width1 Height1]);  

Left2 = 2*Left1+Width1;
Bottom2 = Bottom1;
Width2 = Width1;
Height2 = Height1;    
ax2=axes('position',[Left2 Bottom2 Width2 Height2]);

Left3 = 3*Left1+2*Width1;
Bottom3 =Bottom1;
Width3 = Width1;
Height3 = Height1;
ax3=axes('position',[Left3 Bottom3 Width3 Height3]); 
%% Figure 2 set up
hFig=figure;
set(hFig, 'units','normalized','position', [0.1 0.1 0.4 0.5])
set(gcf,'Color','white')
clf
fs=20;
dW=0.05;

Left1 = 0.12;
Bottom1 = 0.15;
Width1 = 0.85;
Height1 = 0.82;    
ax1_fig2=axes('position',[Left1 Bottom1 Width1 Height1]);
cla(ax1_fig2)


Left2 = 0.6;
Bottom2 = 0.6;
Width2 = 0.32;
Height2 = 0.32;    
ax2_fig2=axes('position',[Left2 Bottom2 Width2 Height2]);
cla(ax2_fig2)
%% Panel A
cla(ax1)    
axes(ax1)
box on
hold on
imagesc(kxA,EbA,log(MAPA))
Cmax=max(max(MAPA));
caxis((log([1e1 Cmax])))
colormap(MAP)
dummy=load('DiffColorMap2.mat');
MAP2=dummy.mycmap;
axis tight
ylabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
set(gca,'Layer','top')
xlim([-0.2,0.2]+1.7)
ylim([-0.25,0.75])

cla(ax2)    
axes(ax2)
box on
hold on
imagesc(kxA,EbA,log(MAPB))
caxis(log([1e1 Cmax]))
colormap(MAP)
axis tight
xlabel('$$k_x$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
set(gca,'Layer','top')
xlim([-0.2,0.2]+1.7)
ylim([-0.25,0.75])

cla(ax3)    
axes(ax3)
box on
hold on
imagesc(kxA,EbA,log(MAPC))
Cmax=max(max(MAPC));
caxis(log([1e1 Cmax]))
colormap(ax3, MAP)
axis tight
xlabel('$$k_x$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
set(gca,'Layer','top')
xlim([-0.2,0.2]+1.7)
ylim([-0.25,0.75])
%% Panel B
cla(ax1_fig2)
axes(ax1_fig2)
box on
hold on
grid on
plot(EbB,EDC1B,'bo','markersize',3,'markerfacecolor','b')
plot(EfitB,yfitB,'b-','linewidth',2)
plot(EbB,EDC2B,'ro','markersize',3,'markerfacecolor','r')
legend('Before pump','fitted bkgd','During pump')
legend boxoff
set(gca,'yscale','log','FontSize',fs)
axis tight
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
ylabel('EDC','FontSize',fs)

cla(ax2_fig2)
axes(ax2_fig2)
plot(EbC, EDCdiffC,'ko','markersize',3,'markerfacecolor','k')
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
ylabel('EDC-bkgd','FontSize',fs)
set(gca,'FontSize',fs-2)
axis tight
k=vline([0.612, 0.493, 0.44 0.32 0.26]);
set(k,'linestyle','--','color','m')
end

