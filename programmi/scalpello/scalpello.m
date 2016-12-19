function scalpello(map, x,y,theta, rho)
    R = double(2*map.Resolution);
    FOV = 15*pi/180;
    nraggi = int32(R*rho*FOV-1);
    npunti = int32(R*rho);

    punti = zeros(nraggi*npunti,2);

    for i = 1:nraggi
        for k = 1: npunti
            d = double(k)/R;
            gamma = theta-FOV/2+(double(i)+1/2)/(R*rho);

            punti((i-1)*npunti+k,1) = x + d*cos(gamma);
            punti((i-1)*npunti+k,2) = y + d*sin(gamma);
        end
    end
    map.setOccupancy(punti, 0);
    %hold on
    %show(map)
    %hold on
    %scatter(punti(:,1),punti(:,2));


end
