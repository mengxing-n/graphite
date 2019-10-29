function [Out] = Rate_eq_mod_all(param, t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Input Parameters
s=102;
tprobe=129;
c_X=param(1);
c_Y=param(2);
c_Z=param(3);
c_U=param(4);
t0=param(5);
A=param(6:8);
Out=zeros(5,length(t));
E=[0.612, 0.491, 0.444, 0.322, 0.262];
%% ODE inputs
opts = odeset('RelTol',1e-4,'AbsTol',1e-5);
tp = (min(t)-100:(t(2)-t(1))/4:max(t)+100)+1e-5;        %Time
Pconv=2/(tprobe*sqrt(2*pi))*exp(-2*(tp-mean(tp)).^2./(tprobe^2)); %Convolution function
%% Solve ODE and convolution
[tp,p] = ode45(@(t,p) odefun_dp_pr(t, p, s, c_X, c_Y, c_Z, c_U, E, t0), tp, [0 0 0 0 0],opts);
p_g=zeros(size(p'));
for i=[1 3 4]
    p_g(i,:)=A(1)*conv(p(:,i)',Pconv,'same');
    Out(i,:)=spline(tp',p_g(i,:),t);
end
p_g(2,:)=A(2)*conv(p(:,2)',Pconv,'same');
Out(2,:)=spline(tp',p_g(2,:),t);
p_g(5,:)=A(3)*conv(p(:,5)',Pconv,'same');
Out(5,:)=spline(tp',p_g(5,:),t);
%% define output

end

