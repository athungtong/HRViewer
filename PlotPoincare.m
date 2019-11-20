function PlotPoincare(X,tau)
if length(X)< 1+tau
    return;
end

x = X(1:end-tau);  y = X(1+tau:end);

% Step 1. Find the new coordinate which is -45 degree from the original coordinate
xcorr = [1; 1]/sqrt(2); ycorr = [-1; 1]/sqrt(2);
xdat = [x y]*xcorr; ydat = [x y]*ycorr;

hii = leverage(xdat);   ri = xdat-mean(xdat);   ci = hii./(1-hii).*ri.^2;
indx=ci>4/length(xdat); % index of outliers

hii = leverage(ydat);   ri = ydat-mean(ydat);   ci = hii./(1-hii).*ri.^2;
indy=ci>4/length(ydat); % index of outliers

% plot(x,y,'color',[0 0.39 0],'marker','.','linestyle','none'); hold on;
% plot(x(indx),y(indx),'r*');
% plot(x(indy),y(indy),'r*');

index=unique([find(indx);find(indy)]);
xdat(index)=[]; 
ydat(index)=[]; 
newx=[xdat ydat]*[1;-1]/sqrt(2);
newy=[xdat ydat]*[1;1]/sqrt(2);
plot(newx,newy,'color',[0 0.39 0],'marker','.','linestyle','none'); hold on;

center=[mean(xdat) mean(ydat)];
SD1C = std(ydat);   SD2C = std(xdat);
if SD2C==0
    SD_Ratio=Inf;
else
    SD_Ratio=SD1C/SD2C;
end

temp = [0 0; 0 SD1C; 0 0 ; SD2C 0;center];
tempx=temp*[1;-1]/sqrt(2);
tempy=temp*[1;1]/sqrt(2);
tempx(1:4)=tempx(1:4)+tempx(end);
tempy(1:4)=tempy(1:4)+tempy(end);
plot(tempx(1:2),tempy(1:2),'r','linewidth',3);
plot(tempx(3:4),tempy(3:4),'color','b','linewidth',3);
ellipse(SD2C,SD1C,pi/4,tempx(5),tempy(5),'k',200);

fac=5*max([SD1C SD2C]);
% fac=2;

% temp = [0 -fac; 0 fac; -fac*.7 0 ; fac*.7 0;center];
% tempx=temp*[1;-1]/sqrt(2);
% tempy=temp*[1;1]/sqrt(2);
% 
% tempx(1:4)=tempx(1:4)+tempx(end);
% tempy(1:4)=tempy(1:4)+tempy(end);
% temp = [center(1) min(ydat) ;center(1) max(ydat);...
%         min(xdat) center(2); max(xdat) center(2)]

temp = [center(1) min(ydat)-(center(2)-min(ydat))/2 ;center(1) max(ydat)+(max(ydat)-center(2))/2;...
        min(xdat)-(center(1)-min(xdat))/2 center(2); max(xdat)+(max(xdat)-center(1))/2 center(2)];
    
    
tempx=temp*[1;-1]/sqrt(2);
tempy=temp*[1;1]/sqrt(2);


plot(tempx(1:2),tempy(1:2),'k');
plot(tempx(3:4),tempy(3:4),'k');

txtSD1=['SD1=' num2str(SD1C,2)];
txtSD2=['SD2=' num2str(SD2C,2)];
txtRatio=['SDRatio=' num2str(SD_Ratio,2)]; 

text(tempx(2),tempy(2),txtSD1,'fontsize',8,'color','r','HorizontalAlignment','center');
text(tempx(4),tempy(4),{txtSD2,txtRatio},'fontsize',8,'color','b','HorizontalAlignment','left');
% axis square
% text(tempx(4),tempy(4)-0.1,txtRatio,'fontsize',8,'color','k');

% xlim([xlim1 xlim2]);
% ylim([ylim1 ylim2]);
hold off;
% figure(1),eda(xdat);


