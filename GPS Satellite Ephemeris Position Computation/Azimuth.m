% Define the LOS vector in NED coordinates
LOSNED = [-4273319.92587693, -14372712.773362, -15700751.0230446];

% Calculate the azimuth angle in radians
azimuth_rad = atan2(LOSNED(2), LOSNED(1));

% Convert the azimuth angle from radians to degrees
azimuth_deg = rad2deg(azimuth_rad);

%We can also switch the angle 
if azimuth_deg < 0
    azimuth_deg = 360 + azimuth_deg;
end

% Display the azimuth angle
disp('Azimuth for PRN 27:');
disp(azimuth_deg);


%Compute Elevation 

%elvation = -asin(H)

% H = LOSNED(3);
% elevation_rad = -asin(H);
% 
% elevation_deg = rad2deg(elevation_rad);
% disp('elevation');
% disp(elevation_deg);

elevation = atan2(LOSNED(3),sqrt(LOSNED(1)^2+LOSNED(2)^2))*180/pi;


disp (elevation);