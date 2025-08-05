G = tf(1, [1 10 20]);

Kp = 300;
Ki = 800;
Kd = 40;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);

t = 0:0.01:2;
step(t, T_PID); title('Controlador PID');