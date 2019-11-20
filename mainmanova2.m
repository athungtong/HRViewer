function [xdat ydat pvalue] = mainmanova2(x,y)
%% return xdat and ydat, do not plot
% % use smallest number of epoch in a group 

    numratx=unique(x(:,2));
    numepochx=zeros(size(numratx));
    for i=1:length(numratx)
        numepochx(i)=length(x(x(:,2)==numratx(i)));
    end
    [numratx numepochx];

    numraty=unique(y(:,2));
    numepochy=zeros(size(numraty));
    for i=1:length(numraty)
        numepochy(i)=length(y(y(:,2)==numraty(i)));
    end
    [numraty numepochy];
    minepoch = min([numepochx;numepochy]);
%     numepochx'
%     numepochy'
    % method 1, use the smallest number of epoch
    tempx=[];
    for i=1:length(numratx)
        temp=x(x(:,2)==numratx(i),:);
        tempx = [tempx;(temp(randperm(numepochx(i),minepoch),1))'];
    end

    tempy=[];
    for i=1:length(numraty)
        temp=y(y(:,2)==numraty(i),:);
        tempy = [tempy;(temp(randperm(numepochy(i),minepoch),1))'];
    end

    [p, table] = anova_rm({tempx tempy}, 'off');


    xdat=reshape(tempx,size(tempx,1)*size(tempx,2),1);
%     temp=prctile(xdat,[25 50 75]);
%     p25x = temp(1);
%     p50x = temp(2);
%     p75x = temp(3);


    ydat=reshape(tempy,size(tempy,1)*size(tempy,2),1);
%     temp=prctile(ydat,[25 50 75]);
%     p25y = temp(1);
%     p50y = temp(2);
%     p75y = temp(3);
% 
    pvalue = p(2);

