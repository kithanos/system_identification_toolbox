function varargout = programa(varargin)
% PROGRAMA MATLAB code for programa.fig
%      PROGRAMA, by itself, creates a new PROGRAMA or raises the existing
%      singleton*.
%
%      H = PROGRAMA returns the handle to a new PROGRAMA or the handle to
%      the existing singleton*.
%
%      PROGRAMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAMA.M with the given input arguments.
%
%      PROGRAMA('Property','Value',...) creates a new PROGRAMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before programa_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to programa_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help programa

% Last Modified by GUIDE v2.5 12-Oct-2017 19:01:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @programa_OpeningFcn, ...
                   'gui_OutputFcn',  @programa_OutputFcn, ...
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


% --- Executes just before programa is made visible.
%Função executada no inicio do programa
function programa_OpeningFcn(hObject, eventdata, handles, varargin)
%variáveis globais
 global a;                  %variável para a conexão com o arduino
 global s;                  %variavel para o servo motor
 global x;
 global t;
 t = 0.01;                  %tempo de cada loop do programa
a = arduino('COM3', 'uno'); %conexão com o Arduino
s = servo(a, 'D3');         %conexão com o servo
%writeDigitalPin(a,13,0);
writePosition(s, 0.20);     %aciona servo em 36º (180º = 1.00)
%current_pos = readPosition(s);
%current_pos = current_pos*180;
fprintf('Motor desativado\n');  %imprime na tela que a cancela está fechada

%plota o gráfico da entrada/saída
 g = figure(1);
 %title('Entrada');
 hLine1 = line(nan, nan, 'Color','blue'); 
 xlabel('Tempo');
 ylabel('Tensão [V]');
 %ylim([0 5])
 x = 0; 
 
 h = figure(1);
 title('Entrada [A]/Saída [V]');
 hLine2 = line(nan, nan, 'Color','red'); 
 xlabel('Tempo');
 ylabel('Tensão [V]');
 ylim([0 5])

 %loop do programa nesse estado
 global true1;
 true1 = 1;
 while true1 == 1
  drawnow() 
  analog_read = readVoltage(a,0);       %leitura do valor analogico do sensor
  %disp(['Valor Sensor MQ3 = ',num2str(analog_read)]);  
  disp(num2str(analog_read));           %imprime na tela
  %pause(0.1); 
  
  
  x1 = get(hLine1, 'XData');  
  y1 = get(hLine1, 'YData'); 
  x2 = get(hLine2, 'XData');  
  y2 = get(hLine2, 'YData'); 
  
  %plota esses valores no gráfico
  x1 = [x1 x];  
  y1 = [y1 0.01]; 
  x2 = [x2 x];  
  y2 = [y2 analog_read]; 
  
  set(hLine1, 'XData', x1, 'YData', y1); 
  set(hLine2, 'XData', x2, 'YData', y2);
  
  x = x + 1;  
  pause(t); 
%plot(analog_read)
 end

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to programa (see VARARGIN)

% Choose default command line output for programa
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes programa wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = programa_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
%Botão "Entrada Degrau" é aberto
function pushbutton1_Callback(hObject, eventdata, handles)
%variáveis globais
 global a;
 global s;
 global x;
 global t;
 global true1;
 true1 = 0;
 %writeDigitalPin(a,13,1);
 %pause(0.5);
 %Aciona servo em 180º (servo aberto)
 writePosition(s, 1);
 %current_pos = readPosition(s);
 %current_pos = current_pos*180;
 %fprintf('Posição atual do eixo é %d degrees\n', current_pos);
 %imprime na tela que o motor foi acionado
 fprintf('Motor ativado\n');
 pause(0.5);
 
 %plota os valores no gráfico
 g = figure(1);
 %title('Entrada');
 hLine1 = line(nan, nan, 'Color','blue'); 
 xlabel('Tempo');
 ylabel('Tensão [V]');
 ylim([0 5])
 %i = 0; 
 
 h = figure(1);
 title('Entrada [A]/Saída [V]');
 hLine2 = line(nan, nan, 'Color','red'); 
 xlabel('Tempo');
 ylabel('Tensão [V]');
 %ylim([0 5])

 global true;
 true = 1;
 while true == 1
  drawnow() 
  analog_read = readVoltage(a,0);   %leitura do valor do sensor
  %disp(['Valor Sensor MQ3 = ',num2str(analog_read)]);  
  disp(num2str(analog_read));       %Imprime os valores na tela
  %disp(analog_read);
  pause(t); 
 
  x1 = get(hLine1, 'XData');  
  y1 = get(hLine1, 'YData'); 
  x2 = get(hLine2, 'XData');  
  y2 = get(hLine2, 'YData'); 
  
  x1 = [x1 x];  
  y1 = [y1 5]; 
  x2 = [x2 x];  
  y2 = [y2 analog_read]; 
  
  set(hLine1, 'XData', x1, 'YData', y1); 
  set(hLine2, 'XData', x2, 'YData', y2);
  
  x = x + 1;  
  %pause(0.5); 
%plot(analog_read)
 end

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
 %global a
 global s;
 global x;
 global t;
 %writeDigitalPin(a,13,0);
 %pause(0.5)
 %Aciona o servo em 20º (cancela fechada)
 writePosition(s, 0.2);
 %current_pos = readPosition(s);
 %current_pos = current_pos*180;
 %fprintf('Posição atual do eixo é %d degrees\n', current_pos);
 %Imprime na tela que o motor foi desativado, o número total de amostras
 %colhidas e a frequencia de amostragem
 fprintf('Motor desativado\n');
 disp(['Número de amostras colhidas = ',num2str(x)]); 
 disp(['Frequência [Hz]= ',num2str(1/t)]); 
 clear t;
 pause(1);
 global true;
 %Limpa as variáveis
 true = 0;
 clear x;
 clear a;
 clear true;
 clear true1;
 clear board;
 fclose(instrfind);
 

 disp('Programa Encerrado'); 
 
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
