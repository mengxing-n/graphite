function [ Out ] = lorentz_fun1( x, A1, B1, C1, D1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Out=A1*(1/2*C1)./((x-B1).^2+(1/2*C1)^2)+D1;

end

