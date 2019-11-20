fp = fopen('fname.txt');
tline = fgets(fp);
fid={};
while ischar(tline)
    fid=[fid;tline(1:end-2)]; 
    tline = fgets(fp);
end


FN=zeros(size(fid));
FP=FN;
TP=FN;
lenanu=FN;
lenmih=FN;

mindt=0.15;
for j=1:length(fid)
    s=sprintf('processing %s',fid{j});
    disp(s);
    rmih=load([num2str(fid{j}) '_ann.txt']);
    ranu=load([num2str(fid{j}) '_Rtime.txt']); 
    ranu(ranu<rmih(1))=[];
    ranu(ranu>rmih(end))=[];
        
    if strcmp(fid{j},'207') 
        ranu(ranu>1539 & ranu<1643)=[];
        ranu(ranu>240 & ranu<282)=[];
        ranu(ranu>39 & ranu<63)=[];       
    end

    if strcmp(fid{j},'f1y07') || strcmp(fid{j},'f2y02')
        continue;
    end
    
    if strcmp(fid{j},'sele0604') || strcmp(fid{j},'sele0116') || strcmp(fid{j},'sele0129') || strcmp(fid{j},'sele0603')
        continue;
    end
    lenanu(j)=length(ranu);
    lenmih(j)=length(rmih);
%     stem(rmih,ones(size(rmih)),'r'); hold on;
%     stem(ranu,ones(size(ranu)),'b'); hold on;
 
    %False positive, detect something which is not a real beat
  
    for i=1:length(ranu)
        indl=find(rmih<=ranu(i),1,'last');
        indr=find(rmih>=ranu(i),1,'first');
       
        dl=abs(rmih(indl)-ranu(i));
        dr=abs(rmih(indr)-ranu(i));
        if isempty(dl),dl=Inf; end
        if isempty(dr),dr=Inf; end
        
        if dl>mindt && dr>mindt
            FP(j)=FP(j)+1;
        end

        %True positive
        if dl<mindt || dr<mindt
            TP(j)=TP(j)+1;
        end
    end
    
    
    % False negative, real beat that is not detected
   for i=1:length(rmih)
        indl=find(ranu<=rmih(i),1,'last');
        indr=find(ranu>=rmih(i),1,'first');
        
        dl=abs(ranu(indl)-rmih(i));
        dr=abs(ranu(indr)-rmih(i));
        
        if isempty(dl),dl=Inf; end
        if isempty(dr),dr=Inf; end
        
        if dl>mindt && dr>mindt
            FN(j)=FN(j)+1;
        end
    end 
    
end
TB=lenmih;
Se = TP./(TP+FN);
P=TP./(TP+FP);
Er=(FN+FP)./TB;
    
for i=1:length(TB)
    str=sprintf('%s\t %d\t %d\t %d\t %d',fid{i}, TB(i), TP(i), FP(i), FN(i));
    disp(str)
end


% [Se'*100 P'*100 Er'*100]
Se(isnan(Se))=[];
P(isnan(P))=[];
Er(isnan(Er))=[];
[mean(Se)*100 mean(P)*100 mean(Er)*100]