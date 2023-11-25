sys = ss(A-B*K,B(:,2),C(2,:),D)
H = tf(sys)
bode(H)
% margin(H)
% Avec le correcteur intégral :
Ti = 5e-4
CI =  tf(1,[-Ti 0]); % négatif pour avoir une phase >180
%bode(H,CI*H,'grid')
% fig =figure();
% margin(CI*H)
% grid on;
% saveas(fig,"manip_5marge.png");

%%
close all;
sim('Grue_NL_corrNL')
fig= figure()
plot(Dc)
hold on
plot(simout.Time, simout.Data(:,1));
xlabel('temps (s)');
grid on;
title('Vérification de la planification de trajectoire');
legend('d_c','d');

fig2= figure()
plot(Rc)
hold on
plot(simout.Time, simout.Data(:,2));
xlabel('temps (s)');
grid on;
title('Vérification de la planification de trajectoire');
legend('r_c','r');


%%

close all
figure()
for e = [1 10 100]
    ed = omega0/e; er= omega0/e;
    sim('Grue_NL_corrNL')
    hold on
    subplot(311)
    hold on
    plot(simout.Time, simout.Data(:,1),"DisplayName",sprintf("\\epsilon_r=\\epsilon_d= \\omega_0/%d",e));
    subplot(312)
    hold on
    plot(simout.Time, simout.Data(:,2),"DisplayName",sprintf("\\epsilon_r=\\epsilon_d= \\omega_0/%d",e));
    subplot(313)
    hold on
    plot(simout.Time, simout.Data(:,3),"DisplayName",sprintf("\\epsilon_r=\\epsilon_d= \\omega_0/%d",e));
end
 xlabel('temps (s)');
subplot(311)
title("choix de l'échelle temps");
ylabel('d'); grid on;
subplot(312)
ylabel('r'); grid on;
subplot(313)
ylabel('\theta'); grid on;
%%

close all
e = 100;
ed = omega0/e; er= omega0/e;
figure()
for m = [300 500 700]
    c0 =m*g*b;
    sim('Grue_NL_corrNL')
    hold on
    subplot(311)
    hold on
    plot(simout.Time, simout.Data(:,1),"DisplayName",sprintf("m = %d",m));
    subplot(312)
    hold on
    plot(simout.Time, simout.Data(:,2),"DisplayName",sprintf("m = %d",m));
    subplot(313)
    hold on
    plot(simout.Time, simout.Data(:,3),"DisplayName",sprintf("m = %d",m));
end
 xlabel('temps (s)');
subplot(311)
title("");
ylabel('d'); grid on;
subplot(312)
ylabel('r'); grid on;
subplot(313)
ylabel('\theta'); grid on;

m = 500;
%%
close all
e = 10;
ed = omega0/e; er= omega0/e;
figure()
for kc = [0.5 1 1.5]
    Cr= Cr*kc
    sim('Grue_NL_corrNL')
    hold on
    subplot(311)
    hold on
    plot(simout.Time, simout.Data(:,1),"DisplayName",sprintf("Cr = %f",Cr));
    subplot(312)
    hold on
    plot(simout.Time, simout.Data(:,2),"DisplayName",sprintf("Cr = %f",Cr));
    subplot(313)
    hold on
    plot(simout.Time, simout.Data(:,3),"DisplayName",sprintf("Cr = %f",Cr));
end
 xlabel('temps (s)');
subplot(311)
title("");
ylabel('d'); grid on;
subplot(312)
ylabel('r'); grid on;
subplot(313)
ylabel('\theta'); grid on;

%%
close all;
sim('Grue_NL_corrNL')
fig= figure()
hold on
plot(simout.Time, complates.Data(:,1));
plot(simout.Time, complates.Data(:,2));
plot(simout.Time, sortieplates.Data(:,2));
plot(simout.Time, sortieplates.Data(:,1));

xlabel('temps (s)');
grid on;
title('Vérification de la planification de trajectoire, sortie plates');
legend('x_c','z_c','x','z');

%%