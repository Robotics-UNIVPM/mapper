delete(instrfindall)
h=animatedline;
h.MaximumNumPoints = 1000;
arduino = serial('/dev/cu.usbmodem1411');
arduino.BaudRate = 115200;
fopen(arduino);
for i=1:1000
    data = str2num(fscanf(arduino));
    h.addpoints(data(1,1)/1000,data(1,2));
    drawnow
end
fclose(arduino)
delete(arduino)
clear arduino
