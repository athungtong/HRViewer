function varargout = PrintManager(varargin)
% PRINTMANAGER MATLAB code for PrintManager.fig
%      PRINTMANAGER, by itself, creates a new PRINTMANAGER or raises the existing
%      singleton*.
%
%      H = PRINTMANAGER returns the handle to a new PRINTMANAGER or the handle to
%      the existing singleton*.
%
%      PRINTMANAGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRINTMANAGER.M with the given input arguments.
%
%      PRINTMANAGER('Property','Value',...) creates a new PRINTMANAGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PrintManager_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PrintManager_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PrintManager

% Last Modified by GUIDE v2.5 17-Jul-2013 10:49:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PrintManager_OpeningFcn, ...
                   'gui_OutputFcn',  @PrintManager_OutputFcn, ...
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


% --- Executes just before PrintManager is made visible.
function PrintManager_OpeningFcn(hObject, eventdata, handles, varargin)
handles.h=varargin{1};



set(handles.figure1,'Name','Print figures')

set(handles.check1,'value',0); 
set(handles.check2,'value',0);
set(handles.check3,'value',0);
set(handles.check4,'value',0);
set(handles.check5,'value',0);
set(handles.check6,'value',0);
set(handles.check7,'value',0);
set(handles.check8,'value',0);

handles.format='-djpeg';

if get(handles.h.showECGcheck,'value')
   handles.showECG=1;
else
    handles.showECG=0;
    set(handles.check8,'enable','off');
    set(handles.fname8,'enable','off');
end


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PrintManager wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PrintManager_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function fname1_Callback(hObject, eventdata, handles)
handles.name1=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fname2_Callback(hObject, eventdata, handles)
handles.name2=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fname3_Callback(hObject, eventdata, handles)
handles.name3=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fname4_Callback(hObject, eventdata, handles)
handles.name4=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fname5_Callback(hObject, eventdata, handles)
handles.name5=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fname6_Callback(hObject, eventdata, handles)
handles.name6=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fname7_Callback(hObject, eventdata, handles)
handles.name7=get(hObject,'String');
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function fname7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fname7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fname8_Callback(hObject, eventdata, handles)
handles.name8=get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fname8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check1.
function check1_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.name1='untitle2'; set(handles.fname1,'string',handles.name1);
else
    handles.name1=''; set(handles.fname1,'string',handles.name1);
end
guidata(hObject, handles);



% --- Executes on button press in check2.
function check2_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.name2='untitle1'; set(handles.fname2,'string',handles.name2);    
else
    handles.name2=''; set(handles.fname2,'string',handles.name2);     
end
guidata(hObject, handles);


% --- Executes on button press in check3.
function check3_Callback(hObject, eventdata, handles)
if get(hObject,'Value')   
    handles.name3='untitle4'; set(handles.fname3,'string',handles.name3);
else     
    handles.name3=''; set(handles.fname3,'string',handles.name3);
end
guidata(hObject, handles);


% --- Executes on button press in check4.
function check4_Callback(hObject, eventdata, handles)
if get(hObject,'Value')     
    handles.name4='untitle3'; set(handles.fname4,'string',handles.name4);
else     
    handles.name4=''; set(handles.fname4,'string',handles.name4);
end
guidata(hObject, handles);


% --- Executes on button press in check5.
function check5_Callback(hObject, eventdata, handles)
if get(hObject,'Value')    
    handles.name5='untitle5'; set(handles.fname5,'string',handles.name5);
else     
    handles.name5=''; set(handles.fname5,'string',handles.name5);
end
guidata(hObject, handles);


% --- Executes on button press in check6.
function check6_Callback(hObject, eventdata, handles)
if get(hObject,'Value')  
    handles.name6='untitle6'; set(handles.fname6,'string',handles.name6);
else     
    handles.name6=''; set(handles.fname6,'string',handles.name6);
end
guidata(hObject, handles);


% --- Executes on button press in check7.
function check7_Callback(hObject, eventdata, handles)
handles.page= get(hObject,'Value');
if get(hObject,'Value') 
    handles.name7='untitle7'; set(handles.fname7,'string',handles.name7);
else     
    handles.name7=''; set(handles.fname7,'string',handles.name7);
end
guidata(hObject, handles);


% --- Executes on button press in check8.
function check8_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.name8='untitle8'; set(handles.fname8,'string',handles.name8);
else
    handles.name8=''; set(handles.fname8,'string',handles.name8);
end
guidata(hObject, handles);

% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
choise=get(eventdata.NewValue,'string');
if strcmp(choise,'.pdf')
    handles.format='-dpdf';
elseif strcmp(choise,'.jpeg')
    handles.format='-djpeg';
elseif strcmp(choise,'.eps')
    handles.format='-depsc';
elseif strcmp(choise,'.png')
    handles.format='-dpng';
else
    handles.format='-dbmp';
end
guidata(hObject, handles);


% --- Executes on button press in printbutton.
function printbutton_Callback(hObject, eventdata, handles)
if get(handles.check1,'value')
    hfig = figure(1);
    hax_new = copyobj(handles.h.axesGroup, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    set(hfig,'paperposition',[0 0 6 4]);
    print(hfig,handles.name1,handles.format);
    close(hfig);     
end

if get(handles.check2,'value')
    hfig = figure(1);
    hax_new = copyobj(handles.h.axesFile, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    set(hfig,'paperposition',[0 0 8 3]);
    print(hfig,handles.name2,handles.format);
    close(hfig); 
end
if get(handles.check3,'value')
    hfig = figure(1);
    hax_new = copyobj(handles.h.axesRRz, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    set(hfig,'paperposition',[0 0 6 2]);
    print(hfig,handles.name3,handles.format);
    close(hfig); 
end
if get(handles.check4,'value')
    hfig = figure(1);
    hax_new = copyobj(handles.h.axesRR, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    set(hfig,'paperposition',[0 0 8 2]);
    print(hfig,handles.name4,handles.format);
    close(hfig); 
end
if get(handles.check5,'value')
    hfig = figure(1);
    hax_new = copyobj(handles.h.axesLomb, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    set(hfig,'paperposition',[0 0 6 5]);
    print(hfig,handles.name5,handles.format);
    close(hfig); 
 
end
if get(handles.check6,'value')
    hfig = figure(1);
    hax_new = copyobj(handles.h.axesPC, hfig);
    set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
    set(hfig,'paperposition',[0 0 6 6]);
    print(hfig,handles.name6,handles.format);
    close(hfig); 

end

if get(handles.check7,'value')
    set(handles.h.figure1,'paperposition',[0 0 16 8]);
    print(handles.h.figure1,handles.name7,handles.format);
end

if get(handles.check8,'value')
    set(handles.h.hecg.figure1,'paperposition',[0 0 16 8]);
    print(handles.h.hecg.figure1,handles.name8,'-depsc');
end



figure1_CloseRequestFcn(hObject, eventdata, handles);


% --- Executes on button press in cancelbutton.
function cancelbutton_Callback(hObject, eventdata, handles)
figure1_CloseRequestFcn(hObject, eventdata, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(handles.figure1);


% --- Executes on button press in selectallcheck.
function selectallcheck_Callback(hObject, eventdata, handles)
handles.selectall= get(hObject,'Value');
if handles.selectall
    handles.name1='untitle2';     handles.name2='untitle1'; 
    handles.name3='untitle4';     handles.name4='untitle3'; 
    handles.name5='untitle5';     handles.name6='untitle6'; 
    handles.name7='untitle7'; 
    if handles.showECG
        handles.name8='untitle8';
    end
    
    set(handles.check1,'value',1); 
    set(handles.check2,'value',1);
    set(handles.check3,'value',1);
    set(handles.check4,'value',1);
    set(handles.check5,'value',1);
    set(handles.check6,'value',1);
    set(handles.check7,'value',1);
    if handles.showECG
        set(handles.check8,'value',1);
    end

else
    handles.name1='';     handles.name2='';     handles.name3='';
    handles.name4='';     handles.name5='';    handles.name6=''; 
    handles.name7=''; 
    if handles.showECG
        handles.name8='';
    end
    
    set(handles.check1,'value',0); 
    set(handles.check2,'value',0);
    set(handles.check3,'value',0);
    set(handles.check4,'value',0);
    set(handles.check5,'value',0);
    set(handles.check6,'value',0);
    set(handles.check7,'value',0);
    if handles.showECG
        set(handles.check8,'value',0);
    end
end
set(handles.fname1,'string',handles.name1);
set(handles.fname2,'string',handles.name2);
set(handles.fname3,'string',handles.name3);
set(handles.fname4,'string',handles.name4);
set(handles.fname5,'string',handles.name5);
set(handles.fname6,'string',handles.name6);
set(handles.fname7,'string',handles.name7);
if handles.showECG
    set(handles.fname8,'string',handles.name8);
end

guidata(hObject, handles);
