function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 14-Mar-2015 10:21:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
numberOfTab = 2;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

pan1pos=get(handles.MLT3Panel,'Position');
set(handles.PAM5Panel,'Position',pan1pos)
set(handles.PAM5Panel,'Visible','off');

set(handles.standartFunctionsPanel,'Position',pan1pos)
set(handles.standartFunctionsPanel,'Visible','off');
set(handles.scramblerPanel,'Position',pan1pos)
set(handles.scramblerPanel,'Visible','off');

[sawtooth, sin, meander, t, t_meander, Fs, Fs_meander] = generateSignals();

axes(handles.sawtoothAxes);
[f,Y , NFFT] = spectrum(sawtooth, t, Fs);
plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
axis([min(f) max(f) 0 100]);

axes(handles.sinAxes);
[f,Y , NFFT] = spectrum(sin, t, Fs);
temp = 2*abs(Y(1:NFFT/2+1));
plot(f,temp,'color',[0.9  0.75 0],'linewidth',2);
axis([min(f) max(f) 0 50]);

axes(handles.meanderAxes);
[f,Y , NFFT] = spectrum(meander, t_meander, Fs_meander);
plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
axis([min(f) max(f) 0 1]);


%icons
bg_PAM5LoadButton = imread('images/loadFileButton.jpg', 'jpg');
a = imresize(bg_PAM5LoadButton, [52 140], 'bilinear'); 
set(handles.PAM5LoadUserDataButton, 'CData', a) 
set(handles.MLT3LoadFileButton, 'CData', a);

%---
bg_PAM5UserDataEdit = imread('images/UserDataEdit.jpg', 'jpg');
a = imresize(bg_PAM5UserDataEdit, [52 140], 'bilinear'); 
set(handles.PAM5UserDataEdit, 'CData', a);

bg_MLT3UserDataEditPanel = imread('images/UserDataEdit.jpg', 'jpg');
a = imresize(bg_MLT3UserDataEditPanel, [52 140], 'bilinear');
set(handles.MLT3UserDataEditPanel, 'CData', a);

%---
bg_RepeatUserDataButton = imread('images/repeatDataButton.jpg', 'jpg');
a = imresize(bg_RepeatUserDataButton, [52 140], 'bilinear');
set(handles.MLT3RepeatUserDataButton, 'CData', a)
set(handles.PAM5RepeatUserDataButton, 'CData', a);

%---
bg_ApplyButton = imread('images/applyButton.jpg', 'jpg');
a = imresize(bg_ApplyButton, [52 140], 'bilinear');
set(handles.PAM5ApplyUserDataButton, 'CData', a)
set(handles.MLT3AplyUserDataButtton, 'CData', a);

%---

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[40 46], 'bilinear');
set(handles.PAM5FirstChannelAxesIncreaseValueButton , 'CData', a)
set(handles.PAM5SecondChannelAxesIncreaseValueButton , 'CData', a)
set(handles.PAM5ThirdChannelAxesIncreaseValueButton , 'CData', a)
set(handles.PAM5FourthChannelAxesIncreaseValueButton , 'CData', a)
set(handles.PAM5SpectrumFirstChannelAxesIncreaseValueButton, 'CData', a)
set(handles.PAM5SpectrumSecondChannelAxesIncreaseValueButton, 'CData', a)
set(handles.PAM5SpectrumThirdChannelAxesIncreaseValueButton, 'CData', a)
set(handles.PAM5SpectrumFourthChannelAxesIncreaseValueButton, 'CData', a);

a = imresize(bg_increaseZoom,[60 70], 'bilinear');
set(handles.MLT3AxesIncreaseValueButton, 'CData', a)
set(handles.MLT3SpectrumAxesIncreaseValueButton, 'Cdata', a);


%----
bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [40 46], 'bilinear');
set(handles.PAM5FirstChannelAxesDecreaseValueButton , 'CData', a)
set(handles.PAM5SecondChannelAxesDecreaseValueButton , 'CData', a)
set(handles.PAM5ThirdChannelAxesDecreaseValueButton , 'CData', a)
set(handles.PAM5FourthChannelAxesDecreaseValueButton , 'CData', a)
set(handles.PAM5SpectrumFirstChannelAxesDecreaseValueButton, 'CData', a)
set(handles.PAM5SpectrumSecondChannelAxesDecreaseValueButton, 'CData', a)
set(handles.PAM5SpectrumThirdChannelAxesDecreaseValueButton, 'CData', a)
set(handles.PAM5SpectrumFourthChannelAxesDecreaseValueButton, 'CData', a);

a = imresize(bg_decreaseZoom,[60 70], 'bilinear');
set(handles.MLT3AxesDecreaseValueButton, 'CData', a)
set(handles.MLT3SpectrumAxesDecreaseValueButton, 'Cdata', a);


bg_backToNormalScale = imread('images/backToNormalScale.jpg', 'jpg');
a = imresize(bg_backToNormalScale, [40 46], 'bilinear');
set(handles.PAM5FirstChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5SecondChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5ThirdChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5FourthChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5SpectrumFirstChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5SpectrumSecondChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5SpectrumThirdChannelOriginalSizeButton, 'CData', a);
set(handles.PAM5SpectrumFourthChannelOriginalSizeButton, 'CData', a);

a = imresize(bg_backToNormalScale, [60 70], 'bilinear');
set(handles.MLT3AxesOriginalSizeButton, 'CData', a);
set(handles.MLT3SpectrumAxesOriginalSizeButton, 'CData', a);
%---
bg_tab = imread('images/tab.jpg', 'jpg');
a = imresize(bg_tab, [50 90], 'bilinear');
set(handles.MLT3TabButton, 'CData', a);
set(handles.PAM5TabButton, 'CData', a);
set(handles.StdTabButton, 'CData', a);
set(handles.ScramblerTabButton, 'CData', a);
%---
%bg_panel = imread('images/background.jpg', 'jpg');
%a = imresize(bg_panel,[853 1660], 'bilinear');
%set(handles.PAM5Panel, 'CData', a);
%---
bg_expandAxesButton = imread('images/PressFullscreen.jpg','jpg');
a = imresize(bg_expandAxesButton, [40 46], 'bilinear');
set(handles.PAM5FirstChannelExpandAxesButton , 'CData', a)
set(handles.PAM5SecondChannelExpandAxesButton , 'CData', a)
set(handles.PAM5ThirdChannelExpandAxesButton , 'CData', a)
set(handles.PAM5FourthChannelExpandAxesButton , 'CData', a)
set(handles.PAM5SpectrumFirstChannelAxesExpandButton, 'CData', a)
set(handles.PAM5SpectrumSecondChannelAxesExpandButton, 'CData', a)
set(handles.PAM5SpectrumThirdChannelAxesExpandButton, 'CData', a)
set(handles.PAM5SpectrumFourthChannelAxesExpandButton, 'CData', a);

a = imresize(bg_expandAxesButton,[60 70], 'bilinear');
set(handles.MLT3AxesExpandButton, 'CData', a)
set(handles.MLT3SpectrumAxesExpandButton, 'Cdata', a);

allAxesInFigure = findobj(gcf,'type','axes');
set(allAxesInFigure,'color',[0 0 0],'YLim',[-2 2]); 

set(handles.firstAlgorithm,'Value',1);
 axes(handles.MLT3Axes);
 zoom(gca, 'on');

 

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in firstAlgorithm.
function firstAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to firstAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.firstAlgorithm, 'Value', 1)
set(handles.secondAlgorithm, 'Value', 0);

% Hint: get(hObject,'Value') returns toggle state of firstAlgorithm


% --- Executes on button press in secondAlgorithm.
function secondAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to secondAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.firstAlgorithm, 'Value', 0)
set(handles.secondAlgorithm, 'Value', 1);

% Hint: get(hObject,'Value') returns toggle state of secondAlgorithm


% --- Executes on button press in MLT3LoadFileButton.
function MLT3LoadFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3LoadFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %filename = uigetfile('*.txt');
    %loaddata = fullfile(filename);
    %data = load(loaddata,'-ascii');
    %disp(data);
    filename = uigetfile('*.txt');
    dataCell = textread(filename, '%q', 1);
    data = char(dataCell);
    set(handles.MLT3UserDataEditPanel,'String',data); 


% --- Executes on button press in MLT3RepeatUserDataButton.
function MLT3RepeatUserDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3RepeatUserDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
string = get(handles.MLT3UserDataEditPanel, 'String');
cc = strcat(string, string);
set(handles.MLT3UserDataEditPanel,'String',cc);



function MLT3UserDataEditPanel_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3UserDataEditPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MLT3UserDataEditPanel as text
%        str2double(get(hObject,'String')) returns contents of MLT3UserDataEditPanel as a double


% --- Executes during object creation, after setting all properties.
function MLT3UserDataEditPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLT3UserDataEditPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MLT3AplyUserDataButtton.
function MLT3AplyUserDataButtton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3AplyUserDataButtton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)  
    data1 = get(handles.MLT3UserDataEditPanel, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    disp(data);
    disp('__');
    %disp(data);
    if(get(handles.firstAlgorithm,'Value') == 1)
        axes(handles.MLT3Axes);
        coded = MLT3coder(data);
        t    = 1:size(coded)*2;
        t(1) = 0.0;
        plotCoded = 1:size(coded)*2;
        timeForBit = 1/(100*2^20);
        for i = 1: size(coded)
            plotCoded(i*2) = coded(i);
            plotCoded(i*2 - 1) = coded(i);
        end
        [~, n] = size(plotCoded);
        for j = 2:n
            if(mod(j,2) ~= 0)
                t(j) = t(j-1);
            else
                t(j) = t(j-1) + timeForBit;
            end  
        end
        plot(t,plotCoded,'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        handles.firstAlgorithm_t_MLT3 = t;
        handles.firstAlgorithm_MLT3_Stream = plotCoded;
        guidata(hObject,handles);
        axes(handles.MLT3SpectrumAxes);
        [f,Y,NFFT] = spectrum(plotCoded, t, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs=20;
        fs_MLT3=25e6;
        [t_MLT3,MLT3_stream, dt] = MLT_3(data',fs,fs_MLT3);
        
        handles.secondAlgorithm_t_MLT3 = t_MLT3;
        handles.secondAlgoriithm_MLT3_Stream = MLT3_stream;
        guidata(hObject,handles);
        
        axes(handles.MLT3Axes);
        plot(t_MLT3,MLT3_stream,'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.MLT3SpectrumAxes);
        [f,Y,NFFT] = spectrum(MLT3_stream, t_MLT3, dt);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        
    end
    axes(handles.MLT3Axes);
    a2 = gca;
    MLT3AxesOriginalSizeXLimits = get(a2,'XLim');
    MLT3AxesOriginalSizeYLimits = get(a2,'YLim');
    disp(MLT3AxesOriginalSizeXLimits);
    disp(MLT3AxesOriginalSizeYLimits);


% --- Executes on button press in MLT3AxesIncreaseValueButton.
function MLT3AxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3AxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.MLT3Axes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);


% --- Executes on button press in MLT3AxesDecreaseValueButton.
function MLT3AxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3AxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.MLT3Axes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

% --- Executes on button press in MLT3AxesExpandButton.
function MLT3AxesExpandButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3AxesExpandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');

handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

data1 = get(handles.MLT3UserDataEditPanel, 'String');
set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
data1 = get(handles.MLT3UserDataEditPanel, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    if(get(handles.firstAlgorithm,'Value') == 1)
        axes(handles_method.fullScreenAxes);
        coded = MLT3coder(data);
        t    = 1:size(coded)*2;
        t(1) = 0.0;
        plotCoded = 1:size(coded)*2;
        timeForBit = 1/(100*2^20);
        for i = 1: size(coded)
            plotCoded(i*2) = coded(i);
            plotCoded(i*2 - 1) = coded(i);
        end
        [~, n] = size(plotCoded);
        for j = 2:n
            if(mod(j,2) ~= 0)
                t(j) = t(j-1);
            else
                t(j) = t(j-1) + timeForBit;
            end  
        end
        plot(t,plotCoded,'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

      
    else
        fs=20;
        fs_MLT3=25e6;
        [t_MLT3,MLT3_stream] = MLT_3(data,fs,fs_MLT3);
        axes(handles_method.fullScreenAxes);
        plot(t_MLT3,MLT3_stream,'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        
    end



% --- Executes on button press in PAM5LoadUserDataButton.
function PAM5LoadUserDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5LoadUserDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = uigetfile('*.txt');
dataCell = textread(filename, '%q', 1);
data = char(dataCell);
set(handles.PAM5UserDataEdit,'String',data); 


% --- Executes on button press in PAM5RepeatUserDataButton.
function PAM5RepeatUserDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5RepeatUserDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
string = get(handles.PAM5UserDataEdit, 'String');
cc = strcat(string, string);
set(handles.PAM5UserDataEdit,'String',cc); 






function PAM5UserDataEdit_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5UserDataEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PAM5UserDataEdit as text
%        str2double(get(hObject,'String')) returns contents of PAM5UserDataEdit as a double


% --- Executes during object creation, after setting all properties.
function PAM5UserDataEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5UserDataEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PAM5ApplyUserDataButton.
function PAM5ApplyUserDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5ApplyUserDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');    

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles.PAM5FirstChannelAxes);
        plot(t1,PAMcode(temp(1,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        axes(handles.PAM5SecondChannelAxes);
        plot(t1, PAMcode(temp(2,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        axes(handles.PAM5ThirdChannelAxes);
        plot(t1, PAMcode(temp(3,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        axes(handles.PAM5FourthChannelAxes);
        plot (t1, PAMcode(temp(4,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumFirstChannelAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(1,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumSecondChannelAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(2,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumThirdChannelAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(3,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumFourthChannelAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(4,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs = 250e6;
        sfs = 20;
        
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        
        data = reshape(data, 4, size_t/4);
        
        
        [t_PAM5_1,PAM5_stream1, dt1] = PAM_5(data(1,:),sfs, fs);
        [t_PAM5_2, PAM5_stream2, dt2] = PAM_5(data(2,:), sfs, fs);
        [t_PAM5_3, PAM5_stream3, dt3] = PAM_5(data(3,:), sfs, fs);
        [t_PAM5_4, PAM5_stream4, dt4] = PAM_5(data(4,:), sfs, fs);
        
        
        axes(handles.PAM5FirstChannelAxes);
        plot(t_PAM5_1,PAM5_stream1(1,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        axes(handles.PAM5SecondChannelAxes);
        plot(t_PAM5_2,PAM5_stream2(1,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        axes(handles.PAM5ThirdChannelAxes);
        plot(t_PAM5_3,PAM5_stream3(1,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        axes(handles.PAM5FourthChannelAxes);
        plot(t_PAM5_4,PAM5_stream4(1,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumFirstChannelAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream1(1,:), t_PAM5_1, dt1);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumSecondChannelAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream2(1,:), t_PAM5_2, dt2);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumThirdChannelAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream3(1,:), t_PAM5_3, dt3);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);

        axes(handles.PAM5SpectrumFourthChannelAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream4(1,:), t_PAM5_4, dt4);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    end

% --- Executes on button press in PAM5FirstChannelAxesIncreaseValueButton.
function PAM5FirstChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FirstChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5FirstChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);




% --- Executes on button press in PAM5FirstChannelAxesDecreaseValueButton.
function PAM5FirstChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FirstChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5FirstChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5FirstChannelExpandAxesButton.
function PAM5FirstChannelExpandAxesButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FirstChannelExpandAxesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        plot(t1,PAMcode(temp(1,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        
    else
        fs = 250e6;
        sfs = 20;
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        
        data = reshape(data, 4, size_t/4);
        
        [t_PAM5,PAM5_stream] = PAM_5(data(1,:),sfs, fs);
        
        axes(handles_method.fullScreenAxes);
        plot(t_PAM5,PAM5_stream(1,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;

        
    end


% --- Executes on button press in PAM5FourthChannelAxesIncreaseValueButton.
function PAM5FourthChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FourthChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5FourthChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5FourthChannelAxesDecreaseValueButton.
function PAM5FourthChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FourthChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5FourthChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5FourthChannelExpandAxesButton.
function PAM5FourthChannelExpandAxesButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FourthChannelExpandAxesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        plot(t1,PAMcode(temp(4,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        
    else
        fs = 250e6;
        sfs = 20;
        disp(data);
        
         data = data';
        size_t = size(data);
        size_t = size_t(2);
        data = reshape(data, 4, size_t/4);
        [t_PAM5,PAM5_stream] = PAM_5(data(4,:),sfs, fs);
       
        
        axes(handles_method.fullScreenAxes);
        plot(t_PAM5,PAM5_stream(4,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;

        
    end

% --- Executes on button press in PAM5ThirdChannelAxesIncreaseValueButton.
function PAM5ThirdChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5ThirdChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5ThirdChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5ThirdChannelAxesDecreaseValueButton.
function PAM5ThirdChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5ThirdChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5ThirdChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5ThirdChannelExpandAxesButton.
function PAM5ThirdChannelExpandAxesButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5ThirdChannelExpandAxesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');
bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        plot(t1,PAMcode(temp(3,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        
    else
        fs = 250e6;
        sfs = 20;
        
          data = data';
        size_t = size(data);
        size_t = size_t(2);
        data = reshape(data, 4, size_t/4);
        [t_PAM5,PAM5_stream] = PAM_5(data(3,:),sfs, fs);
        
        axes(handles_method.fullScreenAxes);
        plot(t_PAM5,PAM5_stream(3,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;

        
    end

% --- Executes on button press in PAM5SecondChannelAxesIncreaseValueButton.
function PAM5SecondChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SecondChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SecondChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5SecondChannelAxesDecreaseValueButton.
function PAM5SecondChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SecondChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SecondChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5SecondChannelExpandAxesButton.
function PAM5SecondChannelExpandAxesButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SecondChannelExpandAxesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        plot(t1,PAMcode(temp(2,:)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;
        
    else
        fs = 250e6;
        sfs = 20;
        
        
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        data = reshape(data, 4, size_t/4);
        [t_PAM5,PAM5_stream] = PAM_5(data(2,:),sfs, fs);
        
        axes(handles_method.fullScreenAxes);
        plot(t_PAM5,PAM5_stream(2,:),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        %figure;

        
    end

% --- Executes on button press in MLT3TabButton.
function MLT3TabButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3TabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.MLT3Panel,'Visible','on')
set(handles.PAM5Panel,'Visible','off')
set(handles.standartFunctionsPanel, 'Visible', 'off')
set(handles.scramblerPanel, 'Visible', 'off')
set(handles.chooseAlgorithmPanel, 'Visible', 'on');


% --- Executes on button press in PAM5TabButton.
function PAM5TabButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5TabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.MLT3Panel,'Visible','off')
set(handles.PAM5Panel,'Visible','on')
set(handles.standartFunctionsPanel, 'Visible', 'off')
set(handles.scramblerPanel, 'Visible', 'off')
set(handles.chooseAlgorithmPanel, 'Visible', 'on');

% --- Executes during object creation, after setting all properties.
function PAM5LoadUserDataButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5LoadUserDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function btn_methodIncrease_Callback(src,evt,handles,handles_method)
axes(handles_method.fullScreenAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);

function btn_methodDecrease_Callback(src,evt,handles,handles_method)
axes(handles_method.fullScreenAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

function btn_methodClose(src,evt,handles,handles_method, h)
close(h);


% --- Executes on button press in MLT3AxesOriginalSizeButton.
function MLT3AxesOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3AxesOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handle structure with handles and user data (see GUIDATA)

 if(get(handles.firstAlgorithm,'Value') == 1)  
    axes(handles.MLT3Axes);
   
    plot( handles.firstAlgorithm_t_MLT3,handles.firstAlgorithm_MLT3_Stream,'color',[0.9  0.75 0],'linewidth',2);
    set(gca, 'color', [0 0 0]);
 else
    plot( handles.secondAlgorithm_t_MLT3,handles.secondAlgorithm_MLT3_Stream,'color',[0.9  0.75 0],'linewidth',2);
    set(gca, 'color', [0 0 0]);
 end


% --- Executes on button press in StdTabButton.
function StdTabButton_Callback(hObject, eventdata, handles)
% hObject    handle to StdTabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.MLT3Panel,'Visible','off')
set(handles.PAM5Panel,'Visible','off')
set(handles.standartFunctionsPanel, 'Visible', 'on')
set(handles.scramblerPanel, 'Visible', 'off')
set(handles.chooseAlgorithmPanel, 'Visible', 'off');


% --- Executes on button press in MLT3SpectrumAxesIncreaseValueButton.
function MLT3SpectrumAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3SpectrumAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.MLT3SpectrumAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);


% --- Executes on button press in MLT3SpectrumAxesDecreaseValueButton.
function MLT3SpectrumAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3SpectrumAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.MLT3SpectrumAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

% --- Executes on button press in MLT3SpectrumAxesExpandButton.
function MLT3SpectrumAxesExpandButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3SpectrumAxesExpandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');

handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

data1 = get(handles.MLT3UserDataEditPanel, 'String');
set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
data1 = get(handles.MLT3UserDataEditPanel, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    disp(data);
    disp('__');
    %disp(data);
    if(get(handles.firstAlgorithm,'Value') == 1)
        axes(handles.MLT3Axes);
        coded = MLT3coder(data);
        t    = 1:size(coded)*2;
        t(1) = 0.0;
        plotCoded = 1:size(coded)*2;
        timeForBit = 1/(100*2^20);
        for i = 1: size(coded)
            plotCoded(i*2) = coded(i);
            plotCoded(i*2 - 1) = coded(i);
        end
        [~, n] = size(plotCoded);
        for j = 2:n
            if(mod(j,2) ~= 0)
                t(j) = t(j-1);
            else
                t(j) = t(j-1) + timeForBit;
            end  
        end
        plot(t,plotCoded,'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(plotCoded, t, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs=20;
        fs_MLT3=25e6;
        [t_MLT3,MLT3_stream, dt] = MLT_3(data',fs,fs_MLT3);
        
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(MLT3_stream, t_MLT3, dt);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
        
    end

% --- Executes on button press in MLT3SpectrumAxesOriginalSizeButton.
function MLT3SpectrumAxesOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to MLT3SpectrumAxesOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5SpectrumFourthChannelOriginalSizeButton.
function PAM5SpectrumFourthChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFourthChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5SpectrumFourthChannelAxesExpandButton.
function PAM5SpectrumFourthChannelAxesExpandButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFourthChannelAxesExpandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})

 data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');    

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(4,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs = 250e6;
        sfs = 20;
        
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        
        data = reshape(data, 4, size_t/4);
       
        [t_PAM5_4, PAM5_stream4, dt4] = PAM_5(data(4,:), sfs, fs);
       
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream4(1,:), t_PAM5_4, dt4);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    end



% --- Executes on button press in PAM5SpectrumFourthChannelAxesDecreaseValueButton.
function PAM5SpectrumFourthChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFourthChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumFourthChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5SpectrumFourthChannelAxesIncreaseValueButton.
function PAM5SpectrumFourthChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFourthChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumFourthChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5SpectrumThirdChannelAxesIncreaseValueButton.
function PAM5SpectrumThirdChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumThirdChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumThirdChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5SpectrumThirdChannelAxesDecreaseValueButton.
function PAM5SpectrumThirdChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumThirdChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumThirdChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5SpectrumThirdChannelAxesExpandButton.
function PAM5SpectrumThirdChannelAxesExpandButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumThirdChannelAxesExpandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})

data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');    

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(3,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs = 250e6;
        sfs = 20;
        
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        
        data = reshape(data, 4, size_t/4);
       
        [t_PAM5_3, PAM5_stream3, dt3] = PAM_5(data(3,:), sfs, fs);
        
        axes(handles.PAM5SpectrumThirdChannelAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream3(1,:), t_PAM5_3, dt3);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    end


% --- Executes on button press in PAM5SpectrumThirdChannelOriginalSizeButton.
function PAM5SpectrumThirdChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumThirdChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5SpectrumSecondChannelAxesIncreaseValueButton.
function PAM5SpectrumSecondChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumSecondChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumSecondChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);

% --- Executes on button press in PAM5SpectrumSecondChannelAxesExpandButton.
function PAM5SpectrumSecondChannelAxesExpandButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumSecondChannelAxesExpandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
 data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end

        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(2,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs = 250e6;
        sfs = 20;
        
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        
        data = reshape(data, 4, size_t/4);
        [t_PAM5_2, PAM5_stream2, dt2] = PAM_5(data(2,:), sfs, fs);
        
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream2(1,:), t_PAM5_2, dt2);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    end


% --- Executes on button press in PAM5SpectrumSecondChannelOriginalSizeButton.
function PAM5SpectrumSecondChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumSecondChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5SpectrumSecondChannelAxesDecreaseValueButton.
function PAM5SpectrumSecondChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumSecondChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumSecondChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5SpectrumFirstChannelAxesIncreaseValueButton.
function PAM5SpectrumFirstChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFirstChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumFirstChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5SpectrumFirstChannelAxesDecreaseValueButton.
function PAM5SpectrumFirstChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFirstChannelAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.PAM5SpectrumFirstChannelAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);


% --- Executes on button press in PAM5SpectrumFirstChannelAxesExpandButton.
function PAM5SpectrumFirstChannelAxesExpandButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFirstChannelAxesExpandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = open('fullScreenAxes.fig');
handles_method=guihandles(h);

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.expandedAxesPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', handles_method.fullScreenButtonsPanel);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles_method.fullScreenAxesIncreaseValueButton , 'CData', a);

bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles_method.fullScreenAxesDecreaseValueButton , 'CData', a);

set(handles_method.fullScreenAxesIncreaseValueButton,'Callback',{@btn_methodIncrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesDecreaseValueButton, 'Callback',{@btn_methodDecrease_Callback,handles,handles_method})
set(handles_method.fullScreenAxesButton, 'CallBack', {@btn_methodClose,handles,handles_method, h})
 data1 = get(handles.PAM5UserDataEdit, 'String');
    %disp(data1);
    %disp(class(data1));
    data = str2num(data1(:));
    %disp(data);
    
    if(get(handles.firstAlgorithm, 'Value') == 1)
        temp = PAM5coder(data');

        timeForBit = 1/(100*2^20);
        [~,n1] = size(temp);
        t1 = 1:n1;
        t1(1) = 0.0;
        for j = 2:n1

            if(mod(j,2) ~= 0)

                t1(j) = t1(j-1);
            else
                t1(j) = t1(j-1) + timeForBit;
            end

        end
        
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAMcode(temp(1,:)), t1, 25e6);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    else
        fs = 250e6;
        sfs = 20;
        data = data';
        size_t = size(data);
        size_t = size_t(2);
        data = reshape(data, 4, size_t/4);     
        [t_PAM5_1,PAM5_stream1, dt1] = PAM_5(data(1,:),sfs, fs);     
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream1(1,:), t_PAM5_1, dt1);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    end

% --- Executes on button press in PAM5SpectrumFirstChannelOriginalSizeButton.
function PAM5SpectrumFirstChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5SpectrumFirstChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5FourthChannelOriginalSizeButton.
function PAM5FourthChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FourthChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5ThirdChannelOriginalSizeButton.
function PAM5ThirdChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5ThirdChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PAM5FirstChannelOriginalSizeButton.
function PAM5FirstChannelOriginalSizeButton_Callback(hObject, eventdata, handles)
% hObject    handle to PAM5FirstChannelOriginalSizeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function MLT3Panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLT3Panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function TabPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TabPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function MLT3AxesButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLT3AxesButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/background.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function chooseAlgorithmPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chooseAlgorithmPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function firstAlgorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'BackgroundColor', [0.72 0.72 0.72]);

% --- Executes during object creation, after setting all properties.
function PAM5AxesButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5AxesButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function PAM5SecondChannelAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5SecondChannelAxesButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function PAM5ThirdChannelAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5ThirdChannelAxesButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function PAM5FourthChannelAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5FourthChannelAxesButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function standartFunctionsPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to standartFunctionsPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function secondAlgorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secondAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'BackgroundColor', [0.72 0.72 0.72]);


% --- Executes during object creation, after setting all properties.
function PAM5Panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5Panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function MLT3SpectrumAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLT3SpectrumAxesButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function uipanel17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

% --- Executes during object creation, after setting all properties.
function uipanel18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

% --- Executes during object creation, after setting all properties.
function uipanel19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

% --- Executes during object creation, after setting all properties.
function uipanel20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% --- Executes during object creation, after setting all properties.
function selectAlgorithmPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectAlgorithmPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function PAM5SecondChannelAxesIncreaseValueButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PAM5SecondChannelAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function countOfDataRepeatMLT3_Callback(hObject, eventdata, handles)
% hObject    handle to countOfDataRepeatMLT3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of countOfDataRepeatMLT3 as text
%        str2double(get(hObject,'String')) returns contents of countOfDataRepeatMLT3 as a double


% --- Executes during object creation, after setting all properties.
function countOfDataRepeatMLT3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to countOfDataRepeatMLT3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function countOfDataRepeatPAM5_Callback(hObject, eventdata, handles)
% hObject    handle to countOfDataRepeatPAM5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of countOfDataRepeatPAM5 as text
%        str2double(get(hObject,'String')) returns contents of countOfDataRepeatPAM5 as a double


% --- Executes during object creation, after setting all properties.
function countOfDataRepeatPAM5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to countOfDataRepeatPAM5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in scramblertabbutton.
function scramblerTab_Callback(hObject, eventdata, handles)
% hObject    handle to scramblertabbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function countOfRepeatDataPAM5_Callback(hObject, eventdata, handles)
% hObject    handle to countOfRepeatDataPAM5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of countOfRepeatDataPAM5 as text
%        str2double(get(hObject,'String')) returns contents of countOfRepeatDataPAM5 as a double


% --- Executes during object creation, after setting all properties.
function countOfRepeatDataPAM5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to countOfRepeatDataPAM5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ScramblerTabButton.
function ScramblerTabButton_Callback(hObject, eventdata, handles)
% hObject    handle to ScramblerTabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.MLT3Panel,'Visible','off')
set(handles.PAM5Panel,'Visible','off')
set(handles.standartFunctionsPanel, 'Visible', 'off')
set(handles.scramblerPanel, 'Visible', 'on')
set(handles.chooseAlgorithmPanel, 'Visible', 'on');


% --- Executes during object creation, after setting all properties.
function scramblerPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scramblerPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');
