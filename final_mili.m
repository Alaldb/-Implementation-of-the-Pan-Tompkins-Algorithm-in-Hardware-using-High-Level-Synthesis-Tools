%% Script para detectar picos en mit200 usando procesamiento muestra a muestra

clear all; clc; close all;

%---- Cargar señal ----

load('mili.mat')
x_in = x_in/2048*10 - 5;
fs = 360;
N = length(x_in);
t = (0:N-1)/fs;

%---- Inicialización ----
det = [];    % índices de picos detectados
lost = [];   % índices de picos perdidos

%---- Procesamiento muestra a muestra ----
for n = 1:N
    [idx, lost_idx] = pt(x_in(n), fs);

    if idx > 0
        det(end+1) = idx;
    end
    if lost_idx > 0
        lost(end+1) = lost_idx;
    end
end

%---- Plot ----
figure;
plot(t, x_in, 'b'); hold on;
plot(t(det), x_in(det), 'ro', 'MarkerFaceColor', 'r');    % picos detectados
plot(t(lost), x_in(lost), 'kx', 'MarkerFaceColor', 'k');  % picos perdidos
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Detección de picos en ECG (mit200)');
legend('ECG', 'Picos detectados', 'Picos perdidos');
grid on;