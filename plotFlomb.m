function [f P]=plotFlomb(RR_time,RR_interval)
%%
% input 
% RR_time =time when beat2beat occur
% RR_interval=beat to beat interval


[f P]=FASPER(RR_time-RR_time(1),RR_interval);
yy = smooth(P/sum(P),'sgolay',1);
plot(f,yy,'color',[0 100 0]/255);hold off;
axis tight
