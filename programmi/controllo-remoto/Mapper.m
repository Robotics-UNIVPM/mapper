classdef Mapper < handle

	properties
		socket
	end
	properties (Constant)
	ID_1 = 65;      %'A'
	ID_2 = 66;      %'B'
	ID_END = 90;    %'Z'
	ID_CMD = uint8(66); %'B'
	end

	methods

		function obj = Mapper(ip)
			obj.socket = tcpclient(ip, 23, 'Timeout', 600);
		end

		function drive(obj,left,right)
			obj.socket.write(obj.ID_CMD);
			obj.socket.write(int16(left));
			obj.socket.write(int16(right));
		end

		function [cntl, cntr, sonar, time] = read(obj)
			chk1 = 0;
			while true
			  % CONTROLLO header ----------------------------------
			  chk2 = 0;
			  while chk2 ~= obj.ID_2
			    if chk2 == obj.ID_1
			      chk1 = chk2;
			    end
			    while chk1 ~= obj.ID_1
			      chk1 = read(obj.socket, 1, 'uint8');
			    end
			    chk1 = 0;
			    chk2 = read(obj.socket, 1, 'uint8');
			  end
			  % LEGGERE TUTTI i dati del pacchetto qui di seguito: ----

				cntl = read(obj.socket, 1, 'int32');
				cntr = read(obj.socket, 1, 'int32');
			  sonar = read(obj.socket, 1, 'uint8');
			  time   = read(obj.socket, 1, 'uint32');

			  % CONTROLLO chiusura -----------------------------------
			  chkEnd = read(obj.socket, 1, 'uint8');
			  if chkEnd ~= obj.ID_END
			    chk1 = chkEnd;
			    disp('bad packet:')
			    continue
			  end
					return
			end
		end
	end
end
