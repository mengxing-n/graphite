function [ Ekfit, EDCfit, Param, CI] = Lorentzian_fit( Ek, EDC, Weight, Var_num, Prob_num, Var_in, Prob_in)
%fit with N number of lorentzians
%Ek = x axis
%EDC = y axis
%P_I = input parameters (starting values)
%Var_in = fit variables
%Prob_in = fit constants
%FTN = number of lorentzians fitted
%Lock = which variables to lock together
%Weight = weight of fit.
Coeff=[];
Prob=[];
Start_val=[];
Var_per=[];
Prob_val=[];
S=size(Var_in);
for i=1:S(1)
    dummy=Var_in(i,:);
    C_in=dummy(~cellfun('isempty',dummy));
    dummy2=Prob_in(i,:);
    P_in=dummy2(~cellfun('isempty',dummy2));
    dummy3=Prob_num(i,:);
    Pn_in=dummy3(~cellfun('isempty',dummy3));

    Coeff=[Coeff,C_in];
    Prob=[Prob,P_in];
    Start_val=[Start_val,Var_num{1,i}];
    Var_per=[Var_per,Var_num{2,i}];
    Prob_val=[Prob_val, Pn_in];
end
LB=Start_val-Var_per.*abs(Start_val);
UB=Start_val+Var_per.*abs(Start_val);
Opt = fitoptions('Method','NonlinearLeastSquares', 'Lower', LB, 'Upper', UB,'Startpoint', Start_val); 

f = fittype('lorentz_fun5( x, A1, A2, A3, A4, A5, B1, B2, B3, B4, B5, C1, D1)','indep','x',...
    'coeff', Coeff, 'problem', Prob,'options', Opt);
        

[c2,~] = fit((Ek)',EDC,f, 'Weight',Weight', 'problem',Prob_val);
Ekfit=linspace(0,max(Ek),1064);
EDCfit=feval(c2,Ekfit);
C=coeffvalues(c2);
CI=confint(c2);
Param=zeros(1, length(C));
Param(1,:)=C;



end

