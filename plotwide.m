function plotwide
scr=get(0, 'screensize');
pos=get(gcf, 'position');
pos(1)=0;
pos(3)=scr(3);
set(gcf, 'position', pos);

