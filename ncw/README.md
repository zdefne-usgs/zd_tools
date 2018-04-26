  A netcdf viewer with ROMS in mind
  ----
 
  ```
  S=ncw(nc, ptype, vname, tind, lyr, eta, xi);
  
  S: structure conatining the answer
  S.s: variable's values 
  S.vname: variable's name
  S.lyr: layer
  S.t: time
  
  nc: netcdf file
  ptype: Plot tyype based on number of dimensions of the variable. Append "m" if masking.
  e.g. '1d', '2d', '3d', '4d' or '2dm', '3dm', '4dm'.
  vname: name of the variable
  tind: time steps (for 3-D and 4-D data)
  lyr: vertical layers (for 3-D and 4-D data)
  eta: eta points (optional for 3-D and 4-D data, required for 1-D)
  xi: xi points (optional for 3-D and 4-D data, required for 1-D)
```
```
  Examples: 
    ti1=3; ti2=10; eta1=4; eta2=14; xi1=5; xi2=15; lyr1=2; lyr2=4;
 ```
 ```
  WITHOUT mask option:
    S=ncw(nc, '4d', 'temp', eta1, xi1);
    S=ncw(nc, '3d', 'zeta', ti1);
    S=ncw(nc, '2d', 'h');
  1D salinity time series for time steps ti1 to ti2 at lyr1
    S=ncw(nc, '1d', 'salt', ti1:ti2, lyr1, eta1, xi1);
  Data is 2D (1 layer) hence lyr=[];
    S=ncw(nc, '1d', 'zeta', ti1:ti2, [], eta1, xi1);
  plot the full time series
    S=ncw(nc, '1d', 'Dwave', :, 220, 155);
 ```
 ```
  WITH masking option. '4dm' instead of '4d':
    S=ncw(nc, '4dm', 'salt', ti1, 3, eta1:eta2, xi1:xi2);
  Slice or vertical profile. '4dp' instead of '4d', slice at xi1:
    S=ncw(nc, '4dp', 'salt', ti1, lyr1:lyr2, eta1:eta2, xi1);
 ```
 ```
  2014, October
  Zafer Defne
    Edited to include profile plot option with '4dp'
 
  S=ncw(nc, '4dp', 'salt', ti1, lyr1:lyr2, eta1:eta2, xi1);
 
  2016, December
  Zafer Defne
