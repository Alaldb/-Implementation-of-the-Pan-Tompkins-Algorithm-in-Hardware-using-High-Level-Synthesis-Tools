clear all; clc; close all;

% Cargar señal
load mit200
fs = 360;
x  = ecgsig(:);
N  = length(x);
t  = (0:N-1)/fs;

% Vectores de salida
det  = [];
lost = [];

for n = 1:N
    [peak_valid, peak_idx, lost_valid, lost_idx] = pt_V2(x(n), fs);

    if peak_valid
        idx = peak_idx; %- LAT;
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

% Visualización
figure;
plot(t, x, 'b'); hold on;
plot(t(det),  x(det),  'ro', 'MarkerFaceColor','r');
plot(t(lost), x(lost), 'kx', 'LineWidth',1.5);
xlabel('Time [s]');
ylabel('Amplitude');
legend('ECG','Detected peaks','Picos perdidos');
grid on;
set(gca, 'FontSize', 20)

