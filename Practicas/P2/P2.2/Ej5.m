G = tf(1, [1 10 20]);
t = 0:0.01:10;

% Sintonizado manual
Kp = 300;
Ki = 800;
Kd = 40;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);

% Visualizacion:
subplot(2, 1, 1);
step(t, T_PID); title('Controlador PID sintonizado manualmente');

% Sintonizado mediante Ziegler-Nichols
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

% Controlador PID
Kp = 1.2/(R*L);
Ti = 2*L;
Ki = Kp/Ti;
Td = 0.5*L;
Kd = Kp*Td;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);

% Visualizacion:
subplot(2, 1, 2);
step(T_PID, t); title('Controlador PID sintonizado mediante Ziegler-Nichols');