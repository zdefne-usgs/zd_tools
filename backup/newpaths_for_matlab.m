function newpaths_for_matlab(use_svn)
if nargin<1
    use_svn=1
end
clc
i=0;
i=i+1;
LOT{i}='T_tide';
addpath('C:\Users\zdefne\Documents\MATLAB\pcatool')
addpath('C:\Users\zdefne\Documents\MATLAB\COAWST\Tools\mfiles\mtools')
addpath('C:\Users\zdefne\Documents\MATLAB\ezyfit')
addpath('C:\Users\zdefne\Documents\MATLAB\tools\roms_nkg\Roms_Interpolation\Mfiles')
addpath('C:\Users\zdefne\Documents\MATLAB\LP_Bathymetry_MODIFIED\Mfiles')
addpath('C:\Users\zdefne\Documents\MATLAB\zd_tools')
addpath('C:\Users\zdefne\Documents\MATLAB\tide\tidal_ellipse')
addpath('C:\Users\zdefne\Documents\MATLAB\tide\tri')
addpath('C:\Users\zdefne\Documents\MATLAB\tide\t_tide')
addpath('C:\Users\zdefne\Documents\MATLAB\tide')
addpath('C:\Users\zdefne\Documents\MATLAB\t_tide_v1_3beta', '-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\GATECH_CODES\ROMS_PRE\bathymetry2seagrid','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\GATECH_CODES\ROMS_PRE\coastline2seagrid','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\GATECH_CODES\ROMS_PRE\grid','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\GATECH_CODES\ArcGIS','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\tools\cf')
addpath('C:\Users\zdefne\Documents\MATLAB\tools\cmglib')
addpath('C:\Users\zdefne\Documents\MATLAB\zd_tools\cm_and_cb_utilities')
addpath('C:\Users\zdefne\Documents\MATLAB\zd_tools\freezeColors')
% addpath('C:\Users\zdefne\Documents\MATLAB\tools\njTools\release\beta\2.0')
% addpath(genpath('C:\Users\zdefne\Documents\MATLAB\tools\njTools\release\beta\2.0\nJfunc'))
% addpath('C:\Users\zdefne\Documents\MATLAB\tools\njTools\release\beta\2.0\njTBX-2.0')
% addpath('C:\Users\zdefne\Documents\MATLAB\tools\njTools\release\beta\2.0\njTBX-2.0\Utilities')
% addpath('C:\Users\zdefne\Documents\MATLAB\tools\njTools\release\beta\2.0\njtbxhelp')
% remove after getting the statistical toolbox----------------------------
addpath('C:\Users\zdefne\Documents\MATLAB\nansuite')
%-------------------------------------------------------------------------

% Rich Signell's NCTOOLBOX------------------------------------------------
i=i+1;
LOT{i}='NCTOOLBOX';
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\graphics','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\interp','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\misc','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\njcompatability','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\search','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\slicing','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\sura_catalog','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\units','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm\utilities\vis','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\cdm','-begin')
addpath('C:\Users\zdefne\Documents\MATLAB\nctoolbox\java','-begin')
%-------------------------------------------------------------------------

if use_svn==1
    % Use mexnc_svn-------------------------------------------------------
    % Rich Signell's method
    rmpath('C:\Users\zdefne\Documents\MATLAB\netcdf_toolbox\netcdf')
    rmpath('C:\Users\zdefne\Documents\MATLAB\netcdf_toolbox\netcdf\nctype')
    rmpath('C:\Users\zdefne\Documents\MATLAB\netcdf_toolbox\netcdf\ncutility')
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf\mexnc')
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf\snctools')
    rmpath('C:\Users\zdefne\Documents\MATLAB\seagrid\presto')
    rmpath('C:\Users\zdefne\Documents\MATLAB\seagrid')
    
    rmpath('C:\Users\zdefne\Documents\MATLAB\seagrid\mex_matlab77_win64')
    
    i=i+1;
    LOT{i}='mexcdf_svn, netcdf_toolbox';
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\netcdf_toolbox\netcdf','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\netcdf_toolbox\netcdf\nctype','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\netcdf_toolbox\netcdf\ncutility','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\mexnc','-begin')
    i=i+1;
    LOT{i}='mexcdf_svn, snctools';
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\snctools','-begin')
    i=i+1;
    LOT{i}='mexcdf_svn, seagrid';
    addpath('C:\Users\zdefne\Documents\MATLAB\seagrid_svn\presto','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\seagrid_svn','-begin')
    setpref('MEXNC','USE_TMW',true)
    TMW='Using the NATIVE netcdf and svn checkout for MEXNC.';

    %---------------------------------------------------------------------
elseif use_svn==0
    % Use mexnc from Gatech-----------------------------------------------
    % use with seagrid2roms_ML
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\netcdf_toolbox\netcdf')
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\netcdf_toolbox\netcdf\nctype')
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\netcdf_toolbox\netcdf\ncutility')
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\mexnc')
    rmpath('C:\Users\zdefne\Documents\MATLAB\mexcdf_svn\snctools')
    rmpath('C:\Users\zdefne\Documents\MATLAB\seagrid_svn\presto')
    rmpath('C:\Users\zdefne\Documents\MATLAB\seagrid_svn')
    
    i=i+1;
    LOT{i}='mexcdf, netcdf_toolbox';
    addpath('C:\Users\zdefne\Documents\MATLAB\netcdf_toolbox\netcdf','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\netcdf_toolbox\netcdf\nctype','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\netcdf_toolbox\netcdf\ncutility','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf\mexnc','-begin')
    i=i+1;
    LOT{i}='mexcdf, snctools';
    addpath('C:\Users\zdefne\Documents\MATLAB\mexcdf\snctools','-begin')
    i=i+1;
    LOT{i}='mexcdf, seagrid';
    addpath('C:\Users\zdefne\Documents\MATLAB\seagrid\presto','-begin')
    addpath('C:\Users\zdefne\Documents\MATLAB\seagrid','-begin')
    
    setpref('MEXNC','USE_TMW',false)
    addpath('C:\Users\zdefne\Documents\MATLAB\seagrid\mex_matlab77_win64') %need this for keep orthogonal while stretching
    TMW='NOT USING THE NATIVE NETCDF for MEXNC!';
    %---------------------------------------------------------------------
else
    disp('use_svn was notset to 1 or 0. Quitting...')
    return
end
% setpref('SNCTOOLS','PRESERVE_FVD',true)
disp('List of Toolboxes added:')
for i=1:length(LOT)
    fprintf('%s\n', LOT{i})
end
run('C:\Users\zdefne\Documents\MATLAB\nctoolbox\setup_nctoolbox.m')
savepath
fprintf('\nChanges to folders on the path are saved.\n%s\n\n',TMW)
which -all mexnc
which -all netcdf
