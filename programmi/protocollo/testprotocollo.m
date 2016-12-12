%Per testare collegarsi in telnet localmente
% 'telnet 127.0.0.1 2300'

t = tcpip('127.0.0.1', 2300, 'NetworkRole', 'server');
fopen(t);

ID_1 = 65;      %'A'
ID_2 = 66;      %'B'
ID_END = 90;    %'Z'



x2 = 0;
x1 = 0;
data = [];
for i = 1:100
    while x2 ~= ID_2
        x1 = x2;
        while x1 ~= ID_1
            x1 = fread(t, 1, 'uint8');
        end
        x1 = 0;
        x2 = fread(t, 1, 'uint8');
    end
    x2 = 0;

    var = fread(t,1,'uint8');

    check2 = fread(t, 1, 'uint8');
    if check2 ~= ID_END
        x1 = check2;
        continue
    end

    disp(var);


end
