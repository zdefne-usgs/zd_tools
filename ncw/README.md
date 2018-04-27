  A netcdf viewer with ROMS in mind
  ----
 
  ```
  s=ncw(nc, ptype, vname, tind, lyr, eta, xi);
  s: structure conatining the answer
  q.val: variable's values 
  q.vname: variable's name
  q.lyr: layer
  q.t: time
      
  nc: Netcdf object. e.g. Using NCTOOLBOX for Matlab:
      nc=ncgeodataset(netcdf_file.nc)
      nc=ncgeodataset(url_to_netcdf_file.ncml)
  ptype: Plot type based on number of dimensions of the variable. Append "m" if masking.
  e.g. '1d', '2d', '3d', '4d' or '2dm', '3dm', '4dm'.
  vname: name of the variable
  tind: time steps (for 3-D and 4-D data)
  lyr: vertical layers (for 3-D and 4-D data)
  eta: eta points (optional for 3-D and 4-D data, required for 1-D)
  xi: xi points (optional for 3-D and 4-D data, required for 1-D)```
 ```
 ```
  WITHOUT mask option:
    s=ncw(nc, '4d', 'temp', eta1, xi1);
    s=ncw(nc, '3d', 'zeta', ti1);
    s=ncw(nc, '2d', 'h');
  1D salinity time series for time steps ti1 to ti2 at lyr1
    s=ncw(nc, '1d', 'salt', ti1:ti2, lyr1, eta1, xi1);
  Data is 2D (1 layer) hence lyr=[];
    s=ncw(nc, '1d', 'zeta', ti1:ti2, [], eta1, xi1);
  plot the full time series
    s=ncw(nc, '1d', 'Dwave', :, 220, 155);
 ```
 ```
  WITH masking option. '4dm' instead of '4d':
    s=ncw(nc, '4dm', 'salt', ti1, 3, eta1:eta2, xi1:xi2);
  Slice or vertical profile. '4dp' instead of '4d', slice at xi1:
    s=ncw(nc, '4dp', 'salt', ti1, lyr1:lyr2, eta1:eta2, xi1);

  2014, October
  Zafer Defne
 ```
 ```
  Edited to include profile plot option with '4dp'
    s=ncw(nc, '4dp', 'salt', ti1, lyr1:lyr2, eta1:eta2, xi1);
 
  2016, December
  Zafer Defne
```
