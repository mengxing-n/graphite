function [dpdt] = odefun_dp_pr(t, p, s, c_X, c_Y, c_Z, c_U, E, t0)
cx=c_X/E(1);
cy=c_Y/E(1);
cz=c_Z/E(2);
cu=c_U/E(3);
dpdt=zeros(2,1);
dpdt(1)=exp(-2*(t-t0)^2/s^2)-cx*E(1)*p(1)-cy*E(1)*p(1);
dpdt(2)=exp(-2*(t-t0)^2/s^2)-cz*E(2)*p(2)-cy*E(2)*p(2);
dpdt(3)=-cx*E(3)*p(3)-cy*E(3)*p(3)+cx*E(1)*p(1);
dpdt(4)=-cx*E(4)*p(4)-cy*E(4)*p(4)+cz*E(2)*p(2);
dpdt(5)=exp(-2*(t-t0)^2/s^2)-cy*E(5)*p(5)-cx*E(5)*p(5);
% 

end
