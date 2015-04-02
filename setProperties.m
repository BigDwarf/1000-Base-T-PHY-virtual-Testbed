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
axis([min(f) f(fix(end/50)) 0 100]);

axes(handles.sinAxes);
[f,Y , NFFT] = spectrum(sin, t, Fs);
temp = 2*abs(Y(1:NFFT/2+1));
plot(f,temp,'color',[0.9  0.75 0],'linewidth',2);
axis([min(f) f(fix(end/50))  0 50]);

axes(handles.meanderAxes);
[f,Y , NFFT] = spectrum(meander, t_meander, Fs_meander);
plot(f,2*abs(Y(1:NFFT/2+1)),'color',[0.9  0.75 0],'linewidth',2);
axis([min(f) f(fix(end/12))  0 1]);

bg_PAM5LoadButton = imread('images/loadFileButton.jpg', 'jpg');
a = imresize(bg_PAM5LoadButton, [52 140], 'bilinear'); 
set(handles.PAM5LoadUserDataButton, 'CData', a) 
set(handles.MLT3LoadFileButton, 'CData', a);

bg_ApplyButton = imread('images/applyButton.jpg', 'jpg');
a = imresize(bg_ApplyButton, [52 140], 'bilinear');
set(handles.PAM5ApplyUserDataButton, 'CData', a)
set(handles.MLT3AplyUserDataButtton, 'CData', a);

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

bg_generate = imread('images/generate.jpg');
a = imresize(bg_generate, [52 140], 'bilinear');
set(handles.generateBitStreamMLT3, 'CData', a)
set(handles.generateBitStreamPAM5, 'CData', a);

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