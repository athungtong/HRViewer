function varargout = HRViewer(varargin)
% HRVIEWER MATLAB code for HRViewer.fig
%      HRVIEWER, by itself, creates a new HRVIEWER or raises the existing
%      singleton*.
%
%      H = HRVIEWER returns the handle to a new HRVIEWER or the handle to
%      the existing singleton*.
%
%      HRVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HRVIEWER.M with the given input arguments.
%
%      HRVIEWER('Property','Value',...) creates a new HRVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HRViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HRViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HRViewer

% Last Modified by GUIDE v2.5 22-Oct-2014 09:57:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HRViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @HRViewer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HRViewer is made visible.
function HRViewer_OpeningFcn(hObject, eventdata, handles, varargin)
% remove preference for overwrite saving dialog
if ispref('removeepoch'),rmpref('removeepoch');end
handles = getstart(handles);
handles.output = hObject;
guidata(hObject, handles);


function handles = getstart(handles)
handles.createSelectsubmenu=0;
handles.ResultPath=cd;
handles.currentECGfile='';
handles.fid=-1;
handles.ProjectName='';
set(handles.figure1,'Name','untitled - HRViewer');
set(handles.selFiletxt,'string','');

handles.saved = 1;
handles.gname={};
handles.Group={};
handles.fname={};
handles.selHRV={};
handles.RRoption='RR';

% handles=setsetting(handles);
% handles=setparam(handles);

handles.rootpath=cd;
handles.ResultPath=handles.rootpath;

%enable multiselection
set(handles.ListFile,'max',2); 
set(handles.ListGroup,'max',2); 

handles=setforGroup(handles);
handles=setforFile(handles,'');
set(handles.HRVFileMenu,'enable','off');

handles.showECG=0;
handles.ECGposition=[15.0000   14.2308  224.0000   49.6154];
handles.epochnum=1;

handles.stemplot=-1;
handles.arrowplot=-1;
handles.arrowplotgroup=-1;
handles.plotanHRV=-1;

handles.pos1=get(handles.axesFile,'position');
handles.posG=get(handles.axesGroup,'position');

handles.c=cell(24,1);
handles.c{1}=[0 100 255]/255;
handles.c{2}=[0 100 0]/255;
handles.c{3}=[200 0 255]/255;
handles.c{4}=[150 150 0]/255;
handles.c{5}=[50 0 255]/255;
handles.c{6}=[255 0 100]/255;
handles.c(7:12)=handles.c(1:6);
handles.c(13:18)=handles.c(1:6);
handles.c(19:24)=handles.c(1:6);

% % Load and display button
% %Coloca una imagen en cada bot�n
% [a,map]=imread('start.jpg');
% [r,c,d]=size(a);
% x=ceil(r/31);
% y=ceil(c/32);
% g=a(1:x:end,1:y:end,:);
% g(g==255)=5.5*255;
% set(handles.pb_GoToStart,'String','');
% set(handles.pb_GoToStart,'CData',g);

% [a,map]=imread('left.jpg');
% [r,c,d]=size(a);
% x=ceil(r/30);
% y=ceil(c/30);
% g=a(1:x:end,1:y:end,:);
% g(g==255)=5.5*255;
% set(handles.pbLeftEpochButton,'String','');
% set(handles.pbLeftEpochButton,'CData',g);

% [a,map]=imread('right.jpg');
% [r,c,d]=size(a);
% x=ceil(r/30);
% y=ceil(c/32);
% g=a(1:x:end,1:y:end,:);
% g(g==255)=5.5*255;
% set(handles.pbRightButton,'String','');
% set(handles.pbRightButton,'CData',g);

% [a,map]=imread('end.jpg');
% [r,c,d]=size(a);
% x=ceil(r/30);
% y=ceil(c/30);
% g=a(1:x:end,1:y:end,:);
% g(g==255)=5.5*255;
% set(handles.pbGoToEnd,'String','');
% set(handles.pbGoToEnd,'CData',g);



% --- Outputs from this function are returned to the command line.
function varargout = HRViewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function handles=setparam(handles)

handles.param.hrv.epochsize=5;
handles.param.hrv.pctau=1;
handles.param.hrv.lowerLF=0.04;
handles.param.hrv.higherLF=0.15;
handles.param.hrv.lowerHF=0.15;
handles.param.hrv.higherHF=0.4;

handles.param.filter.detrend=1;
handles.param.filter.notch=60;
handles.param.filter.lowpass=[];
handles.param.filter.highpass=[];

function handles=setsetting(handles)
handles.set.ecgch.chnum = 'ECG';
handles.set.ecgch.chpref = 1;
handles.set.ecgch.defaultname = 'ECG';

handles.set.preprocess.artifact = 0;
handles.set.preprocess.needfilter = 1;

% handles.set.save.fnameCHopt = 'ECG L';
handles.set.save.fnameopt = '';
handles.set.save.savexls=0;
handles.set.save.savetxt=1;
handles.set.save.outfolderopt = 'Save in same folder as ECG file';
handles.set.save.outPath = cd;
handles.set.save.showlog=0;

handles.set.hrv.stat=1;
handles.set.hrv.geo=1;

handles.set.hrv.poincare=1;
handles.set.hrv.lomb=1;

% --------------------------------------------------------------------
% --------------------------------------------------------------------
function addfileMenu_Callback(hObject, eventdata, handles)
handles=openfile(handles);
guidata(hObject, handles);

function handles=openfile(handles)
[filename, handles.ResultPath] = uigetfile({'*_HRVmass.mat';'*.mat';'*.txt'},'Select HRV files','MultiSelect', 'on');

handles.newfname = {};

handles.fname={};
for i=1:length(handles.Group)
    for j=1:handles.Group{i}.totalfile
        handles.fname=[handles.fname;handles.Group{i}.fname{j}];
    end
end

if ~iscell(filename) % select only one file
    if filename==0, return;end
    
    if sum(strcmp(handles.fname,fullfile(handles.ResultPath,filename)))==0
       handles.newfname{1} = fullfile(handles.ResultPath,filename); 
       handles.fname=[handles.fname;{handles.newfname{1}}];       
    else
       h=warndlg([fullfile(handles.ResultPath,filename) ' was already added']);
       uiwait(h);
    end
else %select multiply files    
    for i=1:length(filename)
        if sum(strcmp(handles.fname,fullfile(handles.ResultPath,filename{i})))==0
           handles.fname=[handles.fname;{fullfile(handles.ResultPath,filename{i})}];
           handles.newfname=[handles.newfname;fullfile(handles.ResultPath,filename{i})];
        else
            h=warndlg([fullfile(handles.ResultPath,filename{i}) ' was already added']);
            uiwait(h);
        end    
    end
end
% if all files are already added
if isempty(handles.newfname),return;end

if length(handles.gname)>1
    [handles.selectedgroupnum isok] = listdlg('PromptString','Select a group to add files in:',...
                    'SelectionMode','single',...
                    'ListString',get(handles.ListGroup,'string'),'ListSize',[160 200],...
                    'InitialValue',length(get(handles.ListGroup,'string')));
    if ~isok,return;end
end
            
handles=loadfiles(handles);
fname=getfname(handles);
handles=setforFile(handles,fname);

%when add files, always select the last file
content=get(handles.ListFile,'string');
handles.selectedfile={content{end}};
set(handles.ListFile,'value',length(content));

content=get(handles.ListGroup,'string');
handles.selectedgroup={content{handles.selectedgroupnum}};
set(handles.ListGroup,'value',handles.selectedgroupnum);

handles.saved = 0;
set(handles.savetool,'enable','on');
set(handles.SaveProjectMenu,'enable','on');

if strcmp(handles.ProjectName,'')
    set(handles.figure1,'Name','untitled* - HRViewer');
else
    set(handles.figure1,'Name',[handles.ProjectName '* - HRViewer'] );
end
handles=updateResultList(handles);
handles=updateHRVlist(handles);
handles=updateplot(handles); 

if length(handles.selectedfile)==1   
    handles.set=handles.Results{1}.set;
    handles.param=handles.Results{1}.param;
    
    handles.EDFfullfile=handles.Results{1}.rawfilename;    
end

if ~isempty(handles.toberemove)
    for i=1:length(handles.toberemove)
        handles.selectedfile=handles.toberemove(i);
        h=warndlg([handles.selectedfile ' does not have appropriate format and will be deleted.']);
        uiwait(h);
        handles.selectedfilenum=1;
        handles=deletefile(handles);
    end
end



% --------------------------------------------------------------------
function addfolderMenu_Callback(hObject, eventdata, handles)
if handles.ResultPath==0,handles.ResultPath=handles.rootpath;end
temp = uigetdir(handles.ResultPath);
if temp==0,return;end
handles.ResultPath=temp;

file =dir(handles.ResultPath); 

file(1:2)=[];
if ~isfield(handles,'fname')
    handles.fname={};
end

handles.newfname={};

for i=1:length(file) 
    [~,fileext,ext]=fileparts(file(i).name);
    if ~strcmp('.mat',ext) ,continue; end
    if isempty(strfind(fileext,'_HRV')) ,continue; end
    if sum(strcmp(handles.fname,fullfile(handles.ResultPath,file(i).name)))==0
       handles.fname=[handles.fname;{fullfile(handles.ResultPath,file(i).name)}];
       handles.newfname=[handles.newfname;fullfile(handles.ResultPath,file(i).name)];
    end
end
% select group to add new files in
if length(handles.gname)>1
    [handles.selectedgroupnum isok] = listdlg('PromptString','Select a group:',...
                    'SelectionMode','single',...
                    'ListString',get(handles.ListGroup,'string'));
    if ~isok,guidata(hObject, handles);return;end
end

handles=loadfiles(handles);

fname=getfname(handles);
handles=setforFile(handles,fname);

%when add files, always select the lastest file
content=get(handles.ListFile,'string');
handles.selectedfile={content{end}};
set(handles.ListFile,'value',length(content));

handles.saved = 0;
set(handles.savetool,'enable','on');
set(handles.SaveProjectMenu,'enable','on');

if strcmp(handles.ProjectName,'')
    set(handles.figure1,'Name','untitled* - HRViewer');
else
    set(handles.figure1,'Name',[handles.ProjectName '* - HRViewer'] );
end
handles=updateResultList(handles);
handles=updateHRVlist(handles);
handles=updateplot(handles); 
guidata(hObject, handles);



% --- Executes on selection change in ListFile.
function ListFile_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));

temp=get(hObject,'Value');
% if isequal(handles.selectedfilenum,temp),return;end %Do nothing if select the same file
handles.selectedfilenum=temp;    
handles.selectedfile={};
for i=1:length(handles.selectedfilenum)
    handles.selectedfile{i,1}=contents{handles.selectedfilenum(i)};
end
handles=updateResultList(handles);

handles.selectedfilenum=1:length(handles.selectedfilenum);

handles.selectedgroupnum=unique(handles.GroupNum);
set(handles.ListGroup,'value',handles.selectedgroupnum); %show selection in list group
content = get(handles.ListGroup,'string');
handles.selectedgroup={};
for i=1:length(handles.selectedgroupnum)
    handles.selectedgroup{i}=content{handles.selectedgroupnum(i)};
end
handles=updateHRVlist(handles);
handles=updateplot(handles); 
%when click on file, will enable remove file
set(handles.deletefileMenu,'enable','on');

handles.param=handles.Results{handles.selectedfilenum(1)}.param;
handles.set=handles.Results{handles.selectedfilenum(1)}.set;
set(handles.SettingMenu,'enable','on');
       
guidata(hObject, handles);

% --- Executes during object creation, after Setting all properties.
function ListFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function deletefileMenu_Callback(hObject, eventdata, handles)
handles=deletefile(handles);
guidata(hObject, handles);

function handles=deletefile(handles)
for j=1:length(handles.selectedfilenum)
    groupnum=handles.GroupNum(j);

    for i=1:handles.Group{groupnum}.totalfile
        if strcmp(handles.selectedfile{j},handles.Group{groupnum}.fname{i})
            break;
        end
    end
    handles.Group{groupnum}.fname(i)=[];
    handles.Group{groupnum}.Results(i)=[];
    handles.Group{groupnum}.totalfile=handles.Group{groupnum}.totalfile-1;
end

handles.saved = 0;
set(handles.savetool,'enable','on');
set(handles.SaveProjectMenu,'enable','on');

if strcmp(handles.ProjectName,'')
    set(handles.figure1,'Name','untitled* - HRViewer');
else
    set(handles.figure1,'Name',[handles.ProjectName '* - HRViewer'] );
end
fname=getfname(handles);
handles=setforFile(handles,fname);

if ~isempty(fname)
    temp=min(length(fname),get(handles.ListFile,'Value'));
    temp=temp(1);
    set(handles.ListFile,'Value',temp);
    handles.selectedfilenum=1;
    handles.selectedfile = {fname{temp}};
    handles=updateResultList(handles);
    handles=updateHRVlist(handles);
    handles=updateplot(handles); 
end

% --------------------------------------------------------------------
function Parameters_Callback(hObject, eventdata, handles)
Parameters(handles.param,1,0); %view current param only



% --------------------------------------------------------------------
function Setting_Callback(hObject, eventdata, handles)
enableDisableFig(handles.figure1, false);
Setting(handles.set,handles.param,1,0,handles.selectedfile{handles.selectedfilenum}); %view current setting only
enableDisableFig(handles.figure1, true);


function handles=loadfiles(handles)
handles.totalfile=length(handles.fname);
if handles.totalfile==0,return;end

flag=1;
handles.toberemove={}; n=1;
for i=1:length(handles.newfname)       

        
    [~,fname,ext]=fileparts(handles.newfname{i});
    torem=0;
    if strcmp(ext,'.mat')
        load(handles.newfname{i}); %This will get Results 
        %check input file format
        if exist('Results','var')
            if ~isstruct(Results),torem=1;
            else [torem Results]=checkformatfile(Results);                   
            end    
        else
            torem=1;
        end    
    else
        Results=loadtxtfile(handles,i);
        if isempty(Results.hrv.Value),torem=1;end
    end
        
    if torem %remove uncompattible hrv file 
        errordlg({['Error loading file ' handles.newfname{i}],'Cannot locate HRV values in this file.'},'Incompattible data format!');
        handles.toberemove{n}=handles.newfname{i};n=n+1;
    else %be able to load HRV file, process to load R file if not exist in HRV file
        if ~isfield(Results,'rawfilename')
            Results.rawfilename='';
        elseif ~ischar(Results.rawfilename)
                Results.rawfilename='';
        end
        Results = checkRRinfo(Results,handles.newfname{i});   
    
        fromHRVmass=0;
        if isfield(Results,'fromHRVmass')
            if Results.fromHRVmass==1
                fromHRVmass=1;
            end
        end
        
        if ~fromHRVmass
            Results.fromHRVmass=0;
            Results.set=[];
            Results.param=[];
            
            [pathname,foutname,ext]=fileparts(handles.newfname{i});
            filename=fullfile(pathname,[foutname '.mat']);  
            if ~strcmp(ext,'.mat')
                warndlg([handles.newfname{i} ' will be renamed to ' filename],'Resave input file','model');
                uiwait;
            end
            save(filename,'Results');
            handles.newfname{i}=filename;
        end
    end 
   
    selg=handles.selectedgroupnum;
    handles.Group{selg}.totalfile=handles.Group{selg}.totalfile+1;
    handles.Group{selg}.fname{handles.Group{selg}.totalfile}=handles.newfname{i};
    handles.Group{selg}.Results{handles.Group{selg}.totalfile}=Results;
          
% %     try to assign initial selected HRV to plot
    if flag
        if ~isempty(handles.Group{selg}.Results{handles.Group{selg}.totalfile}.hrv.Labels)
           handles.selHRV=handles.Group{selg}.Results{handles.Group{selg}.totalfile}.hrv.Labels{1};
           flag=0;
        end 
    end
end

function [flag Results]= checkformatfile(Results)
flag=0;

%check fields for hrv 
if ~isfield(Results,'hrv')
    flag=1;
else 
    if ~isfield(Results.hrv,'Value')
        flag=1;
    else
        if ~isfield(Results.hrv,'Labels')
            % if there is no label, create them
            Results.hrv.Labels={};
            for i=1:size(Results.hrv.Value,2)
                Results.hrv.Labels = [Results.hrv.Labels; 'Unknown ' num2str(i)];
            end
            Results.hrv.Labels=Results.hrv.Labels';
        elseif ~iscellstr(Results.hrv.Labels) %has Labels field but not in the right format (cell of string)
            Results.hrv.Labels={};
            for i=1:size(Results.hrv.Value,2)
                Results.hrv.Labels = [Results.hrv.Labels; 'Unknown ' num2str(i)];
            end
            Results.hrv.Labels=Results.hrv.Labels';
        else %Check dimension of Labels and Value, adjust if needed
            if iscolumn(Results.hrv.Labels)
                Results.hrv.Labels=Results.hrv.Labels';
            end
            
            if length(Results.hrv.Labels)<size(Results.hrv.Value,2)
                %add unknown hrv for hrv with unknown label
                for i=1:size(Results.hrv.Value,2)-length(Results.hrv.Labels)
                    Results.hrv.Labels = [Results.hrv.Labels'; 'Unknown ' num2str(i)];
                end
                Results.hrv.Labels=Results.hrv.Labels';
            elseif length(Results.hrv.Labels)>size(Results.hrv.Value,2)
                % Remove label(s) that do not have value
                Results.hrv.Labels(length(Results.hrv.Value)+1:end)=[];
            end
        end
    end
end


function fname=getfname(handles)

fname={}; n=1;
for i=1:length(handles.selectedgroupnum)
    for j=1:handles.Group{handles.selectedgroupnum(i)}.totalfile
        fname{n}=handles.Group{handles.selectedgroupnum(i)}.fname{j};
        n=n+1;
    end
end



function handles=updateplot(handles)

cla(handles.axesFile);
cla(handles.axesGroup);
cla(handles.axesRR);
cla(handles.axesRRz);
cla(handles.axesPC);
cla(handles.axesLomb);
cla(handles.axesDFA);

set(handles.pvaluetxt,'string','');
set(handles.selGrouptxt,'string','');

if isempty(handles.selectedfilenum),return;end
selfile=handles.selectedfilenum(1);

handles.epochnum=1;
if ~isempty(handles.selHRV)
    handles=updateHRVplot(handles);
    handles=plotstar(handles,selfile);
    handles=updateArrowplot(handles);
else
    set(handles.selFiletxt,'string','  ');
end


if ~isempty(handles.Results{selfile}.RRinfo.R_time)
    set(handles.HRselectbutton,'visible','on');
    set(handles.RRselectbutton,'visible','on');
        
    handles=plotRR(handles,selfile);
    t0=handles.Results{selfile}.RRinfo.R_time(1)/60;
    handles=plotstem(handles,selfile,t0);    
else
    set(handles.HRselectbutton,'visible','off');
    set(handles.RRselectbutton,'visible','off');
    set(handles.showECGcheck,'visible','off');
    set(handles.text8,'visible','off');
    set(handles.text19,'visible','off');
    set(handles.pctxt,'visible','off');
    
    axes(handles.axesRR); axis off;
    axes(handles.axesRRz); axis off;
    axes(handles.axesLomb); axis off;
    axes(handles.axesPC); axis off;
    axes(handles.axesDFA); axis off;
    set(handles.SettingMenu,'visible','off');
    
end


function handles=updateHRVplot(handles)

    if isempty(handles.selHRV),return;end
    if length(handles.Results)==1                                
       plotHRV(handles);
    else
        data=[];
        
        for i=1:length(handles.Results) 
            selHRVnum=find(strcmp(handles.selHRV,handles.Results{i}.hrv.Labels));

            if isempty(selHRVnum),continue;end
            if isempty(handles.Results{i}.hrv.Value),continue;end
%             if strcmp('MNN',handles.selHRV) && strcmp(handles.RRoption,'HR')
%                 datai=60./handles.Results{i}.hrv.Value(:,selHRVnum);
%             else
                datai=handles.Results{i}.hrv.Value(:,selHRVnum);
%             end
            data=[data; datai i*ones(size(datai)) handles.GroupNum(i)*ones(size(datai))]; %the last two number is file and group numbers
        end
        
%         if length(unique(data(:,2)))==1
%             
%             return;
%         end
        
        axes(handles.axesFile);
        
        colorsvec=[]; allfile=[];
        for i=1:length(handles.Group)
            colorsvec=[colorsvec;repmat(handles.c{i},handles.Group{i}.totalfile,1)];
%             allfile{i}=handles.Group{i}
            allfile=[allfile handles.Group{i}.fname];
        end
        
       handles.selectedcolor=[];

       for i=1:length(handles.selectedfile)
           for j=1:length(allfile)
               if strcmp(handles.selectedfile{i},allfile(j))
                   handles.selectedcolor=[handles.selectedcolor;j];
               end
           end
       end 
        
        colorsvec = colorsvec(handles.selectedcolor,:);
        
        
        boxplot(data(:,1),data(:,2),'colors',colorsvec,'symbol','.');
        
        set(handles.axesFile,'Color',[0.95,0.97,0.95]);
        set(handles.axesFile,'position',handles.pos1,'xticklabel',{' '});
        grid on;
    
%         if strcmp('MNN',handles.selHRV)
%             if strcmp(handles.RRoption,'HR')
%                 ylabel([{'Mean Heart Rate'},{'(beats/min)'}],'fontweight','bold');
%             else
%                 ylabel('Mean RR interval (s)','fontweight','bold');
%             end
%         else
            content=get(handles.hrvlist,'string');
            ylabel(content(get(handles.hrvlist,'value')),'fontweight','bold');
%         end
        
        axes(handles.axesGroup);
        colorvec=[];
        for i=1:length(handles.selectedgroupnum)
            colorvec=[colorvec;handles.c{handles.selectedgroupnum(i)}];
        end
        if length(handles.selectedgroupnum)==2 
            n1=handles.Group{handles.selectedgroupnum(1)}.totalfile;
            n2=handles.Group{handles.selectedgroupnum(2)}.totalfile;
            if  n1~=0 && n2~=0 
                x=data(data(:,3)==handles.selectedgroupnum(1),1:2);
                y=data(data(:,3)==handles.selectedgroupnum(2),1:2);
                [~ , ~, handles.pvalue]=mainmanova2(x,y);    
                set(handles.pvaluetxt,'string',['p-value= ' num2str(handles.pvalue,'%1.4f')]);
            end
        else
            set(handles.pvaluetxt,'string','');
        end        
    
        boxplot(data(:,1),data(:,3),'color',colorvec,'symbol','.');
        set(handles.axesGroup,'Color',[0.95,0.97,0.95]);
        set(handles.axesGroup,'position',handles.posG,'XTickLabel',{' '});
        grid on;
   
    end
    
function handles = updateArrowplot(handles)
if length(handles.Results)>1
            
    selfile=handles.selectedfilenum(1);

    axes(handles.axesFile);
    
    ylimit=get(handles.axesFile,'ylim');
    hold on; 
    if ishghandle(handles.arrowplot),delete(handles.arrowplot);end
    mark=ylimit(2)-diff(ylimit)*3/100;
    handles.arrowplot=plot(selfile,mark,'rv'...
        ,'markersize',10,'linewidth',1); hold off;
    set(handles.axesFile,'Color',[0.95,0.97,0.95]);    
end


function handles=updateResultList(handles)

handles.Results=cell(length(handles.selectedfile),1);
handles.GroupNum=zeros(length(handles.selectedfile),1);
for k=1:length(handles.selectedfile)
    flag=0;
    for i=1:length(handles.Group)
        if flag,break;end
        for j=1:handles.Group{i}.totalfile
            if strcmp(handles.selectedfile{k},handles.Group{i}.fname{j})
                handles.Results{k}=handles.Group{i}.Results{j};
                handles.GroupNum(k) = i;
                flag=1;break;
            end
        end
    end
end
    

function handles=updateHRVlist(handles)
% This function will update HRV list when more than one hrv file is
% selected. The purpose of selecting more than 1 file is to compare hrv
% between files. However those 2 files may not have the same hrv so that we
% have to check and show only common hrvs. 


if length(handles.selectedfile)==1 % This is when one file is selected   
    %set hrv list for this file 
    hrvlist=handles.Results{1}.hrv.Labels;
else
   
    hrvlist=handles.Results{1}.hrv.Labels;
    for i=1:length(handles.selectedfile)
        hrvlist=intersect(hrvlist, handles.Results{i}.hrv.Labels,'stable');
    end 
end

set(handles.hrvlist,'string',hrvlist);

handles.selHRVnum=find(strcmp(handles.selHRV,get(handles.hrvlist,'string')));

if length(handles.selHRVnum)>1
    handles.selHRVnum=handles.selHRVnum(1);% in case of hrvlist has repeat hrv name, select only one
end

if  ~isempty(hrvlist)
    if isempty(handles.selHRVnum)
        warning('Selected HRV is not found in this file.');
        handles.selHRV=hrvlist{1}; %change selected HRV to something else
        handles.selHRVnum=1;        
    end
else
    warndlg('Selected files do not have common HRV to compare.','No common HRV');
    uiwait;  
    handles.selHRV=[];
    handles.selHRVnum=-1;
end

set(handles.hrvlist,'value',handles.selHRVnum);
    
function handles=plotHRV(handles)
    
    axes(handles.axesFile);
    
    
    if isempty(handles.Results{1}.hrv.Value),return;end
    
%     if strcmp('MNN',handles.selHRV)     
%         if strcmp(handles.RRoption,'RR')
%             RR = handles.Results{1}.hrv.Value(:,handles.selHRVnum);
%             label='Mean RR interval (s)';
%         else
%             RR = 60./handles.Results{1}.hrv.Value(:,handles.selHRVnum);
%             label=[{'Mean Heart Rate'},{'(beats/min)'}];
%         end
%         
%         plot(handles.Results{1}.hrv.time/60+handles.Results{1}.RRinfo.segmentlength/2,...
%             RR,'.-','color',handles.c{1});  
%         ylabel(label,'fontweight','bold');
%     else
        plot(handles.Results{1}.hrv.time/60+handles.Results{1}.RRinfo.segmentlength/2,...
        handles.Results{1}.hrv.Value(:,handles.selHRVnum),'.-','color',handles.c{1});    
        content=get(handles.hrvlist,'string');
        ylabel(content(get(handles.hrvlist,'value')),'fontweight','bold');
%     end
    
%     % Plot *
%    if ishghandle(handles.plotanHRV),delete(handles.plotanHRV);end
%    hold on;
%    if strcmp(handles.selHRV,'MNN') &&  strcmp(handles.RRoption,'HR') 
%         handles.plotanHRV=plot(handles.Results{1}.hrv.time(handles.epochnum)/60+handles.Results{1}.RRinfo.segmentlength/2,...
%             60./handles.Results{1}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');  
%     else
%         handles.plotanHRV=plot(handles.Results{1}.hrv.time(handles.epochnum)/60+handles.Results{1}.RRinfo.segmentlength/2,...
%             handles.Results{1}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');    
%    end
%    hold off;
   
    %set background color
    set(handles.axesFile,'Color',[0.95,0.97,0.95]);
%     tend=handles.Results{1}.RRinfo.R_time(end);
%     t1=handles.Results{1}.RRinfo.R_time(1);
    tend=handles.Results{1}.hrv.time(end);
    t1=handles.Results{1}.hrv.time(1);
    
    tick=round((t1:(tend-t1)/6:tend)/60*10/5)*5/10;
    tick =unique(tick);
    
    temp=datestr(tick/24/60,'HH:MM:SS');
    tickvec=cell(size(temp,1),1);
    for i=1:size(temp,1)
        tickvec{i}=temp(i,:);
    end
    set(handles.axesFile,'xtick',tick,'XTickLabel',{''});

    %     xlim([min(tick(1),t1/60) max(tick(end),tend/60)]);
    if ~isempty(tick)
        xlim([tick(1) tend/60+handles.Results{1}.RRinfo.segmentlength/2]); 
    end
        grid on;
    
    
    %plot box plot
    axes(handles.axesGroup);
%     if strcmp('MNN',handles.selHRV) && strcmp(handles.RRoption,'HR')
%         boxplot(60./handles.Results{1}.hrv.Value(:,handles.selHRVnum),'color',[0 100 255]/255,'symbol','.');
% %         ylabel([{'Heart Rate'},{'(beats/min)'}],'fontweight','bold');
%     else
        boxplot(handles.Results{1}.hrv.Value(:,handles.selHRVnum),'color',[0 100 255]/255,'symbol','.');
        
%         ylabel(content(get(handles.hrvlist,'value')),'fontweight','bold');
%     end
    ylim(get(handles.axesFile,'ylim'));
    set(handles.axesGroup,'position',handles.posG,'xticklabel',{' '});
    grid on;
    set(handles.axesGroup,'Color',[0.95,0.97,0.95]);
    
function handles=plotRR(handles,fnum)
    axes(handles.axesRR); 
    if isempty(handles.Results{fnum}.RRinfo.R_time),return;end   
    
    RR = handles.Results{fnum}.RRinfo.RR_interval;
    
    RR=filterRR(RR);

    if strcmp(handles.RRoption,'RR')
        
        label='RR interval (s)';
    else
        RR = 60./RR;
        label=[{'Heart Rate'},{'(beats/min)'}];
    end  
    plot(handles.Results{fnum}.RRinfo.R_time/60,RR,'color',[255 0 0]/256);    
    ylabel(label,'fontweight','bold');
    
%     handles.clickRR=0;
    set(handles.axesRR,'Color',[0.96,0.92,0.92],'fontsize',9);
    
    tend=handles.Results{fnum}.RRinfo.R_time(end);
    t1=handles.Results{fnum}.RRinfo.R_time(1);
    
    tick=round((t1:(tend-t1)/6:tend)/60*10/5)*5/10;
    tick =unique(tick);
    temp=datestr(tick/24/60,'HH:MM:SS');
    tickvec=cell(size(temp,1),1);
    for i=1:size(temp,1)
        tickvec{i}=temp(i,:);
    end
    
    set(handles.axesRR,'xtick',tick,'XTickLabel',tickvec);
    if ~isempty(tick)
        xlim([tick(1) tend/60+handles.Results{1}.RRinfo.segmentlength/2]); 
    end
    grid on;

    
% --------------------------------------------------------------------
function QuitGUI_Callback(hObject, eventdata, handles)

figure1_CloseRequestFcn(hObject, eventdata, handles)

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
handles=closeECGplot(handles);
if ~handles.saved
    temp=handles.ProjectName; if strcmp(temp,''),temp='untitled';end;
    button = questdlg(['Do you want to save project ' temp '?'],...
        'HRV_View','Save','Do not save','Cancel','Save');
    if strcmp(button,'Save')
        handles=SaveProject(handles);
        if handles.saved==0,return;end
    elseif strcmp(button,'Cancel')
        return;
    end        
end
delete(handles.figure1);



% --- Executes on selection change in ListGroup.
function ListGroup_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));

temp=get(hObject,'Value');
% if isequal(temp,handles.selectedgroupnum),return;end

handles.selectedgroupnum=temp;
handles.selectedgroup={};
for i=1:length(handles.selectedgroupnum)
    handles.selectedgroup{i}=contents{handles.selectedgroupnum(i)};
end

fname=getfname(handles);
handles=setforFile(handles,fname);

%when click on group, will select all file in the selected group
handles.selectedfile=get(handles.ListFile,'string'); 
set(handles.ListFile,'value',1:length(handles.selectedfile));
handles.selectedfilenum=get(handles.ListFile,'value');

if ~isempty(handles.selectedfile)
    handles=updateResultList(handles);
    handles=updateHRVlist(handles);
    handles=updateplot(handles); 
end

%when click on group, will disable remove file
set(handles.deletefileMenu,'enable','off');

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ListGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hrvlist.
function hrvlist_Callback(hObject, eventdata, handles)
handles.selHRVnum=get(hObject,'value');
content=get(hObject,'string');
temp=content{handles.selHRVnum};
if strcmp(handles.selHRV,temp),return;end %do nothing if select the same HRV
handles.selHRV=temp;
% handles=updateplot(handles);
handles=updateHRVplot(handles);
handles=updateArrowplot(handles);

% plot star on HRV line if RR interval if is available
% if isempty(handles.Results{1}.RRinfo.R_time),return;end 

if length(handles.selectedfile)==1
   axes(handles.axesFile);
%    set(handles.axesFile,'Color',[0.95,0.97,0.95]);
   
   
   if ishghandle(handles.plotanHRV),delete(handles.plotanHRV);end
   hold on;
%    if strcmp(handles.selHRV,'MNN') &&  strcmp(handles.RRoption,'HR') 
%         handles.plotanHRV=plot(handles.Results{1}.hrv.time(handles.epochnum)/60+handles.Results{1}.RRinfo.segmentlength/2,...
%             60./handles.Results{1}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');  
%    else
            handles.plotanHRV=plot(handles.Results{1}.hrv.time(handles.epochnum)/60+handles.Results{1}.RRinfo.segmentlength/2,...
            handles.Results{1}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');    
%    end
   hold off;
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function hrvlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hrvlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function GroupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to GroupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function addgroupMenu_Callback(hObject, eventdata, handles)
handles=addgroup(handles);
guidata(hObject, handles);

% --- Executes on button press in creategroupbutton.
function creategroupbutton_Callback(hObject, eventdata, handles)
handles=addgroup(handles);
guidata(hObject, handles);


function handles=addgroup(handles)
prompt = {'Name the new group:'};
dlg_title = 'Create group';
num_lines = 1;
newname = {'untitled'};
options.Resize='on';
options.WindowStyle='normal';

flag=1; j=1;  
while flag
   redundant=0;
   for i=1:length(handles.gname)
       if strcmp(handles.gname{i},newname)
          newname = {['untitled' num2str(j)]};
          redundant = 1; j=j+1;break;
       end
   end
   if ~redundant,flag=0; end
end
   
handles.newgname = inputdlg(prompt,dlg_title,num_lines,newname,options);
if isempty(handles.newgname),return;end

handles.Group{length(handles.Group)+1}.gname=handles.newgname;
handles.Group{length(handles.Group)}.totalfile=0;
handles.Group{length(handles.Group)}.Results={};

handles.gname=[handles.gname;handles.newgname];
handles=setforGroup(handles); %set GUI 

handles.saved = 0;
set(handles.savetool,'enable','on');
set(handles.SaveProjectMenu,'enable','on');

if strcmp(handles.ProjectName,'')
    set(handles.figure1,'Name','untitled* - HRViewer');
else
    set(handles.figure1,'Name',[handles.ProjectName '* - HRViewer'] );
end
%select the lastest group
set(handles.ListGroup,'value',length(handles.Group));
handles.selectedgroup=handles.gname{length(handles.Group)};
handles.selectedgroupnum=length(handles.Group);

% fname will always empty because we selected the lastest group
handles=setforFile(handles,{});
%promp for file selection
handles=openfile(handles);

% --------------------------------------------------------------------
function deletegroupMenu_Callback(hObject, eventdata, handles)
handles=deletegroup(handles);
guidata(hObject, handles);

function deletegroupbutton_Callback(hObject, eventdata, handles)
handles=deletegroup(handles);
guidata(hObject, handles);

function handles=deletegroup(handles)
if isempty(handles.Group),return;end

deletedgroup=handles.gname(handles.selectedgroupnum);
handles.gname(handles.selectedgroupnum)=[];

for j=1:length(deletedgroup)
    for i=1:length(handles.Group)
        if strcmp(deletedgroup{j},handles.Group{i}.gname)
            handles.Group(i)=[]; break;
        end
    end
end
set(handles.ListGroup,'String',handles.gname);  
temp=min(length(handles.Group),get(handles.ListGroup,'Value'));
set(handles.ListGroup,'Value',temp);
handles=setforGroup(handles);
    
handles.saved = 0;
set(handles.savetool,'enable','on');
set(handles.SaveProjectMenu,'enable','on');

if strcmp(handles.ProjectName,'')
    set(handles.figure1,'Name','untitled* - HRViewer');
else
    set(handles.figure1,'Name',[handles.ProjectName '* - HRViewer'] );
end

if ~isempty(handles.Group)
    handles.selectedgroupnum=temp;
    handles.selectedgroup=handles.gname{temp};            

    fname=getfname(handles);
    handles=setforFile(handles,fname);
    
    %when click on group, will select all file in the selected group
    handles.selectedfile=get(handles.ListFile,'string');    
    set(handles.ListFile,'value',1:length(handles.selectedfile));
    
    if ~isempty(handles.selectedfile)
        handles=updateResultList(handles);
        handles=updateHRVlist(handles);
        handles=updateplot(handles); 
    end
else
    handles=setforFile(handles,{});
end

% --- Executes on button press in addfilebutton.
function addfilebutton_Callback(hObject, eventdata, handles)
handles=openfile(handles);
guidata(hObject, handles);

% --- Executes on button press in deletefilebutton.
function deletefilebutton_Callback(hObject, eventdata, handles)
handles=deletefile(handles);
guidata(hObject, handles);

function handles=setforGroup(handles)


if isempty(handles.Group)
    handles.gname={};
    handles.Group={};
    handles.selectedgroupnum=0;
    handles.selectedgroup={''};
    
    set(handles.ListGroup,'enable','off');
    set(handles.deletegroupbutton,'enable','off');
    set(handles.creategroupbutton,'enable','off');
    set(handles.GroupMenu,'enable','off');
    set(handles.deletegroupMenu,'enable','off');
    
    
    set(handles.HRVFileMenu,'enable','off');
    set(handles.addfilebutton,'enable','off');
    set(handles.deletefilebutton,'enable','off');

    set(handles.ListGroup,'string',handles.gname);
    set(handles.ListGroup,'value',1);
    set(handles.selGrouptxt,'string','');

    set(handles.SaveProjectMenu,'enable','off');
    set(handles.SaveProjectAsMenu,'enable','off');
    set(handles.savetool,'enable','off');
    set(handles.SaveProjectMenu,'enable','off');

else % has some groups
    set(handles.GroupMenu,'enable','on');
    set(handles.ListGroup,'string',handles.gname);
    set(handles.ListGroup,'enable','on');
    set(handles.deletegroupbutton,'enable','on');
    set(handles.creategroupbutton,'enable','on');
    set(handles.deletegroupMenu,'enable','on');
    set(handles.HRVFileMenu,'enable','on');
    set(handles.addfilebutton,'enable','on');
%     set(handles.SaveProjectMenu,'enable','on');
    set(handles.SaveProjectAsMenu,'enable','on');
%     set(handles.savetool,'enable','on');
end


function handles=setforFile(handles,fname)

if isempty(fname)
    set(handles.ListFile,'enable','off');
    set(handles.ListFile,'string','');    

    set(handles.deletefileMenu,'enable','off');
    set(handles.deletefilebutton,'enable','off');
    set(handles.SettingMenu,'enable','off');
     
    set(handles.hrvlist,'enable','off');   
    set(handles.hrvlist,'string','');    
    
    handles.selectedfilenum=1;
    handles.selectedfile={};
    set(handles.pvaluetxt,'string','');

    set(handles.PrintMenu,'enable','off');
    set(handles.printtool,'enable','off');
    set(handles.zoomintool,'enable','off');
    set(handles.zoomouttool,'enable','off');
    set(handles.pantool,'enable','off');
    set(handles.cursortool,'enable','off');
    
%     set(handles.TPVAMenu,'enable','off');
    set(handles.showECGcheck,'enable','off');
    set(handles.showECGcheck,'value',0);
    
    set(handles.pbRightButton,'enable','off');
    set(handles.pbLeftEpochButton,'enable','off');
%     set(handles.pb_GoToStart,'enable','off');
%     set(handles.pbGoToEnd,'enable','off');
    set(handles.epochnumbox,'enable','off');
    set(handles.firstepochnumbox,'enable','off');
    set(handles.lastepochnumbox,'enable','off');
    set(handles.RemoveEpochbutton,'enable','off');
    set(handles.RRselectbutton,'enable','off');
    set(handles.HRselectbutton,'enable','off');
    
    set(handles.epochnumbox,'string','');
    set(handles.firstepochnumbox,'string','');
    set(handles.lastepochnumbox,'string','');
    set(handles.totalEpochtxt,'string','');
    
    clearaxes(handles.axesGroup);
    clearaxes(handles.axesFile);
    clearaxes(handles.axesRR);
    clearaxes(handles.axesRRz);
    clearaxes(handles.axesPC);
    clearaxes(handles.axesLomb);
    clearaxes(handles.axesDFA);
    
else % has some files
    set(handles.ListFile,'String',fname);
    set(handles.ListFile,'enable','on');    
    set(handles.hrvlist,'enable','on');     
    set(handles.SettingMenu,'enable','on'); 
    set(handles.deletefileMenu,'enable','on');
    set(handles.deletefilebutton,'enable','on');
    set(handles.PrintMenu,'enable','on');
    set(handles.printtool,'enable','on');
    set(handles.zoomintool,'enable','on');
    set(handles.zoomouttool,'enable','on');
    set(handles.pantool,'enable','on');
    set(handles.cursortool,'enable','on');
    
%     set(handles.TPVAMenu,'enable','on');
    set(handles.showECGcheck,'enable','on');
    
    set(handles.pbRightButton,'enable','on');
    set(handles.pbLeftEpochButton,'enable','on');
%     set(handles.pb_GoToStart,'enable','on');
%     set(handles.pbGoToEnd,'enable','on');
    set(handles.epochnumbox,'enable','on');
    set(handles.firstepochnumbox,'enable','on');
    set(handles.lastepochnumbox,'enable','on');
    set(handles.RemoveEpochbutton,'enable','on');
    set(handles.RRselectbutton,'enable','on');
    set(handles.HRselectbutton,'enable','on');
end

function clearaxes(h)
    cla(h);
    set(h,'XGrid','off')
    set(h,'YGrid','off')
    set(h,'yticklabel','','xticklabel','');
    axes(h); ylabel('');



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)

Loc=get(handles.axesFile,'CurrentPoint');
xLim = get(handles.axesFile,'xlim');
yLim = get(handles.axesFile,'ylim');
% Check if button down is in boxplot(file) window
if isempty(handles.selectedfile),return;end
if (Loc(3)>yLim(1) & Loc(3)<yLim(2) & Loc(1)>xLim(1) & Loc(1)<xLim(2))
    if length(handles.selectedfile)>1 %The exes1 is plotting box plot
        handles.selectedfilenum = round(Loc(1));

        handles=updateArrowplot(handles);
        
        %select new file action  
        handles.EDFfullfile=handles.Results{handles.selectedfilenum}.rawfilename;
        [~,~,ext] = fileparts(handles.EDFfullfile);
        set(handles.selFiletxt,'string',['  ' handles.selectedfile{handles.selectedfilenum}]);

        %Check if this file is .edf    
        if ~strcmp(ext,'.edf')
               handles=closeECGplot(handles); 
               set(handles.showECGcheck,'value',0,'enable','off');
               handles.showECG=0;       
        else
            set(handles.showECGcheck,'enable','on');
        end
        
        handles.param=handles.Results{handles.selectedfilenum}.param;
        handles.set=handles.Results{handles.selectedfilenum}.set;
        set(handles.SettingMenu,'enable','on');
        
        if isempty(handles.Results{handles.selectedfilenum}.RRinfo.R_time),
            guidata(hObject, handles);
            return;
        end 
        handles=plotRR(handles,handles.selectedfilenum);
        handles.epochnum=1;
        t0=handles.Results{handles.selectedfilenum}.hrv.time(handles.epochnum)/60;  
        handles=plotstem(handles,handles.selectedfilenum,t0);  
    else                        
        [~,handles.epochnum]=min(abs( round(Loc(1)-handles.Results{1}.hrv.time/60) ));
        t0=handles.Results{1}.hrv.time(handles.epochnum)/60;
        handles=plotstar(handles,1);
        handles=plotstem(handles,1,t0);       
    end
end


Loc=get(handles.axesGroup,'CurrentPoint');
xLim = get(handles.axesGroup,'xlim');
yLim = get(handles.axesGroup,'ylim');
% Check if button down is in boxplot(file) window
if (Loc(3)>yLim(1) & Loc(3)<yLim(2) & Loc(1)>xLim(1) & Loc(1)<xLim(2))
    gnum = round(Loc(1));
    set(handles.selGrouptxt,'string',[char(handles.selectedgroup{gnum})]);
    axes(handles.axesGroup);
    ylimit=get(handles.axesGroup,'ylim');

    if ishghandle(handles.arrowplotgroup),delete(handles.arrowplotgroup);end
    hold on; 
    mark=ylimit(2)-diff(ylimit)*3/100;
    handles.arrowplotgroup=plot(gnum,mark,'rv'...
        ,'markersize',10,'linewidth',1); hold off;
else
    set(handles.selGrouptxt,'string','');
    if ishghandle(handles.arrowplotgroup),delete(handles.arrowplotgroup);end
%     handles.clickboxgroup=0;
end

Loc=get(handles.axesRR,'CurrentPoint');
xLim = get(handles.axesRR,'xlim');
yLim = get(handles.axesRR,'ylim');
% Check if button down is in RR(file) window
if (Loc(3)>yLim(1) & Loc(3)<yLim(2) & Loc(1)>xLim(1) & Loc(1)<xLim(2))
    selfile=handles.selectedfilenum(1);
    if length(handles.Results)==1,selfile=1;end
    if isempty(handles.Results{selfile}.RRinfo.R_time)
        guidata(hObject, handles);
        return;
    end
    [~, handles.epochnum]=min(abs( round(Loc(1)-handles.Results{selfile}.hrv.time/60) ));

    t0=handles.Results{selfile}.hrv.time(handles.epochnum)/60;
    handles=plotstar(handles,selfile);
    handles=plotstem(handles,selfile,t0);
end
guidata(hObject, handles);

function handles=plotstar(handles,selfile)
enableDisableFig(handles.figure1, false);
T=handles.Results{selfile}.RRinfo.segmentlength;
handles=setepochnum(handles);
set(handles.totalEpochtxt,'string',['/' num2str(length(handles.Results{selfile}.hrv.time))]);
set(handles.epochlengthtxt,'string',['Epoch length = ' num2str(T) ' minutes']);

if length(handles.selectedfile)==1
   axes(handles.axesFile);
   set(handles.axesFile,'Color',[0.95,0.97,0.95]);
   if ishghandle(handles.plotanHRV),delete(handles.plotanHRV);end
   hold on;
%    if strcmp('MNN',handles.selHRV) && strcmp(handles.RRoption,'HR')
%         handles.plotanHRV=plot(handles.Results{1}.hrv.time(handles.epochnum)/60+handles.Results{1}.RRinfo.segmentlength/2,...
%             60./handles.Results{1}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');  
%    else
        handles.plotanHRV=plot(handles.Results{1}.hrv.time(handles.epochnum)/60+handles.Results{1}.RRinfo.segmentlength/2,...
        handles.Results{1}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');    
%    end
   hold off;
end
enableDisableFig(handles.figure1, true);

function handles=plotstem(handles,selfile,t0)
%Plot stem (bar) on RR plot, execuse only when RR time is available
if isempty(handles.Results{selfile}.RRinfo.R_time),return;end
% enableDisableFig(handles.figure1, false);
if ishghandle(handles.stemplot),delete(handles.stemplot);end

T=handles.Results{selfile}.RRinfo.segmentlength;
tend=t0+T;
ind1=find(handles.Results{selfile}.RRinfo.R_time/60>=t0,1,'first');
ind2=find(handles.Results{selfile}.RRinfo.R_time/60<tend,1,'last');
rr_time=handles.Results{selfile}.RRinfo.R_time(ind1:ind2);


% update stem

axes(handles.axesRR);hold on;
ylimit=get(handles.axesRR,'ylim');
handles.stemplot=stem([rr_time(1) rr_time(end)]/60,1000*[1 1],...
'color',[0 100 255]/255,'marker','none','linewidth',1);
ylim(ylimit); hold off;

%check if file is from HRVmass and process 
if handles.Results{selfile}.fromHRVmass
    set(handles.text8,'visible','on');
    set(handles.text19,'visible','on');
    set(handles.pctxt,'visible','on');
    set(handles.showECGcheck,'visible','on');
    set(handles.SettingMenu,'visible','on');
    handles=plotepoch(handles,selfile,t0);
    
    handles.EDFfullfile=handles.Results{selfile}.rawfilename;
    [~,~,ext] = fileparts(handles.EDFfullfile);
    set(handles.selFiletxt,'string',['  ' handles.selectedfile{selfile}]);

%     %Check if raw file is .edf    
%     if ~strcmp(ext,'.edf')
%            handles=closeECGplot(handles); 
%            set(handles.showECGcheck,'value',0,'enable','off');
%            handles.showECG=0;       
%     else
%         set(handles.showECGcheck,'enable','on');
%     end

else
    set(handles.text8,'visible','off');
    set(handles.text19,'visible','off');
    set(handles.pctxt,'visible','off');
    set(handles.showECGcheck,'visible','off');
    
    axes(handles.axesRRz); axis off;
    axes(handles.axesLomb); axis off;
    axes(handles.axesPC); axis off;
    axes(handles.axesDFA); axis off;
    
    set(handles.SettingMenu,'visible','off');
end
% enableDisableFig(handles.figure1, true);       

function handles=plotepoch(handles,selfile,t0)
T=handles.Results{selfile}.RRinfo.segmentlength;
tend=t0+T;
ind1=find(handles.Results{selfile}.RRinfo.R_time/60>=t0,1,'first');
ind2=find(handles.Results{selfile}.RRinfo.R_time/60<tend,1,'last');
rr_time=handles.Results{selfile}.RRinfo.R_time(ind1:ind2);
rr_interval=handles.Results{selfile}.RRinfo.RR_interval(ind1:ind2);    

% Plot RRz histogram
axes(handles.axesRRz);
hii = leverage(rr_interval);   ri = rr_interval-mean(rr_interval);   
ci = hii./(1-hii).*ri.^2;
indr=ci>4/length(rr_interval); % index of outliers
temp=rr_interval;
temp(indr)=[];

[f edges]=gethistogram(temp,1/128);
% if strcmp(handles.RRoption,'HR')
%     edges=60./edges;
% end
bar(edges,f,'facecolor',[0.04 0.52 0.78],'edgecolor','b');
% if strcmp(handles.RRoption,'HR')
    xlabel('RR (s)','fontweight','bold');
% else
%     xlabel([{'Heart Rate'},{'(beats/min)'}],'fontweight','bold');
% end

set(handles.axesRRz,'Color',[0.94,0.94,0.94]);
ylimit=get(handles.axesRRz,'ylim');
xlimit=get(handles.axesRRz,'xlim');

%compute TINN here
[Y X]=max(f); 
%Left triangle                 
d1=zeros(X-1,1);
for x=1:X-1                 
    q=[zeros(x-1,1); Y/(X-x)*((x:X)'-x)];
    d1(x)=sum((f(1:X)-q).^2);              
end
[~, iA]=min(d1);
A = edges(iA);

xl=edges(edges>=A & edges<=edges(X));
yl=Y*(xl-A)/(edges(X)-A);
hold on;
plot(xl,yl,'-','color','r');


%Right triangle                     
d2=zeros(length(edges)-X,1);
for x=X+1:length(edges)                   
    q=[Y/(x-X)*(x-(X:x-1)'); zeros(length(edges)-x+1,1)];
    d2(x-X)=sum((f(X:end)-q).^2); 
end

[~, iB]=min(d2); 
B=edges(iB+X-1);      

xr=edges(edges>=edges(X) & edges<=B);
yr=Y*(B-xr)/(B-edges(X));
plot(xr,yr,'-','color','r');
hold off;



if handles.Results{selfile}.set.hrv.geo
    num= strcmp(handles.Results{selfile}.hrv.Labels,'TRI');
    TRI = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
    txt1=['TRI=' num2str(TRI,2)];
    text(xlimit(1)+(xlimit(2)-xlimit(1))*2/3,ylimit(2)*7/8,txt1,'fontsize',8,'color','b');

    num= strcmp(handles.Results{selfile}.hrv.Labels,'TINN');
    TINN = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
    txt1=['TINN=' num2str(TINN,2)];
    text(xlimit(1)+(xlimit(2)-xlimit(1))*2/3,ylimit(2)*6/8,txt1,'fontsize',8,'color','b');
end

% if handles.Results{selfile}.set.hrv.geo
%     num= strcmp(handles.Results{selfile}.hrv.Labels,'MNN');
%     MNN = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
%     txt1=['MNN=' num2str(MNN,2)];
%     text(xlimit(1)+(xlimit(2)-xlimit(1))*2/3,ylimit(2)*7/8,txt1,'fontsize',8,'color','b');
% 
%     num= strcmp(handles.Results{selfile}.hrv.Labels,'SDNN');
%     SDNN = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
%     txt1=['SDNN=' num2str(SDNN,2)];
%     text(xlimit(1)+(xlimit(2)-xlimit(1))*2/3,ylimit(2)*6/8,txt1,'fontsize',8,'color','b');
% end


% Plot Poincare
if handles.Results{selfile}.set.hrv.poincare
    axes(handles.axesPC);
    tau=handles.Results{selfile}.param.hrv.pctau;
%     plot([min(rr_interval) max(rr_interval)],[min(rr_interval) max(rr_interval)],'r');hold on;
%     plot(rr_interval(1:end-tau),rr_interval(1+tau:end),'color',[0 100 0]/255,'marker','.','linestyle','none');hold off;    
%     set(handles.pctxt,'string',['Poincare plot: tau = ' num2str(tau)]); 
%     if strcmp(handles.RRoption,'HR')
%         PlotPoincare(60./rr_interval,tau);
%         xlabel('HR_{n} (beats/min)','fontweight','bold'); ylabel('HR_{n+1} (beats/min)','fontweight','bold');
%     else
        PlotPoincare(rr_interval,tau);
        xlabel('RR_{n} (s)','fontweight','bold'); ylabel(['RR_{n+' num2str(tau) '} (s)'],'fontweight','bold');
%     end
    %     grid on;
    set(handles.axesPC,'Color',[0.94,0.94,0.94]);
%     axis tight;    
else
    cla(handles.axesPC);
end

% plot lomb periodogram
if handles.Results{selfile}.set.hrv.lomb
     
    axes(handles.axesLomb);
    [f P]=FASPER(rr_time-rr_time(1),rr_interval);
%     yy = P/sum(P);
    yy=smooth(P/sum(P),'moving',3);
    
    lowerLF = handles.Results{selfile}.param.hrv.lowerLF;
    higherLF = handles.Results{selfile}.param.hrv.higherLF;
    
    lowerHF=handles.Results{selfile}.param.hrv.lowerHF;
    higherHF=handles.Results{selfile}.param.hrv.higherHF;
    
    yy(f<lowerLF/4)=0;
    LF = f( f>=lowerLF & f<=higherLF); yLF = yy( f>=lowerLF & f<=higherLF);
    HF = f( f>=lowerHF & f<=higherHF); yHF = yy( f>=lowerHF & f<=higherHF); 

%     if ~isempty(LF),LFP=sum(LF)/sum(P);
%     else LFP=-Inf;end
%     
%     if ~isempty(HF),HFP=sum(HF)/sum(P);
%     else HFP=-Inf;end    
%     
%     LHR=LFP./HFP;
    
    h=area(LF,yLF); set(h,'FaceColor',[1 0.6 0.78]); hold on;
    h=area(HF,yHF); set(h,'FaceColor',[0.68 0.92 1]);    
    plot(f,yy,'k');
    axis tight;
    ylabel('Relative power','fontweight','bold');
    xlabel('Frequency (Hz)','fontweight','bold');
    ylimit=get(handles.axesLomb,'ylim');
    xlimit=get(handles.axesLomb,'xlim');
    
    num= strcmp(handles.Results{selfile}.hrv.Labels,'LFP');
    LFP = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
    
    num= strcmp(handles.Results{selfile}.hrv.Labels,'HFP');
    HFP = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
    
    num= strcmp(handles.Results{selfile}.hrv.Labels,'LHR');
    LHR = handles.Results{selfile}.hrv.Value(handles.epochnum,num);
    
    txt1=['LFP=' num2str(LFP,2)];
    txt2=['HFP=' num2str(HFP,2)];
    txt3=['LHR=' num2str(LHR,2)];
%     text(LF(1),max(ylimit(2)*2/3,max(yLF)),txt1,'fontsize',8,'color','r');
%     text(HF(1),max(ylimit(2)/2,max(yHF)),txt2,'fontsize',8,'color','b');
%     text(HF(end),max(ylimit(2)/2,max(yHF)),txt3,'fontsize',8,'color','k');

    
    text(xlimit(2)*2/3,ylimit(2)*7/8,txt1,'fontsize',8,'color',[0.48 0.06 0.89]);
    text(xlimit(2)*2/3,ylimit(2)*6/8,txt2,'fontsize',8,'color',[0.04 0.52 .78]);
    text(xlimit(2)*2/3,ylimit(2)*5/8,txt3,'fontsize',8,'color','b');

%     text(LF(1), max( [ylimit(2)*2/3 max(yLF) max(yHF)]),txt,'fontsize',8);
    
    xlim([min(f(1),handles.Results{selfile}.param.hrv.lowerLF) max(f(end),handles.Results{selfile}.param.hrv.higherHF)]);
    set(handles.axesLomb,'Color',[0.94,0.94,0.94]);
    hold off;
else
    cla(handles.axesLomb);
end

%Plot DFA
axes(handles.axesDFA);
n=4:16;   N1=length(n);
F_n=zeros(N1,1);
 for i=1:N1
     F_n(i)=DFA(rr_interval,n(i),1);
 end
n=n';
plot(log10(n),log10(F_n),'.'); hold on;
A=polyfit(log10(n(1:end)),log10(F_n(1:end)),1);
Alpha1=A(1);
y=polyval(A,log10(n));
plot(log10(n),y,'r');
txtA1=['\alpha_1=' num2str(Alpha1,2)];
text(log10(n(round(length(n)/3))),y(round(length(n)/2))+0.1,txtA1,'fontsize',8,'color','r','HorizontalAlignment','center');
% Again for alpha2
n=16:64;   N1=length(n);
F_n=zeros(N1,1);
 for i=1:N1
     F_n(i)=DFA(rr_interval,n(i),1);
 end
n=n';
plot(log10(n),log10(F_n),'.'); hold on;
xlabel('log(n)','fontweight','bold'); ylabel('log(F(n))','fontweight','bold')
A=polyfit(log10(n(1:end)),log10(F_n(1:end)),1);
Alpha2=A(1);
y=polyval(A,log10(n));
plot(log10(n),y,'color',[0 0.39 0]);  
txtA2=['\alpha_2=' num2str(Alpha2,2)];
text(log10(n(round(length(n)/3))),y(round(length(n)/2))+0.1,txtA2,'fontsize',8,'color',[0 0.39 0],'HorizontalAlignment','center');

hold off;
set(handles.axesDFA,'Color',[0.94,0.94,0.94]);


%--------------------------------------

% save rr_interval for TPVA and maybe for ECG_view
handles.RR_interval=rr_interval;
handles.R_time=rr_time;

handles.t0=t0;

%Plot ECG if needed
if get(handles.showECGcheck,'value')
    handles=prepareECGfile(handles,selfile);
    if handles.foundECG
        % don't need to call ECGViewer if it's been already opened
        flag=1;
        if isfield(handles,'hecg')
            if ishandle(handles.hecg.figure1) 
                flag=0;
            end
        end
        if flag, handles.hecg=ECGViewer(handles); end
       
%         set(handles.hecg.figure1,'position',handles.ECGposition);  
        handles=LoadandPlotECG(handles); 
    else
       handles=closeECGplot(handles); 
       set(handles.showECGcheck,'value',0);
       handles.showECG=0;
    end
else
    handles=closeECGplot(handles);
end

% % --------------------------------------------------------------------
% function EDF_ViewMenu_Callback(hObject, eventdata, handles)
% % hObject    handle to EDF_ViewMenu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% EDF_View;

% % --------------------------------------------------------------------
% function HRV_ComputeMenu_Callback(hObject, eventdata, handles)
% % hObject    handle to HRV_ComputeMenu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% HRV_Compute;


% --------------------------------------------------------------------
function PrintMenu_Callback(hObject, eventdata, handles)
PrintManager(handles);


% --------------------------------------------------------------------
function SessionMenu_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function LoadProjectMenu_Callback(hObject, eventdata, handles)
% [handles.Group name]=ConfigManager([],'load',handles.rootpath,...
%     '','newproject','project','HRVFileMenu a project');

if ~handles.saved
    temp=handles.ProjectName; if strcmp(temp,''),temp='untitled';end;
    button = questdlg(['Do you want to save project ' temp '?'],...
        'HRV_View','Save','Do not save','Cancel','Save');
    if strcmp(button,'Save')
        handles=SaveProject(handles);
        if handles.saved==0,return;end
    elseif strcmp(button,'Cancel')
        return;
    end        
end

path = fullfile(handles.rootpath,'project');
[FileName,PathName] = uigetfile([path '\*.mat'],'Open project');

if FileName==0,return;end
file = fullfile(PathName,FileName);
load(file);
if ~exist('Group')
    warndlg([file ' is not a project file.'],'File error','replace');
    return;
end

% reset everything
handles=getstart(handles);

handles.ProjectName=file;
handles.saved = 1;
set(handles.savetool,'enable','off');
set(handles.SaveProjectMenu,'enable','off');

set(handles.figure1,'Name',[handles.ProjectName ' - HRViewer'] );

handles.Group=Group;

%First get Result struct
flag=1;
handles.gname=cell(length(handles.Group),1);
for i=1:length(handles.Group)
    handles.newfname=handles.Group{i}.fname;
    
    for j=1:length(handles.newfname)
        handles.gname{i}=char(handles.Group{i}.gname);
        
        %handles.newfname{j}(1:22)=[];
        
        
        fid=fopen(handles.newfname{j});
        if fid==-1
            warndlg(['Cannot find ' handles.newfname{j}]);
            continue;
        end
        
        load(handles.newfname{j});
        handles.Group{i}.Results{j}=Results;
        if flag
            if ~isempty(handles.Group{i}.Results{j}.hrv.Labels)
               handles.selHRV=handles.Group{i}.Results{j}.hrv.Labels{1};
               flag=0;
            end 
        end
    end
end

if flag
%     guidata(hObject, handles); % check if should be here
    return; %do nothing if cannot load any file.
end
% Now set up

handles=setforGroup(handles); %set GUI 

%Select the first Group
set(handles.ListGroup,'value',1);
handles.selectedgroup={handles.gname{1}};
handles.selectedgroupnum=1;

fname=getfname(handles);
handles=setforFile(handles,fname);

%Select the first file
content=get(handles.ListFile,'string');
handles.selectedfile={content{1}};
set(handles.ListFile,'value',1);
handles.selectedfilenum=1;
% Update GUI
handles=updateResultList(handles);
handles=updateHRVlist(handles);
handles=updateplot(handles); 

guidata(hObject, handles);


% --------------------------------------------------------------------
function SaveProjectMenu_Callback(hObject, eventdata, handles)
handles=SaveProject(handles);
guidata(hObject, handles);

% --------------------------------------------------------------------
function SaveProjectAsMenu_Callback(hObject, eventdata, handles)
handles=SaveProjectAs(handles);
guidata(hObject, handles);

function handles=SaveProject(handles)


if ~strcmp(handles.ProjectName,'')
    Group=handles.Group;
    for i=1:length(Group)
        Group{i}=rmfield(Group{i},'Results');
    end
    save(handles.ProjectName,'Group');
    set(handles.figure1,'Name',[handles.ProjectName ' - HRViewer'] );
    handles.saved = 1;
    set(handles.savetool,'enable','off');
    set(handles.SaveProjectMenu,'enable','off');
else
    handles=SaveProjectAs(handles);
end

function handles=SaveProjectAs(handles)


path = fullfile(handles.rootpath,'project');
[FileName,PathName] = uiputfile([path '\*.mat'],'Save as');

if FileName==0,return;end

handles.ProjectName = fullfile(PathName,FileName);
if ~strcmp(handles.ProjectName(end-3:end),'.mat')
    handles.ProjectName=[handles.ProjectName '.mat'];
end

Group=handles.Group;
for i=1:length(Group)
    Group{i}=rmfield(Group{i},'Results');
end
save(handles.ProjectName,'Group');
handles.saved = 1;
set(handles.savetool,'enable','off');
set(handles.SaveProjectMenu,'enable','off');
set(handles.figure1,'Name',[handles.ProjectName ' - HRViewer'] );


function epochnumbox_Callback(hObject, eventdata, handles)
% hObject    handle to epochnumbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x=str2double(get(hObject,'String'));
 
if isnan(x) || x<=0
   errordlg('Epoch number must be a positive number','Input error','replace'); 
   set(handles.epochnumbox,'BackgroundColor',[1 0.6 0.7]);
   return;
end
handles.epochnum=x;
handles=slideepoch(handles);
guidata(hObject, handles);

function handles=setepochnum(handles)

x=handles.epochnum;
handles.firstepochnum=x;
handles.lastepochnum=handles.epochnum;
set(handles.epochnumbox,'String',num2str(x));

set(handles.epochnumbox,'String',num2str(x),'BackgroundColor',[1 1 1]);
set(handles.firstepochnumbox,'String',num2str(x),'BackgroundColor',[1 1 1]);
set(handles.lastepochnumbox,'String',num2str(x),'BackgroundColor',[1 1 1]);




function handles=slideepoch(handles)
selfile=handles.selectedfilenum(1);

if length(handles.Results)==1,selfile=1;end

if handles.epochnum<1
    handles.epochnum=1;
elseif handles.epochnum>length(handles.Results{selfile}.hrv.time)
    handles.epochnum=length(handles.Results{selfile}.hrv.time);    
end
handles.firstepochnum=handles.epochnum;
handles.lastepochnum=handles.epochnum;

t0=handles.Results{selfile}.hrv.time(handles.epochnum)/60;
handles=plotstar(handles,selfile);
handles=plotstem(handles,selfile,t0);



% --- Executes during object creation, after setting all properties.
function epochnumbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epochnumbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% function TPVAMenu_Callback(hObject, eventdata, handles)
%     if length(handles.selectedfilenum)>1
%         selfile=handles.selectedfilenum(1);
%     else
%         selfile=handles.selectedfilenum;
%     end
%     
%     if length(handles.Results)==1,selfile=1;end
%     
% % handles.fs=handles.Results{selfile}.fileinfo.samplingfreq;
% handles.FileName=handles.selectedfile{selfile};
% TPVAnalysis(handles);
% 

% --- Executes on button press in showECGcheck.
function showECGcheck_Callback(hObject, eventdata, handles)
handles.showECG =get(hObject,'value');

if length(handles.selectedfilenum)>1
    selfile=handles.selectedfilenum(1);
else
    selfile=handles.selectedfilenum;
end

if length(handles.Results)==1,selfile=1;end
    
if handles.showECG
    handles=prepareECGfile(handles,selfile);
    if handles.foundECG
        handles.hecg=ECGViewer(handles);
        handles=LoadandPlotECG(handles); 
    else
       handles=closeECGplot(handles); 
       set(handles.showECGcheck,'value',0);
       handles.showECG=0;
    end
else
    handles=closeECGplot(handles);
end
guidata(hObject,handles);

function handles=closeECGplot(handles)
if isfield(handles,'hecg')
    if ishandle(handles.hecg.figure1)
        delete(handles.hecg.figure1);
        set(handles.showECGcheck,'value',0);
        handles.showECG=0;
        handles=rmfield(handles,'hecg');
    end
end
        

function handles=prepareECGfile(handles,selfile)
    if ~strcmp(handles.Results{selfile}.rawfilename(end-3:end),'.edf')
        handles.foundECG=0;
        return; %same file, use current file info
    end
    if strcmp(handles.currentECGfile,handles.Results{selfile}.rawfilename)
        return; %same file, use current file info
    end        
           
    %HRVFileMenu new file
    handles.EDFfullfile=handles.Results{selfile}.rawfilename;
    if handles.fid~=-1
        fclose(handles.fid);
        % close current file and process to hrvfilemenu the new one
    end
    handles.fid = fopen(handles.EDFfullfile);
    handles.currentECGfile=handles.EDFfullfile;

    % HRVFileMenu file dlg if cannot file not found
    if handles.fid==-1 
        [filename, filepath] = uigetfile('*.edf','Select ECG file');
        if filename==0,handles.foundECG=0;return;end
        handles.EDFfullfile=fullfile(filepath,filename);
        handles.Results{selfile}.rawfilename=handles.EDFfullfile;
        handles.fid = fopen(handles.EDFfullfile);
        handles.currentECGfile=handles.EDFfullfile;
    end
       
    handles.foundECG=1;
    handles.set=handles.Results{selfile}.set;
    handles.param=handles.Results{selfile}.param;
        
    handles.set.ecgch.defaultname = handles.set.ecgch.chnum;
    handles.set.ecgch.chpref = 1;
    handles=findchannelnum(handles);
    
    if isempty(handles.ECGch)
       text=['Cannot find the ECG channel name "'...
        handles.set.ecgch.chnum '" in the file '...
        handles.EDFfullfile];
        return;
    end
    

    % Collect file information
    h=edfInfo(handles.EDFfullfile);
    handles.FileInfo=h.FileInfo; handles.ChInfo=h.ChInfo;
    handles.fs=handles.ChInfo.nr(handles.ECGch)/handles.FileInfo.DataRecordDuration;
    handles.numdata=handles.FileInfo.NumberDataRecord*handles.FileInfo.DataRecordDuration;

    numSkipHeaderByte=handles.FileInfo.HeaderNumBytes; %header byte
    numSkipBeforByte=2*sum(handles.ChInfo.nr(1:(handles.ECGch-1))); %byte of channels before first ecg channel    
    handles.numSkipAfterByte=2*(sum(handles.ChInfo.nr)-handles.ChInfo.nr(handles.ECGch)); %byte of channel after the last ECGch
     
     
    fseek(handles.fid,numSkipHeaderByte+numSkipBeforByte,-1);
    handles.origin=ftell(handles.fid);
    
    % Design filter
    handles=DesignFilters(handles);
    handles.w=handles.Results{selfile}.param.hrv.epochsize*60;
    
function handles=LoadandPlotECG(handles)

handles.offset=handles.t0*60;
blockstart=floor(handles.offset/handles.FileInfo.DataRecordDuration)*handles.FileInfo.DataRecordDuration;
ndel1 = round((handles.offset-blockstart)*handles.fs); %number of data point to be deleted after load the block
N=ceil(handles.w/handles.FileInfo.DataRecordDuration)*handles.FileInfo.DataRecordDuration+1; %number of second to be read
data=zeros(N*handles.fs,1);    
w=handles.ChInfo.nr(handles.ECGch); %number of data point in each block
fseek(handles.fid,handles.origin+2*sum(handles.ChInfo.nr)*blockstart/handles.FileInfo.DataRecordDuration,-1);
handles.x=edfread(N,handles,w,data,handles.offset,ndel1);
% fclose(handles.fid);

if isempty(handles.x)
    return;
end
handles.x(handles.x(:,1)>handles.offset+handles.w,:)=[];

if handles.param.filter.detrend 
    handles.x(:,2)=detrendECG(handles.x(:,2));
end

handles.x(:,2) = filter(handles.FilterParam.B,handles.FilterParam.A,handles.x(:,2));

% prepare ECGViewer window
temp = handles.hecg.epoch_menu_values;
temp(temp>handles.param.hrv.epochsize*60)=[];
ln=length(temp);
set(handles.hecg.PopMenuWindowTime,'String',handles.hecg.epoch_menu_strings(1:ln));
set(handles.hecg.PopMenuWindowTime,'value',ln);

%Plot RR
axes(handles.hecg.axesRR);

RR = handles.RR_interval;

RR=filterRR(RR);

if strcmp(handles.RRoption,'RR')    
    label='RR interval (s)';
else
    RR = 60./RR;
    label=[{'Heart Rate'},{'(beats/min)'}];
end  
plot(handles.R_time/60,RR,'.-','color',[255 0 0]/256);    
ylabel(label,'fontweight','bold');


% t1=handles.R_time(1);
% tend=handles.R_time(end);

t1=handles.x(1,1);
tend=handles.x(end,1);


tick=(t1:(tend-t1)/5:tend)/60*2/2;
tick =unique(tick);
temp=datestr(tick/24/60,'HH:MM:SS');
tickvec=cell(size(temp,1),1);
for i=1:size(temp,1)
    tickvec{i}=temp(i,:);
end


set(handles.hecg.axesRR,'xtick',tick,'XTickLabel',tickvec);
if ~isempty(tick)
    xlim([tick(1) tick(end)]);
end
grid on;
set(handles.hecg.axesRR,'Color',[0.96,0.92,0.92],'fontsize',9);

%Plot ECG
axes(handles.hecg.axesECG); 
plot(handles.x(:,1)/60 ,handles.x(:,2),'color',[0 100 200]/255); hold on; 
tick=get(handles.hecg.axesRR,'xtick');
% round((t1:(tend-t1)/5:tend)/60*2)/2;
temp=datestr(tick/24/60,'HH:MM:SS');
tickvec=cell(size(temp,1),1);
for i=1:size(temp,1)
    tickvec{i}=temp(i,:);
end

set(handles.hecg.axesECG,'xtick',tick,'XTickLabel',tickvec);
ylabel([{handles.ChInfo.Labels(handles.ECGch,1:5)}, {['(' handles.ChInfo.PhyDim(handles.ECGch,1:2) ')']}],'fontweight','bold');


xlim([tick(1) tick(end)]);
grid on;

%Plot R_time
index = round(handles.fs*handles.R_time)-round(handles.fs*handles.x(1,1))+1;
% tempR_time=handles.R_time;
% tempR_time(index>length(handles.x))=[];
index(index>length(handles.x))=[];

plot(handles.x(index,1)/60 ,handles.x(index,2),'*r','markersize',8); hold off;

%show ECG filename
set(handles.hecg.fnametxt,'string',handles.EDFfullfile);
set(handles.hecg.axesECG,'Color',[0.97,0.97,0.9],'fontsize',9);

% activate the main viewer window
axes(handles.axesRR);



function x=edfread(N,handles,w,data,offset,ndel1)
if handles.FileInfo.SignalNumbers==1
    %if there is only ecg recording,don't need to do for loop, no skip
    data=fread(handles.fid,[N*handles.fs 1],'int16');
else        
    for i=1 : floor(N/handles.FileInfo.DataRecordDuration)           
        temp=fread(handles.fid,[w 1],'int16'); 
        if length(temp)<w
            data(w*(i-1)+1 : w*(i-1)+length(temp))=temp;
            data(w*(i-1)+length(temp)+1:end)=[];
            break; 
        end
        data(w*(i-1)+(1:w))=temp;   
        fseek(handles.fid,handles.numSkipAfterByte,'cof');
    end
end
data =(data-handles.ChInfo.DiMin(handles.ECGch))/(handles.ChInfo.DiMax(handles.ECGch)-handles.ChInfo.DiMin(handles.ECGch)) *...
    (handles.ChInfo.PhyMax(handles.ECGch)-handles.ChInfo.PhyMin(handles.ECGch))+handles.ChInfo.PhyMin(handles.ECGch);

if isempty(data)
    x=[];return;
end
data(1:ndel1)=[];
temp=offset+ (0:length(data)-1)'/handles.fs;
x=[temp data];


% % --- Executes on button press in pbRightButton.
% function pbRightButton_Callback(hObject, eventdata, handles)
% x=str2double(get(handles.epochnumbox,'String'));
% if isnan(x) || x<=0
%    errordlg('Epoch number must be a positive number','Input error','replace'); 
%    return;
% end
% 
% handles.epochnum=x+1;
% handles=slideepoch(handles);
% guidata(hObject, handles);


% % --- Executes on button press in pbLeftEpochButton.
% function pbLeftEpochButton_Callback(hObject, eventdata, handles)
% x=str2double(get(handles.epochnumbox,'String'));
% if isnan(x) || x<=0
%    errordlg('Epoch number must be a positive number','Input error','replace'); 
%    return;
% end
% 
% handles.epochnum=x-1;
% handles=slideepoch(handles);
% guidata(hObject, handles);


% % --- Executes on button press in pb_GoToStart.
% function pb_GoToStart_Callback(hObject, eventdata, handles)
% handles.epochnum=1;
% handles=slideepoch(handles);
% guidata(hObject, handles);

% % --- Executes on button press in pbGoToEnd.
% function pbGoToEnd_Callback(hObject, eventdata, handles)
% temp=get(handles.totalEpochtxt,'string');
% handles.epochnum = str2double(temp(2:end));
% handles=slideepoch(handles);
% guidata(hObject, handles);


% --------------------------------------------------------------------
function SettingMenu_Callback(hObject, eventdata, handles)
% hObject    handle to SettingMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function NewProjectMenu_Callback(hObject, eventdata, handles)

if ~handles.saved
    temp=handles.ProjectName; if strcmp(temp,''),temp='untitled';end;
    button = questdlg(['Do you want to save project ' temp '?'],...
        'HRV_View','Save','Do not save','Cancel','Save');
    if strcmp(button,'Save')
        handles=SaveProject(handles);
        if handles.saved==0,return;end
    elseif strcmp(button,'Cancel')
        return;
    end        
end


handles=getstart(handles);
handles=addgroup(handles);
guidata(hObject, handles);


% --- Executes on button press in RemoveEpochbutton.
function RemoveEpochbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveEpochbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selfile=handles.selectedfilenum(1);

totalepochnum=length(handles.Results{selfile}.hrv.time);
if isnan(handles.firstepochnum) || handles.firstepochnum<=0 || handles.firstepochnum > totalepochnum
   errordlg(['Epoch number must be a positive number less than or equal to ' num2str(totalepochnum)],'Input error','replace'); 
   set(handles.firstepochnumbox,'BackgroundColor',[1 0.6 0.7]);
   return;
end
set(handles.firstepochnumbox,'BackgroundColor',[1 1 1]);

if isnan(handles.lastepochnum) || handles.lastepochnum<handles.firstepochnum || handles.lastepochnum > totalepochnum
   errordlg(['Epoch number must be a positive number between ' num2str(handles.firstepochnum) ' to ' num2str(totalepochnum)],'Input error','replace'); 
   set(handles.lastepochnumbox,'BackgroundColor',[1 0.6 0.7]);
   return;
end
set(handles.lastepochnumbox,'BackgroundColor',[1 1 1]);

% Warn user that this action cannot be undo. New HRV will be saved on the
% HRV file. 
    [selectedButton dlgshown] = uigetpref(...
        'removeepoch',...                        % Group
        'remove',...           % Preference
        'Remove epochs?',...                    % Window title
        {'This action will change HRV file and cannot be undo'
         ''
         'Are you sure you want to remove segments?'},...
        {'Remove','Do not remove'},...        % Values and button strings
         'DefaultButton','Do not remove',...             % Default choice
         'CheckboxString','Do not show this dialog again');           
     if strcmp(selectedButton,'Do not remove'),return;end


%Compute time frame to be remove
t0=handles.Results{selfile}.hrv.time(handles.firstepochnum)/60;
T=handles.Results{selfile}.RRinfo.segmentlength;
tend=handles.Results{selfile}.hrv.time(handles.lastepochnum)/60+T;

ind1=find(handles.Results{selfile}.RRinfo.R_time/60>=t0,1,'first');
ind2=find(handles.Results{selfile}.RRinfo.R_time/60<tend,1,'last');

handles.Results{selfile}.hrv.time(handles.firstepochnum:handles.lastepochnum)=[];
handles.Results{selfile}.hrv.Value(handles.firstepochnum:handles.lastepochnum,:)=[];

if ~isempty(handles.Results{selfile}.RRinfo.R_time)
    handles.Results{selfile}.RRinfo.R_time(ind1:ind2)=[];
    handles.Results{selfile}.RRinfo.RR_interval(ind1:ind2)=[];
end

set(handles.totalEpochtxt,'string',['/' num2str(length(handles.Results{selfile}.hrv.time))]);

%Assign change to handles.Group 
flag=0;
for i=1:length(handles.Group)
    if flag,break;end
    for j=1:handles.Group{i}.totalfile
        if strcmp(handles.selectedfile{selfile},handles.Group{i}.fname{j})
            handles.Group{i}.Results{j}=handles.Results{selfile};
            flag=1;break;
        end
    end
end
    
%set new curser
if handles.epochnum>length(handles.Results{selfile}.hrv.time)
    handles.epochnum=length(handles.Results{selfile}.hrv.time);
end
handles=setepochnum(handles);

selfile=handles.selectedfilenum(1);

set(handles.pvaluetxt,'string','');
set(handles.selGrouptxt,'string','');

handles=updateHRVplot(handles);
handles=plotstar(handles,selfile);

if ~isempty(handles.Results{selfile}.RRinfo.R_time)
    handles=plotRR(handles,selfile);
    t0=handles.Results{selfile}.hrv.time(handles.epochnum)/60;
    handles=plotstem(handles,selfile,t0);
end

% save new Results
Results=handles.Results{selfile};
if handles.Results{selfile}.fromHRVmass
    foutname = handles.selectedfile{selfile}(1:end-8);
    saveResults(foutname,Results);
else    
    save(handles.selectedfile{selfile},'Results');
end
guidata(hObject, handles);



% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

if strcmp(eventdata.Key,'leftarrow') || strcmp(eventdata.Key,'backspace')
     if ishghandle(handles.stemplot),delete(handles.stemplot);end
     x=str2double(get(handles.epochnumbox,'String'));
    if isnan(x) || x<=0
       errordlg('Epoch number must be a positive number','Input error','replace'); 
       set(handles.epochnumbox,'BackgroundColor',[1 0.6 0.7]);
       return;
    end
   
    set(handles.epochnumbox,'BackgroundColor',[1 1 1]);
    handles.epochnum=x-1;
    handles=slideepoch(handles);
elseif strcmp(eventdata.Key,'rightarrow') || strcmp(eventdata.Key,'space')
    if ishghandle(handles.stemplot),delete(handles.stemplot);end
    x=str2double(get(handles.epochnumbox,'String'));
    if isnan(x) || x<=0
       errordlg('Epoch number must be a positive number','Input error','replace'); 
       set(handles.epochnumbox,'BackgroundColor',[1 0.6 0.7]);
       return;
    end
    
    set(handles.epochnumbox,'BackgroundColor',[1 1 1]);

    handles.epochnum=x+1;
    handles=slideepoch(handles);
elseif strcmp(eventdata.Key,'uparrow')
    if ishghandle(handles.stemplot),delete(handles.stemplot);end
    handles.epochnum=1;
    handles=slideepoch(handles);
elseif strcmp(eventdata.Key,'downarrow')
    if ishghandle(handles.stemplot),delete(handles.stemplot);end
    temp=get(handles.totalEpochtxt,'string');
    handles.epochnum = str2double(temp(2:end));
    handles=slideepoch(handles);
    
end

guidata(hObject,handles);



function firstepochnumbox_Callback(hObject, eventdata, handles)
handles.firstepochnum=str2double(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function firstepochnumbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstepochnumbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lastepochnumbox_Callback(hObject, eventdata, handles)
handles.lastepochnum=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function lastepochnumbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lastepochnumbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in RRoptions.
function RRoptions_SelectionChangeFcn(hObject, eventdata, handles)
temp=get(eventdata.NewValue,'string');
if strcmp(temp,'RR interval')
    handles.RRoption = 'RR';
else
    handles.RRoption = 'HR';
end
% handles=updateHRVplot(handles);
% handles=updateArrowplot(handles);

selfile=handles.selectedfilenum(1);

% if ishghandle(handles.plotanHRV),delete(handles.plotanHRV);end

% hold on;
% if strcmp(handles.selHRV,'MNN') &&  strcmp(handles.RRoption,'HR') 
%     handles.plotanHRV=plot(handles.Results{selfile}.hrv.time(handles.epochnum)/60+handles.Results{selfile}.RRinfo.segmentlength/2,...
%         60./handles.Results{selfile}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');  
% else
%     handles.plotanHRV=plot(handles.Results{selfile}.hrv.time(handles.epochnum)/60+handles.Results{selfile}.RRinfo.segmentlength/2,...
%         handles.Results{selfile}.hrv.Value((handles.epochnum),handles.selHRVnum),'*r');    
% end
% hold off;
% handles=plotstar(handles,selfile);
handles=plotRR(handles,selfile);
t0=handles.Results{selfile}.hrv.time(handles.epochnum)/60;
handles=plotstem(handles,selfile,t0);
guidata(hObject, handles);


% --- Executes on button press in pbRightButton.
function pbRightButton_Callback(hObject, eventdata, handles)
x=str2double(get(handles.epochnumbox,'String'));
if isnan(x) || x<=0
   errordlg('Epoch number must be a positive number','Input error','replace'); 
   return;
end

handles.epochnum=x+1;
handles=slideepoch(handles);
guidata(hObject, handles);


% --- Executes on button press in pbLeftEpochButton.
function pbLeftEpochButton_Callback(hObject, eventdata, handles)
x=str2double(get(handles.epochnumbox,'String'));
if isnan(x) || x<=0
   errordlg('Epoch number must be a positive number','Input error','replace'); 
   return;
end

handles.epochnum=x-1;
handles=slideepoch(handles);
guidata(hObject, handles);


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)

if eventdata.VerticalScrollCount==-1
     if ishghandle(handles.stemplot),delete(handles.stemplot);end
     x=str2double(get(handles.epochnumbox,'String'));
    if isnan(x) || x<=0
       errordlg('Epoch number must be a positive number','Input error','replace'); 
       set(handles.epochnumbox,'BackgroundColor',[1 0.6 0.7]);
       return;
    end
   
    set(handles.epochnumbox,'BackgroundColor',[1 1 1]);
    handles.epochnum=x-1;
    handles=slideepoch(handles);
elseif eventdata.VerticalScrollCount==1
    if ishghandle(handles.stemplot),delete(handles.stemplot);end
    x=str2double(get(handles.epochnumbox,'String'));
    if isnan(x) || x<=0
       errordlg('Epoch number must be a positive number','Input error','replace'); 
       set(handles.epochnumbox,'BackgroundColor',[1 0.6 0.7]);
       return;
    end
    
    set(handles.epochnumbox,'BackgroundColor',[1 1 1]);

    handles.epochnum=x+1;
    handles=slideepoch(handles);
end

guidata(hObject, handles);
