%a)
J = 2; % [kg*m^2]
B = 5; % [N*s/rad]
k = 10; % [N/rad]
G = tf([1 0], [J B k]);
step(G);
title("Escalon unitario")
xlabel('t [s]'); ylabel('Amplitud (velocidad angular) [rad/s]');

%c)
impulse(G);
title("Impulso unitario")
xlabel('t [s]'); ylabel('Amplitud (velocidad angular) [rad/s]');

%d)
[Z, P, K]= zpkdata(G);

%e)
%Si varia 'J':
J = 4;
B = 5;
k = 10;
G_J = tf([1 0], [J B k]);

%Si varia 'B':
J = 2;
B = 10;
k = 10;
G_B = tf([1 0], [J B k]);

%Si varia 'k':
J = 2;
B = 5;
k = 20;
G_k = tf([1 0], [J B k]);

figure(2)
step(G, G_J, G_B, G_k);
title("Respuesta a escalon unitario (velocidad angular (salida) [rad/s]/par (entrada) [N*m])");
legend("Señal inicial", "Aumenta 'J'", "Aumenta 'B'", "Aumenta 'k'")