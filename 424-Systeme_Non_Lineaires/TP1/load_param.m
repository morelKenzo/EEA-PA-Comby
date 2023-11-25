clear all;
close all;

load param.mat

A = [0 0                   1                   0;
     0 0                   0                   1 ;
     0 Ks/Jp               (-(N*phi)^2)/(R*Jp) 0 ;
     0 -Ks*(Jb+Jp)/(Jp*Jb) (N*phi)^2/(R*Jp)   0 ]
B = [0            0;
     0            0; 
     N*phi/(R*Jp) 0;  
    -N*phi/(R*Jp) 1]
%% Manip2 

   L = [0, -Ks^2*(Jp+Jb)/(Jp*Jb^2) , Ks*phi^2*N^2/(R*Jp*Jb), 0];
                                            
   l1 = m*g*h/Jb;
   l2 = -(m*g*h)^2/(Jb*Jb);
   l3 = Ks*m*g*h/(Jb^2);
   l4 = Ks*m*g*h/(Jb*Jb);
   Somme = [1 1 1 1 1];
   beta = R*Jp*Jb/(Ks*N*phi);