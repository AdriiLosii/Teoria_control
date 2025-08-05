%% 1. Representar el sistema como un objeto LTI.
A = [0 1 0; 0 0 1; -50 -20 -10];
B = [0; 0; 1];
C = [30 0 0];
D = 0;
sys = ss(A, B, C, D);

% Obtengo las matrices:
% a) Mediante funciones:
Co = ctrb(sys);     % Matriz de controlabilidad
Ob = obsv(sys);     % Matriz de observabilidad

% b) Mediante calculos con matrices:
% Matriz de controlabilidad -> U = [B AB A^2B]
U = [B A*B A^2*B];
% Matriz de observabilidad -> V = [C; CA; CA^2]
V = [C; C*A; C*A^2];

display(Co==U);
display(Ob==V);


%% 2. Evaluar si el sistema es observable y controlable.
% SISO:
display(det(Co));   % Controlabilidad
display(det(Ob));   % Observabilidad
% Como el resultado de la matriz es distinto de 0, la matriz no es
% singular y por lo tanto tiene rango n (3), es decir, es
% controlable/observable.