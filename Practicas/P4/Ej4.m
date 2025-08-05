L = 23/100;
R = 3.5/100;

A = [0 0 0; 0 0 1; 0 0 0];
B = [R/2 R/2; R/2 R/2; R/L -R/L];
C = [0 0 0; 0 0 0];
D = [R/2 R/2; R/L -R/L];

sys = ss(A, B, C, D);
step(sys);