close all
% Defaults for this blog post
width = 3.475;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 8;      % Fontsize
lw = 0.72;      % LineWidth
msz = 8;       % MarkerSize

mu=[0,2.5,3,4,6,10];
mu=[0,10,12];
mu2=[0,10,3.2];
h=figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

for i=1:length(mu)
    w=normrnd(0,1,1e6,1);
    x=normrnd(mu(i),2,1e6,1);
    y=normrnd(mu2(i),2,1e6,1);
    if i==3,  z=[w;x;y];else z=[w;x];end
    xi=linspace(min(z),max(z),100);
    [fYk,xi] = ksdensity(z,xi);
    
    dfy0=diff(fYk)/(xi(2)-xi(1));
    dfy=smooth(dfy0,5)';

    [imax imin]=localmaxmin(dfy);


    imax(1)=0; imax(end)=0; imax=find(imax);
    imin(1)=0; imin(end)=0; imin=find(imin);
    jf =[imax';imin']'; % index of inflection point

    candidate=[];
    for n=1:length(jf)
        if sum(fYk(1:jf(n))/sum(fYk))>0.02 && sum(fYk(jf(n)+1:end)/sum(fYk))>0.02
            candidate =[candidate; n];
        end
    end
    jf=jf(candidate); %inflection point

    % indPx: index of local minimum of Px
    [jm jn]=localmaxmin(fYk);    
    jn(1)=0; jn(end)=0; jn=find(jn);
    jm(1)=0; jm(end)=0; jm=find(jm);
    %jx = index of local max
    %jn = index  of local min

    % find candidate xi 
    % get candidate from local min of Px such that the amplitude in 5-95 percentile
    candidate=[];
    for n=1:length(jn)
        % 0.05 is adjusted for 208 MITDB don't change
        if sum(fYk(1:jn(n))/sum(fYk))>0.05 && sum(fYk(jn(n)+1:end)/sum(fYk))>0.05
            candidate =[candidate; n];
        end
    end
    jn=jn(candidate); %index of local minimum

    
    %We need interpolation here to make the figure look smooth
    xx = linspace(min(xi),max(xi),1e5);
    yy = spline(xi,fYk,xx);
    
%     subplot(2,3,i)
%     z2=z(randperm(length(z)));
%     
%     plot(z2(1:200),'.k');
%     set(gca,'xticklabel',''); set(gca,'yticklabel','')
    subplot(1,3,i)
    plot(xx,yy,'k','linewidth',lw); hold on;
    plot(xi(jf),fYk(jf),'k.','markersize',msz); 
    if ~isempty(jn)
        plot(xi(jn),fYk(jn),'ko','markersize',3); 
    end
    hold off;
    axis('tight'); 
    set(gca,'xticklabel',''); set(gca,'yticklabel','')
    %txt=text(['$\mu=$' mu(i)],'interpreter','-latex');
    %t=title(['$\mu$ = ' num2str(mu(i))]);
    %set(t,'Interpreter','Latex','fontsize',fsz)
%     subplot(212),plot(xi(1:end-1),dfy); hold on
%     plot(xi(jf),dfy(jf),'rx'); hold off;
    ylim([0 max(yy)+max(yy)*0.1])
end
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(h,'PaperPosition', myfiguresize);

%set(h,'paperposition',[0.25 2.5 4.344,height]);
set(h,'paperposition',[0.25 2.5 4.344,height/2]);
print(gcf,'-depsc','-loose','sample');

%% Multiple distribution

width = 3.475;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 8;      % Fontsize
lw = 0.72;      % LineWidth
msz = 8;       % MarkerSize

mu=[0,2.5,3,4,6,10];
mu=[0,3,6];
h=figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

for i=1:length(mu)
    x=normrnd(0,1,1e6,1);
    y=normrnd(mu(i),2,1e6,1);
    z=[x;y];
    xi=linspace(min(z),max(z),100);
    [fYk,xi] = ksdensity(z,xi);
    %fYk=smooth(Px,5);
    %need dome kind of smooth function here for Px
    dfy0=diff(fYk)/(xi(2)-xi(1));
    dfy=smooth(dfy0,5)';

    [imax imin]=localmaxmin(dfy);


    imax(1)=0; imax(end)=0; imax=find(imax);
    imin(1)=0; imin(end)=0; imin=find(imin);
    jf =[imax';imin']'; % index of inflection point

    candidate=[];
    for n=1:length(jf)
        if sum(fYk(1:jf(n))/sum(fYk))>0.05 && sum(fYk(jf(n)+1:end)/sum(fYk))>0.05
            candidate =[candidate; n];
        end
    end
    jf=jf(candidate); %inflection point

    
    %We need interpolation here to make the figure look smooth
    xx = linspace(min(xi),max(xi),1e5);
    yy = spline(xi,fYk,xx);
    
%     subplot(2,3,i)
%     z2=z(randperm(length(z)));
%     
%     plot(z2(1:200),'.k');
%     set(gca,'xticklabel',''); set(gca,'yticklabel','')
    subplot(2,3,i)
    plot(xx,yy,'k','linewidth',lw); hold on;
    plot(xi(jf),fYk(jf),'k.','markersize',msz); hold off;
    axis('tight'); 
    set(gca,'xticklabel',''); set(gca,'yticklabel','')
    %txt=text(['$\mu=$' mu(i)],'interpreter','-latex');
    t=title(['$\mu$ = ' num2str(mu(i))]);
    set(t,'Interpreter','Latex','fontsize',fsz)
%     subplot(212),plot(xi(1:end-1),dfy); hold on
%     plot(xi(jf),dfy(jf),'rx'); hold off;
    ylim([0 max(yy)+max(yy)*0.1])
end
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(h,'PaperPosition', myfiguresize);

set(h,'paperposition',[0.25 2.5 4.344,height]);
print(gcf,'-depsc','-loose','sample');

%%
x=randn(10000,1);
y=4*randn(10000,1);

score=zeros(20,1);
for k=1:20
    z=[x;(20-k+y)];

    
    [Px,xi] = ksdensity( z);
    plot(xi,Px);
    input('?');
    Ex = sum(xi.*Px)*(xi(2)-xi(1));
    Dmx=(xi'-Ex).^4;
    Dmx=(Dmx-min(Dmx))/range(Dmx);

    [indPxmax indPx]=localmaxmin(Px);    indPx(1)=0; indPx(end)=0; indPx=find(indPx);
    indPxmax(1)=0; indPxmax(end)=0; indPxmax=find(indPxmax);

    % find candidate xi 
    % get candidate from local min of Px such that the amplitude in 5-95 percentile
    candidate=[];
    for j=1:length(indPx)
        % 0.05 is adjusted for 208 MITDB don't change
        if sum(Px(1:indPx(j))/sum(Px))>0.05 && sum(Px(indPx(j)+1:end)/sum(Px))>0.05
            candidate =[candidate; j];
        end
    end
    indPx=indPx(candidate);

    Pxn = (Px-min(Px))/range(Px);  
    dPx = diff(Pxn)*(xi(2)-xi(1));
    [imax imin]=localmaxmin(dPx);

    imax(1)=0; imax(end)=0; imax=find(imax);
    imin(1)=0; imin(end)=0; imin=find(imin);
    inddPx =[imax';imin']';

    candidate=[];
    for j=1:length(inddPx)
        if sum(Px(1:inddPx(j))/sum(Px))>0.05 && sum(Px(inddPx(j)+1:end)/sum(Px))>0.05
            candidate =[candidate; j];
        end
    end
    inddPx=inddPx(candidate); 

    % compute degree of complexity (how many density exist and check if they
    % are sepharable

    if length(inddPx)<=2 % one distribution
        fval=inf;        
        index = [];
    elseif isempty(indPx) % more than 2 inflection point and no local min

        [foverlap indd]=min(abs(dPx(inddPx)) + Dmx(inddPx)');

        fval=fcom+foverlap;

    else % at least one local min exist
        fcom = length(indPx)/10+length(inddPx)/40;

        d=zeros(length(indPx),1);
        for i=1:length(indPx) 
            i1= indPxmax<indPx(i);
            i2= indPxmax>indPx(i);
            P1 = max(Pxn(indPxmax(i1)));
            P2 = max(Pxn(indPxmax(i2)));
            % To measure how the two density is sepharated, we measure percentage of overlaping
            % by computing ratio between the Px at the local minimal and the Px
            % at the local maximum of the best of the left and the right and
            % take the biggest one.
            d(i) = max( Pxn(indPx(i))/P1, Pxn(indPx(i))/P2 ); 
        end

        d = d + Dmx(indPx);
        [foverlap indd] = min(d);

        fval=fcom+foverlap;
        score(k)=foverlap;
    end


end

plot(1:20,score,'.-');