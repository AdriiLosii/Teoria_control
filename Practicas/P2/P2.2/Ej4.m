G = tf(1, [1 10 20]);
t = 0:0.01:2;

figure(1)
step(G, t);
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

display(L);
display(R);

% Controlador P
Kp = 1/(R*L);
Ki = 0;
Kd = 0;
P = pid(Kp, Ki, Kd);
T_P = feedback(G*P, 1);
figure(2)
subplot(3, 1, 1);
step(T_P, t); title('Controlador P');

% Controlador PI
Kp = 0.9/(R*L);
Ti = 3*L;
Ki = Kp/Ti;
Kd = 0;
PI = pid(Kp, Ki, Kd);
T_PI = feedback(G*PI, 1);
subplot(3, 1, 2);
step(T_PI, t); title('Controlador PI');

% Controlador PID
Kp = 1.2/(R*L);
Ti = 2*L;
Ki = Kp/Ti;
Td = 0.5*L;
Kd = Kp*Td;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);
subplot(3, 1, 3);
step(T_PID, t); title('Controlador PID');