function varargout = Main(varargin)
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

function Main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
createBackground();
setProperties();
guidata(hObject, handles);

function varargout = Main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function firstAlgorithm_Callback(hObject, eventdata, handles)
set(handles.firstAlgorithm, 'Value', 1)
set(handles.secondAlgorithm, 'Value', 0);

function secondAlgorithm_Callback(hObject, eventdata, handles)
set(handles.firstAlgorithm, 'Value', 0)
set(handles.secondAlgorithm, 'Value', 1);

function MLT3LoadFileButton_Callback(hObject, eventdata, handles)
filename = uigetfile('*.txt');
dataCell = textread(filename, '%q', 1);
data = char(dataCell);
set(handles.MLT3UserDataEditPanel,'String',data); 

function MLT3RepeatUserDataButton_Callback(hObject, eventdata, handles)
string = get(handles.MLT3UserDataEditPanel, 'String');
cc = strcat(string, string);
set(handles.MLT3UserDataEditPanel,'String',cc);

function MLT3UserDataEditPanel_Callback(hObject, eventdata, handles)

function MLT3UserDataEditPanel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MLT3AplyUserDataButtton_Callback(hObject, eventdata, handles)
    data1 = get(handles.MLT3UserDataEditPanel, 'String');
    data = str2num(data1(:));
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
    
function MLT3AxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.MLT3Axes);
increaseSize();

function MLT3AxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.MLT3Axes);
decreaseSize();

function MLT3AxesExpandButton_Callback(hObject, eventdata, handles)
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
    data = str2num(data1(:));
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
function PAM5LoadUserDataButton_Callback(hObject, eventdata, handles)
filename = uigetfile('*.txt');
dataCell = textread(filename, '%q', 1);
data = char(dataCell);
set(handles.PAM5UserDataEdit,'String',data); 


% --- Executes on button press in PAM5RepeatUserDataButton.
function PAM5RepeatUserDataButton_Callback(hObject, eventdata, handles)
string = get(handles.PAM5UserDataEdit, 'String');
cc = strcat(string, string);
set(handles.PAM5UserDataEdit,'String',cc); 

function PAM5UserDataEdit_Callback(hObject, eventdata, handles)

function PAM5UserDataEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PAM5ApplyUserDataButton_Callback(hObject, eventdata, handles)

    data1 = get(handles.PAM5UserDataEdit, 'String');
    data = str2num(data1(:));
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
function PAM5FirstChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5FirstChannelAxes);
increaseSize();

function PAM5FirstChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5FirstChannelAxes);
decreaseSize();

function PAM5FirstChannelExpandAxesButton_Callback(hObject, eventdata, handles)
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
data = str2num(data1(:));
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
    end
function PAM5FourthChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5FourthChannelAxes);
increaseSize();

function PAM5FourthChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5FourthChannelAxes);
decreaseSize();

function PAM5FourthChannelExpandAxesButton_Callback(hObject, eventdata, handles)
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
data = str2num(data1(:));
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
function PAM5ThirdChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5ThirdChannelAxes);
increaseSize();

function PAM5ThirdChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5ThirdChannelAxes);
decreaseSize();

function PAM5ThirdChannelExpandAxesButton_Callback(hObject, eventdata, handles)
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
function PAM5SecondChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SecondChannelAxes);
increaseSize();

function PAM5SecondChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SecondChannelAxes);
decreaseSize();

function PAM5SecondChannelExpandAxesButton_Callback(hObject, eventdata, handles)
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
data = str2num(data1(:));  
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
    end
function MLT3TabButton_Callback(hObject, eventdata, handles)
set(handles.MLT3Panel,'Visible','on')
set(handles.PAM5Panel,'Visible','off')
set(handles.standartFunctionsPanel, 'Visible', 'off')
set(handles.scramblerPanel, 'Visible', 'off')
set(handles.chooseAlgorithmPanel, 'Visible', 'on');

function PAM5TabButton_Callback(hObject, eventdata, handles)
set(handles.MLT3Panel,'Visible','off')
set(handles.PAM5Panel,'Visible','on')
set(handles.standartFunctionsPanel, 'Visible', 'off')
set(handles.scramblerPanel, 'Visible', 'off')
set(handles.chooseAlgorithmPanel, 'Visible', 'on');

function PAM5LoadUserDataButton_CreateFcn(hObject, eventdata, handles)

function btn_methodIncrease_Callback(src,evt,handles,handles_method)
axes(handles_method.fullScreenAxes);
increaseSize();

function btn_methodDecrease_Callback(src,evt,handles,handles_method)
axes(handles_method.fullScreenAxes);
decreaseSize();

function btn_methodClose(src,evt,handles,handles_method, h)
close(h);

function MLT3AxesOriginalSizeButton_Callback(hObject, eventdata, handles)
 if(get(handles.firstAlgorithm,'Value') == 1)  
    axes(handles.MLT3Axes);
   
    plot( handles.firstAlgorithm_t_MLT3,handles.firstAlgorithm_MLT3_Stream,'color',[0.9  0.75 0],'linewidth',2);
    set(gca, 'color', [0 0 0]);
 else
    plot( handles.secondAlgorithm_t_MLT3,handles.secondAlgorithm_MLT3_Stream,'color',[0.9  0.75 0],'linewidth',2);
    set(gca, 'color', [0 0 0]);
 end

function StdTabButton_Callback(hObject, eventdata, handles)
set(handles.MLT3Panel,'Visible','off')
set(handles.PAM5Panel,'Visible','off')
set(handles.standartFunctionsPanel, 'Visible', 'on')
set(handles.scramblerPanel, 'Visible', 'off')
set(handles.chooseAlgorithmPanel, 'Visible', 'off');

function MLT3SpectrumAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.MLT3SpectrumAxes);
increaseSize();

function MLT3SpectrumAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.MLT3SpectrumAxes);
decreaseSize();

function MLT3SpectrumAxesExpandButton_Callback(hObject, eventdata, handles)
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

function MLT3SpectrumAxesOriginalSizeButton_Callback(hObject, eventdata, handles)

function PAM5SpectrumFourthChannelOriginalSizeButton_Callback(hObject, eventdata, handles)

function PAM5SpectrumFourthChannelAxesExpandButton_Callback(hObject, eventdata, handles)
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

function PAM5SpectrumFourthChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumFourthChannelAxes);
decreaseSize();

function PAM5SpectrumFourthChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumFourthChannelAxes);
increaseSize();

function PAM5SpectrumThirdChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumThirdChannelAxes);
increaseSize();

function PAM5SpectrumThirdChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumThirdChannelAxes);
decreaseSize();

function PAM5SpectrumThirdChannelAxesExpandButton_Callback(hObject, eventdata, handles)
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

function PAM5SpectrumSecondChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumSecondChannelAxes);
increaseSize();

function PAM5SpectrumSecondChannelAxesExpandButton_Callback(hObject, eventdata, handles)
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
data = str2num(data1(:));
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

function PAM5SpectrumSecondChannelOriginalSizeButton_Callback(hObject, eventdata, handles)

function PAM5SpectrumSecondChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumSecondChannelAxes);
decreaseSize();

% --- Executes on button press in PAM5SpectrumFirstChannelAxesIncreaseValueButton.
function PAM5SpectrumFirstChannelAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumFirstChannelAxes);
increaseSize();


% --- Executes on button press in PAM5SpectrumFirstChannelAxesDecreaseValueButton.
function PAM5SpectrumFirstChannelAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
axes(handles.PAM5SpectrumFirstChannelAxes);
decreaseSize();

function PAM5SpectrumFirstChannelAxesExpandButton_Callback(hObject, eventdata, handles)
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
data = str2num(data1(:));
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
        [t_PAM5_1, PAM5_stream1, dt1] = PAM_5(data(1,:), sfs, fs);
        
        axes(handles_method.fullScreenAxes);
        [f,Y,NFFT] = spectrum(PAM5_stream1(1,:), t_PAM5_1, dt1);
        plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
        set(gca,'color',[0 0 0]);
    end

function PAM5SpectrumFirstChannelOriginalSizeButton_Callback(hObject, eventdata, handles)

function PAM5FourthChannelOriginalSizeButton_Callback(hObject, eventdata, handles)

function PAM5ThirdChannelOriginalSizeButton_Callback(hObject, eventdata, handles)

function PAM5FirstChannelOriginalSizeButton_Callback(hObject, eventdata, handles)

function MLT3Panel_CreateFcn(hObject, eventdata, handles)
createBackground();

function TabPanel_CreateFcn(hObject, eventdata, handles)
createBackground();

function MLT3AxesButtonGroup_CreateFcn(hObject, eventdata, handles)
createBackground();

function chooseAlgorithmPanel_CreateFcn(hObject, eventdata, handles)
createBackground();

function firstAlgorithm_CreateFcn(hObject, eventdata, handles)
set(hObject,'BackgroundColor', [0.72 0.72 0.72]);

function PAM5AxesButtonGroup_CreateFcn(hObject, eventdata, handles)
createBackground();

function PAM5SecondChannelAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
createBackground();

function PAM5ThirdChannelAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
createBackground();

function PAM5FourthChannelAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
createBackground();

function standartFunctionsPanel_CreateFcn(hObject, eventdata, handles)
createBackground();

function secondAlgorithm_CreateFcn(hObject, eventdata, handles)
set(hObject,'BackgroundColor', [0.72 0.72 0.72]);

function PAM5Panel_CreateFcn(hObject, eventdata, handles)
createBackground();

function MLT3SpectrumAxesButtonGroup_CreateFcn(hObject, eventdata, handles)
createBackground();

function uipanel17_CreateFcn(hObject, eventdata, handles)
createBackground();

function uipanel18_CreateFcn(hObject, eventdata, handles)
createBackground();

function uipanel19_CreateFcn(hObject, eventdata, handles)
createBackground();

function uipanel20_CreateFcn(hObject, eventdata, handles)
createBackground();


function selectAlgorithmPanel_CreateFcn(hObject, eventdata, handles)


function PAM5SecondChannelAxesIncreaseValueButton_CreateFcn(hObject, eventdata, handles)


function countOfDataRepeatMLT3_Callback(hObject, eventdata, handles)


function countOfDataRepeatMLT3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function countOfDataRepeatPAM5_Callback(hObject, eventdata, handles)


function countOfDataRepeatPAM5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function scramblerTab_Callback(hObject, eventdata, handles)


function edit4_Callback(hObject, eventdata, handles)


function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function countOfRepeatDataPAM5_Callback(hObject, eventdata, handles)

function countOfRepeatDataPAM5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ScramblerTabButton_Callback(hObject, eventdata, handles)
set(handles.MLT3Panel,'Visible','off')
set(handles.PAM5Panel,'Visible','off')
set(handles.standartFunctionsPanel, 'Visible', 'off')
set(handles.scramblerPanel, 'Visible', 'on')
set(handles.chooseAlgorithmPanel, 'Visible', 'on');

function scramblerPanel_CreateFcn(hObject, eventdata, handles)
createBackground();
