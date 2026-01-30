clear all; clc; close all;

% Cargar señal
load('mili.mat')
x_in = x_in/2048*10 - 5;
fs = 360;
N = length(x_in);
t = (0:N-1)/fs;

% Vectores de salida
det  = [];
lost = [];

for n = 1:N
    [peak_valid, peak_idx, lost_valid, lost_idx] = pt_V2(x_in(n), fs);

    if peak_valid
        idx = peak_idx;%- LAT;
        if idx > 0 && idx <= N
            det(end+1) = idx;
        end
    end

    if lost_valid
        idx = lost_idx - LAT;
        if idx > 0 && idx <= N
            lost(end+1) = idx;
        end
    end
end

%Visualización
figure;
plot(t, x_in, 'b'); hold on;
plot(t(det),  x_in(det),  'ro', 'MarkerFaceColor','r');
plot(t(lost), x_in(lost), 'kx', 'LineWidth',1.5);
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Detección de picos ECG – Golden HW reference');
legend('ECG','Picos detectados','Picos perdidos');
grid on;
xlim([480 500]);