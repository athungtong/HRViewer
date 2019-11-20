function varargout = ConfigManager(varargin)
% CONFIGMANAGER MATLAB code for ConfigManager.fig
%      CONFIGMANAGER, by itself, creates a new CONFIGMANAGER or raises the existing
%      singleton*.
%
%      H = CONFIGMANAGER returns the handle to a new CONFIGMANAGER or the handle to
%      the existing singleton*.
%
%      CONFIGMANAGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGMANAGER.M with the given input arguments.
%
%      CONFIGMANAGER('Property','Value',...) creates a new CONFIGMANAGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ConfigManager_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ConfigManager_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ConfigManager

% Last Modified by GUIDE v2.5 05-Apr-2013 12:35:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ConfigManager_OpeningFcn, ...
                   'gui_OutputFcn',  @ConfigManager_OutputFcn, ...
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


% --- Executes just before ConfigManager is made visible.
function ConfigManager_OpeningFcn(hObject, eventdata, handles, varargin)
handles.content = varargin{1};
handles.action = varargin{2};
handles.rootpath=varargin{3};
handles.filename=varargin{4};
handles.suggestname=varargin{5};
handles.folder=varargin{6};
set(handles.figure1,'Name',varargin{7});

% handles.suggestname='newsetting';

file =dir(fullfile(handles.rootpath,handles.folder)); 
file(1:2)=[];
handles.fname={};
for i=1:length(file)
    [~,~,ext]=fileparts(file(i).name);
    if ~strcmp('.mat',ext) ,continue; end
    handles.fname=[handles.fname;{file(i).name(1:end-4)}];
end
set(handles.ListFile,'Value',1);
handles.selectedfilenum=1;
handles.totalfile=length(handles.fname);
set(handles.ListFile,'String',handles.fname);

if strcmp(handles.action,'load')
   set(handles.actionbutton,'string','Load');
   set(handles.savetext,'visible','off');
   set(handles.newfnamebox,'visible','off');
end

if strcmp(handles.action,'save as')
   set(handles.actionbutton,'string','Save'); 
   set(handles.savetext,'visible','on');
   set(handles.newfnamebox,'visible','on');
%    set(handles.ListFile,'enable','off');
   
   flag=1; j=1; newname=handles.suggestname;
   while flag
       redundant=0;
       for i=1:size(handles.fname,1)
           if strcmp(handles.fname{i},newname)
              newname = [handles.suggestname num2str(j)];
              redundant = 1; j=j+1;break;
           end
       end
       if ~redundant
           set(handles.newfnamebox,'string',newname);
           handles.newfname=newname;
           flag=0;
       end
   end
end

if strcmp(handles.action,'delete')
   set(handles.actionbutton,'string','Delete');
   set(handles.cancelbutton,'string','Close');
   set(handles.savetext,'visible','off');
   set(handles.newfnamebox,'visible','off');
end

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ConfigManager wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ConfigManager_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.content;
varargout{2} = handles.filename;
delete(handles.figure1);


% --- Executes on selection change in ListFile.
function ListFile_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
handles.selectedfile=contents{get(hObject,'Value')};
handles.selectedfilenum=get(hObject,'Value');

if strcmp(handles.action,'save as')
    set(handles.newfnamebox,'String',handles.selectedfile);
    handles.newfname = handles.selectedfile;
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ListFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in actionbutton.
function actionbutton_Callback(hObject, eventdata, handles)

if strcmp(handles.action,'load')
   load(fullfile(handles.folder,[char(handles.fname(handles.selectedfilenum,:)) '.mat']));
   handles.content=content;
   handles.filename=char(handles.fname(handles.selectedfilenum,:));
   guidata(hObject, handles);
   figure1_CloseRequestFcn(hObject, eventdata, handles);
end

if strcmp(handles.action,'save as')
    content=handles.content;
    save(fullfile(handles.rootpath,handles.folder,[handles.newfname '.mat']),'content');
    handles.filename=handles.newfname;
    guidata(hObject, handles);
    figure1_CloseRequestFcn(hObject, eventdata, handles);
end

if strcmp(handles.action,'delete')
    if handles.totalfile==0,return;end
    char(handles.fname(handles.selectedfilenum,:));
    if strcmp(char(handles.fname(handles.selectedfilenum,:)),handles.filename)
        errordlg(['Cannot delete "' char(handles.fname(handles.selectedfilenum,:)) '". This setting is currently in used']);
        return;
    end
    delete(fullfile(handles.rootpath,handles.folder,[char(handles.fname(handles.selectedfilenum,:)) '.mat']));
    handles.fname(handles.selectedfilenum,:)=[];
    set(handles.ListFile,'String',handles.fname);  
    handles.totalfile=length(handles.fname);
    temp=min(handles.totalfile,get(handles.ListFile,'Value'));
    set(handles.ListFile,'Value',temp);
    if handles.totalfile==0
        set(handles.ListFile,'enable','off');
        set(handles.actionbutton,'enable','off');
    end
    
    handles.selectedfilenum=temp;    
    guidata(hObject, handles);
end


% --- Executes on button press in cancelbutton.
function cancelbutton_Callback(hObject, eventdata, handles)
figure1_CloseRequestFcn(hObject, eventdata, handles);


function newfnamebox_Callback(hObject, eventdata, handles)
handles.newfname=get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function newfnamebox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newfnamebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(handles.figure1);
