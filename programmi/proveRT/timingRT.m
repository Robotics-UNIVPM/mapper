n = 20000; %numero di campioni da prendere

ID = 255;
id = 0;

tempo = animatedline('Color','r');
arduino = tcpclient('192.168.0.33', 23);

cnt = zeros(n,2); % passi encoder [#]
t = zeros(n,1); % tempo dall'avvio del programma [ms]

while true
    id = read(arduino, 1, 'uint8');
    if id == ID
        break
    end
    disp('bad start');
end
cnt(1,:) = read(arduino, 2, 'int32');
t(1) = read(arduino, 1, 'uint32');



for k = 2:n
  id = read(arduino, 1, 'uint8');
  if id ~= ID
      disp('bad packet');
      break
  end
  cnt(k,:) = read(arduino, 2, 'int32');
  t(k) = read(arduino, 1, 'uint32');

  addpoints(tempo, k, t(k));
  drawnow

end

clear arduino id;
