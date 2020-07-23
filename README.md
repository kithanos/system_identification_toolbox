# system_identification_toolbox
Arquivos do projeto de Identificação de sistemas por função de transferência utilizando a System Identification Toolbox.

Para acessar o artigo publicado, por favor acessem:

http://seer.spo.ifsp.edu.br/index.php/regrasp/article/view/255


Para reprodução deste projeto, é necessário instalar o pacote do Arduino no MATLAB, 
para instala-lo (caso não o tenha), o leitor deve clicar na opção Add-Ons do menu Home, 
e em seguida em Get Hardware Support Packages, deixar marcada a ação Install from Internet, 
e procurar nas opções que apareceram a do Arduino (há dois pacotes, um para o MATLAB e outro para o Simulink), 
depois basta seguir as instruções da janela. Esse procedimento foi realizado na versão 2016 do MATLAB.

Requisitos:

Matlab
Simulink


Materiais:

1 Sensor MQ-3;
1 Placa Arduino Uno
1 Cabo USB;
1 Matriz de contatos (ou Protoboad);
Fios e cabinhos (diversos);
1 Servo motor;
1 Capacitor 1μF 
1 Resistor 10kΩ --> junto ao capacitor, para filtro RC série.


Esquemas de ligação:

Servo: Pino D3
Leitura sensor MQ-3: A0 (colocar filtro RC p/ elminiar ruídos)

Atentar a porta de comunicação de sua máquina, no programa, a porta está configurada como a "COM3".

O arquivo programa.fig é a inteface gráfica.




