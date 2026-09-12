%% Etapa 1: Model-in-the-Loop del TCLab
clearvars;
close all;
clc;

%% Modelo FOPDT identificado

K     = 0.937801;     % Ganancia [°C/%]
tau   = 189.293;      % Constante de tiempo [s]
theta = 21;           % Retardo [s]

Gp = tf(K, [tau 1], ...
    'InputDelay', theta);

disp('Modelo nominal del TCLab:')
Gp

%% Condiciones de operación

T_amb = 25;           % Temperatura ambiente inicial [°C]

T_ref_min = 50;       % Referencia mínima [°C]
T_ref_max = 70;       % Referencia máxima [°C]

Q_min = 0;            % Potencia mínima físicamente posible [%]
Q_max = 90;           % Potencia máxima físicamente posible [%]

T_max = 90;           % Límite de seguridad [°C]

%% Verificación del modelo

fprintf('Ganancia estática: %.6f °C/%%\n', dcgain(Gp));
fprintf('Polo de la planta: %.6f 1/s\n', pole(Gp));

figure;
step(Gp, 1200);
grid on;
title('Respuesta del modelo ante un incremento de 1 % en Q_1');
xlabel('Tiempo [s]');
ylabel('\Delta T_1 [°C]');

%% Diseño del PI mediante SIMC/IMC

% tau_c determina la rapidez deseada del lazo cerrado:
%   tau_c = theta   -> diseño rápido y más agresivo.
%   tau_c = 2*theta -> diseño más conservador y robusto.
%
% Un tau_c mayor produce una respuesta más lenta,
% pero requiere un menor esfuerzo de control.

tau_c = 2*theta;      % Sintonización conservadora [s]

% Parámetros según las reglas SIMC
Kc = tau/(K*(tau_c + theta));
Ti = min(tau, 4*(tau_c + theta));

% Forma paralela del PI:
% C(s) = Kp + Ki/s
Kp_IMC = Kc;
Ki_IMC = Kc/Ti;

C_IMC = pid(Kp_IMC, Ki_IMC);

fprintf('\nControlador PI mediante SIMC/IMC\n');
fprintf('tau_c = %.3f s\n', tau_c);
fprintf('Kp    = %.6f %%/°C\n', Kp_IMC);
fprintf('Ti    = %.3f s\n', Ti);
fprintf('Ki    = %.6f %%/(°C·s)\n', Ki_IMC);

disp('Controlador PI:')
C_IMC

%% Selección de la referencia

T_ref = NaN;

while ~isfinite(T_ref) || T_ref < T_ref_min || T_ref > T_ref_max

    entrada = input( ...
        sprintf('Ingrese la referencia entre %.0f y %.0f °C: ', ...
        T_ref_min, T_ref_max), ...
        's');

    % Permite escribir el decimal con punto o coma
    T_ref = str2double(strrep(entrada, ',', '.'));

    if ~isfinite(T_ref) || ...
            T_ref < T_ref_min || T_ref > T_ref_max

        fprintf('La referencia debe estar entre %.0f y %.0f °C.\n', ...
            T_ref_min, T_ref_max);
    end
end

%% Condiciones iniciales del controlador

% Al iniciar, la acción integral es cero. Por tanto:
%
% Q_cmd(0) = Kp*(T_ref - T_amb)

error_inicial = T_ref - T_amb;
Q_cmd_0 = Kp_IMC*error_inicial;

% Potencia aplicada por el sistema físico limitado
Q_aplicada_0 = min(max(Q_cmd_0, Q_min), Q_max);

fprintf('\nCondiciones iniciales\n');
fprintf('Temperatura ambiente:          %.2f °C\n', T_amb);
fprintf('Temperatura de referencia:     %.2f °C\n', T_ref);
fprintf('Error inicial:                 %.2f °C\n', error_inicial);
fprintf('Potencia solicitada por el PI: %.2f %%\n', Q_cmd_0);
fprintf('Potencia aplicada con límite:  %.2f %%\n', Q_aplicada_0);

if Q_cmd_0 > Q_max
    fprintf('El actuador físico inicia saturado en el límite superior.\n');
elseif Q_cmd_0 < Q_min
    fprintf('El actuador físico inicia saturado en el límite inferior.\n');
else
    fprintf('El actuador físico no inicia saturado.\n');
end

%% Parámetros de simulación

Ts = 1;                   % Periodo de simulación [s]
t_final = 1800;           % Duración total [s]
t = (0:Ts:t_final)';

%% Caso 1: PI ideal sin saturación

% En este caso académico se aplica directamente:
%
% Q1 = Q_cmd
%
% Por tanto, la planta puede recibir valores físicamente imposibles,
% como 115 % o incluso valores negativos.

resultado_ideal = simularPI( ...
    t, Ts, T_ref, T_amb, ...
    K, tau, theta, ...
    Kp_IMC, Ki_IMC, ...
    Q_min, Q_max, ...
    false, false);

%% Caso 2: PI con saturación y sin anti-windup

% La potencia aplicada se limita entre Q_min y Q_max, pero el integrador
% continúa acumulando error durante la saturación. Esto produce windup.

resultado_sinAW = simularPI( ...
    t, Ts, T_ref, T_amb, ...
    K, tau, theta, ...
    Kp_IMC, Ki_IMC, ...
    Q_min, Q_max, ...
    true, false);

%% Caso 3: PI con saturación y anti-windup

% El clamping detiene el integrador cuando:
%
% 1. La salida solicitada por el PI está fuera de los límites; y
% 2. el error tiende a profundizar todavía más la saturación.
%
% El integrador vuelve a actuar cuando el error ayuda al controlador
% a salir de la saturación.

resultado_conAW = simularPI( ...
    t, Ts, T_ref, T_amb, ...
    K, tau, theta, ...
    Kp_IMC, Ki_IMC, ...
    Q_min, Q_max, ...
    true, true);

%% Evaluación del desempeño

metricas_ideal = calcularMetricas( ...
    resultado_ideal, t, Ts, T_ref, T_amb, Q_min, Q_max);

metricas_sinAW = calcularMetricas( ...
    resultado_sinAW, t, Ts, T_ref, T_amb, Q_min, Q_max);

metricas_conAW = calcularMetricas( ...
    resultado_conAW, t, Ts, T_ref, T_amb, Q_min, Q_max);

fprintf('\n====================================================\n');
fprintf('COMPARACIÓN DE RESULTADOS\n');
fprintf('====================================================\n');

fprintf('\nCaso 1: PI ideal sin saturación\n');
mostrarMetricas(metricas_ideal);

fprintf('\nCaso 2: PI con saturación y sin anti-windup\n');
mostrarMetricas(metricas_sinAW);

fprintf('\nCaso 3: PI con saturación y anti-windup\n');
mostrarMetricas(metricas_conAW);

%% Verificación automática de los requerimientos

% Los requerimientos físicos se verifican sobre el controlador
% con saturación y anti-windup.

ts_max = 600;             % Tiempo máximo de establecimiento [s]
OS_max = 5;               % Sobreimpulso máximo [%]

cumple_ts = ...
    metricas_conAW.SettlingTime <= ts_max;

cumple_OS = ...
    metricas_conAW.Overshoot <= OS_max;

cumple_Q = ...
    min(resultado_conAW.Q1) >= Q_min && ...
    max(resultado_conAW.Q1) <= Q_max;

cumple_T = ...
    max(resultado_conAW.T1) <= T_max;

fprintf('\nCumplimiento con saturación y anti-windup\n');
fprintf('ts <= %.0f s:             %s\n', ...
    ts_max, string(cumple_ts));

fprintf('Sobreimpulso <= %.0f %%:  %s\n', ...
    OS_max, string(cumple_OS));

fprintf('%.0f <= Q1 <= %.0f %%:      %s\n', ...
    Q_min, Q_max, string(cumple_Q));

fprintf('T1 <= %.0f °C:            %s\n', ...
    T_max, string(cumple_T));

%% Gráficas comparativas

figure;

tiledlayout(3,1);

% Temperatura
nexttile;

plot(t, resultado_ideal.T1, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'PI ideal');

hold on;

plot(t, resultado_sinAW.T1, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'Saturación sin AW');

plot(t, resultado_conAW.T1, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'Saturación con AW');

yline(T_ref, '--k', ...
    'Referencia', ...
    'HandleVisibility', 'off');

yline(T_max, ':r', ...
    'Límite de 5ad', ...
    'HandleVisibility', 'off');

grid on;
ylabel('T_1 [°C]');

title(sprintf( ...
    'Arranque desde %.1f °C hasta %.1f °C', ...
    T_amb, T_ref));

legend('Location', 'best');

% Potencia aplicada a la planta
nexttile;

plot(t, resultado_ideal.Q1, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'PI ideal');

hold on;

plot(t, resultado_sinAW.Q1, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'Saturación sin AW');

plot(t, resultado_conAW.Q1, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'Saturación con AW');

yline(Q_max, ':r', ...
    'Límite superior', ...
    'HandleVisibility', 'off');

yline(Q_min, ':k', ...
    'Límite inferior', ...
    'HandleVisibility', 'off');

grid on;
ylabel('Q_1 [%]');
legend('Location', 'best');

% Acción integral
nexttile;

plot(t, resultado_ideal.integral, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'PI ideal');

hold on;

plot(t, resultado_sinAW.integral, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'Saturación sin AW');

plot(t, resultado_conAW.integral, ...
    'LineWidth', 1.4, ...
    'DisplayName', 'Saturación con AW');

grid on;
xlabel('Tiempo [s]');
ylabel('Acción integral [%]');
legend('Location', 'best');

%% Funciones locales

function resultado = simularPI( ...
    t, Ts, T_ref, T_amb, ...
    K, tau, theta, ...
    Kp, Ki, Q_min, Q_max, ...
    aplicarSaturacion, usarAntiWindup)

    if usarAntiWindup && ~aplicarSaturacion
        error(['El anti-windup solamente tiene sentido cuando ', ...
            'se aplica saturación.']);
    end

    N = length(t);

    T1 = zeros(N,1);
    DeltaT = zeros(N,1);
    error_control = zeros(N,1);

    Q1 = zeros(N,1);
    Q_cmd = zeros(N,1);

    integral = zeros(N,1);

    % Condiciones iniciales
    T1(1) = T_amb;
    DeltaT(1) = 0;
    integral(1) = 0;

    % Número de muestras correspondiente al retardo
    N_delay = round(theta/Ts);

    % Discretización exacta del sistema de primer orden
    a = exp(-Ts/tau);
    b = K*(1-a);

    for k = 1:N

        % Error de control en temperatura absoluta
        error_control(k) = T_ref - T1(k);

        % Salida solicitada por el PI
        Q_cmd(k) = ...
            Kp*error_control(k) + integral(k);

        % Aplicación opcional de la saturación física
        if aplicarSaturacion

            Q1(k) = min(max( ...
                Q_cmd(k), Q_min), Q_max);

        else

            % Caso ideal: se aplica exactamente lo solicitado
            Q1(k) = Q_cmd(k);
        end

        if k < N

            % Actualización del integrador
            detener_integrador = false;

            if aplicarSaturacion && usarAntiWindup

                saturacion_superior = ...
                    Q_cmd(k) >= Q_max && ...
                    error_control(k) > 0;

                saturacion_inferior = ...
                    Q_cmd(k) <= Q_min && ...
                    error_control(k) < 0;

                detener_integrador = ...
                    saturacion_superior || ...
                    saturacion_inferior;
            end

            if detener_integrador

                % Clamping: se conserva el valor del integrador
                integral(k+1) = integral(k);

            else

                integral(k+1) = integral(k) + ...
                    Ki*Ts*error_control(k);
            end

            % Aplicación del retardo
            indice_retrasado = k - N_delay;

            if indice_retrasado >= 1
                Q_retrasada = Q1(indice_retrasado);
            else
                Q_retrasada = 0;
            end

            % Modelo discreto de primer orden
            DeltaT(k+1) = ...
                a*DeltaT(k) + b*Q_retrasada;

            T1(k+1) = T_amb + DeltaT(k+1);
        end
    end

    resultado.T1 = T1;
    resultado.DeltaT = DeltaT;
    resultado.error = error_control;
    resultado.Q1 = Q1;
    resultado.Q_cmd = Q_cmd;
    resultado.integral = integral;
end

function metricas = calcularMetricas( ...
    resultado, t, Ts, T_ref, T_amb, Q_min, Q_max)

    DeltaT_ref = T_ref - T_amb;

    % stepinfo recibe la variación respecto a la temperatura ambiente.
    info = stepinfo( ...
        resultado.DeltaT, ...
        t, ...
        DeltaT_ref, ...
        'SettlingTimeThreshold', 0.02);

    % Error estacionario promedio durante los últimos 60 segundos
    muestras_finales = min(round(60/Ts), length(t));

    indices_finales = ...
        length(t)-muestras_finales+1:length(t);

    error_estacionario = ...
        T_ref - mean(resultado.T1(indices_finales));

    % Intervalos en los que el PI solicita una potencia fuera
    % de los límites físicos.
    comando_fuera_limites = ...
        resultado.Q_cmd > Q_max | ...
        resultado.Q_cmd < Q_min;

    tiempo_fuera_limites = ...
        sum(comando_fuera_limites(1:end-1))*Ts;

    metricas.RiseTime = info.RiseTime;
    metricas.SettlingTime = info.SettlingTime;
    metricas.Overshoot = info.Overshoot;

    metricas.ErrorEstacionario = ...
        error_estacionario;

    metricas.TemperaturaMaxima = ...
        max(resultado.T1);

    metricas.PotenciaMinima = ...
        min(resultado.Q1);

    metricas.PotenciaMaxima = ...
        max(resultado.Q1);

    metricas.TiempoFueraLimites = ...
        tiempo_fuera_limites;
end

function mostrarMetricas(metricas)

    fprintf('Tiempo de subida:               %.2f s\n', ...
        metricas.RiseTime);

    fprintf('Tiempo de establecimiento:      %.2f s\n', ...
        metricas.SettlingTime);

    fprintf('Sobreimpulso:                    %.2f %%\n', ...
        metricas.Overshoot);

    fprintf('Error estacionario:              %.4f °C\n', ...
        metricas.ErrorEstacionario);

    fprintf('Temperatura máxima:              %.2f °C\n', ...
        metricas.TemperaturaMaxima);

    fprintf('Potencia mínima aplicada:        %.2f %%\n', ...
        metricas.PotenciaMinima);

    fprintf('Potencia máxima aplicada:        %.2f %%\n', ...
        metricas.PotenciaMaxima);

    fprintf('Tiempo con Q_cmd fuera de rango: %.2f s\n', ...
        metricas.TiempoFueraLimites);
end