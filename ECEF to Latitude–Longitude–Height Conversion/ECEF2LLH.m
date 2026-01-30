function llh = ECEF2LLH(xyz)
% Equatorial radius (semimajor axis of earth ellipsoid)
a = 6378137;
% Polar radius (semiminor axis)
b = 6356752.3142;
a2 = a*a;
b2 = b*b;
% Eccentricity squared
e2 = 1-b2/a2;
e = .08181919084;
e3 = e*e;
o = .00000015625992;
H1 = .000000000000022501018;
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);
x2 = x.^2;
y2 = y.^2;
z2 = z.^2;
w2 = x2 + y2;
l = e3./2;
m = w2./a2;
n = z * o;
n1 = n.^2;
p = (m + n - 4*l^2)/6;
m1 = m';
mn = m1 * n1;
G = mn * l.^2;
H = 2*(p.^3)+ G;
if (H > H1)
HG = sqrt(H.*G);   
  
C =  nthroot(H + G +2*HG,3);
S = nthroot (2,3);
C1= C./S;
i = ((2*1.^2) + m + n)/2;
p2 = p.^2;
B = (i./3) - C1 - (p2./C1);
l2 = l.^2;
k = l2.*(l2 - m -n);
BK = sqrt (B.^2 - k);
t = sqrt (BK - (B+i)/2);
T =abs(t);
Bi = abs (sqrt((B-i)/2));
T1 = T - sign(m-n).*(Bi);
T2 = T1.^2;
T4 = T1.^4;
T3 = T1.^3;
F = T4 + 2i.*T2 + 2*l.*(m-n).*T + k;
F1 = abs (F);
dF = 4*T3 + 4*i.*t + 2*l.*(m-n);
dF1 = abs (dF);
tdelta = -F1./dF1;
%tdelta1 = abs(tdelta);
u = T + tdelta + l;
v = T + tdelta - l;
w = sqrt(w2);
lat = atan2(z.*u,w.*v);
U = (1-1/u);
U1 =U';
wdelta = w.*U1;
E = .99330562;
%v1=v';
z1=z';
zdelta = z1.*(1-(E/v));
HS = sign(u-1);
wdelta1=wdelta';
HS1=HS';
Height = HS1.*(wdelta1 + zdelta);
long = atan2(y,x);
  
else  
   disp( "H < Hmin")
end
% distance of point on ellipsoid to earth center of mass
%n = a./sqrt(1 - e2.*sinx.*sinx);
% x
llh(:,1) = lat*(180/pi);
% y
llh(:,2) = long*(180/pi);
% z
llh(:,3) = Height;

plot(long,lat,'.');

save('llh.mat','llh');