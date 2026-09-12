%% Tarea 1 - Control Automatico - Punto 2
% Sintonizacion de controlador PID a partir del modelo identificado
% Planta: G(s) = K*exp(-L*s)/(tau*s+1)
clear; clc; close all;

%% Datos identificados (Motor.csv, System Identification Toolbox)
K   = 28.52/10.28;   % Ganancia estatica
tau = 1/10.28;        % Constante de tiempo
L   = 0.0001;          % Tiempo muerto forzado (valor bajo, ver Seccion de identificacion)

s = tf('s');
G = tf(K, [tau 1], 'ioDelay', L);

fprintf('K = %.6f\n', K);
fprintf('tau = %.6f\n', tau);
fprintf('L = %.6f\n', L);

%% Ganancia ultima (Ku) y periodo ultimo (Pu)
% margin() evalua la respuesta en frecuencia EXACTA del sistema con
% retardo (no usa aproximacion de Pade), por lo que Wcg es la frecuencia
% de cruce de fase de -180 grados del lazo abierto G(s).
[Gm, Pm, Wcg, Wcp] = margin(G);
Ku = Gm;
Pu = 2*pi/Wcg;
fprintf('Ku = %.4f\n', Ku);
fprintf('Pu = %.6e s\n', Pu);

%% 1) Ziegler-Nichols lazo abierto (PID)
Kp_zno = 1.2*tau/(K*L);
Ti_zno = 2*L;
Td_zno = 0.5*L;

%% 2) Ziegler-Nichols lazo cerrado (PID)
Kp_znc = 0.6*Ku;
Ti_znc = 0.5*Pu;
Td_znc = 0.125*Pu;

%% 3) Cohen-Coon (PID)
r = L/tau;
Kp_cc = (1/(K*r))*(4/3 + r/4);
Ti_cc = L*(32 + 6*r)/(13 + 8*r);
Td_cc = L*4/(11 + 2*r);

%% 4) Tyreus-Luyben (PID)
Kp_tl = Ku/2.2;
Ti_tl = 2.2*Pu;
Td_tl = Pu/6.3;

%% Tabla resumen de constantes
metodos = {'ZN Lazo Abierto'; 'ZN Lazo Cerrado'; 'Cohen-Coon'; 'Tyreus-Luyben'};
Kp_v = [Kp_zno; Kp_znc; Kp_cc; Kp_tl];
Ti_v = [Ti_zno; Ti_znc; Ti_cc; Ti_tl];
Td_v = [Td_zno; Td_znc; Td_cc; Td_tl];
Ki_v = Kp_v ./ Ti_v;
Kd_v = Kp_v .* Td_v;

TablaConstantes = table(metodos, Kp_v, Ti_v, Td_v, Ki_v, Kd_v, ...
    'VariableNames', {'Metodo','Kp','Ti_s','Td_s','Ki','Kd'});
disp(TablaConstantes)

%% Simulacion en lazo cerrado (mismo grafico) + tabla de transitorio
figure; hold on; grid on;
Ttrans = table();
for i = 1:4
    C = pid(Kp_v(i), Ki_v(i), Kd_v(i));
    sys_cl = feedback(C*G, 1);

    [y, t] = step(sys_cl, 0.0025);
    plot(t, y, 'DisplayName', metodos{i}, 'LineWidth', 1.2);

    S = stepinfo(sys_cl, 'SettlingTimeThreshold', 0.02);
    ess = abs(1 - y(end));

    Ttrans = [Ttrans; table(metodos(i), S.RiseTime, S.SettlingTime, S.Overshoot, ess, ...
        'VariableNames', {'Metodo','RiseTime_s','SettlingTime_s','Overshoot_pct','ess'})];
end
yline(1, 'k--', 'LineWidth', 0.7);
xlabel('Tiempo [s]');
ylabel('Salida (respuesta a escalon unitario)');
title('Respuesta de lazo cerrado - Planta + Controlador PID');
legend('show', 'Location', 'best');

disp(Ttrans)

% Guardar figura para el reporte
exportgraphics(gcf, 'fig_step_response.png', 'Resolution', 300);