function varargout = guiMain(varargin)
% GUIMAIN MATLAB code for guiMain.fig
%      GUIMAIN, by itself, creates a new GUIMAIN or raises the existing
%      singleton*.
%
%      H = GUIMAIN returns the handle to a new GUIMAIN or the handle to
%      the existing singleton*.
%
%      GUIMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMAIN.M with the given input arguments.
%
%      GUIMAIN('Property','Value',...) creates a new GUIMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiMain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiMain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiMain

% Last Modified by GUIDE v2.5 26-Feb-2019 15:40:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiMain_OpeningFcn, ...
                   'gui_OutputFcn',  @guiMain_OutputFcn, ...
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


% --- Executes just before guiMain is made visible.
function guiMain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiMain (see VARARGIN)

% Choose default command line output for guiMain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiMain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiMain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function ImageScaleSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ImageScaleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(hObject,'Value');
valueRounded = round(value);

global filename filepath;
filePathName = [filepath filename] 

image = imread(filePathName);
xsize = size(image,1);
ysize = size(image,2);

newDimension = num2str(round(xsize*32/valueRounded)) + " x " + num2str(round(ysize*32/valueRounded)) + " px";

set(handles.DimensionText, 'BackgroundColor', get( hObject, 'BackgroundColor' ) );
set(handles.DimensionText, 'String', newDimension);
set(handles.factor, 'String', num2str(valueRounded));

%set(handles.DimensionText, 'String', dimensions)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ImageScaleSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageScaleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ImagePathText_Callback(hObject, eventdata, handles)
% hObject    handle to ImagePathText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImagePathText as text
%        str2double(get(hObject,'String')) returns contents of ImagePathText as a double


% --- Executes during object creation, after setting all properties.
function ImagePathText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImagePathText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ChoosePathButton.
function ChoosePathButton_Callback(hObject, eventdata, handles)
% hObject    handle to ChoosePathButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename filepath
[filename , filepath]=uigetfile({'*.jpg'},'Select an image');
%ImagePathText_Callback(filename);
%set(handles.pushbutton1,'string','running','enable','off');
full_filepath = [filepath filename];

image = imread(full_filepath);
xsize = size(image,1);
ysize = size(image,2);

set(handles.ImageScaleSlider,'visible','on')
set(handles.factor,'visible','on')
set(handles.DatabaseMenu,'visible','on')
set(handles.GenerateButton,'visible','on')


set(handles.ImagePathText, 'String', full_filepath);
newDimension = "Use slider to decide output size";
set(handles.DimensionText, 'String', newDimension);


% --- Executes on selection change in DatabaseMenu.
function DatabaseMenu_Callback(hObject, eventdata, handles)
% hObject    handle to DatabaseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DatabaseMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DatabaseMenu


% --- Executes during object creation, after setting all properties.
function DatabaseMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DatabaseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
basicwaitbar;


% --- Executes on button press in GenerateButton.
function GenerateButton_Callback(hObject, eventdata, handles)
% hObject    handle to GenerateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
