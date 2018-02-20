function f=usa(k)
% USA 
%    colormap(usa) 
%
% Set colormap for a figure from blue to white to red.
% 2014, December
% Zafer Defne
% 
if nargin < 1
   k = size(get(gcf,'colormap'),1);
end
one=ones(1, k);
zero=zeros(1, k);
zero_to_one=0:1/(k-1):1;
one_to_zero=1:-1/(k-1):0;
r=[one,one_to_zero];
g=[zero_to_one,one_to_zero];
b=[zero_to_one,one];
f=[r',g',b'];