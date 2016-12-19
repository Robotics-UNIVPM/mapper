clear all
clc

n = 2000; %numero di campioni da prendere

ID_1 = 65;      %'A'
ID_2 = 66;      %'B'
ID_END = 90;    %'Z'

piano    = animatedline('MarkerSize', 2, 'MarkerEdgeColor','r', 'Marker', 'o');
badpiano = animatedline('MarkerSize', 2, 'MarkerEdgeColor','g', 'Marker', 'o');

arduino = tcpclient('192.168.10.11', 23); 

D = 8.2; % diametro ruota, [cm]
L = 15.2; % distanza ruote, [cm]
N = 720; % numero passi encoder [#]
K = pi * D / N; % distanza percorsa corrispondente a un passo di encoder, [cm]

cnt = zeros(n,2); % passi encoder [#]
sonar = zeros(n,1);
t = zeros(n,1); % tempo dall'avvio del programma [ms]

l = zeros(n,1); % distanza misurata sulla ruota sx [cm]
r = zeros(n,1); % distanza misurata sulla ruota dx [cm]

theta = zeros(n,1); % imbardata [radianti]
x = zeros(n,1); % ascissa del robot sul piano in [cm]
y = zeros(n,1); % ordinata in [cm]

badx = zeros(n,1); % ascissa del robot sul piano in [cm]
bady = zeros(n,1); % ordinata in [cm]

x(1) = 0;
y(1) = 0;

chk1 = 0;

for k = 1:n

  % CONTROLLO header ----------------------------------
  chk2 = 0;
  while chk2 ~= ID_2
    if chk2 == ID_1
      chk1 = chk2;
    end
    while chk1 ~= ID_1
      chk1 = read(arduino, 1, 'uint8');
    end
    chk1 = 0;
    chk2 = read(arduino, 1, 'uint8');
  end
  % LEGGERE TUTTI i dati del pacchetto qui di seguito: ----

  cnt(k,:) = read(arduino, 2, 'int32');
  sonar(k) = read(arduino, 1, 'uint8');
  t(k) = read(arduino, 1, 'uint32');

  % CONTROLLO chiusura -----------------------------------
  chkEnd = read(arduino, 1, 'uint8');
  if chkEnd ~= ID_END
    chk1 = chkEnd;
    disp('bad packet');
    k = k - 1;
    continue
  end
  % USARE i dati letti solo da qua in poi -----------------

  l(k) = K * cnt(k,1);
  r(k) = K * cnt(k,2);

  theta(k) = (r(k)-l(k))/L;

  if k == 1
    continue
  end

  arco = ( r(k)-r(k-1) + l(k)-l(k-1) ) / 2; % lunghezza arco percorso [cm]
  deltatheta = theta(k)-theta(k-1); % ampiezza arco percorso [rad]

  if deltatheta == 0
    corda = arco; % spostamento lineare [cm]
  else
    raggio = arco / deltatheta; % raggio di curvatura [cm]
    corda = 2 * raggio * sin(deltatheta/2); % spostamento lineare [cm]
    % (teorema della corda)
  end

  alpha = (theta(k) + theta(k-1)) / 2; % direzione corda [rad]

  x(k)    = x(k-1)    + corda*cos(alpha);
  y(k)    = y(k-1)    + corda*sin(alpha);

  badx(k) = badx(k-1) + arco*cos(theta(k));

  bady(k) = bady(k-1) + arco*sin(theta(k));

  if ~ishghandle(piano)
    disp('figure closed')
    break
  end

  addpoints(piano, x(k), y(k));
  addpoints(badpiano, badx(k), bady(k));

  %per risparmiare risorse disegnamo il grafico 10 camponi alla volta
  if mod(k,10) == 0
    drawnow
  end

end

%vengono eliminate le variabili temporanee
clear arduino arco corda alpha deltatheta id k;
clear ID_1 ID_2 ID_END chk1 chk2 chkEnd;
