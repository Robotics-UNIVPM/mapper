clear all
clc

number = 2000;

t = tcpclient('192.168.10.11', 23);
enc_l = zeros(number,1);
enc_r = zeros(number,1);
tempo = zeros(number,1);

for i = 2:number
    enc_l(i) = read(t, 1, 'int32');
    enc_r(i) = read(t, 1, 'int32');
    tempo(i) = read(t, 1, 'int32');
end

R = 4.1; % raggio ruota, cm
L = 15.2; % distanza ruote, cm
N = 720; % numero passi encoder

const = 2*pi*R / N; % distanza percorsa corrispondente a un passo di encoder

enc_l = cast(enc_l, 'double');
enc_r = cast(enc_r, 'double');

dist_l = enc_l * const;
dist_r = enc_r * const;

theta = (dist_r - dist_l)/L;

% Calcolo traiettoria effettiva
distX(1, 1) = 0;
distY(1, 1) = 0;
for k = 2:number
    distX(k, 1) = distX(k-1) + (dist_l(k) + dist_r(k) - dist_l(k-1) - dist_r(k-1))*cos(theta(k))/2;

    distY(k, 1) = distY(k-1) + (dist_l(k) + dist_r(k) - dist_l(k-1) - dist_r(k-1))*sin(theta(k))/2;
end


distanza = [distX, distY];
encoder = [enc_l, enc_r];

clear t;
