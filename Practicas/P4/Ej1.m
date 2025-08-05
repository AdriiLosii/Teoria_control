% 1. Representar el sistema como un objeto LTI.
A = [0 1 0; 0 0 1; -50 -20 -10];
B = [0; 0; 1];
C = [30 0 0];
D = 0;
sys = ss(A, B, C, D);
display(sys);


%% 2. Obtener la respuesta del sistema, la evolucion de las variables de estado, considerando una entrada escalon unitario y condiciones iniciales nulas.
figure(1)
step(sys); title("2. Respuesta del sistema");

figure(2)
[~, t, x] = step(sys);
plot(t, x); title("2. Evolución de las variables de estado");


%% 3. Obtener la respuesta del sistema y la evoluci´on de las variables de estado, considerando condiones iniciales x0 = [0, 5, −1] y entrada nula.
x0 = [0, 5, -1];

figure(1)
initial(sys, x0); title("3. Respuesta del sistema");

figure(2)
[~, t, x] = initial(sys, x0);
plot(t, x); title("3. Evolución de las variables de estado");


%% 4. Obtener la respuesta del sistema y evolucion de los estados ante una entrada escalon unitario y condiciones inicales x0 = [0, 5, −1].
x0 = [0, 5, -1];
t_sim = 0:0.1:10;
u = ones(1, length(t_sim));

figure(1)
lsim(sys, u, t_sim, x0); title("4. Respuesta del sistema");

figure(2)
[~, ts, x] = lsim(sys, u, t_sim, x0);
plot(ts, x); title("4. Evolución de las variables de estado");


%% 5. Obtener la respuesta del sistema cuando la entrada es como la que se muestra en la figura y suponiendo condiciones iniciales nulas
x0 = [0, 0, 0];
t_sim = 0:0.1:10;
u = zeros(1, length(t_sim));

% Tramo 1:
u(t_sim>=0 & t_sim<=2.5) = 5*(t_sim(t_sim>=0 & t_sim<=2.5))/2.5;

% Tramo 2:
u(t_sim>2.5 & t_sim<=7.5) = 5;

% Tramo 3:
u(t_sim>7.5 & t_sim<=10) = 5*(1-(t_sim(t_sim>7.5 & t_sim<=10)-7.5)/2.5);

figure(1)
lsim(sys, u, t_sim, x0); title("5. Respuesta del sistema");

figure(2)
[~, ts, x] = lsim(sys, u, t_sim, x0);
plot(ts, x); title("5. Evolución de las variables de estado");


%% 6. Obtener la funcion de transferencia del sistema y la salida de dicha funcion ante un escalon unitario, comprobar que el resultado coincide con la 2ª cuestion
sys_tf = tf(sys);
subplot(1, 2, 1);
step(sys_tf); title("6. Respuesta del sistema (tf)");
subplot(1, 2, 2);
step(sys); title("2. Respuesta del sistema (sys)");