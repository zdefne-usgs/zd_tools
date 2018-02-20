function [urho, vrho]= uv_rho(nc, lyr,ti)
% Interpolate velocities form u and v points to rho points.
%
% [urho, vrho]= uv_rho(nc, lyr,ti)
%
% nc: netcdf file (should be loaded in memory already)
% lyr: rho layer the values are at
% ti: time index
%
% 2014, October
% Zafer Defne

u=squeeze(nc{'u'}(ti,lyr,:,:));
v=squeeze(nc{'v'}(ti,lyr,:,:));
urho=nanmean(cat(3,u(2:end-1,2:end), u(2:end-1,1:end-1)),3);
vrho=nanmean(cat(3,v(2:end,2:end-1), v(1:end-1,2:end-1)),3);