function [ ] = pk_loc_fit( )
%% Load Data
Dat=load('Fig3dat.mat');
Data=Dat.TR_tot;
Param=Dat.Param;
close all
Eb=Param{1,1};
ang=Param{1,2};

Angle=0.03;
dA=0.6;
amin = find(ang>Angle-dA/2,1);
amax = find(ang>Angle+dA/2,1)-1;
%% Function control
pkN=5;
ds=13;
w=ones(1,length(Eb));
%% Define coefficients and problem parameters of fit
Amp_coeff={'A1','A2','A3','A4','A5'};
Amp_coeff_val={[300 100 100 100 70]};
Amp_variation={[1 1 1 1 1]};
Amp_prob={[]};
Amp_prob_val={};

Peak_coeff={'B1','B2','B3','B4','B5'};
Peak_coeff_val={[0.61, 0.49, 0.45, 0.32, 0.26]};
Peak_variation={[1 1 1 1 1]*0.5};
Peak_prob={[]};
Peak_prob_val={[]};
%%
Width_coeff_val={[0.074497]};
Width_variation={[0.3]};
Width_coeff={'C1'};
Width_prob={[]};
Width_prob_val={};
   
Offset_coeff_val={[]};
Offset_variation={[]};
Offset_coeff={[]};
Offset_prob={'D1'};
Offset_prob_val={0};

Exp_coeff_val={[1.751e+06  -21.04  3.579e+04  -3.211]};
Exp_variation={[3 3 3 3]};
Exp_coeff={'a','b','c','d'};
Exp_prob={[]};
Exp_prob_val={};
a=1;
b=11;
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
Var_num(1,4)=Offset_coeff_val;
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
r_lorentz=zeros(3,pkN);
%% Fit EDCs
EDC=sum(sum(Data(:,amin:amax,a:b),2),3)/(length(a:b));
[ ~, ~, Param] = exp_Lorentzian_fit( Eb, EDC, w, Var_num, Prob_num, Var_in, Prob_in);
for j=0:pkN-1
    r_lorentz(:,j+1)=Param(:,pkN+j+1); 
end
fprintf('pk1 = %.3f +/- %.3f\n',round(r_lorentz(1,1)*1e3)/1e3,round((r_lorentz(1,1)-r_lorentz(2,1))*1e3)/1e3)
fprintf('pk2 = %.3f +/- %.3f\n',round(r_lorentz(1,2)*1e3)/1e3,round((r_lorentz(1,2)-r_lorentz(2,2))*1e3)/1e3)
fprintf('pk3 = %.2f +/- %.2f\n',round(r_lorentz(1,3)*1e2)/1e2,round((r_lorentz(1,3)-r_lorentz(2,3))*1e2)/1e2)
fprintf('pk4 = %.2f +/- %.2f\n',round(r_lorentz(1,4)*1e2)/1e2,round((r_lorentz(1,4)-r_lorentz(2,4))*1e2)/1e2)
fprintf('pk5 = %.2f +/- %.2f\n',round(r_lorentz(1,5)*1e2)/1e2,round((r_lorentz(1,5)-r_lorentz(2,5))*1e2)/1e2)
end

