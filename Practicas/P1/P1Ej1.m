%a)
m = 2; % [kg]
b = 10; % [N*s/m]
k = 20; % [N/m]
G = tf(1, [m b k]);

figure(1)
subplot(1, 2, 1);
step(G);
title("a) Escalon unitario");
xlabel('t [s]'); ylabel('Amplitud [m]');

%c)
subplot(1, 2, 2);
impulse(G);
title("b) Impulso unitario");
xlabel('t [s]'); ylabel('Amplitud [m]');

%d)
[Z, P, K]= zpkdata(G);

%e)
%Si varia 'm':
m = 4;
b = 10;
k = 20;
G_m = tf(1, [m b k]);

%Si varia 'b':
m = 2;
b = 20;
k = 20;
G_b = tf(1, [m b k]);

%Si varia 'k':
m = 2;
b = 10;
k = 40;
G_k = tf(1, [m b k]);

figure(2)
step(G, G_m, G_b, G_k);
title("Respuesta a escalon unitario");
legend("Señal inicial", "Aumenta 'm'", "Aumenta 'b'", "Aumenta 'k'")
xlabel('t [s]'); ylabel('Amplitud [m]');