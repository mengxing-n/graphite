function [  ] = MTFig4(  )
close all
%% Load Fig4A
A=load('MT_Fig4A.mat');
EbA=A.EbA;
kxA=A.kxA;
OJDOSA=A.OJDOSA;
bands1A=A.bands1A;
bands2A=A.bands2A;
%% Load Fig4B
B=load('MT_Fig4B.mat');
EbB=B.EbB;
ojdosB=B.ojdosB;
%% Load Fig4C
C=load('MT_Fig4C.mat');
qC=C.qC;
bandsC=C.bandsC;
epcC=C.epcC;
%% Load Fig4D
D=load('MT_Fig4D.mat');
kx1D=D.kx1D;
ky1D=D.ky1D;
kx2D=D.kx2D;
ky2D=D.ky2D;
EPC1D=D.EPC1D;
EPC2D=D.EPC2D;
%% Figure window setup ---------------------------------------------------------------------------------%
figure(1)
fs=20;
set(gcf,'color','white')
set(gcf,'WindowStyle','normal','units','inches','Position',[0.1,0.1,18,8])
dW=0.075;
Left1 = dW;
Bottom1 = 0.1;
Width1 = 0.175;
Height1 = 0.85;   
ax1=axes('position',[Left1 Bottom1 Width1 Height1]);

Left2 = Left1+Width1+dW;
Bottom2 = 0.575;
Width2 = 0.16;
Height2 = 0.375; 
ax2=axes('position',[Left2 Bottom2 Width2 Height2]);

Left6 = Left2+Width2+dW;
Bottom6=Bottom2;
Width6=2.25*Width2;
Height6=Height2;
ax6=axes('position',[Left6 Bottom6 Width6 Height6]);

Left7=Left2;
Bottom7=Bottom1;
Width7=Width2;
Height7=Height2;
ax7=axes('position',[Left7 Bottom7 Width7 Height7]);

Left8=Left7+Width7+dW;
Bottom8=Bottom7;
Width8=Width7;
Height8=Height7;
ax8=axes('position',[Left8 Bottom8 Width8 Height8]);
%% OJDOS 2D plot
Cmin=log(750);
Cmax=max(max(OJDOSA))*1;
xmin=2*0.85-0.15;
xmax=2*0.85;
ymin=-1;
ymax=1.05;
axes(ax1)
% OJDOSA=log(OJDOSA+1e-15);
imagesc(kxA,EbA,real(OJDOSA));
set(gca,'Ydir','normal')
hold on
for k1=1:4
    plot(kxA,bands1A(:,k1),'w-','linewidth',0.2)
    plot(kxA,bands2A(:,k1),'w-','linewidth',0.2)
end
xlim([xmin, xmax])
caxis([Cmin,Cmax])
cb=colorbar();
ylim([ymin,ymax])
set(gca,'Layer','top')
% MAP=dlmread('GeoColorTable.txt');
% MAP=flipud(MAP./max(max(MAP)));
% colormap(ax1,MAP)
grid off
ylabel('$$E-E_F (\mathrm{eV})$$','FontSize',fs+2,'interpreter','latex')
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
text(1.56,-0.85,'$$k_z= 2.61$$','FontSize',fs+2,'color','white','interpreter','latex')
set(gca,'FontSize',fs)
%% OJDOS plot
axes(ax2)
hold on
box on
ylim([0,0.8])
plot(EbB,ojdosB,'k-','linewidth',2)
xlim([0.1,0.7])
ylabel('OJDOS')
xlabel('$$E-E_F (\mathrm{eV})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
%% k-integrated EPC
axes(ax6)
hold on
box on
for i=12:-1:1
    y = bandsC(i,:);
    col =epcC(i,:);  % This is the color, vary with x in this case.
    scatter(qC,y,40,col,'filled')
end
axis tight
colorbar('location','eastoutside')
set(gca,'fontsize',fs)
xlabel('Momentum (q)')
ylabel('Energy (eV)')
%% k-resolved EPC
kEPC_tot=zeros(1,3);
axes(ax7)
hold on
box on
scatter(kx1D,ky1D,20,EPC1D,'filled');
Cmax=max(EPC1D);
caxis([0,Cmax])
ylabel('$$ k_y (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
xlim([-0.1,0.1])
ylim([-0.1,0.1])
axes(ax8)
hold on
box on
scatter(kx2D,ky2D,20,EPC2D,'filled');
caxis([0,Cmax])
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
xlim([-0.1,0.1])
ylim([-0.1,0.1])
end

