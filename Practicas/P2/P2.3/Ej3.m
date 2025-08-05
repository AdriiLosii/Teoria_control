G = tf(1, [1 10 20]);
t = 0:0.01:5;

[y, t] = step(G, t);
pendientes_y = diff(y)./diff(t);    % Obtenemos un vector con todas las pendientes de la respuesta
[~, index_max] = max(pendientes_y);   % Obtenemos el índice del valor de maxima pendiente
R_y = y(index_max);
R_t = t(index_max);

% Creamos la recta tangente R:
P1 = [t(index_max-1), y(index_max-1)];
P2 = [t(index_max+1), y(index_max+1)];

R = (P2(2)-P1(2))/(P2(1)-P1(1));    % Pendiente maxima
b = P1(2)-R*P1(1);

x_tan = linspace(P1(1),P2(1));
y_tan = R*x_tan + b;

% Obtenemos L:
[~, index_L] = min(y);
L_y = y_tan(index_L);
L = x_tan(index_L);


% Controlador P:
% Ziegler-Nichols
Kp = 1/(R*L);
Ki = 0;
Kd = 0;
P = pid(Kp, Ki, Kd);
T_P = feedback(G*P, 1);
subplot(3, 1, 1);
hold on
step(T_P, t);

% pidTuner()
Kp = 41.7002;
Ki = 0;
Kd = 0;
step(feedback(G*pid(Kp,Ki,Kd),1), t);
title('Controlador P');
legend('Ziegler-Nichols','pidTuner');
hold off

% Controlador PI:
% Ziegler-Nichols
Kp = 0.9/(R*L);
Ti = 3*L;
Ki = Kp/Ti;
Kd = 0;
PI = pid(Kp, Ki, Kd);
T_PI = feedback(G*PI, 1);
subplot(3, 1, 2);
hold on
step(T_PI, t);

% pidTuner()
Kp = 34.6971;
Ki = 96.2542;
Kd = 0;
step(feedback(G*pid(Kp,Ki,Kd),1), t);
title('Controlador PI');
legend('Ziegler-Nichols','pidTuner');
hold off

% Controlador PID:
% Ziegler-Nichols
Kp = 1.2/(R*L);
Ti = 2*L;
Ki = Kp/Ti;
Td = 0.5*L;
Kd = Kp*Td;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);
subplot(3, 1, 3);
hold on
step(T_PID, t);

% pidTuner()
Kp = 39.2721;
Ki = 115.9397;
Kd = 3.3256;
step(feedback(G*pid(Kp,Ki,Kd),1), t);
title('Controlador PID');
legend('Ziegler-Nichols','pidTuner');
hold off