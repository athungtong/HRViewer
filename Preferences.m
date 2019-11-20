function varargout = Preferences(varargin)
% PREFERENCES MATLAB code for Preferences.fig
%      PREFERENCES, by itself, creates a new PREFERENCES or raises the existing
%      singleton*.
%
%      H = PREFERENCES returns the handle to a new PREFERENCES or the handle to
%      the existing singleton*.
%
%      PREFERENCES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREFERENCES.M with the given input arguments.
%
%      PREFERENCES('Property','Value',...) creates a new PREFERENCES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Preferences_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Preferences_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Preferences

% Last Modified by GUIDE v2.5 22-Oct-2014 12:06:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Preferences_OpeningFcn, ...
                   'gui_OutputFcn',  @Preferences_OutputFcn, ...
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


% --- Executes just before Preferences is made visible.
function Preferences_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Preferences (see VARARGIN)

handles.set.ecgch.chnum = varargin{1};
handles.set.click = varargin{2};
handles.param.filter.notch=varargin{3};
plotting = varargin{4};

handles.chnum = varargin{1};
handles.click = varargin{2};
handles.notch=varargin{3};


if strcmp(handles.set.click,'alt')
    set(handles.Rclick,'value',1);
    set(handles.Lclick,'value',0);
else
    set(handles.Rclick,'value',0);
    set(handles.Lclick,'value',1);   
end

set(handles.chnamebox,'string',handles.set.ecgch.chnum);

if handles.notch==60
    set(handles.notchpopup,'value',2);
elseif handles.notch==50
    set(handles.notchpopup,'value',3);
else
    set(handles.notchpopup,'value',1);
end

if plotting
   set(handles.chnamebox,'enable','off');
   set(handles.notchpopup,'enable','off');
else
        set(handles.chnamebox,'enable','on');
    set(handles.notchpopup,'enable','on');
end
% Choose default command line output for Preferences
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Preferences wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Preferences_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.set.ecgch.chnum;
varargout{2}=handles.set.click;
varargout{3}=handles.param.filter.notch;
delete(handles.figure1);


% --- Executes on button press in Rclick.
function Rclick_Callback(hObject, eventdata, handles)
% hObject    handle to Rclick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Rclick


% --- Executes on button press in Lclick.
function Lclick_Callback(hObject, eventdata, handles)
% hObject    handle to Lclick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Lclick



function chnamebox_Callback(hObject, eventdata, handles)
% hObject    handle to chnamebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.chnum=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function chnamebox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chnamebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in mouseoption.
function mouseoption_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in mouseoption 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
temp=get(eventdata.NewValue,'string');
if strcmp(temp,'Right click')
    handles.click = 'alt';
else
    handles.click = 'normal';
end
guidata(hObject, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
uiresume(handles.figure1);



% --- Executes on selection change in notchpopup.
function notchpopup_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
handles.notch=str2double(contents{get(hObject,'Value')});
if isnan(handles.notch)
    handles.notch=[];
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function notchpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to notchpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
handles.set.ecgch.chnum = handles.chnum;
handles.set.click = handles.click;
handles.param.filter.notch=handles.notch;
guidata(hObject, handles);
figure1_CloseRequestFcn(hObject, eventdata, handles);


% --- Executes on button press in CancelButton.
function CancelButton_Callback(hObject, eventdata, handles)
figure1_CloseRequestFcn(hObject, eventdata, handles);
