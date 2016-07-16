function varargout = Label_UI(varargin)
% LABEL_UI MATLAB code for Label_UI.fig
%      LABEL_UI, by itself, creates a new LABEL_UI or raises the existing
%      singleton*.
%
%      H = LABEL_UI returns the handle to a new LABEL_UI or the handle to
%      the existing singleton*.
%
%      LABEL_UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LABEL_UI.M with the given input arguments.
%
%      LABEL_UI('Property','Value',...) creates a new LABEL_UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Label_UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Label_UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Label_UI

% Last Modified by GUIDE v2.5 27-Jul-2015 08:46:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Label_UI_OpeningFcn, ...
                   'gui_OutputFcn',  @Label_UI_OutputFcn, ...
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


% --- Executes just before Label_UI is made visible.
function Label_UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Label_UI (see VARARGIN)

% Choose default command line output for Label_UI
handles.output = hObject;
set(handles.slider1,'Max',100,'Min',0);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Label_UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Label_UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a %锟斤拷im为全锟街憋拷锟斤拷
global file_name file_index count begin_num file_info 
a = 0;
%选锟斤拷图片路锟斤拷
load('/home/share/biao_label_lfw_one/lfw_one_info.mat');
count = get(handles.edit1, 'String');
count = str2num(count);
begin_num = count;
%[filename,pathname,filterindex]=uigetfile({'*.jpg'},'选锟斤拷图片')
file_name = file_info(count).name;
file_index = file_info(count).index;
%锟较筹拷路锟斤拷+锟侥硷拷锟斤拷
%str=[pathname filename]; 
%str2=[filename(1:end-4)]
 %锟斤拷取图片
axes1=imread(file_index); 
%使锟矫碉拷一锟斤拷axes 
 %锟斤拷示图片
 
imshow(axes1);





function pushbutton1_Callback(hObject, eventdata, handles)

global a
global descriptor save_file_name count begin_num file_info
% temp = zeros(1,65);
% for i = 1:65
%     if isempty(eval(sprintf('a%d', i))) ~= 1
%         temp(i) = eval(sprintf('a%d', i));%str2double(eval(sprintf('a%d', i)));
%     end
% end
% if isempty(descriptor)
%     descriptor = temp;
% else
descriptor = a;
class_count = get(handles.edit2, 'String');
class_count = str2num(class_count);
save_file_name = sprintf('/home/share/biao_label_lfw_one/begin_with_%d_ID_num_%d.mat', begin_num, class_count);
%/home/share/botong/biao label lfw/descriptor label/
if exist(save_file_name)
    temp2 = descriptor;
    load(save_file_name)
    descriptor = [descriptor;temp2];
end
save(save_file_name, 'descriptor');
count = count + 1;
set(handles.edit1, 'String', num2str(count));

file_name = file_info(count).name;
file_index = file_info(count).index;
%锟较筹拷路锟斤拷+锟侥硷拷锟斤拷
%str=[pathname filename]; 
%str2=[filename(1:end-4)]
 %锟斤拷取图片
axes1=imread(file_index); 
%使锟矫碉拷一锟斤拷axes 
 %锟斤拷示图片

imshow(axes1);



%save(str2,'a1','a2','a3','a4','a5','a6','a7','a8','a9','a10','a11','a12','a13','a14','a15','a16','a17','a18','a19','a20','a21','a22','a23','a24','a25','a26','a27','a28','a29','a30','a31','a32','a33','a34','a35','a36','a37','a38','a39','a40','a41','a42','a43','a44','a45','a46','a47','a48','a49','a50','a51','a52','a53','a54','a55','a56','a57','a58','a59','a60','a61','a62','a63','a64','a65')
%clear global



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
key = get(handles.figure1, 'CurrentKey');
switch key
    case 'return'
        pushbutton1_Callback(hObject, eventdata, handles);
end
        
function preBut_Callback(hObject, eventdata, handles)  
% hObject    handle to preBut (see GCBO)    
% eventdata  reserved - to be defined in a future version of MATLAB  
% handles    structure with handles and user data (see GUIDATA)  
% previous button callback  
    current_no = str2double(get(handles.imgNo,'String'));  
    if imgno_number_check(current_no, handles) == -1  
        return;  
    elseif imgno_number_check(current_no, handles) == 2  
        msgbox('At the first image!!','Attention','modal');  
    else  
        current_no = current_no - 1;  
    end  
    gui_contents_update(handles, current_no);  
    guidata(hObject, handles);  
  
function nextBut_Callback(hObject, eventdata, handles)  
% hObject    handle to nextBut (see GCBO)  
% eventdata  reserved - to be defined in a future version of MATLAB  
% handles    structure with handles and user data (see GUIDATA)  
% next button callback  
    current_no = str2double(get(handles.imgNo,'String'));  
    if imgno_number_check(current_no, handles) == -1  
        return;  
    elseif imgno_number_check(current_no, handles) == 3  
        msgbox('At the last image!!','Attention','modal');  
    else  
        current_no = current_no + 1;  
    end  
    gui_contents_update(handles, current_no);  
    guidata(hObject, handles);  



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
a=num2str(get(handles.slider1,'value'));
set(handles.edit3,'string',a);
a=get(handles.slider1,'value');

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
