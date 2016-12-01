clear all
clc

%% Carico il file csv
filename = 'five_minutes.csv';
M = csvread(filename);

%% Separo i dati
t = M(:, 1)/1000 ;          % secondi
t = t - t(1,1);             % tolgo t0 a tutti valori, così si parte dall'istante 0
AccX = M(:, 2)*9.81/1000;   % metri al secondo quadrato
AccY = M(:, 3)*9.81/1000;
AccZ = M(:, 4)*9.81/1000;
GirX = M(:, 5);             % gradi al secondo
GirY = M(:, 6);
GirZ = M(:, 7);
MagX = M(:, 8);             % milliGauss
MagY = M(:, 9);
MagZ = M(:, 10);


%% Plot dei dati, togliere il commento per visualizzarli
% plot(t, AccX)
% plot(t, AccY)
% plot(t, AccZ)
% plot(t, AccX, t, AccY, t, AccZ)
% plot(t, GirX)
% plot(t, GirY)
% plot(t, GirZ)
% plot(t, GirX, t, GirY, t, GirZ)
% plot(t, MagX)
% plot(t, MagY)
% plot(t, MagZ)
% plot(t, MagX, t, MagY, t, MagZ)


%% Calcolo velocità e spostamento, valori LONTANI dalla realtà
% Vettore dei delta_t
t1 = [t(2:end); 0];
delta_t = t1 - t;
delta_t = delta_t(1:end-1);

% Vettore velocità
VelX(1, 1) = 0;
for i = 2:length(delta_t)
    VelX(i, 1) = VelX(i-1, 1) + delta_t(i,1)*AccX(i,1);
end

% Vettore spostamento
DistX(1, 1) = 0;
for i = 2:length(delta_t)
    DistX(i, 1) = DistX(i-1,1) + VelX(i,1)*delta_t(i, 1) + delta_t(i,1)^2*AccX(i,1)/2;
end


% plot(t(1:end-1), VelX)
% plot(t(1:end-1), DistX)
