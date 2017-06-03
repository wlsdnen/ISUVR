function varargout = Experiment(varargin)
% EXPERIMENT MATLAB code for Experiment.fig
%      EXPERIMENT, by itself, creates a new EXPERIMENT or raises the existing
%      singleton*.
%
%      H = EXPERIMENT returns the handle to a new EXPERIMENT or the handle to
%      the existing singleton*.
%
%      EXPERIMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT.M with the given input arguments.
%
%      EXPERIMENT('Property','Value',...) creates a new EXPERIMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment

% Last Modified by GUIDE v2.5 01-Mar-2017 21:16:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Experiment_OpeningFcn, ...
    'gui_OutputFcn',  @Experiment_OutputFcn, ...
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


% --- Executes just before Experiment is made visible.
function Experiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experiment (see VARARGIN)

% Choose default command line output for Experiment
handles.output = hObject;
global sensors
global onSensors

% Configure instrument object, obj1.
bt = varargin{1};


out = query(bt,'SensorList');
[parsedSensorData mapNameObj mapTypeObj]= ParseSensorInfo (out);
sensors = parsedSensorData;
% vid = VideoGUI (varargin{2}, handles.AxesCam);

setappdata (handles.main_ex_figure, 'bt_connection', bt);
setappdata (handles.main_ex_figure, 'vid', varargin{2});
setappdata (handles.main_ex_figure, 'mapNameObj',   mapNameObj);
setappdata (handles.main_ex_figure, 'mapTypeObj',     mapTypeObj);

set(handles.ListSensor, 'String', {parsedSensorData.name});

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experiment wait for user response (see UIRESUME)
% uiwait(handles.main_ex_figure);


% --- Outputs from this function are returned to the command line.
function varargout = Experiment_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in ListSensor.
function ListSensor_Callback(hObject, eventdata, handles)
% hObject    handle to ListSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sensors

index = get(hObject, 'Value');

if length(index) < 2
    set(handles.textName,        'String', sensors(index).name);
    set(handles.textPower,       'String', sensors(index).power);
    set(handles.textResolution,'String', sensors(index).resolution);
    set(handles.textRange,       'String', sensors(index).range);
    set(handles.textVendor,     'String', sensors(index).vendor);
    set(handles.textVersion,     'String', sensors(index).version);
end
% Hints: contents = cellstr(get(hObject,'String')) returns ListSensor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListSensor


% --- Executes during object creation, after setting all properties.
function ListSensor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in toggleRun.
function toggleRun_Callback(hObject, eventdata, handles)
% hObject    handle to toggleRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of toggleRun
warning off;
global sensors

if  get(hObject,'Value')

    bt = getappdata (handles.main_ex_figure, 'bt_connection');
    mapTypeObj = getappdata (handles.main_ex_figure, 'mapTypeObj');
    
    t = datetime('now');
    dataFilename    = strrep(datestr(t), ':', '');
    fprintf (bt, 'START');
    flushinput (bt);
    tic
    while get(hObject,'Value')
        
        str = fscanf(bt);
        
        if ~isempty(str)
            
            data = strsplit(str, ',');
            temp = [];
            idx = mapTypeObj(data{1});
            
            for i=2:length(data)
                temp(end+1) = str2double(data{i});
            end
            
            t = toc;
            sensors(idx).data(end+1, 1:length(temp)) = temp;
            sensors(idx).annotation(end+1) = -1;
            sensors(idx).count = sensors(idx).count + 1;
            
            cnt = sensors(idx).count;
            
            DrawGraph (str2double(data{1}), t, temp);

            if mod(cnt,30)==0
                drawnow limitrate
            end
            
        end
        
    end
    
    resetSensors (handles, dataFilename);
    drawnow;

else
    
    bt = getappdata (handles.main_ex_figure, 'bt_connection');
    fprintf (bt, 'STOP');
    
end


%데이터 저장 및 리셋, 파일 닫기, 
function resetSensors ( handles, filename )
%RESETSENSORS 이 함수의 요약 설명 위치
%   자세한 설명 위치
global sensors
mapNameObj = getappdata (handles.main_ex_figure, 'mapNameObj');

for i = 1:length(sensors)

    if sensors(i).count > 0
        dlmwrite (strcat(filename, '_', sensors(i).name, '.txt'), sensors(i).data);
        dlmwrite (strcat(filename, '_', sensors(i).name,'_ann' , '.txt'), sensors(i).annotation);
        sensors(i).data = [];
        sensors(i).annotation = [];
        sensors(i).count = 0;
        DrawGraph(mapNameObj(sensors(i).name));
    end
    
end


% --------------------------------------------------------------------
function SensorOn_Callback(hObject, eventdata, handles)
% hObject    handle to SensorOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx    =  get(handles.ListSensor, 'Value');
list     = get(handles.ListSensor, 'String');

mapNameObj = getappdata (handles.main_ex_figure, 'mapNameObj');
selectedSensorIndex = values(mapNameObj, list([idx]));

bt = getappdata (handles.main_ex_figure, 'bt_connection');

for i=1:length(selectedSensorIndex)
    fprintf (bt, strcat('ON:', num2str(selectedSensorIndex{i}) ) );
    DrawGraph (handles, selectedSensorIndex{i} );
end

set(handles.toggleRun, 'Enable', 'ON');

% --------------------------------------------------------------------
function SensorOff_Callback(hObject, eventdata, handles)
% hObject    handle to SensorOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx     =  get(handles.ListSensor, 'Value');
list     =  get(handles.ListSensor, 'String');

mapName = getappdata (handles.main_ex_figure, 'mapNameObj');
selectedSensorIndex = values(mapName, list([idx]));

bt = getappdata (handles.main_ex_figure, 'bt_connection');

for i=1:length(selectedSensorIndex)
    fprintf (bt, strcat('OFF:', num2str(selectedSensorIndex{i}) ) );
end


% --- Executes when user attempts to close main_ex_figure.
function main_ex_figure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to main_ex_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt = getappdata(handles.main_ex_figure, 'bt_connection');

fclose (bt);
clear (sprintf('bt'));
delete(hObject);
% Hint: delete(hObject) closes the figure


% --------------------------------------------------------------------
function SensorContext_Callback(hObject, eventdata, handles)
% hObject    handle to SensorContext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on main_ex_figure or any of its controls.
function main_ex_figure_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to main_ex_figure (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global sensors

% determine the key that was pressed
keyPressed = eventdata.Key
    
switch keyPressed
    case 'numpad0'
        for i = 1:length(sensors)
            if sensors(i).count > 0
                sensors(i).annotation(end) = 0
            end
        end
    case 'numpad1'
        for i = 1:length(sensors)
            if sensors(i).count > 0
                sensors(i).annotation(end) = 1
            end
        end
    case 'numpad2'
        for i = 1:length(sensors)
            if sensors(i).count > 0
                sensors(i).annotation(end) = 2
            end
        end
    case 'numpad3'
        for i = 1:length(sensors)
            if sensors(i).count > 0
                sensors(i).annotation(end) = 3
            end
        end
end
