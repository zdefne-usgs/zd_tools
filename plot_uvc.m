function [ur vr]=plot_uvc(url, timestamp, lyr, uname, vname, scl)
% quiver plot for vector fields in ROMS and COAWST. Now with pcolor
% backgrpund map!
%
% [ur vr]=plot_uvc(url, timestamp, lyr, uname, vname, scl)
% 
% This tool requires NCTOOLBOX toolbox to work properly. See
% https://github.com/nctoolbox/nctoolbox
% 
% url: address to your netcdf file. Can be local or asn ncml.
% timestamp: time stamp of the snapshot
% lyr: layer 
% uname: name of the u variable. Default is u.
% vname: name of the v variable. Default is v.
% scl: alue to use to scale the vector plot. Default is 1.
% 
% October 2018
% Zafer Defne

if nargin < 1
    url = 'http://geoport.whoi.edu/thredds/dodsC/sand/usgs/Projects/BBLEH/run071tRX/00_dir_roms.ncml'
    timestamp=datenum(2012,10,30,0,0,0);
    lyr=1;
end
if nargin <6
    scl =1;
end
if nargin <4
    uname='u';
    vname='v';
end

nc=ncgeodataset(url);
lon=nc{'lon_rho'}(:);
m=nc{'mask_rho'}(:);
lat=nc{'lat_rho'}(:);
lat(m==0)=nan;
lon(m==0)=nan;
t=nc.time('ocean_time');

metau=nc{uname};
unts=metau.attribute('units');

ti=near(t,timestamp);
tie=ti;
if lyr==-1
    u=squeeze(nc{uname}(ti:tie,:,:));
    v=squeeze(nc{vname}(ti:tie,:,:));
else
    u=squeeze(nc{uname}(ti:tie,lyr,:,:));
    v=squeeze(nc{vname}(ti:tie,lyr,:,:));
end
urho=nanmean(cat(3,u(2:end-1,2:end), u(2:end-1,1:end-1)),3);
vrho=nanmean(cat(3,v(2:end,2:end-1), v(1:end-1,2:end-1)),3);

urho(isnan(urho))=0;
vrho(isnan(vrho))=0;

% z=squeeze(nc{'zeta'}(ti:tie,2:end-1,2:end-1));

%angles to rotate
a=nc{'angle'}(2:end-1,2:end-1);

%% rotate
ur=urho.*cos(a)-vrho.*sin(a);
vr=vrho.*cos(a)+urho.*sin(a);

vel=abs(ur+sqrt(-1)*vr);
pcolor(lon(2:end-1,2:end-1),lat(2:end-1,2:end-1),vel);
shading flat
colorbar
hold on

quiver(lon(2:end-1,2:end-1), lat(2:end-1,2:end-1), ur, vr, scl, 'color', 'k')
axis equal
title({sprintf('Vector plot for %s, %s',uname,vname); sprintf('Layer: %d, Date: %s', lyr, datestr(t(ti))); unts},...
    'interpreter', 'none')

