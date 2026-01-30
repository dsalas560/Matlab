function M1 = ECEF2ENU(lla)
lat = lla(:,1);
long = lla(:,2);
M = [-sin(long) cos(long) 0; ...
-cos(long).*sin(lat) -sin(long).*sin(lat) cos(lat); ...
cos(long).*cos(lat) sin(long).*cos(lat) sin(lat)];
M1 = M';




North = M1(:,2);


disp (North);
%x = (-cos(long).*sin(lat));
%y = (-sin(long).*sin(lat));
%z = cos(lat);

%x = (-sin(long) * (-cos(long).*sin(lat)) * cos(long).*cos(lat));
%y = (cos(long) * (-sin(long).*sin(lat)) * sin(long).*cos(lat));
%z = (0 * cos(lat) * sin(lat));

%disp(x);
%disp(y);%is this what is due North?
%disp(z);



% 
% SVpos = SVpos(:,:,1);
% user_pos = [33.8822 -117.8828 150];
% 
% LOS = SVpos - repmat(user_pos,[32,1]);
% 
% LOS1 = LOS';
% 
% los = LOS1 * M1




% SVpos = SVpos(:,:,1);
% user_pos = [33.8822 -117.8828 150];
% 
% LOS = SVpos - repmat(user_pos,[32,1]);





% los = LOS * M1;
% 
% dis(los);

%  LOS2ENU;
% 
%     function Los1 = LOS2ENU(LOS1)
%      
%  % los = LOS1(:,:,1); 
%          
%  Los1 = M1 * LOS1;
% 
%  disp ('Line of sight vectors ENU');
%  disp(Los1);
%  
%      end

 

%user = [33.8822 -117.8828 150]


