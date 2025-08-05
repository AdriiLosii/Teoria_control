G = tf(1, [1 10 20]);   %Lazo abierto
F = 1;
t = 0:0.01:2;
u = ones(size(t));
plot(t, u, t, step(t, G));
legend('Entrada (Escalón unitario)', 'Salida')

%Naturaleza de las magnitudes:
% -Fuerza aplicada (Entrada)(Vectorial: dirección, módulo y sentido). Unidades: [N]
% -Posición de la masa (Salida)(Vectorial: coordenadas). Unidades: [m]