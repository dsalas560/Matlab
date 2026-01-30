% Given time of week (t) in seconds
t = 304218;

% Load ephemeris parameters (replace with your actual parameters)
load('ephemeris_PRN06_2227_302400.mat');

% Constants
mu = 3.986005e14; % Earth's gravitational constant (m^3/s^2)

% Compute GPS system time (seconds)
time_gps = eph.toe + t;

% Compute elapsed time since ephemeris reference epoch
dt = time_gps - eph.toe;

% Correct for week crossover
if dt > 302400
    dt = dt - 604800;
elseif dt < -302400
    dt = dt + 604800;
end

% Compute mean motion (n)
n0 = sqrt(mu / eph.sqrtA^6);
n = n0 + eph.deltaN;

% Compute mean anomaly (M)
M = eph.Mo + n * dt;

% Compute eccentric anomaly (E) using iterative method
E = M;
for i = 1:10
    E = M + eph.eccentricity * sin(E);
end

% Compute true anomaly (v)
v = atan2(sqrt(1 - eph.eccentricity^2) * sin(E), cos(E) - eph.eccentricity);

% Compute argument of latitude (u)
u = v + eph.omega;

% Compute radius in orbital plane (r)
r = eph.sqrtA^2 * (1 - eph.eccentricity * cos(E));

% Compute satellite coordinates in orbital plane (x', y')
x_orbital = r * cos(u);
y_orbital = r * sin(u);

% Rotate satellite coordinates from orbital plane to ECEF coordinates
x = x_orbital * cos(eph.OMEGA0 ) - y_orbital * cos(eph.i0) * sin(eph.OMEGA0);
y = x_orbital * sin(eph.OMEGA0 ) + y_orbital * cos(eph.i0) * cos(eph.OMEGA0);
z = y_orbital * sin(eph.i0);


fprintf('SV ECEF Position at time t = %d seconds:\n', t);
fprintf('X: %.2f meters\n', x);
fprintf('Y: %.2f meters\n', y);
fprintf('Z: %.2f meters\n', z);
