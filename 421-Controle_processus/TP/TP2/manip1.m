% UE421 - TP2 - Manipulation 1

close all;

Te = 50e-6;
tau = 1e-3; %ms
K=2;

% Paramètres du second ordre analogique
m=0.5;
Omega = 5000; %rad/s
x = m*Omega;
omega0 = Omega*sqrt(1-m^2);
F0 = omega0/(omega0^2+x^2);

% Paramètres du second ordre numérique correspondant
a = exp(-Te/tau);
k1 = K*(1-a);
A = exp(-x*Te)*sin(omega0*Te);
B = -2*exp(-x*Te)*cos(omega0*Te);
C = exp(-2*x*Te);
b = -C;
Kd = (B-b+1)/k1;

% Simulation ordre 2 analogique

% Delta = 1e-4; % pas d'intégration
% sim ('scripts/ordre2ana.slx')
% sim_an = simout;
% s_an = sim_an.data(:,2);
% s0_an = s_an(end); % Valeur finale pour normalisation
% figure(1);
% plot(sim_an.time,sim_an.data(:,2))
% xlabel('temps (s)');
% title('Reponse indicielle (systeme analogique, pas 100us, Dormand Price(8))');


% Simulation ordre 2 numérique
% Delta = 5e-6; % pas d'intégration < Te
% sim ('scripts/ordre2num.slx');
% sim_num = simout;
% s_num = sim_num.data(:,2);
% s0_num = s_num(end); % Valeur finale pour normalisation

%Comparaison des réponses analogique / numérique
% figure(2);
% plot(sim_num.time,s_num/s0_num,'.',sim_an.time,s_an/s0_an);
% xlabel('temps(s)');
% title('Comparaison des reponses indicielles');

%Effet de la fréquence d'échantllonnage
% figure(2);
% xlabel('temps(s)');
% title('Comparaison des reponses indicielles numériques');
% temps_ech = [1e-6,1e-5,1e-4,1e-3,5e-3,1e-2];
% 
% for k = [1:1:6]
%     Te=temps_ech(k);
%     a = exp(-Te/tau);
%     k1 = K*(1-a);
%     A = exp(-x*Te)*sin(omega0*Te);
%     B = -2*exp(-x*Te)*cos(omega0*Te);
%     C = exp(-2*x*Te);
%     b = -C;
%     Kd = (B-b+1)/k1;
%     sim ('scripts/boucle.slx');
%     sim_num = simout;
%     s_num = sim_num.data(:,3);
%     s0_num = s_num(end); % Valeur finale pour normalisation
%     subplot(2,3,k); plot(sim_num.time,s_num/s0_num);
% end;
% 


% Recherche réponse par modèle analogique
z=tf('z',Te)
D=Kd*z*(z-a)/((z-1)*(z+b))
Dt = d2c(D,'Tustin')

% Système analogique par BF
Delta = 1e-5; % pas d'intégration
sim ('scripts/ordre2ana.slx')
sim_an0 = simout;
s_an0 = sim_an0.data(:,2);
s0_an0 = s_an0(end); % Valeur finale pour normalisation

% Approximation analogique par Tustin
Delta = 1e-5; % pas d'intégration
sim ('scripts/ordre2ana2.slx')
sim_an = simout;
s_an = sim_an.data(:,2);
s0_an = s_an(end); % Valeur finale pour normalisation

%Simulation ordre 2 numérique bouclé
sim ('scripts/boucle.slx');
sim_num = simout;
s_num = sim_num.data(:,3);
s0_num = s_num(end); % Valeur finale pour normalisation

%Comparaison des réponses analogique / numérique
figure(1);
plot(sim_num.time,s_num/s0_num,sim_an.time,s_an/s0_an);
xlabel('temps(s)');
title('Comparaison des reponses indicielles');