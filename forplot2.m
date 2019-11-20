function handles=forplot2(handles)
%%%%%%%%%%%%%%%%%%
% axes(handles.ha);
figure(1)
axis tight
set(handles.ha,'xlim',handles.xlimit);
ylim('auto');
tick=((handles.xlimit(1):(handles.xlimit(2)-handles.xlimit(1))/5:handles.xlimit(2))*2)/2;
tick =unique(tick);
% temp=datestr(tick/24/60,'HH:MM:SS');
% tickvec=cell(size(temp,1),1);
% for i=1:size(temp,1)
%     tickvec{i}=temp(i,:);
% end
set(gca,'xticklabel','');
set(handles.ha,'xtick',tick);
set(gcf,'paperposition',[2.5 4 3.475,1]);
print(gcf,'-depsc','-loose','samplebadsegment203');


'Done deal'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
