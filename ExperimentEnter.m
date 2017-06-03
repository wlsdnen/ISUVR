function varargout = ExperimentEnter(varargin)
% EXPERIMENTENTER MATLAB code for ExperimentEnter.fig
%      EXPERIMENTENTER, by itself, creates a new EXPERIMENTENTER or raises the existing
%      singleton*.
%
%      H = EXPERIMENTENTER returns the handle to a new EXPERIMENTENTER or the handle to
%      the existing singleton*.
%
%      EXPERIMENTENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTENTER.M with the given input arguments.
%
%      EXPERIMENTENTER('Property','Value',...) creates a new EXPERIMENTENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExperimentEnter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExperimentEnter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExperimentEnter

% Last Modified by GUIDE v2.5 14-Jan-2017 01:05:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ExperimentEnter_OpeningFcn, ...
    'gui_OutputFcn',  @ExperimentEnter_OutputFcn, ...
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


% --- Executes just before ExperimentEnter is made visible.
function ExperimentEnter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExperimentEnter (see VARARGIN)

% Choose default command line output for ExperimentEnter
handles.output = hObject;
% 
fileName = 'bt_history.mat';

if ~isempty (fileName)
    tmp = load(fileName);
    try
        fopen (tmp.bt);        
        setappdata (handles.main_figure, 'bt_connection', tmp.bt);
        
        set (handles.BtnStart, 'Enable', 'ON');       
        set (handles.BtnConnect,'String' ,'Disconnect');
        set (handles.ListBT, 'String', tmp.bt.RemoteName);
        set (handles.TextBT, 'String', 'Connection Succeeded');
        
%         set (handles.ListBT, 'String', tmp.bt.RemoteNames);
    catch
        set (handles.TextBT, 'String', '-');
    end
    
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ExperimentEnter wait for user response (see UIRESUME)
% uiwait(handles.main_figure);


% --- Outputs from this function are returned to the command line.
function varargout = ExperimentEnter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BtnScan.
function BtnScan_Callback(hObject, eventdata, handles)
% hObject    handle to BtnScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
obj = instrhwinfo('Bluetooth');
set (handles.ListBT, 'String', obj.RemoteNames);
set (handles.BtnConnect, 'Enable', 'ON');


% --- Executes on button press in BtnConnect.
function BtnConnect_Callback(hObject, eventdata, handles)
% hObject    handle to BtnConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btnText = get(hObject, 'String');

if strcmp (btnText, 'Connect')
    
    %The selected device for connecting
    idx = get(handles.ListBT, 'Value');
    devices = get(handles.ListBT, 'String');
    selected_device = char (devices(idx));
    
    try
        %Search the channel for the selected device.
        tmp = instrhwinfo('Bluetooth', selected_device)
        
        %Connect the device.
        bt = Bluetooth (tmp.RemoteName, str2double(tmp.Channels{1}));
        bt.InputBufferSize = 512000;
        bt.Timeout = 0.1;
        fopen (bt);
        save 'bt_history.mat' bt;        

        %Save the succeeded connection object.
        setappdata (handles.main_figure, 'bt_connection', bt);
        set (handles.BtnStart, 'Enable', 'ON');        
        set (hObject,'String' ,'Disconnect');
        
        set (handles.TextBT, 'String', 'Connection Succeeded');
    catch
        set (handles.TextBT, 'String', 'Connection Failed');
    end

else 
    fclose(getappdata(handles.main_figure, 'bt_connection'));
    set (hObject,'String' ,'Connect');
end


% --- Executes on selection change in ListBT.
function ListBT_Callback(hObject, eventdata, handles)
% hObject    handle to ListBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListBT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBT


% --- Executes during object creation, after setting all properties.
function ListBT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BtnStart.
function BtnStart_Callback(hObject, eventdata, handles)
% hObject    handle to BtnStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt = getappdata (handles.main_figure, 'bt_connection');
camIdx = get (handles.ListWebcam, 'Value');
Experiment (bt, camIdx);
close (ExperimentEnter);

% --- Executes on selection change in ListWebcam.
function ListWebcam_Callback(hObject, eventdata, handles)
% hObject    handle to ListWebcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% selected_webcam = webcam (char (devices([idx])));

% Hints: contents = cellstr(get(hObject,'String')) returns ListWebcam contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListWebcam

% --- Executes during object creation, after setting all properties.
function ListWebcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListWebcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

