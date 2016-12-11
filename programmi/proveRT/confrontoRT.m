n = 20000; %numero di campioni da prendere

ID = 255;
id = 0;

piano = animatedline('Color','r');
badpiano = animatedline('Color','b');
arduino = tcpclient('192.168.0.33', 23);

D = 8.2; % diametro ruota, [cm]
L = 15.2; % distanza ruote, [cm]
N = 720; % numero passi encoder [#]
K = pi * D / N; % distanza percorsa corrispondente a un passo di encoder, [cm]

cnt = zeros(n,2); % passi encoder [#]
t = zeros(n,1); % tempo dall'avvio del programma [ms]

l = zeros(n,1); % distanza misurata sulla ruota sx [cm]
r = zeros(n,1); % distanza misurata sulla ruota dx [cm]

theta = zeros(n,1); % imbardata [radianti]
x = zeros(n,1); % ascissa del robot sul piano in [cm]
y = zeros(n,1); % ordinata in [cm]

badx = zeros(n,1); % ascissa del robot sul piano in [cm]
bady = zeros(n,1); % ordinata in [cm]

while true
    id = read(arduino, 1, 'uint8');
    if id == ID
        break
    end
    disp('bad start');
end
cnt(1,:) = read(arduino, 2, 'int32');
t(1) = read(arduino, 1, 'uint32');
l(1) = K * cnt(1,1);
r(1) = K * cnt(1,2);
theta(1) = (r(1)-l(1))/L;
x(1) = 0;
y(1) = 0;


for k = 2:n
  id = read(arduino, 1, 'uint8');
  if id ~= ID
      disp('bad packet');
      break
  end
  cnt(k,:) = read(arduino, 2, 'int32');
  t(k) = read(arduino, 1, 'uint32');

  l(k) = K * cnt(k,1);
  r(k) = K * cnt(k,2);

  theta(k) = (r(k)-l(k))/L;

  arco = ( r(k)-r(k-1) + l(k)-l(k-1) ) / 2; % lunghezza arco percorso [cm]
  deltatheta = theta(k)-theta(k-1); % ampiezza arco percorso [rad]

  if deltatheta == 0
    corda = arco; % spostamento lineare [cm]
  else
    raggio = arco / deltatheta; % raggio di curvatura [cm]
    corda = 2 * raggio * sin(deltatheta/2); % spostamento lineare [cm]
  end

  alpha = (theta(k) + theta(k-1)) / 2; % direzione corda [rad]

  x(k) = x(k-1) + (corda * cos(alpha));
  y(k) = y(k-1) + (corda * sin(alpha));
  
  badx(k) = badx(k-1) + arco*cos(theta(k));

  bady(k) = bady(k-1) + arco*sin(theta(k));

  addpoints(piano, x(k), y(k));
  addpoints(badpiano, badx(k), bady(k));
  drawnow

end

clear arduino arco corda alpha deltatheta id;
