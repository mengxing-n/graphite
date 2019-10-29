function [  ] = Analysis(  )
%% Load Data and parameters
%% Load Data
Dat=load('Fig3dat.mat');
Param=Dat.Param;
Eb=Param{1,1};
[Data, DataDiff,t] = pk_bkgd_fit( );
close all
%% Function control
pkN=5;
w=ones(1,length(Eb));
%% Define coefficients and problem parameters of fit -- Amp and Peak
Amp_coeff={'A1','A2','A3','A4','A5'};
Amp_coeff_val={[300 100 100 100 100]};
Amp_variation={[1 1 1 1 1]};
Amp_prob={[]};
Amp_prob_val={};

Peak_coeff={[]};
Peak_coeff_val={[]};
Peak_variation={[]};
Peak_prob={'B1','B2','B3','B4','B5'};
Peak_prob_val={0.612, 0.4927, 0.4468, 0.3212, 0.2626};

%% Width, offset, and background
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
%% Preparing fit input parameters
Var_in=cell(4);
Var_in(1,1:length(Amp_coeff))=Amp_coeff;
Var_in(2,1:length(Peak_coeff))=Peak_coeff;
Var_in(3,1:length(Width_coeff))=Width_coeff;
Var_in(4,1:length(Offset_coeff))=Offset_coeff;

Var_num=cell(2,4);
Var_num(1,1)=Amp_coeff_val;
Var_num(1,2)=Peak_coeff_val;
Var_num(1,3)=Width_coeff_val;
Var_num(1,4)=Offset_coeff_val;

Var_num(2,1)=Amp_variation;
Var_num(2,2)=Peak_variation;
Var_num(2,3)=Width_variation;
Var_num(2,4)=Offset_variation;

Prob_in=cell(4);
Prob_in(1,1:length(Amp_prob))=Amp_prob;
Prob_in(2,1:length(Peak_prob))= Peak_prob;
Prob_in(3,1:length(Width_prob))= Width_prob;
Prob_in(4,1:length(Offset_prob))= Offset_prob;

Prob_num=cell(4);
Prob_num(1,1:length(Amp_prob_val))=Amp_prob_val;
Prob_num(2,1:length(Peak_prob_val))=Peak_prob_val;
Prob_num(3,1:length(Width_prob_val))=Width_prob_val;
Prob_num(4,1:length(Offset_prob_val))=Offset_prob_val;
%% Initiating Output Space
I_lorentz=zeros(3,length(t),pkN);
EDCfit=zeros(length(t),1064);
w_lorentz=zeros(1,length(t)); 
r_lorentz=zeros(length(t),pkN);
A_lorentz=zeros(length(t),pkN);
pk_lorentz=zeros(pkN,length(Eb),length(t));
%% Fit EDCs
for i=1:length(t)
    EDC=DataDiff(:,i);
    [ Ebfit, EDCfit_dummy, Param, CI] = ...
        Lorentzian_fit( Eb, EDC, w, Var_num, Prob_num, Var_in, Prob_in);
    EDCfit(i,:)=EDCfit_dummy; 
    for j=1:pkN
        r_lorentz(j)=Peak_prob_val{j};
        w_lorentz(:,i)=Param(pkN+1:length(Param));
        A_lorentz(i,j)=Param(j);
        I_lorentz(1,i,j)=Param(j);
        I_lorentz(2:3,i,j)=CI(:,j);
        [ Out ] = lorentz_fun1( Eb, A_lorentz(i,j), r_lorentz(j), w_lorentz(i), 0);
        pk_lorentz(j,:,i)=Out;
    end
end
%% Figure window setup ---------------------------------------------------------------------------------%
figure(2)
CM2=lines(pkN);
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

%% Background subtraction plot
axes(ax3)
offset=2e4;
hold on
box on
n=2;
pk_lorentz=sum(pk_lorentz(:,:,n:n+5),3);
EDC_tot=sum(Data(:,n:n+5),2);
EDC_diff=sum(DataDiff(:,n:n+5),2);
pk_lorentz=sum(pk_lorentz,3);
bkgd=EDC_tot-EDC_diff;
bkgd=smooth(bkgd,5);
plot(Eb, EDC_tot+offset,'ko','markersize',5);
plot(Eb, 1.5*EDC_diff,'ko','markerfacecolor','k','markersize',5);
plot(Eb, bkgd+offset,'k--','linewidth',1.5);
for j=1:pkN
    plot(Eb,1.5*pk_lorentz(j,:),'-','linewidth',2,'color',CM2(j,:))
    k1=vline(r_lorentz(j));
    set(k1,'linestyle',':','color',CM2(j,:),'linewidth',2)
end
axis tight
ylim([min(EDC_diff),4e5])
set(gca,'fontsize',fs)
%% Fitting Gaussians - Lorentz area
c=zeros(pkN,3);
ci=zeros(2*pkN,3);
It=zeros(5,length(t));
for i=1:5
    f=fit(t',I_lorentz(1,:,i)','gauss1');
    c(i,:)=coeffvalues(f);
    ci(2*i-1:2*i,:)=confint(f);
    It(i,:)=I_lorentz(1,:,i);
end
axes(ax5)
hold on
box on
%% Rate Equation Model 2
Init=[1/150,1/50 ,1/180, 1/250, 0 , 200, 100 100];
LB  =[1/200,1/200,1/500, 1/1000, -50,  0,   0   0];
UB  =[1/10 ,1/10 ,1/10,  1/10, 150, 1e3, 1e3 1e3];

[x, ~, resid, ~, ~, ~, J]=lsqcurvefit(@Rate_eq_mod_all,Init,t,It,LB,UB);
tp=linspace(min(t),max(t));
ci=nlparci(x,resid,'jacobian',J);
Ifit=Rate_eq_mod_all(x,tp)*(tp(2)-tp(1))/(t(2)-t(1));
axes(ax5)
hold on
ind=zeros(1,5);
for i=1:5
    ind(i)=find(Ifit(i,:)==max(Ifit(i,:)));
    tzero_m=tp(ind(1));
    plot(tp-tzero_m,Ifit(i,:),'.-','linewidth',2,'color',CM2(i,:),'markersize',2)
    k1=vline(tp(ind(i))-tzero_m);
    set(k1,'linestyle','-','color',CM2(i,:),'linewidth',2)
end
for i =[1 2 3 4 5]
    errorbar(t-tzero_m,I_lorentz(1,:,i),abs(I_lorentz(2,:,i)-I_lorentz(1,:,i)),abs(I_lorentz(3,:,i)-I_lorentz(1,:,i)),...
        'o','color',CM2(i,:),'markerfacecolor',CM2(i,:),'markersize',8,'linewidth',2);
end

axis tight
xlabel('Delay (fs)','fontsize',fs+2,'interpreter','latex')
ylabel('Intensity (norm.)','fontsize',fs+2,'interpreter','latex')
set(gca,'fontsize',fs)
axis tight
xlim([min(t),max(t)]-tzero_m)
Dt1=round(tp(ind(2))-tzero_m);
Dt2=round(tp(ind(3))-tzero_m);
Dt3=round(tp(ind(4))-tp(ind(2)));
fprintf('Dt1 = %.2f \n',Dt1);
fprintf('Dt2 = %.2f \n',Dt2);
fprintf('Dt2 = %.2f \n',Dt3);
%% EDC plot
axes(ax4)
fs=20;
hold on
box on
M=[2 6 8 10];
CM=copper(length(M)+2);
Offset2=[0 2e4, 5e4 8e4];
for i=1:length(M)
    EDC=sum(DataDiff(:,M(i)-1:M(i)+1),2);
    EDCf=sum(EDCfit(M(i)-1:M(i)+1,:),1);
    plot(Eb,EDC*0.65+Offset2(i),'color',CM(i,:),'marker','.','markersize',7)
    plot(Ebfit, EDCf*0.65+Offset2(i),'color',CM(i,:),'linestyle','-','linewidth',2)
    pkOut=zeros(pkN,length(Eb));
    for j=1:pkN        
        for k=[-1 0 1]
            [ Out ] = lorentz_fun1( Eb, A_lorentz(M(i)+k,j), r_lorentz(j), w_lorentz(M(i)+k), 0);
            pkOut(j,:)=pkOut(j,:)+Out;        
        end
        plot(Eb,pkOut(j,:)*0.65+Offset2(i),'-','linewidth',2,'color',CM2(j,:))
    end
end
xlim([0.375,max(Eb)])
ylim([0,1.05e5])
for i=1:pkN
    k1=vline(r_lorentz(i));
    set(k1,'linestyle',':','color',CM2(i,:),'linewidth',2)
end
set(gca,'fontsize',20)
xlabel('$$E-E_F (eV)$$','FontSize',fs+2,'interpreter','latex')
%% Calculate values and errors (Rate-eq fit)
gm_ep1=x(1);
dgm_ep1=(ci(1,2)-x(1));
gm_th1=x(2);
dgm_th1=(ci(2,2)-x(2));
gm_ep2=x(3);
dgm_ep2=(ci(3,2)-x(3));
gm_ep3=x(4);
dgm_ep3=(ci(4,2)-x(4));

tau_ep1=1/gm_ep1;
dt_ep1=dgm_ep1/gm_ep1^2;
tau_th1=1/gm_th1;
dt_th1=dgm_th1/gm_th1^2;
tau_tot1=1/(gm_ep1+gm_th1);
dt_tot1=sqrt((dgm_ep1)^2+(dgm_th1)^2)/(gm_ep1+gm_th1)*tau_tot1;
tau_ep2=1./gm_ep2;
dt_ep2=(dgm_ep2)/gm_ep2^2;

tau_th2=r_lorentz(1)/r_lorentz(2)*tau_th1;
dt_th2=r_lorentz(1)/r_lorentz(2)*dt_th1;
gm_th2=1/tau_th2;
dgm_th2=dgm_th1*r_lorentz(2)/r_lorentz(1);
tau_tot2=(gm_ep2+gm_th2)^(-1);
dt_tot2=sqrt((dgm_ep2)^2+(dgm_th2)^2)/(gm_ep2+gm_th2)*tau_tot2;


fprintf('DTP1 tau_ep = %.2f +/- %.2f fs \n',tau_ep1,dt_ep1)
fprintf('DTP1 tau_th = %.2f +/- %.2f fs \n',tau_th1,dt_th1)
fprintf('DTP1 tau_tot = %.2f +/- %.2f fs \n',tau_tot1,dt_tot1)
fprintf('DTP2 tau_ep = %.2f +/- %.2f fs \n',tau_ep2,dt_ep2)
fprintf('DTP2 tau_th = %.2f +/- %.2f fs \n',tau_th2,dt_th2)
fprintf('DTP2 tau_tot = %.2f +/- %.2f fs \n',tau_tot2,dt_tot2)
end

