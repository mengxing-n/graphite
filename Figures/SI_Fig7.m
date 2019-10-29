function [ output_args ] = SI_Fig7( input_args )
close all
A=load('SI_Fig7.mat');
%% Load Panel A
qA=A.qA;
bandsA=A.bandsA;
epcA=A.epcA;
%% Load Panel B
kx1B=A.kx1B;
ky1B=A.ky1B;
kx2B=A.kx2B;
ky2B=A.ky2B;
kx3B=kx2B;
ky3B=ky2B;
EPC1B=A.EPC1B;
EPC2B=A.EPC2B;
EPC3B=A.EPC3B;
%% Panel A
figure(1)
fs=20;
hold on
box on
for i=6:-1:1
    y = bandsA(i,:);
    col =epcA(i,:);  % This is the color, vary with x in this case.
    scatter(qA,y,40,col,'filled')
end
axis tight
colorbar('location','eastoutside')
set(gca,'fontsize',fs)
xlabel('Momentum (q)')
ylabel('Energy (eV)')
%% Panel B
figure(2)
set(gcf,'color','white')
subplot(1,3,1)
hold on
box on
scatter(kx1B,ky1B,20,EPC1B,'filled');
Cmax=max(EPC1B);
caxis([0,Cmax])
ylabel('$$ k_y (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
xlim([-0.1,0.1])
ylim([-0.1,0.1])
subplot(1,3,2)
hold on
box on
scatter(kx2B,ky2B,20,EPC2B,'filled');
Cmax=max(EPC1B);
caxis([0,Cmax])
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
xlim([-0.1,0.1])
ylim([-0.1,0.1])
subplot(1,3,3)
hold on
box on
scatter(kx3B,ky3B,20,EPC3B,'filled');
Cmax=max(EPC1B);
caxis([0,Cmax])
xlabel('$$ k_x (\mathrm{\AA}^{-1})$$','FontSize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
xlim([-0.1,0.1])
ylim([-0.1,0.1])

end

