SVpos = SVpos(:,:,1);
user_pos = [33.8822 -117.8828 150];

LOS = SVpos - repmat(user_pos,[32,1]);

LOS1 = LOS';



LOS2 = ans * LOS1;

LOS3 = LOS2';

disp ('line of sight vectors')

disp (LOS3);


elevations = atan2d(LOS2(3,:), sqrt(LOS2(1,:).^2 + LOS2(2,:).^2));

above = sum(elevations > 0);

disp ('number above 0 degrees');
disp (above);


above1 = LOS2(:, elevations > 0);

H = above1';

GDOP = sqrt(trace(inv(H' * H)));
PDOP = sqrt(trace(inv(H(:,1:3)' * H(:,1:3))));
HDOP = sqrt(trace(inv(H(:,1:2)' * H(:,1:2))));
VDOP = sqrt(trace(inv(H(:,3)' * H(:,3))));
TDOP = sqrt(trace(inv(H(:,4:end)' * H(:,4:end))));


disp ('THIS IS GDOP');
disp (GDOP);
disp ('THIS IS PDOP');
disp (PDOP);
disp ('THIS IS HDOP');
disp (HDOP);
disp ('THIS IS VDOP');
disp (VDOP);
disp ('THIS IS TDOP');
disp (TDOP);

%{
function V = LLH2ENU(LOS)
lat = LOS(:,1);
long = L
V = [-sin(long) cos(lOS(:,2);ong) 0; ...
-cos(long).*sin(lat) -sin(long).*sin(lat) cos(lat); ...
cos(long).*cos(lat) sin(long).*cos(lat) sin(lat)];
end
%}

%los = LOS1 * M1;
%disp (LOS);
% 
% lat = LOS(:,1);
% long = LOS(:,2);
%   
% M = [-sin(long) cos(long) 0; ...
% -cos(long).*sin(lat) -sin(long).*sin(lat) cos(lat); ...
% cos(long).*cos(lat) sin(long).*c
% os(lat) sin(lat)];
% 
% M1 = M';