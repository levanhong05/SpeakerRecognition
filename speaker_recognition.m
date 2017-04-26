function varargout = speaker_recognition(varargin)
% SPEAKER_RECOGNITION MATLAB code for speaker_recognition.fig
%      SPEAKER_RECOGNITION, by itself, creates a new SPEAKER_RECOGNITION or raises the existing
%      singleton*.
%
%      H = SPEAKER_RECOGNITION returns the handle to a new SPEAKER_RECOGNITION or the handle to
%      the existing singleton*.
%
%      SPEAKER_RECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEAKER_RECOGNITION.M with the given input arguments.
%
%      SPEAKER_RECOGNITION('Property','Value',...) creates a new SPEAKER_RECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speaker_recognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speaker_recognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speaker_recognition

% Last Modified by GUIDE v2.5 26-Apr-2017 11:30:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speaker_recognition_OpeningFcn, ...
                   'gui_OutputFcn',  @speaker_recognition_OutputFcn, ...
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


% --- Executes just before speaker_recognition is made visible.
function speaker_recognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speaker_recognition (see VARARGIN)

% Choose default command line output for speaker_recognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes speaker_recognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speaker_recognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function txtTrainingDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to txtTrainingDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTrainingDirectory as text
%        str2double(get(hObject,'String')) returns contents of txtTrainingDirectory as a double


% --- Executes during object creation, after setting all properties.
function txtTrainingDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTrainingDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnBrowser.
function btnBrowser_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % n = 1000;
    % progressbar % Create figure and set starting time
    % for i = 1:n
    %     pause(0.01) % Do something important
    %     progressbar(i/n) % Update figure
    % end
    dname = uigetdir(pwd, 'Training Data Directory');
    
    set(handles.txtTrainingDirectory, 'String', dname);

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnTraining.
function btnTraining_Callback(hObject, eventdata, handles)
% hObject    handle to btnTraining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    files = subdir(fullfile(get(handles.txtTrainingDirectory, 'String'), '', '', '*.wav'));
    
    global f_arr;
    
    f_arr = [];
    
    size = length(files);
    
    progressbar

    for i = 1:size
        if files(i).isdir == 1
        else
            fileName = files(i).name;
            
            initial_name=cellstr(get(handles.listbox1,'String'));
            new_name = [initial_name; {strjoin({'Training', fileName}, ' ')}];
            set(handles.listbox1, 'String', new_name);
            
            a = audioread(fileName);
            b = mfcc(a);
            g1_0 = gNew(12, 16, 'diag');
            g2_0 = gInit(g1_0, b, 100);
            f_arr = [f_arr; gRE(g2_0, b, 100)];
                        
            pause(0.01) % Do something important
            progressbar(i/size) % Update figure
        end
        % Do stuff
    end 
    
    uiwait(msgbox('Training Completed', 'Success', 'modal'));



function txtTestDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to txtTestDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTestDirectory as text
%        str2double(get(hObject,'String')) returns contents of txtTestDirectory as a double


% --- Executes during object creation, after setting all properties.
function txtTestDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTestDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnBrowserTest.
function btnBrowserTest_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowserTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile({'*.wav','Wav Aufio Files';},'Select Test File', pwd);
    set(handles.txtTestDirectory, 'String', strcat(pathname, filename));


% --- Executes on button press in btnTest.
function btnTest_Callback(hObject, eventdata, handles)
% hObject    handle to btnTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    x_w = audioread(get(handles.txtTestDirectory, 'String'));
    x = mfcc(x_w);
    
    global f_arr;
    
    index = 0;
    maxPercent = 0;
    
    p_arr = [];
    
    for i=1:20
        per = mean(gPr(f_arr(i), x));
        
        if per > maxPercent
            maxPercent = per;
            index = i;
        end
    end
    
    set(handles.txtSpeaker, 'String', num2str(index));
    
    if index == 1
        set(handles.chkCorrect, 'Value', 1)
        set(handles.chkIncorrect, 'Value', 0)
    else
        set(handles.chkCorrect, 'Value', 0)
        set(handles.chkIncorrect, 'Value', 1)
    end

function txtSpeaker_Callback(hObject, eventdata, handles)
% hObject    handle to txtSpeaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSpeaker as text
%        str2double(get(hObject,'String')) returns contents of txtSpeaker as a double


% --- Executes during object creation, after setting all properties.
function txtSpeaker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSpeaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkCorrect.
function chkCorrect_Callback(hObject, eventdata, handles)
% hObject    handle to chkCorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkCorrect


% --- Executes on button press in chkIncorrect.
function chkIncorrect_Callback(hObject, eventdata, handles)
% hObject    handle to chkIncorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkIncorrect
