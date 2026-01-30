% Given data
gpstime = 1347217218; % GPS time
Az = 90; % Azimuth
El = 45; % Elevation
llh = [33.88221, -117.88281, 0]; % Latitude, Longitude, Height
c = 2.99792458e8;


% Extract PR, SV, User, and Klobuchar data
PR_L1 = PR.L1;
PR_L2 = PR.L2;
SV_xyz = SV.xyz;
SV_vel = SV.vel;
User_xyz = User.xyz;
User_vel = User.vel;
alpha = klobuchar.alpha;
beta = klobuchar.beta;

% Azimuth in radians
Azs = Az * pi/180;


% Convert angles to semi-circles
Els = El / 180;

% Convert latitude and longitude to semi-circles
lats = llh(1) / 180;
longs = llh(2) / 180;


%Step 1
% Compute Earth-centered angle psi
psi = 0.0137 / (Els + 0.11) - 0.022; %semi



%Step 2
%Compute lat of iono pierce point

lat_i  = lats + psi*cos(Azs); %semi
if (lat_i > 0.416)
    lat_i = 0.416;
  elseif(lat_i < -0.416)
      lat_i = -0.416;
end


%Step 3
% Compute longitude of the IPP653   // note that lat_i has to bve turned
% into radians 
long_i = longs + (psi* sin(Azs))/cos(lat_i * pi); %semi


%step 4 find the geomagnetic latitude of the IPP

lat_m = lat_i + 0.064*cos((long_i-1.617)* pi); %semi

%Step 5 find the local time at the IPP 

t = 43200*long_i + 302418;
t = mod(t,86400.);                    % Seconds of day
if (t > 86400.)
    t = t - 86400.;
end
if (t < 0.)
    t = t + 86400.;
end


%step 6 compute the amplitude of the ionoshperic delay

% Amplitud of the model
amp = alpha(1) + alpha(2)*lat_m + alpha(3)*lat_m^2 +alpha(4)*lat_m^3; %seconds
if(amp < 0.)
    amp = 0.;
end

%step 7 compute the period of ionospheric delay 

 % Period of model
per = beta(1) + beta(2)*lat_m + beta(3)*lat_m^2 +beta(4)*lat_m^3; %seconds

if (per < 72000.)
    per = 72000.;
end



%Step 8 compute the phase of ionospheric delay 

%Phase of the model
phase = 2 * pi * (t-50400.)/per; %Radians


%Step 9 Compute the slant factor (Elevation in semicircles

% Compute slant factor F
F = 1 + 16 * (0.53 - (Els))^3;


%Step 10 Compute the ionospheric time delay 

if(abs(phase) > 1.57)
    Iono = F * (5.e-9);
else
    Iono = F * (5.e-9 + amp*(1 - phase^2/2 + phase^4/24));
end

disp('Ionospheric delay: ');

disp(Iono)

