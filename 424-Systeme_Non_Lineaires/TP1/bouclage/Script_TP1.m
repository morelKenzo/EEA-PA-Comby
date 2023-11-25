clc, clear, warning('off')


%% Valeurs des variables
   Ks  = 1.61;   %N/m
   Jp  = 0.0021; %kg/(m.m)
   Jb  = 0.0059; %kg/(m.m)
   m   = 0.403;  %kg
   h   = 0.06;   %m
   g   = 9.8;    %N/m
   N   = 70;     %Sans dim
   Phi = 0.00767;%N.s/rad
   R   = 2.6;    %Ohm 
   
%% Manip. 1 : Modèle NL
   A_nl = [0  0                    1                  0 ;...
           0  0                    0                  1 ;...
           0  Ks/Jp                -Phi^2*N^2/(R*Jp)  0 ;...
           0  -Ks*(Jp+Jb)/(Jp*Jb)  Phi^2*N^2/(R*Jp)   0]; 

  B = [0; 0; Phi*N/(R*Jp); -Phi*N/(R*Jp)];
  B_b = [0; 0; 0; m*g*h/Jb];  
  B_nl = [B B_b];
  
  C = [1,  1,  0,  0];

%% Manip. 2 : Bouclage linéarisant

   L = [0, -Ks^2*(Jp+Jb)/(Jp*Jb^2) , Ks*Phi^2*N^2/(R*Jp*Jb), 0];
                                            
   l1 = m*g*h/Jb;
   l2 = -(m*g*h)^2/(Jb*Jb);
   l3 = Ks*m*g*h/(Jb^2);
   l4 = Ks*m*g*h/(Jb*Jb);
   Somme = [1 1 1 1 1];
   beta = R*Jp*Jb/(Ks*N*Phi);
   
%% Manip. 6 : Poursuite asymptotique
   
%    m =0.8;
%    w0 = 20;
%    w1 = 35;
%    w2 = 20;
%    i = sqrt(-1);
   
    m = 2;
   w0 = 2000;
   w1 = 3500;
   w2 = 3000;
   i = sqrt(-1);
   
   
   p = tf('p');
   Po = (p+w0*m-i*w0*sqrt(1-m^2))*(p+w0*m+i*w0*sqrt(1-m^2))*...
         (p+w1)*(p+w2);
   P = Po.num{1}; a3=P(2); a2=P(3); a1=P(4); a0=P(5);
   
   T = 1/10;
   yinf = pi/4; 
   

   % Modèle de la consigne :
   Pc = (p+(w0/100)*0.7-i*(w0/100)*sqrt(1-0.7^2))*(p+(w0/100)*0.7+i*(w0/100)*sqrt(1-0.7^2))*...
        (p+w1/100)*(p+w2/100)*(p+w2/100);
   Pc = Pc.num{1}; b4=Pc(2); b3=Pc(3); b2=Pc(4); b1=Pc(5); b0=Pc(6);
   Ac = [0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1; ...
         -b0 -b1 -b2 -b3 -b4];
   Bc = [0; 0; 0; 0; b0];   
   
   
%    
%  %% Manip. 10 : Backstepping
%     La1 = -10;
%     La2 = 10*La1;
%     La3 = 10*La2;
%     La4 = 10*La3;
    
  
   
   