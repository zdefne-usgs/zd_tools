function [ur, vr]=plot_uvcm(url, timestamp, elev, uname, vname, scl);
% quiver plot for vector fields in ROMS and COAWST. Now with pcolor
% backgrpund map!
%
% [ur vr]=PLOT_UVCM(url, timestamp, elev, uname, vname, scl)
% 
% This tool requires NCTOOLBOX toolbox to work properly. See
% https://github.com/nctoolbox/nctoolbox
% 
% url: address to your netcdf file. Can be local or asn ncml.
% timestamp: time stamp of the snapshot
% elev: elev in meters, z-axis positive up from the still water level (negative of depth h in ROMS output)
% uname: name of the u variable. Default is u.
% vname: name of the v variable. Default is v.
% scl: value to use to scale the vector plot. Default is 1.
% 
% October 2018
% Zafer Defne
tic
if nargin < 1
    url = 'http://geoport.whoi.edu/thredds/dodsC/sand/usgs/Projects/BBLEH/run071tRX/00_dir_roms.ncml'
    timestamp=datenum(2012,10,30,0,0,0);
    elev=-5;
end
if nargin <6
    scl =1;
end
if nargin <4
    uname='u';
    vname='v';
end

nc=ncgeodataset(url);
lon_rho=nc{'lon_rho'}(:);
lat_rho=nc{'lat_rho'}(:);
lon_u=nc{'lon_u'}(:);
lon_v=nc{'lon_v'}(:);
m=nc{'mask_rho'}(:);
h=nc{'h'}(:);
s_rho=nc{'s_rho'}(:);
lyr=nan*m;
for eta=1:size(lon_rho,1)
    for xi=1:size(lon_rho,2)
        lyr(eta,xi)=near(h(eta,xi).*s_rho, elev);
    end
end
m_elev=m;
m_elev(-h> elev)=nan;
   

lat_rho(m==0)=nan;
lon_rho(m==0)=nan;


time1=[];
time2=[];
try 
    time1=nc.time('ocean_time');
catch err
    disp(['ocean_time : ' err.message])
end
try 
    time2=nc.time('time');
catch err
    disp(['time : ' err.message])
end

if length(time1) >= length(time2)
    t=time1;
elseif length(time1) < length(time2)
    t=time2;
else
    disp('Problem with locating time dimension')
end

metau=nc{uname};
unts=metau.attribute('units');

ti=near(t,timestamp);
tie=ti;
u=nan*lon_u;
v=nan*lon_v;

uk=nan([length(s_rho) size(lon_u, 1) size(lon_u, 2)]);
vk=nan([length(s_rho) size(lon_v, 1) size(lon_v, 2)]);
for k=1:length(s_rho)
    uk(k,:,:)=squeeze(nc{uname}(ti:tie,k,:,:));
    vk(k,:,:)=squeeze(nc{vname}(ti:tie,k,:,:));
end

for eta=1:size(lon_u,1)
    for xi=1:size(lon_u,2)
        u(eta,xi)=squeeze(uk(lyr(eta,xi),eta,xi));
    end
end
for eta=1:size(lon_v,1)
    for xi=1:size(lon_v,2)
        v(eta,xi)=squeeze(vk(lyr(eta,xi),eta,xi));
    end
end

urho=nanmean(cat(3,u(2:end-1,2:end), u(2:end-1,1:end-1)),3).*m_elev(2:end-1,2:end-1);
vrho=nanmean(cat(3,v(2:end,2:end-1), v(1:end-1,2:end-1)),3).*m_elev(2:end-1,2:end-1);
vel=double(abs(urho+sqrt(-1)*vrho));

pcolor(lon_rho(2:end-1,2:end-1),lat_rho(2:end-1,2:end-1),vel);
shading flat
colorbar
hold on

urho(isnan(urho))=0;
vrho(isnan(vrho))=0;

% z=squeeze(nc{'zeta'}(ti:tie,2:end-1,2:end-1));

%angles to rotate
a=nc{'angle'}(2:end-1,2:end-1);

%% rotate
ur=urho.*cos(a)-vrho.*sin(a);
vr=vrho.*cos(a)+urho.*sin(a);


quiver(lon_rho(2:end-1,2:end-1), lat_rho(2:end-1,2:end-1), ur, vr, scl, 'color', 'k');
axis equal
title({sprintf('Vector plot for %s, %s',uname,vname); sprintf('Depth: %.1f meters, Date: %s', elev, datestr(t(ti))); unts},...
    'interpreter', 'none');
toc
