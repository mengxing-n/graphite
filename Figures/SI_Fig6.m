function [ output_args ] = SI_Fig6( input_args )
close all
A=load('SI_Fig6.mat');
Eb=A.Eb;
DOS=A.DOS;
figure(1)
set(gcf,'color','white')
plot(Eb, DOS,'k-','linewidth',2)
ylim([0,0.06])
xlabel('Energy (eV)')
ylabel('DOS (1/eV)')
set(gca,'fontsize',16)
end

