tau = 0.056;
Kohm=1.1;
Kthe=3.98;
K=1.18;

K2=K*Kthe;
mBF=0.8;

C=1/(mBF^2*4*K2*tau)
omega0 = (K2*C/tau)^(1/2)

num=[K2];
den=[tau 1 0];

sys=tf(num,den);

% 
% zeta=0.8;wn=12.5;
% rlocus(sys);
% sgrid(zeta,wn);
% 
% C=0.1;
% sysBF = feedback(C*sys,1,-1);
rlocus(sys);

% prep 2
%  omegaBF=[20 30 50];
%  
%  l1=tau.*omegaBF.^2/K2
%  l2=(2*tau*mBF.*omegaBF-1)/K2