clear all;
close all;

load ephemeris_PRN06_2227_302400.mat;
tow_range = 304214:304218;
position = zeros(length(tow_range), 3);
velocity = zeros(length(tow_range)-1, 3);

for i = 1:length(tow_range)
    tow = tow_range(i);


mu = 3.986005e14;
OmegadotE = 7.2921151467e-5;

A = eph.sqrtA^2;
n0 = sqrt(mu/A^3);

tk = tow-eph.toe;
n = n0+eph.deltaN;
Mk = eph.Mo + n*tk;

E = Mk;
Eold = 0;
while max(abs(E-Eold)) > 1e-10
    Eold = E;
    E = E + (Mk-E + eph.eccentricity*sin(E))./(1-eph.eccentricity*cos(E));
end

vk = 2*atan(sqrt((1+eph.eccentricity)/(1-eph.eccentricity))*tan(E/2));

Phik = vk + eph.omega;

delta_uk = eph.Cus*sin(2*Phik) + eph.Cuc*cos(2*Phik);
delta_rk = eph.Crs*sin(2*Phik) + eph.Crc*cos(2*Phik);
delta_ik = eph.Cis*sin(2*Phik) + eph.Cic*cos(2*Phik);

uk = Phik + delta_uk;
rk = A*(1 - eph.eccentricity*cos(E)) + delta_rk;
ik = eph.i0 + delta_ik + eph.IDOT*tk;

xkp = rk.*cos(uk);
ykp = rk.*sin(uk);

Omegak = eph.OMEGA0 + (eph.OMEGAdot - OmegadotE)*tk - OmegadotE*eph.toe;

xyz = [xkp.*cos(Omegak) - ykp.*cos(ik).*sin(Omegak), xkp.*sin(Omegak) + ykp.*cos(ik).*cos(Omegak), ykp.*sin(ik)];

position(i, :) = xyz;

 % Compute velocity for times 304214 through 304217
    if i > 1

% Velocity Computation
Ek = E;

% Eccentric Anomaly Rate
Ek_dot = n ./ (1 - eph.eccentricity * cos(Ek));
% True Anomaly Rate
vk_dot = Ek_dot .* sqrt(1 - eph.eccentricity^2) ./ (1 - eph.eccentricity * cos(Ek));
% Corrected Inclination Angle Rate
dik_dt = eph.IDOT + 2 * vk_dot .* (eph.Cis * cos(2 * Phik) - eph.Cic * sin(2 * Phik));
% Corrected Argument of Latitude Rate
uk_dot = vk_dot + 2 * vk_dot .* (eph.Cus * cos(2 * Phik) - eph.Cuc * sin(2 * Phik));
% Corrected Radius Rate
rk_dot = eph.eccentricity * A * Ek_dot .* sin(Ek) + 2 * vk_dot .* (eph.Crs * cos(2 * Phik) - eph.Crc * sin(2 * Phik));
% Longitude of Ascending Node Rate
Omegak_dot = eph.OMEGA0 - OmegadotE;
% In-plane velocity components
xk_dotprime = rk_dot .* cos(uk) - rk .* uk_dot .* sin(uk);
yk_dotprime = rk_dot .* sin(uk) + rk .* uk_dot .* cos(uk);
% Earth-fixed velocity components
xk_dot = -xkp .*Omegak_dot* sin(Omegak) + xk_dotprime.* cos(Omegak)- yk_dotprime .* sin(Omegak).* cos(ik) - ykp .*(Omegak_dot* cos(Omegak)* cos(ik) - dik_dt .* sin(Omegak) * sin(ik));
yk_dot = xkp .*Omegak_dot* cos(Omegak) + xk_dotprime.* sin(Omegak)+ yk_dotprime .* cos(Omegak).* cos(ik) - ykp .*(Omegak_dot* sin(Omegak)* cos(ik) + dik_dt .* cos(Omegak) * sin(ik));
zk = yk_dotprime .* sin(ik) + ykp .*dik_dt* cos(ik);

velocity(i-1, :) = [xk_dot, yk_dot, zk];
    end
end

% Compute delta position for times 304214 through 304218
delta_position = diff(position);

disp('Delta Position (Latitude, Longitude, Altitude):');
disp(delta_position);
disp('Velocity (Vx, Vy, Vz):');
disp(velocity);
