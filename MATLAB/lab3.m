clc; clear; close all; 
 
% parameters
Tb = 400e-6;
A = 2;
Ts = 2e-6;
%int_time = Tb/Ts;

 
% E1
S1_sqrd = @(t) (abs(A*sin(pi*t/Tb))).^2 ;
E1 = integral(S1_sqrd,0,Tb)
 
% E2
S2_sqrd = @(t) (A*t/Tb).^2;
E2 = integral(S2_sqrd,0,Tb)
 
% rho
S1S2 = @(t) (abs(A*sin(pi*t/Tb))).*(A*t/Tb);
rho = integral(S1S2,0,Tb)/sqrt(E1*E2)

% phi 2 hat scalar
d21 = sqrt(E2-2*rho*sqrt(E1*E2)+E1)
 
% Threshold
%s12
S1p2 = @(t) (A*sin(pi*t/Tb)).*(A*t/Tb-abs(A*sin(pi*t/Tb)))./d21;
s12 = integral(S1p2,0,Tb)
%s22
S2p2 = @(t) (A*t/Tb).*(A*t/Tb-abs(A*sin(pi*t/Tb)))./d21;
s22 = integral(S2p2,0,Tb)

T = (s12+s22)/2


Pav = (E1 + E2)/2/Tb;


sd = @(t) (abs(A*sin(pi*t/Tb)) - (A*t/Tb)).^2;

Ed = integral(sd,0,Tb);
Pd = Ed/Tb;


%% Enter noise power
Noise_var = [100];
No = Noise_var*Ts*2;
BER = qfunc(sqrt(Ed./(2*No))) 
