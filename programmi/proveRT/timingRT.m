grafico = animatedline('Color','r','Marker', 'o');
disp('Guarda il tempo scorrere...');
arduino = tcpclient('192.168.10.11', 23);

ID_1 = 65;      %'A'
ID_2 = 66;      %'B'
ID_END = 90;    %'Z'

k = 0; % contatore di cicli
chk1 = 0;

while ishghandle(grafico) % script termina a grafico chiuso

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

  cnt = read(arduino, 2, 'int32');
  sonar = read(arduino, 1, 'uint8');
  t = read(arduino, 1, 'uint32');

  % CONTROLLO chiusura -----------------------------------
  chkEnd = read(arduino, 1, 'uint8');
  if chkEnd ~= ID_END
    chk1 = chkEnd;
    disp('bad packet');
    continue
  end
  % USARE i dati letti solo da qua in poi -----------------

  addpoints(grafico, k, double(t));

  k = k + 1;

end

clear arduino ID_1 ID_2 ID_END chk1 chk2 chkEnd cnt t k;
