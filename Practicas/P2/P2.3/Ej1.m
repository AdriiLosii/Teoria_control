G = tf(1, [1 10 20]);
hold on
step(feedback(G, 1));
%pidTuner(G)

% Controlador P:
Kp = 41.7002;
Ki = 0;
Kd = 0;
step(feedback(G*pid(Kp,Ki,Kd), 1));

% Controlador PD:
Kp = 41.7002;
Ki = 0;
Kd = 0;
step(feedback(G*pid(Kp,Ki,Kd), 1));

% Controlador PI:
Kp = 34.6971;
Ki = 96.2542;
Kd = 0;
step(feedback(G*pid(Kp,Ki,Kd), 1));

% Controlador PID:
Kp = 39.2721;
Ki = 115.9397;
Kd = 3.3256;
step(feedback(G*pid(Kp,Ki,Kd), 1));
legend('Respuesta inicial','Controlador P','Controlador PD','Controlador PI','Controlador PID')
hold off