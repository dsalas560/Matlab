%% function LLH2ECEF
%
% This function maps lat-long-height coordinates to ECEF using WGS-84
%
% Inputs: Nx3 matrix
% columns: 1-latitude (deg)
% 2-longitude (deg)
% 3-height (m)
%
% Outputs: Nx3 matrix of corresponding ECEF coordinates
% columns: 1-x, 2-y, 3-z
%
% Example:
%
% llh = [33 -117 100].*[pi/180 pi/180 1]
% xyz = LLH2ECEF(llh)
%
% xyz =
%
% -2430918.75919308 -4770946.69482189 3454013.10503955
%
%%
function xyz = LLH2ECEF(llh)
% Equatorial radius (semimajor axis of earth ellipsoid)
a = 6378137;
% Polar radius (semiminor axis)
b = 6356752.3142;
a2 = a*a;
b2 = b*b;
% Eccentricity squared
e2 = 1-b2/a2;
% column 1 is latitude (rad)
lat = llh(:,1);
% column 2 is longitude (rad)
long = llh(:,2);
% column 3 is height (m)
h = llh(:,3);
% cosines and sines
coslat = cos(lat);
coslong = cos(long);
sinlat = sin(lat);
sinlong = sin(long);
% distance of point on ellipsoid to earth center of mass
n = a./sqrt(1 - e2.*sinlat.*sinlat);
% x
xyz(:,1) = (n + h).*coslat.*coslong;
% y
xyz(:,2) = (n + h).*coslat.*sinlong;
% z
xyz(:,3) = (n*b2/a2 + h).*sinlat;
