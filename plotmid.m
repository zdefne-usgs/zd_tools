function plotmid
% Plot figure towards the middle of the screen
s=get(0, 'screenSize');
x=s(3);
y=s(4);
set(gcf, 'position', [x/3.80 y/10 x/3.85 y/1.25]);
axis normal
% set(gca, 'position', [.2 .1 .5 .8]);

