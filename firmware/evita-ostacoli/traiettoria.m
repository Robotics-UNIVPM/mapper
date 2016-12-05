clear all
clc 

byte = 16;
number = 800;
package = byte*number;

t = tcpclient('192.168.10.11', 23);
data = read(t, package, 'int32');
data = reshape(data, [4,package/4]);
data = data';

R = 4.1; % raggio ruota, cm
L = 15.2; % distanza ruote, cm
N = 720; % numero passi encoder

const = 2*pi*R / N; % costante distanza encoder

enc_l = cast(data(:,1), 'double');
enc_r = cast(data(:,2), 'double');
tempo = data(:,3);
sonar = data(:, 4);
t = tempo/1000 ;          % secondi
t = t - t(1,1);           % tolgo t0, così si parte da zero

dist_l = enc_l * const;
dist_r = enc_r * const;

theta = (dist_r - dist_l)/L;

% Calcolo distanza effettiva
distX(1, 1) = 0;
for k = 2:length(dist_l)
    distX(k, 1) = distX(k-1) + (dist_l(k) + dist_r(k) - dist_l(k-1) - dist_r(k-1))*cos(theta(k))/2;
end

distY(1, 1) = 0;
for k = 2:length(dist_l)
    distY(k, 1) = distY(k-1) + (dist_l(k) + dist_r(k) - dist_l(k-1) - dist_r(k-1))*sin(theta(k))/2;
end


distanza = [distX, distY, t];
encoder = [enc_l, enc_r];
