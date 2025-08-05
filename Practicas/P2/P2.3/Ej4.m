G = tf(1, [1 10 20]);
t = 0:0.01:2;

% Sintonizado manual:
Kp = 300;
Ki = 800;
Kd = 40;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);
hold on
step(t, T_PID);

% Sintonizado automatico:
%pidTuner(G, 'pid');
Kp = 261.322;
Ki = 886.6783;
Kd = 19.2542;
PID = pid(Kp, Ki, Kd);
T_PID = feedback(G*PID, 1);
step(t, T_PID);
legend('PID (sintonizado manual)','PID (sintonizado con valores pidTuner)');
hold off