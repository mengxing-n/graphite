function [ output_args ] = MT_Fig1( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A=load('MT_Fig1.mat');
Eb=A.Eb;
kx=A.kx;
SimA=A.SimA;
SimB=A.SimB;
SimC=A.SimC;

hFig=figure; 
set(hFig, 'units','normalized','position', [0.1 0.1 .81 .81])
set(gcf,'Color','white')
MAP=colormap('bone');
MAP=flipud(MAP);
Cmin=max(max(SimA))*0.1;
Cmax=max(max(SimA))*1;
xmin=2*0.85-0.15;
xmax=2*0.85+0.15;
ymin=-1;
ymax=1;

clf
fs=18;
dW=0.05;
Left1 = 1.5*dW;
Bottom1 = 2*dW;
Width1 = 0.25;
Height1 = 0.8;    
ax1=axes('position',[Left1 Bottom1 Width1 Height1]);
cla(ax1)

Left2 = Left1+Width1+dW;
Bottom2 = Bottom1;
Width2 = Width1;
Height2 = Height1;    
ax2=axes('position',[Left2 Bottom2 Width2 Height2]);
cla(ax2)

Left3 = Left2+Width2+1*dW;
Bottom3 = Bottom1;
Width3 = Width1;
Height3 = Height1;    
ax3=axes('position',[Left3 Bottom3 Width3 Height3]);
cla(ax3)

%%
A=8;
S=size(SimA);
axes(ax1)
hold on
box on
grid off
imagesc(kx,Eb(1:120),SimA(1:120,:));
imagesc(kx,Eb(121:S(1)),A*SimA(121:S(1),:));
colormap(MAP)
xlim([xmin, xmax])
caxis([Cmin,Cmax])
ylim([ymin,ymax])
set(gca,'Layer','top')
grid off
ylabel('$$E-E_F (\mathrm{eV})$$','FontSize',fs+2,'interpreter','latex')
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
ylim([-0.25,0.7])
%% 2D plot 2
axes(ax2)
hold on
box on
grid off
imagesc(kx,Eb(1:120),SimB(1:120,:));
imagesc(kx,Eb(121:S(1)),A*SimB(121:S(1),:));
colormap(ax2,MAP)
caxis([Cmin,Cmax])
axis tight
xlim([xmin, xmax])
ylim([ymin,ymax])
set(gca,'Layer','top')
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
ylim([-0.25,0.7])
%% 2D plot 3
axes(ax3)
hold on
box on
grid off
imagesc(kx,Eb(1:120),SimC(1:120,:));
imagesc(kx,Eb(121:S(1)),A*SimC(121:S(1),:));
colormap(ax2,MAP)
colorbar
caxis([Cmin,Cmax])
axis tight
xlim([xmin, xmax])
ylim([ymin,ymax])
set(gca,'Layer','top')
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
ylim([-0.25,0.7])

end

