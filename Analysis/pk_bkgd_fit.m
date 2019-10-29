function [Data_wBKGD, DataDiff, t, r_lorentz] = pk_bkgd_fit(  )
%% Load Data
Dat=load('Fig3dat.mat');
Data=Dat.TR_tot;
Param=Dat.Param;
close all
Eb=Param{1,1};
ang=Param{1,2};
t=Param{1,3};

Angle=0.03;
dA=0.6;
m1=1;
m2=131;
amin = find(ang>Angle-dA/2,1);
amax = find(ang>Angle+dA/2,1)-1;
%% Function control
pkN=5;
ds=2;
w=ones(1,length(Eb));
%% Define coefficients and problem parameters of fit
Amp_coeff={'A1','A2','A3','A4','A5'};
Amp_coeff_val={[300 100 100 100 70]};
Amp_variation={[1 1 1 1 1]};
Amp_prob={[]};
Amp_prob_val={};

Peak_coeff={[]};
Peak_coeff_val={[]};
Peak_variation={[]};
Peak_prob={'B1','B2','B3','B4','B5'};
Peak_prob_val={0.612, 0.4927, 0.4468, 0.3212, 0.2626};

Width_coeff_val={[0.074497]};
Width_variation={[0.3]};
Width_coeff={'C1'};
Width_prob={[]};
Width_prob_val={};

Offset1={[]};
Offset_variation={[]};
Offset_coeff={[]};
Offset_prob={'D1'};
Offset_prob_val={0};

Exp_coeff_val={[1.751e+06  -21.04  3.579e+04  -3.211]};
Exp_variation={[3 3 3 3]};
Exp_coeff={'a','b','c','d'};
Exp_prob={[]};
Exp_prob_val={};
%% Preparing fit input parameters
Var_in=cell(5);
Var_in(1,1:length(Amp_coeff))=Amp_coeff;
Var_in(2,1:length(Peak_coeff))=Peak_coeff;
Var_in(3,1:length(Width_coeff))=Width_coeff;
Var_in(4,1:length(Offset_coeff))=Offset_coeff;
Var_in(5,1:length(Exp_coeff))=Exp_coeff;

Var_num=cell(2,5);
Var_num(1,1)=Amp_coeff_val;
Var_num(1,2)=Peak_coeff_val;
Var_num(1,3)=Width_coeff_val;
Var_num(1,4)=Offset1;
Var_num(1,5)=Exp_coeff_val;

Var_num(2,1)=Amp_variation;
Var_num(2,2)=Peak_variation;
Var_num(2,3)=Width_variation;
Var_num(2,4)=Offset_variation;
Var_num(2,5)=Exp_variation;

Prob_in=cell(5);
Prob_in(1,1:length(Amp_prob))=Amp_prob;
Prob_in(2,1:length(Peak_prob))= Peak_prob;
Prob_in(3,1:length(Width_prob))= Width_prob;
Prob_in(4,1:length(Offset_prob))= Offset_prob;
Prob_in(5,1:length(Exp_prob))= Exp_prob;

Prob_num=cell(5);
Prob_num(1,1:length(Amp_prob_val))=Amp_prob_val;
Prob_num(2,1:length(Peak_prob_val))=Peak_prob_val;
Prob_num(3,1:length(Width_prob_val))=Width_prob_val;
Prob_num(4,1:length(Offset_prob_val))=Offset_prob_val;
Prob_num(5,1:length(Exp_prob_val))=Exp_prob_val;
%% Initiating Output space
DataDiff=zeros(length(Eb),length(t)-ds);
Data_wBKGD=DataDiff;
figure(1)
set(gcf,'color','white')
fs=16;
hold on
grid on
box on
CM=copper(length(t));
%% Fit EDCs
for i=1:length(t)-ds
    Offset1=(i-1)*5e4*1;
    EDC=sum(sum(Data(:,amin:amax,i:i+ds),2),3)/(ds+1);
    [ Ebfit, ~, Param] = ...
        exp_Lorentzian_fit( Eb, EDC, w, Var_num, Prob_num, Var_in, Prob_in);
    S=size(Param);
    a=Param(1,S(2)-3);
    b=Param(1,S(2)-2);
    c=Param(1,S(2)-1);
    d=Param(1,S(2));
    bkgd=a*exp(b*Eb) + c*exp(d*Eb);
    bkgdfit=a*exp(b*Ebfit) + c*exp(d*Ebfit);
    Data_wBKGD(:,i)=EDC';
    DataDiff(:,i)=EDC-bkgd';

    hold on
    box on
    plot(Eb,EDC+Offset1,'color',CM(i,:),'marker','o','markersize',3,'markerfacecolor','k','linestyle','none')
    plot(Ebfit, bkgdfit+Offset1,'color',CM(i,:),'linestyle','-','linewidth',1)
    axis tight
    xlabel('Energy (eV)')
    set(gca,'fontsize',fs)
end
t=t(1:length(t)-ds)*1e15;

end

