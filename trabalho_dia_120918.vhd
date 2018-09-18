--Trabalho do dia 12/09/2018
--Nome: Jorge Martins Fontenele Rocha
		--Lucas Fernandes
--Objetivo: Gerar uma maquina de primos, em que a saida tivesse um sistema de piscagem no
--display de 7 segmentos, quando apresentasse determinados numeros.
--Demais detalhes no arquivo de diretrizes.

entity trabalho_dia_120918 is
--declaracao de portas basicas. definimos entradas clk, control, e os displays localizados nas portas padroes.
port (
signal clk, control : in bit;
signal d7, d6, d5, d4, 
       d3, d2, d1, d0 : out bit_vector (6 downto 0)

);
end entity trabalho_dia_120918;

--inicio da arquitetura do projeto inteiro
architecture c_trabalho_dia_120918 of trabalho_dia_120918 is

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

component gerador_clock_duplo is
port (
	signal clock_in : in bit;
	signal clock_out1 : out bit; --Pisca1
	signal clock_out2 : out bit --Pisca2
);
end component gerador_clock_duplo;

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

component gerador_pwm is
port (
signal clock_in : in bit;
signal pwm1, pwm2, pwm3 : out bit
);
end component gerador_pwm;

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

component maq_primos is
port (
	signal pwm1 : in bit;
	signal control: in bit;
	signal estado : out bit_vector (3 downto 0);
	signal tipo : out bit_vector (1 downto 0)
);
end component maq_primos;

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

component controlador_display_new is
port (
signal pwm2, clock_out1, clock_out2 : in bit;
signal estado : in bit_vector(3 downto 0);
signal tipo : in bit_vector(1 downto 0);
signal num7, num6, num5, num4, num3, num2, num1, num0 : out bit_vector (3 downto 0);
signal en7, en6, en5, en4, en3, en2, en1, en0 : out bit
);
end component controlador_display_new;

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

component conv_7seg is
port (
	signal en : in bit;
	signal dado : in bit_vector (3 downto 0);
	signal display : out bit_vector (6 downto 0)
);
end component conv_7seg;

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- variaveis intermediarias
--signal clk : bit; --iniciadas no programa atual, portanto nao precisa de intermediaria (?)
--signal control : bit; --iniciadas no programa atual, portanto nao precisa de intermediaria (?)
signal clock_out1 : bit; --uma das saidas do gerador de clock duplo
signal clock_out2 : bit; --outra saida do gerador de clock duplo
signal pwm1, pwm2, pwm3 : bit; --saidas do gerador de pwm 
signal estado : bit_vector (3 downto 0); --numero que sai da maquina de primos
signal tipo : bit_vector (1 downto 0); --tipo do numero que sai da maquina de primos
signal num7, num6, num5, num4, num3, num2, num1, num0 : bit_vector (3 downto 0); --Numeros enviados para cada display, pelo controlador de displays
signal en7, en6, en5, en4, en3, en2, en1, en0 : bit; -- Os clocks de cada display
signal pisca1 : bit;
signal pisca2 : bit;

-- conexoes dos componentes utilizando as variaveis intermediarias

begin

xgerador_clock_duplo: gerador_clock_duplo port map (clk, clock_out1, clock_out2);
--no gerador de clock duplo, entra o clock inicial da placa, e saem dois clocks utilizados para o sistema

xgerador_pwm: gerador_pwm port map (clk, pwm1, pwm2, pwm3);
--no gerador de pwm, entra o clock inicial da placa, e saem 3 clocks gerados, cada um com um atraso diferente

xmaq_primos: maq_primos port map (pwm1, control, estado, tipo);
--na maquina de primos entra o clock do pwm, o controle que determina se sao primos ou nao
--e sai o estado, que e o numero em si, e o seu tipo, que determina seu "pisca"

xcontrolador_display_new: controlador_display_new port map (pwm2, clock_out1, clock_out2, estado, tipo,
	 num7, num6, num5, num4, num3, num2, num1, num0,
	 en7, en6, en5, en4, en3, en2, en1, en0);
--no controlador do display, entram o pwm2, que e o clock atrasado, o estado, que e o numero gerado pela maquina de primos e os
--clocks que definem a frequencia de piscagem. Saem os numeros, e os comandos de energia dos displays.	 

xconv7: conv_7seg port map (en7, num7, d7);
xconv6: conv_7seg port map (en6, num6, d6);
xconv5: conv_7seg port map (en5, num5, d5);
xconv4: conv_7seg port map (en4, num4, d4);
xconv3: conv_7seg port map (en3, num3, d3);
xconv2: conv_7seg port map (en2, num2, d2);
xconv1: conv_7seg port map (en1, num1, d1);
xconv0: conv_7seg port map (en0, num0, d0);

--conversores de valores decimais em valores de displays. Cada um dos dn (n de 0 a 7) sendo um display diferente
--composto de 7 segmentos, e ja instalado na porta padrao da fpga. Os enable funcionam ligando, desligando e piscando,
--e os num sao quais entradas do display devem acender, ou nao.


end architecture c_trabalho_dia_120918;