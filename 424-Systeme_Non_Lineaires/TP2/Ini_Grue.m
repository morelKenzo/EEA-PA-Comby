% Ce script permet de d�clarer les valeurs des param�tres du mod�le
% Il sert aussi � d�clarer et � calculer les diff�rentes variables 
% de commande tout au long du TP (Exemples : Point de fonctionnement,
% trajectoire, commande � grand gain, ...
clear, clc,


%% Param�tres : 
m  = 500;  %kg
Mc = 5000; %kg
g  = 10;   %m/s^2
J  = 50;   %kg.m^2
b  = 0.4;  %m
Cd = 20;   %kg/s
Cr = 20;   %kg.m^2/s

%% Point de fonctionnement 
R = 10;
D = 0;
C0 = m*g*b; 
F = 0;
 
%% Trajectoire
Rini = R;
Dini = 0;
Rfin = 5;
Dfin = 20;
zh = 1;
dt = 10;
%% Manip 1 
A = [0 0 0 1 0 0 ; 
     0 0 0 0 1 0 ; 
     0 0 0 0 0 1 ; 
     0 0 m*g/Mc -Cd/Mc 0 0 ; 
     0 0 0 0 -Cr/(b^2*(J/b^2+m)) 0 ; 
     0 0 -g/R*(1+m/Mc) Cd/(Mc*R) 0 0];
 
B = [0 0 ; 
     0 0 ;
     0 0 ;
     1/Mc 0 ;
     0 -1/(b*(J/b^2+m)) ;
     -1/(R*Mc) 0 ];
C= eye(6);
Com = [B A*B A^2*B A^3*B A^4*B A^5*B];
rank(Com)

%% Manip 2 

vprA = damp(eig(A)); % valeur propres de A 
omega0 = vprA(2);
xi = 0.5
i=complex(0,1);
p1 = omega0*(-xi+ i *sqrt(1-xi^2));
p2 = omega0*(-xi- i *sqrt(1-xi^2));
p = [-2 -2.5 -3 -4 p1 p2];


K = place(A,B,p)
C_1 =C(1,:);
B_1 =B(:,1);

eta = -1/(C_1*(A-B*K)^-1*B_1);


%% pretty figure
% plot(simout)
% legend("d","r","\theta","d d/dt","dr/dt","d\theta/dt");
% grid on;
%% Commande grand gain
Deltat= 10
Dini = 0;
Dfin = 20;
R = 15;
Rini = 15;
Rfin = 15;
ed = omega0/100;
er = ed;

coeff_phi = [6/Deltat^5 -15/Deltat^4 10/Deltat^3 0 0 0]
coeff_phi2 = [-20/Deltat^7 70/Deltat^6 -84/Deltat^5 35/Deltat^4 0 0 0 0]


zh = 1;

xh = (Dini+sqrt((Rini-zh)/(Rfin-zh))*Dfin)/(1+sqrt((Rini-zh)/(Rfin-zh)));
a = (Rini-zh)/(Dini-xh)^2;



