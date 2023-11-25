Omega=2;
Omega0=100;
Sp=1.2;
Sm=0.8;

m=0.5;
k=m/Sm;

t=[0:0.001:5];

sinf=Sm*cos(Omega*t);
Sc=Sp*(1+m*cos(Omega*t)).*cos(Omega0*t);
Ss=Sp*(m*cos(Omega*t)).*cos(Omega0*t);

figure(1);
plot(t,Ss,t,sinf);


%{
figure(1)
plot(sinf,Sc)
grid
xlabel('sinf(t)')
ylabel('s(t)')
title('D.B.P.C')
hold on
plot(sinf,Sp*(1+k*sinf),'r')


plot(sinf,Ss)
grid
xlabel('sinf(t)')
ylabel('s(t)')
title('D.B.P.S')
hold on
plot(sinf,Sp*k*sinf,'r')
%}