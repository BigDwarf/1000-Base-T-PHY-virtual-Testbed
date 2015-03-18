function varargout = fullScreenAxes(varargin)
% FULLSCREENAXES MATLAB code for fullScreenAxes.fig
%      FULLSCREENAXES, by itself, creates a new FULLSCREENAXES or raises the existing
%      singleton*.
%
%      H = FULLSCREENAXES returns the handle to a new FULLSCREENAXES or the handle to
%      the existing singleton*.
%
%      FULLSCREENAXES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FULLSCREENAXES.M with the given input arguments.
%
%      FULLSCREENAXES('Property','Value',...) creates a new FULLSCREENAXES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fullScreenAxes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fullScreenAxes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fullScreenAxes

% Last Modified by GUIDE v2.5 27-Feb-2015 13:42:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fullScreenAxes_OpeningFcn, ...
                   'gui_OutputFcn',  @fullScreenAxes_OutputFcn, ...
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


% --- Executes just before fullScreenAxes is made visible.
function fullScreenAxes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fullScreenAxes (see VARARGIN)

% Choose default command line output for fullScreenAxes
handles.output = hObject;
%---
bg_increaseZoom = imread('images/PressZoom+.jpg', 'jpg');
a = imresize(bg_increaseZoom,[100 112], 'bilinear');
set(handles.fullScreenAxesIncreaseValueButton , 'CData', a);


%----
bg_decreaseZoom = imread('images/PressZoom-.jpg', 'jpg');
a = imresize(bg_decreaseZoom, [100 112], 'bilinear');
set(handles.fullScreenAxesDecreaseValueButton , 'CData', a);

%---
%bg_panel = imread('images/background.jpg', 'jpg');
%a = imresize(bg_panel,[853 1660], 'bilinear');
%set(handles.PAM5Panel, 'CData', a);
%---
%bg_expandAxesButton = imread('images/PressFullscreen.jpg','jpg');
%a = imresize(bg_expandAxesButton, [40 46], 'bilinear');
%set(handles.PAM5FirstChannelExpandAxesButton , 'CData', a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fullScreenAxes wait for user response (see UIRESUME)
% uiwait(handles.fullScreenAxesPanel);


% --- Outputs from this function are returned to the command line.
function varargout = fullScreenAxes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in fullScreenAxesIncreaseValueButton.
function fullScreenAxesIncreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to fullScreenAxesIncreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fullScreenAxesDecreaseValueButton.
function fullScreenAxesDecreaseValueButton_Callback(hObject, eventdata, handles)
% hObject    handle to fullScreenAxesDecreaseValueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.fullScreenAxes);
a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)/2 xLimits(2)/2 yLimits(1) yLimits(2)]);

% --- Executes on button press in fullScreenAxesButton.
function fullScreenAxesButton_Callback(hObject, eventdata, handles)
% hObject    handle to fullScreenAxesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
