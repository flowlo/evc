function varargout = gui_main(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @gui_main_OpeningFcn, ...
                       'gui_OutputFcn',  @gui_main_OutputFcn, ...
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
end

function gui_main_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

    global UserSettings;
    UserSettings.color          = im2double(imread('color.png'));
    UserSettings.normals        = im2double(imread('normals.png'));
    UserSettings.cellIntervals  = 11;
    UserSettings.cellExponent   = 0.15;
    UserSettings.glowSigma      = 1.5;
    UserSettings.edgeColor      = [1,1,0];
    UserSettings.edgeStrength   = 2.0;
    
    set(handles.sliderCellInterval, 'Value', UserSettings.cellIntervals);
    set(handles.sliderCellExponent, 'Value', UserSettings.cellExponent);
    set(handles.sliderGlowSigma,    'Value', UserSettings.glowSigma);    
    set(handles.sliderEdgeStrength, 'Value', UserSettings.edgeStrength);  
    axes(handles.axesColor); 
        imshow(UserSettings.color);      
    axes(handles.axesNormals); 
        imshow(UserSettings.normals);        
    guidata(hObject, handles);
    
    updateOutput(hObject, handles);
end

function updateOutput(hObject, handles)
    global UserSettings;    
    UserSettings.cellIntervals  = ceil( get(handles.sliderCellInterval,   'Value'));
    UserSettings.cellExponent   =       get(handles.sliderCellExponent,   'Value');
    UserSettings.glowSigma      =       get(handles.sliderGlowSigma,      'Value');    
    UserSettings.edgeStrength   =       get(handles.sliderEdgeStrength,   'Value');    
    try
        [UserSettings.cell, fnc_compute_brightness, fnc_compute_chromaticity, fnc_pow_brightness, fnc_transform_brightness, fnc_recompute_color, fnc_fix_NaNs_and_Inf] = ...
                            evc_cel( UserSettings.color, ...
                                     UserSettings.cellIntervals, ...
                                     UserSettings.cellExponent);
    catch err
        fprintf(2,[err.getReport() '\n']);
        UserSettings.cell = UserSettings.color;
    end
    try
        [UserSettings.edge,fnc_detect_edges,fnc_maximum_edge,fnc_blur_edges,fnc_strengthen_edges,fnc_blend_edges] = ...
                            evc_edge(UserSettings.cell, ...
                                     UserSettings.normals * 2 - 1, ...
                                     UserSettings.glowSigma, ...
                                     repmat(reshape(UserSettings.edgeColor, [1,1,3]),[size(UserSettings.normals,1),size(UserSettings.normals,2),1]), ...
                                     UserSettings.edgeStrength * sqrt(UserSettings.glowSigma));
    catch err
        fprintf(2,[err.getReport() '\n']);
        UserSettings.edge = UserSettings.color;
    end
    UserSettings.result = UserSettings.edge;
    
    axes(handles.axesResult);
        cla;
        imshow(UserSettings.result);    
    set(handles.txtCellIntervals,   'String',           num2str(UserSettings.cellIntervals));
    set(handles.txtCellExponent,    'String',           num2str(UserSettings.cellExponent));
    set(handles.txtGlowSigma,       'String',           num2str(UserSettings.glowSigma));    
    set(handles.txtEdgeStrength,    'String',           num2str(UserSettings.edgeStrength));    
    set(handles.btnEdgeColor,       'BackgroundColor',  UserSettings.edgeColor);  
    guidata(hObject, handles);
end

function sliderCellInterval_Callback(hObject, eventdata, handles) %#ok<DEFNU>
    updateOutput(hObject, handles);
end
function sliderCellExponent_Callback(hObject, eventdata, handles) %#ok<DEFNU>
    updateOutput(hObject, handles);
end
function sliderGlowSigma_Callback(hObject, eventdata, handles) %#ok<DEFNU>
    updateOutput(hObject, handles);
end
function sliderEdgeStrength_Callback(hObject, eventdata, handles) %#ok<DEFNU>
    updateOutput(hObject, handles);
end
function btnEdgeColor_Callback(hObject, eventdata, handles) %#ok<DEFNU>
    global UserSettings;    
    UserSettings.edgeColor = uisetcolor(UserSettings.edgeColor);
    updateOutput(hObject, handles);
end

function varargout = gui_main_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;
end
