function varargout = ECGViewer(varargin)
% ECGVIEWER MATLAB code for ECGViewer.fig
%      ECGVIEWER, by itself, creates a new ECGVIEWER or raises the existing
%      singleton*.
%
%      H = ECGVIEWER returns the handle to a new ECGVIEWER or the handle to
%      the existing singleton*.
%
%      ECGVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECGVIEWER.M handles.with the given input arguments.
%
%      ECGVIEWER('Property','Value',...) creates a new ECGVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECGViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECGViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECGViewer

% Last Modified by GUIDE v2.5 03-Jul-2014 10:03:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECGViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @ECGViewer_OutputFcn, ...
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


% --- Outputs from this function are returned to the command line.
function varargout = ECGViewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure handles.with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



% --- Executes just before ECGViewer is made visible.
function ECGViewer_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% isshow=varargin{1};
% if ~isshow 
%     figure1_CloseRequestFcn(hObject, eventdata, handles);
%     return;
% end;

h=varargin{1}; %h is handles.HRV_View
% handles.FilterParam=h.FilterParam;
handles.h=h;

% set(handles.figure1,'position', [15.0000   14.2308  224.0000   49.6154]);


handles.epoch_menu_values = [5; 10; 15; 20; 25; 30; 60; 120; 180; 300; 600];
handles.epoch_menu_strings = {'  5 sec','10 sec','15 sec','20 sec','25 sec',...
    '30 sec','  1 min','  2 min','  3 min','  5 min','10 min'};
handles.epoch_length = 20/60;
% set(handles.PopMenuWindowTime,'String',handles.epoch_menu);
% set(handles.PopMenuWindowTime,'Value',handles.epoch_menu_values);

handles.w=300;


handles.stemplot=-1;
% % Clear hypnogram and signal axes labels
% set(handles.axesECG,'xTickLabel','','yTickLabel','');
cla(handles.axesRR);
set(handles.axesRR,'xTickLabel','','yTickLabel','');
set(handles.axesRR,'XGrid','off')
set(handles.axesRR,'YGrid','off')
% 
% % Clear signal
cla(handles.axesECG);
set(handles.axesECG,'xTickLabel','','yTickLabel','');
set(handles.axesECG,'XGrid','off')
set(handles.axesECG,'YGrid','off')

ECGViewer_OutputFcn(hObject, eventdata, handles);
guidata(hObject, handles);

    
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

% if ishandle(handles.h.figure1)
    set(handles.h.showECGcheck,'value',0);
% end
delete(hObject);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

popup_id = find(handles.epoch_menu_values/60==handles.epoch_length);
set(handles.PopMenuWindowTime,'value',popup_id);
handles.epoch_length = handles.epoch_menu_values(popup_id)/60;

Loc=get(handles.axesRR,'CurrentPoint');
xLim = get(handles.axesRR,'xlim');
yLim = get(handles.axesRR,'ylim');
% Check if button down is in RR(file) PopMenuWindowTime
if (Loc(3)>yLim(1) & Loc(3)<yLim(2) & Loc(1)>xLim(1) & Loc(1)<xLim(2))
    t0=Loc(1);
    xlimit=[t0-handles.epoch_length/2 t0+handles.epoch_length/2];
  
%     xlimit0=get(handles.h.axesRRz,'xlim');
    xlimit0=xLim;
    if xlimit(2)>xlimit0(2)
        xlimit(2)=xlimit0(2);
        xlimit(1)=xlimit(2)-handles.epoch_length;
    end
    
    if xlimit(1)<xlimit0(1)
        xlimit(1)=xlimit0(1);
        xlimit(2)=xlimit(1)+handles.epoch_length;
    end
    
    handles = moveblock(handles,xlimit);
end
guidata(hObject,handles);



% --- Executes on selection change in PopMenuWindowTime.
function PopMenuWindowTime_Callback(hObject, eventdata, handles)
xlimit=get(handles.axesECG,'xlim');
% xlimit0=get(handles.h.axesRRz,'xlim');
xlimit0=get(handles.axesRR,'xlim');

popup_id = get(handles.PopMenuWindowTime,'value');
handles.epoch_length = handles.epoch_menu_values(popup_id)/60;

% if handles.epoch_length> xlimit0(2)-xlimit0(1), handles.epoch_length = xlimit0(2)-xlimit0(1);end
xlimit(2) = xlimit(1)+handles.epoch_length;

if xlimit(2)>xlimit0(2)
    xlimit(2)=xlimit0(2);
    xlimit(1)=xlimit(2)-handles.epoch_length;
end  
handles = moveblock(handles,xlimit);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function PopMenuWindowTime_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function handles = moveblock(handles,xlimit)

set(handles.axesECG,'xlim',xlimit);

tick=((xlimit(1):(xlimit(2)-xlimit(1))/5:xlimit(2))*2)/2;
tick =unique(tick);
temp=datestr(tick/24/60,'HH:MM:SS');
tickvec=cell(size(temp,1),1);
for i=1:size(temp,1)
    tickvec{i}=temp(i,:);
end
set(handles.axesECG,'xtick',tick,'XTickLabel',tickvec);

if ishghandle(handles.stemplot),delete(handles.stemplot);end
axes(handles.axesRR); hold on;
ylimit=get(handles.axesRR,'ylim');
handles.stemplot=stem(xlimit,1000*[1 1],...
'color',[0 100 255]/255,'marker','none','linewidth',2);hold off;
ylim(ylimit); 


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
xlimit = get(handles.axesECG,'xlim');
if strcmp(eventdata.Key,'leftarrow')
    xlimit=xlimit-handles.epoch_length;
elseif strcmp(eventdata.Key,'rightarrow')
    xlimit=xlimit+handles.epoch_length;
end

% xlimit0=get(handles.h.axesRRz,'xlim');
xlimit0=get(handles.axesRR,'xlim');

if xlimit(2)>xlimit0(2)
    xlimit(2)=xlimit0(2);
    xlimit(1)=xlimit(2)-handles.epoch_length;
end

if xlimit(1)<xlimit0(1)
    xlimit(1)=xlimit0(1);
    xlimit(2)=xlimit(1)+handles.epoch_length;
end

handles = moveblock(handles,xlimit);
guidata(hObject,handles);
