%% Script para detectar picos en mit200 usando procesamiento muestra a muestra

clear all; clc; close all;

%---- Cargar señal ----
load mit200
fs = 360;
N = length(ecgsig);
t = (0:N-1)/fs;

%---- Inicialización ----
det = [];    % índices de picos detectados
lost = [];   % índices de picos perdidos

%---- Procesamiento muestra a muestra ----
for n = 1:N
    [idx, lost_idx] = pt(ecgsig(n), fs);

    if idx > 0
        det(end+1) = idx;
    end
    if lost_idx > 0
        lost(end+1) = lost_idx;
    end
end

%---- Plot ----
figure;
plot(t, ecgsig, 'b'); hold on;
plot(t(det), ecgsig(det), 'ro', 'MarkerFaceColor', 'r');    % picos detectados
plot(t(lost), ecgsig(lost), 'kx', 'MarkerFaceColor', 'k');  % picos perdidos
xlabel('Timw [s]');
ylabel('Amplitude');
title('Detección de picos en ECG (mit200)');
legend('ECG', 'Detected peaks', 'Lost peaks');
grid on;
set(gca, 'FontSize', 20)

[picos_recuperados,picos_perdidos]=carga_datos_vivado;
picos_recuperados = double(hex2dec(picos_recuperados).');
picos_perdidos = double(hex2dec(picos_perdidos).');

picos_referencia=readlines('peak_index_expected.dat');

figure (2);
plot(t, ecgsig, 'b'); hold on;
plot(t(picos_recuperados), ecgsig(picos_recuperados), 'ro', 'MarkerFaceColor', 'r');    % picos detectados
% plot(t(picos_perdidos), ecgsig(picos_perdidos), 'kx', 'MarkerFaceColor', 'k');  % picos perdidos
xlabel('Time [s]');
ylabel('Amplitude');
legend('ECG', 'Detected peaks', 'Lost peaks');
grid on;
set(gca, 'FontSize', 20)


% %%
% 
% clear all; clc; close all;
% 
% %---- Cargar señal ----
% load mit200
% fs = 360;
% N = length(ecgsig);
% t = (0:N-1)/fs;
% 
% %---- Inicialización ----
% det = [];  % índices de picos detectados
% 
% %---- Procesamiento muestra a muestra ----
% for n = 1:N
%     idx = pt_sm(ecgsig(n), fs);  % procesar muestra
%     if idx > 0
%         det(end+1) = idx;
%     end
% end
% 
% %---- Plot ----
% figure;
% plot(t, ecgsig, 'b'); hold on;
% plot(t(det), ecgsig(det), 'ro', 'MarkerFaceColor', 'r'); % picos detectados
% xlabel('Tiempo [s]');
% ylabel('Amplitud');
% title('Detección de picos QRS en ECG (mit200)');
% legend('ECG', 'Picos detectados');
% grid on;
