G = tf(1, [1 10 20]);

Kp = 20;
Kd = 8;
Ki = 20;
P = pid(Kp, 0, 0);
PD = pid(Kp, 0, Kd);
PI = pid(Kp, Ki, 0);
PID = pid(Kp, Ki, Kd);

T = feedback(G, 1);
T_P = feedback(G*P, 1);
T_PD = feedback(G*PD, 1);
T_PI = feedback(G*PI, 1);
T_PID = feedback(G*PID, 1);
t = 0:0.01:2;

figure(1)
step(t, T); title('Sistema inicial');

figure(2)
subplot(2, 2, 1);
step(t, T_P); title('Controlador P');

subplot(2, 2, 2);
step(t, T_PD); title('Controlador PD');

subplot(2, 2, 3);
step(t, T_PI); title('Controlador PI');

subplot(2, 2, 4);
step(t, T_PID); title('Controlador PID');

% ¿Qué hace cada controlador?
% Controlador PID o proporcional-integral-derivativo:
% -P o proporcional: ayuda a reducir el error actual.
% -I o integral: ayuda a eliminar el error constante.
% -D o derivativo: ayuda a reducir el efecto del cambio rápido en el error.