function [ output_args ] = MT_Fig2( input_args )
close all
A=load('MT_Fig2.mat');
Eb=A.Eb;
kx=A.kx;
MAPA=A.Unpumped;
MAPB=A.Delay0;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%% MAP1
cla(ax1)    
axes(ax1)
box on
hold on
imagesc(kx,Eb,MAPA)
Cmax=max(max(MAPA));
caxis(([1e1 Cmax]))
colormap(MAP)
dummy=load('DiffColorMap2.mat');
MAP2=dummy.mycmap;
axis tight
ylabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
set(gca,'Layer','top')
xlim([-0.2,0.2]+1.7)
ylim([-0.25,0.4])

cla(ax2)    
axes(ax2)
box on
hold on
imagesc(kx,Eb,MAPB)
caxis(([1e1 Cmax]))
colormap(MAP)
axis tight
xlabel('$$k_x$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
set(gca,'Layer','top')
xlim([-0.2,0.2]+1.7)
ylim([-0.25,0.4])

cla(ax3)    
axes(ax3)
box on
hold on
imagesc(kx,Eb,MAPB-MAPA)
Cmax=max(max(MAPB-MAPA));
caxis(([-1,1]*5e3))
colormap(ax3, MAP2)
axis tight
xlabel('$$k_x$$','FontSize',fs+2,'interpreter','latex')
set(gca,'FontSize',fs)
set(gca,'Layer','top')
xlim([-0.2,0.2]+1.7)
ylim([-0.25,0.4])
end

