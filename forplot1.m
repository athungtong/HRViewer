function handles=forplot1(handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%% To extract the figure
figure(1)
clf
    width = 3.475; 
    height = 1;    % Height in inches
    alw = 0.75;    % AxesLineWidth
    fsz = 8;      % Fontsize
    lw = 0.72;      % LineWidth
    msz = 8;       % MarkerSize

    [handles.ha, pos] = tight_subplot(1,1,[.04 .1],[.03 .1],[.13 .05]); % [left right],[buttom, above], [left right of all subplot]
    pos = get(gcf, 'Position');
    set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size


axes(handles.ha(1)),plot(handles.x(:,1)/60 ,handles.ecg,'k'); hold on; 
ylabel([ {['(' handles.ChInfo.PhyDim(handles.ECGch,1:2) ')']}],'FontSize', fsz,'Interpreter','LaTex');
t1=handles.x(1,1);
tend=handles.x(end,1);

tick=(t1:(tend-t1)/5:tend)*2/2;
tick =unique(tick);
temp=datestr(tick/24/60,'HH:MM:SS');
tickvec=cell(size(temp,1),1);
for i=1:size(temp,1)
    tickvec{i}=temp(i,:);
end

set(handles.axesECG,'xtick',tick,'XTickLabel',tickvec);

if ~isempty(tick)
    xlim([tick(1) tick(end)]);
end

handles.xlimit = get(gca,'xlim');


%Plot R_time
handles.indexR = round(handles.fs*handles.R_time)-round(handles.fs*handles.x(1,1))+1;
% index = round(handles.fs*handles.R_time-handles.x(1,1))+1;
% index = floor(handles.fs*handles.R_time)-floor(handles.fs*handles.x(1,1))+1

% tempR_time=handles.R_time;
% tempR_time(index>length(handles.x))=[];
handles.indexR(handles.indexR>length(handles.x))=[];


plot(handles.x(handles.indexR,1)/60 ,handles.ecg(handles.indexR),'.r','markersize',msz); 

%add for debug

handles.indexann = round(handles.fs*handles.ann_time)-round(handles.fs*handles.x(1,1))+1;
% [handles.fs length(handles.x) max(handles.indexann) ]

plot(handles.x(handles.indexann,1)/60 ,handles.ecg(handles.indexann),'sb','markersize',3); 

hold off;
