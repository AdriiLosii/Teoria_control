G = tf(1, [1 10 20]);   %Lazo abierto

Kp = 34;
Ki = 96;
C = pid(Kp, Ki, 0);
T = feedback(C*G, 1);   %Lazo cerrado
t = 0:0.01:2;

step(T, t)
pidTuner(G)