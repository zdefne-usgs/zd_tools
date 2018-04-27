function s=ncw(varargin)
% A netcdf viewer with ROMS in mind. 
%
% s=NCW(nc, ptype, vname, tind, lyr, eta, xi);
% s: structure conatining the answer
% q.val: variable's values 
% q.vname: variable's name
% q.lyr: layer
% q.t: time
%     
% nc: Netcdf object. e.g. Using NCTOOLBOX for Matlab:
%     nc=ncgeodataset(netcdf_file.nc)
%     nc=ncgeodataset(url_to_netcdf_file.ncml)
% ptype: Plot type based on number of dimensions of the variable. Append "m" if masking.
% e.g. '1d', '2d', '3d', '4d' or '2dm', '3dm', '4dm'.
% vname: name of the variable
% tind: time steps (for 3-D and 4-D data)
% lyr: vertical layers (for 3-D and 4-D data)
% eta: eta points (optional for 3-D and 4-D data, required for 1-D)
% xi: xi points (optional for 3-D and 4-D data, required for 1-D)
%
% WITHOUT mask option:
%   s=ncw(nc, '4d', 'temp', eta1, xi1);
%   s=ncw(nc, '3d', 'zeta', ti1);
%   s=ncw(nc, '2d', 'h');
% 1D salinity time series for time steps ti1 to ti2 at lyr1
%   s=ncw(nc, '1d', 'salt', ti1:ti2, lyr1, eta1, xi1);
% Data is 2D (1 layer) hence lyr=[];
%   s=ncw(nc, '1d', 'zeta', ti1:ti2, [], eta1, xi1);
% plot the full time series
%   s=ncw(nc, '1d', 'Dwave', :, 220, 155);
%
% WITH masking option. '4dm' instead of '4d':
%   s=ncw(nc, '4dm', 'salt', ti1, 3, eta1:eta2, xi1:xi2);
% Slice or vertical profile. '4dp' instead of '4d', slice at xi1:
%   s=ncw(nc, '4dp', 'salt', ti1, lyr1:lyr2, eta1:eta2, xi1);
%
% 2014, October
% Zafer Defne
% --------------------------------------------------------------------
% Edited to include profile plot option with '4dp'
%  s=ncw(nc, '4dp', 'salt', ti1, lyr1:lyr2, eta1:eta2, xi1);
%
% 2016, December
% Zafer Defne

nc=varargin{1}; 
ptype=varargin{2}; 
vname=varargin{3};
if nargin>3
    tind=varargin{4};
else
    tind=[];
end
eta=[];
xi=[];
t=[];
if strcmp(ptype,'1d') && nargin==6
    lyr=[];
    eta=varargin{5};
    xi=varargin{6};
elseif nargin>4
    lyr=varargin{5};
    if nargin==6
        eta=varargin{5};
        xi=varargin{6};
    elseif nargin==7
        eta=varargin{6};
        xi=varargin{7};
    else
        eta=[]; xi=[];
    end
else
    lyr=[];
end
try
    t=nc.time{'ocean_time'};
catch
    try
        
        d=nc{'dstart'};
        datt=d.attributes;
        dstr=cell2mat(datt(end, end));
        istr1=cell2mat(regexpi(dstr, {'since '}, 'end'));
        dstart=datenum(dstr(istr1+1:end));
    catch
        fprintf('No date attribute found. Setting start date to 0')
        dstart=0;
    end
        t=dstart+nc{'ocean_time'}(tind)/3600/24;
end

v=nc{vname};
%check for coordinates to use to plot
% ncvars=nc.variables;
% if(sum(strcmpi(ncvars, 'lon_rho'))<1)
%    xcoor='x_rho'; ycoor='y_rho';
% else
%    xcoor='lon_rho'; ycoor='lat_rho';
% end

% strcoor=vatt(strcmpi(vatt(:,1), 'coordinates') , 2);
strcoor=v.attribute('coordinates');
strind=strfind(v.attribute('coordinates'),' ');
xcoor=strcoor(1:strind(1)-1)
ycoor=strcoor(strind(1):strind(2)-1)

if ~isempty(strfind(strcoor, '_rho'))
    mtype='_rho';
elseif ~isempty(strfind(strcoor, '_u'))
    mtype='_u';
elseif ~isempty(strfind(strcoor, '_v'))
    mtype='_v';
end
switch ptype
    case '4dm'
        mname=['wetdry_mask' mtype];
        if isempty(eta) && isempty(xi)
            m=squeeze(nc{mname}(tind, :, :));
            s=squeeze(nc{vname}(tind, lyr, :, :));
        else
            m(eta,xi)=squeeze(nc{mname}(tind, eta, xi));
            s(eta,xi)=squeeze(nc{vname}(tind, lyr, eta, xi));
        end
        s=s.*m./m;
        t=t(tind);
        figure
        pcolor(double(s)), colorbar, axis equal, shading flat
        plotleft
        title(sprintf('%s\n%s\nlayer %d', vname, datestr(t), lyr),'interpreter', 'none')
    case '4d'
        if isempty(eta) && isempty(xi)
            s=squeeze(nc{vname}(tind, lyr, :, :));
        else
            s(eta,xi)=squeeze(nc{vname}(tind, lyr, eta, xi));
        end
        t=t(tind);
        figure
        pcolor(double(s)), colorbar, axis equal, shading flat
        plotleft
        title(sprintf('%s\n%s\nlayer %d', vname, datestr(t), lyr),'interpreter', 'none')
    case '4dp'
        try 
            h=squeeze(nc{'h'}(eta, xi));
        catch 
            h=squeeze(nc{'bath'}(eta, xi));
        end
        s_rho=nc{'s_rho'}(lyr);
        if lyr(end) < length(nc{'s_rho'}(:))
            s_rho(end+1)=nc{'s_rho'}(lyr(end)+1);
        else
            s_rho(end+1)=0;
        end
        if length(eta)>length(xi)+1
            hh=s_rho*h';
            for i=1:length(lyr)+1
                xh(i,:)=nc{ycoor}(eta, xi);
            end
            slicetxt=sprintf('slice at xi = %d', xi);
        else
            hh=s_rho*h;
            for i=1:length(lyr)+1
                xh(i,:)=nc{xcoor}(eta, xi);
            end
            slicetxt=sprintf('slice at eta = %d', eta);
        end
        
%         hh(end+1,:)=0;
        s=squeeze(nc{vname}(tind, lyr, eta, xi));
        ss=s;
        ss(end+1,:)=ss(end,:);
        t=t(tind);
        figure
        pcolor(double(xh),double(hh),double(ss)), colorbar
        plotwide
        title(sprintf('%s\n%s\n%s', vname, datestr(t), slicetxt),'interpreter', 'none')
    case '3dm'
        mname=['wetdry_mask' mtype];
        if isempty(eta) && isempty(xi)
            m=squeeze(nc{mname}(tind, :, :));
            s=squeeze(nc{vname}(tind, :, :));
        else
            m(eta,xi)=squeeze(nc{mname}(tind, eta, xi));
            s(eta,xi)=squeeze(nc{vname}(tind, eta, xi));
        end
        s=s.*m./m;
        t=t(tind);
        figure
        pcolor(double(s)), colorbar, axis equal, shading flat
        plotmid
        title(sprintf('%s\n%s', vname, datestr(t)),'interpreter', 'none')
    case '3d'
        if isempty(eta) && isempty(xi)
            s=squeeze(nc{vname}(tind, :, :));
        else
            s(eta,xi)=squeeze(nc{vname}(tind, eta, xi));
        end
        t=t(tind);
        figure
        pcolor(double(s)), colorbar, axis equal, shading flat
        plotmid
        title(sprintf('%s\n%s', vname, datestr(t)),'interpreter', 'none')
    case '2dm'
        mname=['mask' mtype];
        if isempty(eta) && isempty(xi)
            m=squeeze(nc{mname}(:, :));
            s=squeeze(nc{vname}(:, :));
        else
            m(eta,xi)=squeeze(nc{mname}(eta, xi));
            s(eta,xi)=squeeze(nc{vname}(eta, xi));
        end
        s=s.*m./m;
        figure
        pcolor(double(s)), colorbar, axis equal, shading flat
        plotright
        title(sprintf('%s', vname),'interpreter', 'none')
    case '2d'
        if isempty(eta) && isempty(xi)
            s=squeeze(nc{vname}(:, :));
        else
            s(eta,xi)=squeeze(nc{vname}(eta, xi));
        end
        figure
        pcolor(double(s)), colorbar, axis equal, shading flat
        plotright
        title(sprintf('%s', vname),'interpreter', 'none')
    case '1d'
        if length(size(nc{vname})) > 3
            s=squeeze(nc{vname}(tind, lyr, eta, xi));
        else
            s=squeeze(nc{vname}(tind, eta, xi));
        end
        figure
        plotwide
%         set(gcf, 'position', [ 580 750 1100 250])
        t=t(tind);
        if length(tind)>1
            plot(t, s, '.-')
            datetick('x', 'mm/dd HH:MM', 'keepticks')
            if isempty(lyr)
                title(sprintf('%s(%d,%d)', vname, eta, xi ),'interpreter', 'none')
            else
                title(sprintf('%s(%d,%d,%d)', vname, lyr, eta, xi ),'interpreter', 'none')
            end
        elseif length(xi)>1
             plot(xi, s, '.-')
            if isempty(lyr)
                title(sprintf('%s @eta=%d, t=%s', vname, eta, datestr(t) ),'interpreter', 'none')
            else
                title(sprintf('%s @eta=%d, lyr=%s, t=%s', vname, lyr, eta, datestr(t) ),'interpreter', 'none')
            end
        elseif length(eta)>1
             plot(eta, s, '.-')
            if isempty(lyr)
                title(sprintf('%s @xi=%d, t=%s', vname, xi, datestr(t) ),'interpreter', 'none')
            else
                title(sprintf('%s @xi=%d, lyr=%s, t=%s', vname, lyr, xi, datestr(t) ),'interpreter', 'none')
            end
        end
        grid on
end
if ~(strcmpi(ptype, '1d') || strcmpi(ptype, '4dp')) && ~isempty(eta) && ~isempty(xi)
    ylim([eta(1),eta(end)])
    xlim([xi(1),xi(end)])
end
q.val=s; q.vname=vname; q.lyr=lyr; q.t=t;






