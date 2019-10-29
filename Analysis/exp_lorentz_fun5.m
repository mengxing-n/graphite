function [ Out ] = exp_lorentz_fun5( x, A1, A2, A3, A4, A5, B1, B2, B3, B4, B5, C1, D1, a, b, c, d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Out=a*exp(b*x) + c*exp(d*x)...
   +A1*(1/2*C1)./((x-B1).^2+(1/2*C1)^2)+A2*(1/2*C1)./((x-B2).^2+(1/2*C1)^2)...
   +A3*(1/2*C1)./((x-B3).^2+(1/2*C1)^2)+A4*(1/2*C1)./((x-B4).^2+(1/2*C1)^2)...
   +A5*(1/2*C1)./((x-B5).^2+(1/2*C1)^2)+D1;

end

