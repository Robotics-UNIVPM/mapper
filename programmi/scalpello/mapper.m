n = 20000; %numero di campioni da prendere

ID_1 = 65;      %'A'
ID_2 = 66;      %'B'
ID_END = 90;    %'Z'
ID_CMD = uint8(66);


arduino = tcpclient('192.168.0.33', 23, 'Timeout', 600);

map = robotics.BinaryOccupancyGrid(ones(100,100),0.5);
map.GridLocationInWorld = [-25,-100];
show(map)
hold on
traiettoria = animatedline('MarkerSize', 2, 'MarkerEdgeColor','r', 'Marker', 'o');


D = 6.2; %8.0735997228; % diametro ruota, [cm]
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

chk1 = 0;
k = 1; %indice "dinamico"
while true
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

  tempcnt = read(arduino, 2, 'int32');
  tempsonar = read(arduino, 1, 'uint8');
  tempt   = read(arduino, 1, 'uint32');

  % CONTROLLO chiusura -----------------------------------
  chkEnd = read(arduino, 1, 'uint8');
  if chkEnd ~= ID_END
    chk1 = chkEnd;
    disp('bad packet:');
    tempcnt = [-1, -1];
    tempt = -1;
    continue
  end
  % USARE i dati letti solo da qua in poi -----------------

  cnt(k,:)=tempcnt;
  sonar(k) = tempsonar;
  if sonar(k) == 0
    sonar(k) = 30;
  end

  t(k)=tempt;
  
  if k == 1
    % il primo loop viene solo usato per impostare il punto di partenza
    x(1) = 0;
    y(1) = 0;
    k = k + 1;
    continue
  end

  % Integrazione percorso -----------------------------------------------------

  cnt(k,:) = cnt(k,:) - cnt(1,:);

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
    % (teorema della corda)
  end

  alpha = (theta(k) + theta(k-1)) / 2; % direzione corda [rad]

  x(k) = x(k-1) + corda*cos(alpha);
  y(k) = y(k-1) + corda*sin(alpha);
  % ---------------------------------------------------------------------------

  if sonar(k) ~= 255
    scalpello(map,x(k),y(k),theta(k),sonar(k));
  end


  % Rappresentazione ----------------------------------------------------------
  addpoints(traiettoria, x(k), y(k));


  %per risparmiare risorse disegnamo il grafico pi? campioni alla volta
  if mod(k,100) == 0
    show(map)
    drawnow 
    uistack(traiettoria, 'top')

  end
  % --------------------------------------------------------------

  if ~ishghandle(traiettoria) % se chiudi il grafico il programma termina
    disp('figure closed')
    break
  end

  k = k + 1;
end

x=x(1:k);
y=y(1:k);
sonar=sonar(1:k);


%vengono eliminate le variabili temporanee
clear arduino arco corda alpha deltatheta k;
clear ID_1 ID_2 ID_END ID_CMD chk1 chk2 chkEnd;
