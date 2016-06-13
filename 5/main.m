function varargout = main(varargin)
% MAIN MATLAB code for main.fig
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
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 11-May-2015 17:41:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Bilder laden
handles.I = im2double(imread('c.png'));
D = im2double(imread('disp.png'));
mindisp = 882.6262626262626;
maxdisp = 2184.716737771605;
D = D * (maxdisp - mindisp) + mindisp;
handles.D = D;

% View matrix
fov = 49.1 * pi / 180;
half = tan(fov)/2;
x = -half:(2*half)/(size(handles.D,2)-1):half;
half = -tan(fov * size(handles.D,1) / size(handles.I,2))/2;
y = (-half:(2*half)/(size(handles.D,1)-1):half)';
V = cat(3, repmat(x, size(handles.D,1), 1), repmat(y, 1, size(handles.D,2)), -ones(size(handles.D)));
VdotV = V .* V;
VdotV = sqrt(VdotV(:,:,1)+VdotV(:,:,2)+VdotV(:,:,3));
V = V ./ cat(3, VdotV, VdotV, VdotV);
handles.V = V;

handles.L = calcLight([-0.5 1 1] , hObject, handles);

%for user input - scales the distance from the pixel surfece to the light
%position along the pixels' normal.
handles.lightDistanceFactor = 0.5; 

set(handles.text_lightinfo, 'String', 'Light Direction = [-0.5 1 1]');
guidata(hObject, handles);

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% EVC INIT
%Light Matrix

updateInput(hObject,handles);
%imwrite(updateOutput(hObject,handles), 'bsp_5_final.png', 'png');
updateOutput(hObject,handles);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_setlight.
function pushbutton_setlight_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_setlight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [l, p] = gui_pick_point(handles.I, handles);
    
    %disp(['USER PICKED: x=' num2str(x) ', y=' num2str(y) ', p=' num2str(p)]);
    if (p)
        one = ones(size(handles.I,1), size(handles.I,2));
        L = l;
        set(handles.text_lightinfo, 'String', ['Light Position = [' num2str(L(1)) ', ' num2str(L(2)) ', ' num2str(L(3)) ']']);
        
        p = -handles.V .* cat(3, handles.Z, handles.Z, handles.Z);
        L = cat(3,one*L(1),one*L(2),one*L(3));
        L = L - p;
        L_len = sqrt(L(:,:,1).*L(:,:,1) + L(:,:,2).*L(:,:,2) + L(:,:,3).*L(:,:,3));
        L = L ./ cat(3,L_len,L_len,L_len);
        handles.L = L;
        guidata(hObject, handles);
        updateOutput(hObject, handles);
    end
    
function [l,p] = gui_pick_point(input, handles)
    
    [x, y, button, ax] = ginputax(handles.axes_output,1);
    
     %Die Koordinaten runden
     x = floor(x);
     y = floor(y);
     
    p = -handles.V .* cat(3, handles.Z, handles.Z, handles.Z);
    p = p (y,x,:);
    
    n = handles.N;
    n_len = sqrt(n(:,:,1).*n(:,:,1) + n(:,:,2).*n(:,:,2) + n(:,:,3).*n(:,:,3));
    n = n ./ cat(3,n_len,n_len,n_len);
    n = n (y,x,:);
    
    l = p + n * handles.lightDistanceFactor;
    
    p = 0;
    if ax == 1
        p = 1;
    end
%     
%     
%     
%     %Die Koordinaten runden
%     x = floor(x);
%     y = floor(y);
%     
%     %normalisieren
%     width = size(input,2);
%     height = size(input,1);
%     x = x/width * 2 - 1;
%     y = y/height * 2 - 1;
%     x = max(-1,x);x = min(1,x);
%     y = max(-1,y);y = min(1,y);

function updateInput(hObject,handles)
    axes(handles.axes_input);
    imshow(handles.I);
    
function [result] = updateOutput(hObject,handles)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    one = ones(size(handles.I,1), size(handles.I,2));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Licht Einstellungen
    ks = 1.0;
    kd = 0.8;
    ka = 0.2;
    is = [1,0.95,0.93];
    id = [1,0.95,0.98];
    ia = [0.98,0.95,1];
    ia = cat(3, one*ia(1), one*ia(2), one*ia(3));
    id = cat(3, one*id(1), one*id(2), one*id(3));
    is = cat(3, one*is(1), one*is(2), one*is(3));
    alpha = 32;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Camera Einstellungen
    f = 2.8; %fokale Länge in mm
    B = 30; %Basis (Abstand zw. Kameras) in mm
    ps = 0.005; %Größe eines Pixels in mm

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Berechnung der Tiefe
    Z = evc_compute_depth(handles.D, f, B, ps);
    Z = -Z;
    handles.Z = Z;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Normalmap berechnen
    N = evc_compute_normals(Z, handles.V);
    handles.N = N;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Phong Shading
    H = evc_phong(-handles.V,handles.L,N,ia,id,is,ka,kd,ks,alpha);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    result = handles.I .* H;
    axes(handles.axes_output);
    imshow(result);
    axes(handles.axes_depth);
    imshow(Z,[]);
    axes(handles.axes_normals);
    imshow(N * 0.5 + 0.5);
    axes(handles.axes_shading);
    imshow(H);
    
    guidata(hObject, handles);


% --- Executes on button press in pushbutton_resetlight.
function pushbutton_resetlight_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_resetlight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    L = [-0.5 1 1];
    handles.L = calcLight(L , hObject, handles);
    set(handles.text_lightinfo, 'String', ['L = [' num2str(L(1)) ', ' num2str(L(2)) ', ' num2str(L(3)) ']']);
    guidata(hObject, handles);
    updateOutput(hObject, handles);

function result = calcLight(L , hObject,handles)
    one = ones(size(handles.I,1), size(handles.I,2));
    %L = [x -y 1];
    L = L / norm(L);
    result = cat(3,one*L(1),one*L(2),one*L(3));
