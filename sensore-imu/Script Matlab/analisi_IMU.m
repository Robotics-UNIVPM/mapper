clear all
clc

filename = 'file20.csv';

M = csvread(filename);

t = M(:, 1)/1000 ;
t = t - t(1,1);
AccX = M(:, 2)*9.81/1000; % metri al secondo quadrato
AccY = M(:, 3)*9.81/1000;
AccZ = M(:, 4)*9.81/1000;
GirX = M(:, 5);
GirY = M(:, 6);
GirZ = M(:, 7);
MagX = M(:, 8);
MagY = M(:, 9);
MagZ = M(:, 10);


t1 = [t(2:end); 0];
delta_t = t1 - t;
delta_t = delta_t(1:end-1);

% Calcolo Delta Accelerazioni per usarle qui sotto al posto di AccX


VelX(1, 1) = 0;
for i = 2:length(delta_t)
    VelX(i, 1) = VelX(i-1, 1) + delta_t(i,1)*AccX(i,1);
end

DistX(1, 1) = 0;
for i = 2:length(delta_t)
    DistX(i, 1) = DistX(i-1,1) + VelX(i,1)*delta_t(i, 1) + delta_t(i,1)^2*AccX(i,1)/2;
end




% per plottare, basta fare sul terminale "plot (X1, Y1, X2, Y2, ...)"
% ovviamente i valori sono accoppiati