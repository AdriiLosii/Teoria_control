% ts = 2s (Error del 2%)    ->  wn = 4/(ts*epsilon) = 4/(2*0.46) ~= 4.386
% %Sobreoscilacion = 20%    ->  F. amort. (epsilon) = -log(0.2)/sqrt(pi^2 + log(0.2)^2) ~= 0.46
% Ess = 0


% 1. Obtener los polos dominantes buscados, en lazo cerrado para las especificaciones listadas anteriormente.
F = tf(15, [1 10 27 18]);   % Lazo abierto
H = feedback(F, 1, -1);     % Lazo cerrado

% Calculamos el factor de amortiguamiento (epsilon):
E = -log(0.2)/sqrt(pi^2 + log(0.2)^2);

% Calculamos el factor de amortiguamiento (wn):
ts = 2;
wn = 4/(ts*E);

%Calculamos los polos dominantes:
p1 = -E*wn+(1j*wn*sqrt(1-E^2));
p2 = -E*wn-(1j*wn*sqrt(1-E^2));
display(p1); display(p2);


% 2. Obtener el lugar de las raices para este sistema en lazo cerrado con un controlador proporcional.
Kp = 2.725;
F_P = Kp*F;
H_P = feedback(F_P, 1, -1);
figure(1)
rlocus(F_P); title("LGDR con controlador P");


% 3. Diseñar un compensador PD que satisfaga las condiciones dinamicas
K = 1.08;
% Calculamos zc:
[P, Z] = pzmap(F);
% Criterio del angulo
ang1 = rad2deg(atan((imag(p1)-imag(P(1)))/(real(p1)-(real(P(1))))));
ang2 = rad2deg(atan((imag(p1)-imag(P(2)))/(real(p1)-(real(P(2))))));
ang3 = 180 + rad2deg(atan((imag(p1)-imag(P(3)))/(real(p1)-(real(P(3))))));
% Posicion del cero en el eje real
zc = imag(p1)/tan(deg2rad(180+ang1+ang2+ang3)) - real(p1);
display(zc);
PD = (K*tf([1 zc], 1));
F_PD = PD*F;
H_PD = feedback(F_PD, 1, -1);

ang_rad = acos(E);  % Angulo de inclinacion en radianes
m = tan(ang_rad);   % Pendiente de la recta
x = linspace(-10, 0);
y = 0 + m*(x - 0);  % Ecuacion de la recta

% Calculamos sigma:
ts = 2;
sigma = 4/2;

figure(2)
hold on
% Sobreelongación:
plot(x, -y, x, y);  % (Polos contenidos entre las dos diagonales)

% Tiempo de asentamiento:
plot([-sigma -sigma], [-10 10]);    % (Polos a la izquierda de la linea vertical)

% LGDR
rlocus(F_PD);
title("Compensador PD"); ylim([-5 5]);
hold off

% d) Comparacion compensado vs sin compensar
figure(3)
step(H_PD, H); title("Comparacion PD");
legend("Compensado (PD)", "Sin compensar");


% 4. Añadir un compensador PI, elegir la posicion de su cero y simular e iterar hasta obtener la respuesta buscada.
a = 0.6;            % Posicion del cero en el eje real
PI = K*tf([1 a], [1 0]);
F_PI = PI*F;
H_PI = feedback(F_PI, 1, -1);

% Comparacion compensado vs sin compensar
figure(4)
step(H_PI, H); title("Comparacion PI");
legend("Compensado (PI)", "Sin compensar");


% 5. Obtener los valores de las constantes del PID diseñado.
Kp = K*zc+K*a;
Ki = K*zc*a;
Kd = K;
PID_a = pid(Kp, Ki, Kd);
PID_b = PD*PI;

F_PID_a = PID_a*F;
F_PID_b = PID_b*F;
H_PID_a = feedback(F_PID_a, 1, -1);
H_PID_b = feedback(F_PID_b, 1, -1);

% Comparacion compensado vs sin compensar
figure(5)
subplot(1, 2, 1)
step(H_PID_a, H); title("Comparacion PID (funcion pid())");
subplot(1, 2, 2)
step(H_PID_b, H); title("Comparacion PID (fórmula PI*PD)");
legend("Compensado (PID)", "Sin compensar");