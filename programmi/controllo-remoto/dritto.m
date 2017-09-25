n = 20000; %numero di campioni da prendere

ID_1 = 65;      %'A'
ID_2 = 66;      %'B'
ID_END = 90;    %'Z'
ID_CMD = uint8(66);

piano    = animatedline('MarkerSize', 2, 'MarkerEdgeColor','r', 'Marker', 'o');

arduino = tcpclient('192.168.0.33', 23, 'Timeout', 600);

D = 8.0735997228; % diametro ruota, [cm]
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

x(1) = 0;
y(1) = 0;


arduino.write(ID_CMD);
arduino.write(int16(255));
arduino.write(int16(255));

k = 1; %indice "dinamico"
while true
  % CONTROLLO header ----------------------------------
  chk1 = 0;
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
  t(k)=tempt;

  % Integrazione percorso -----------------------------------------------------

  if k == 1
    % il primo loop viene solo usato per impostare il punto di partenza
    k = k + 1;
    continue
  end

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

  % Rappresentazione ----------------------------------------------------------

  addpoints(piano, x(k), y(k));

  %per risparmiare risorse disegnamo il grafico pi?? campioni alla volta
  if mod(k,100) == 0
    drawnow
  end
  % --------------------------------------------------------------



  if x(k) >= 150
    arduino.write(ID_CMD); % arduino fermatiii!!!
    arduino.write(int16(0));
    arduino.write(int16(0));
  end

  if ~ishghandle(piano) % se chiudi il grafico il programma termina
    disp('figure closed')
    break
  end

  k = k + 1;
end

x=x(1:k);
y=y(1:k);

disp('Corda percorsa: ')
d = (x(k)^2+y(k)^2)^(1/2)

%vengono eliminate le variabili temporanee
clear arduino arco corda alpha deltatheta k;
clear ID_1 ID_2 ID_END ID_CMD chk1 chk2 chkEnd;
