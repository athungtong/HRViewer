x=edfRead2('bi0001.edf','ECG L');
x=x{1};

A = mdbRead('J:/Dropbox/EDF Viewer/bi0001.mdb','ECG');

r=zeros(length(A),2);
r(:,1)=cell2mat(A(:,1));
r(:,2)=cell2mat(A(:,9));
r0=r(r(:,2)~=1,1);

%%
% plot( (1:10:2e7)/512/60,x(1:10:2e7),'color',[0 100 255]/255); 
plot(r(:,1)/256/60,0.1*ones(size(r,1),1),'gx');hold on;
plot(r0(:,1)/256/60,0.1*ones(size(r0,1),1),'.r'); 
plot(r(1:end-1,1)/256/60,60./(diff(r(:,1))/256),'r');
hold off
