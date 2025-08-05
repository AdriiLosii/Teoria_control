% ts = 2s (Error del 2%)    ->  σ = 4/ts
% %Sobreoscilacion = 20%    ->  E = -log(0.2)/sqrt(pi^2 + log(0.2)^2) = 0.46
% Ess = 0


% 1. Obtener los polos dominantes buscados, en lazo cerrado para las especificaciones listadas anteriormente.
F = tf(15, [1 10 27 18]);   % Lazo abierto
H = feedback(F, 1, -1);     % Lazo cerrado

E = -log(0.2)/sqrt(pi^2 + log(0.2)^2);  %Calculamos el factor de amortiguamiento
ang_rad = acos(E);  % Angulo de inclinacion en radianes
m = tan(ang_rad);   % Pendiente de la recta
x = linspace(-10, 0);
y = 0 + m*(x - 0);  % Ecuacion de la recta

% Calculamos sigma:
ts = 2;
sigma = 4/ts;                                        

% En donde se cruza la recta y el LGDR -> Polos deseados para %OS = 20%
figure(1)
hold on
% Sobreelongación:
plot(x, -y, x, y);  % (Polos contenidos entre las dos diagonales)

% Tiempo de asentamiento:
plot([-sigma -sigma], [-10 10]);    % (Polos a la izquierda de la linea vertical)
Kp = 2.725;
F_P = Kp*F;
H_P = feedback(F_P, 1, -1);
figure(1)
rlocus(F); title("LGDR con controlador P");
hold off

[P, Z] = pzmap(F);

display(P(1));
display(P(2));
display(P(3));

% Interseccion de las 2 curvas (polos dominantes): s1,2 = -2 +- 3.9j