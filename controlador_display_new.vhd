--Componente mais importante. Recebe os valores gerados anteriormente, e os converte
--nos valores simplificados a serem utilizados pelo Conversor de sete segmentos.

entity controlador_display_new is
port (
signal pwm2, clock_out1, clock_out2 : in bit;
--Entrada dos clocks.Entrada do segundo clock gerado internamente (com um pouco de atraso),
--e determinado pelo gerador interno. Entrada dos clocks de Pisca1 e Pisca2, gerados pelo gerador
--de clock duplo.

signal estado : in bit_vector(3 downto 0);
--Entrada do valor gerado na maquina de primos

signal tipo : in bit_vector(1 downto 0);
--Entrada do tipo de valor, ja determinado pela maquina de primos, o qual sera atribuida a devida ordem de pisca.

signal num7, num6, num5, num4, num3, num2, num1, num0 : out bit_vector (3 downto 0);
--Saida dos valores traduzidos, e que definirao o que/onde acendera no display de 7 segmentos.

signal en7, en6, en5, en4, en3, en2, en1, en0 : out bit
--Saida dos Enables que farao o display acender ou piscar, ao serem conectados ao seu devido clock.

);
end entity controlador_display_new;

architecture c_controlador_display_new of controlador_display_new is

signal aux7, aux6, aux5, aux4, aux3, aux2, aux1, aux0 : bit_vector (3 downto 0) := "0000";
		   
signal tipo7, tipo6, tipo5, tipo4, tipo3, tipo2, tipo1, tipo0 : bit_vector (1 downto 0) := "00";

begin

num7 <= aux7;
num6 <= aux6;
num5 <= aux5;
num4 <= aux4;
num3 <= aux3;
num2 <= aux2;
num1 <= aux1;
num0 <= aux0;

en7 <=   '0' when tipo7="00" else
		   '1' when tipo7="01" else
			clock_out1 when tipo7="10" else
			clock_out2;
		
en6 <=   '0' when tipo6="00" else
		   '1' when tipo6="01" else
			clock_out1 when tipo6="10" else
			clock_out2;

en5 <=   '0' when tipo5="00" else
		   '1' when tipo5="01" else
			clock_out1 when tipo5="10" else
			clock_out2;
		
en4 <=   '0' when tipo4="00" else
		   '1' when tipo4="01" else
			clock_out1 when tipo4="10" else
			clock_out2;
		
en3 <=   '0' when tipo3="00" else
		   '1' when tipo3="01" else
			clock_out1 when tipo3="10" else
			clock_out2;
		
en2 <=   '0' when tipo2="00" else
		   '1' when tipo2="01" else
			clock_out1 when tipo2="10" else
			clock_out2;
		
en1 <=   '0' when tipo1="00" else
		   '1' when tipo1="01" else
			clock_out1 when tipo1="10" else
			clock_out2;
		
en0 <=   '0' when tipo0="00" else
		   '1' when tipo0="01" else
			clock_out1 when tipo0="10" else
			clock_out2;

		
		
controlador: process (pwm2)

variable vnum7, vnum6, vnum5, vnum4, vnum3, vnum2, vnum1, vnum0 : bit_vector (3 downto 0) := "0000";

variable vtipo7, vtipo6, vtipo5, vtipo4, vtipo3, vtipo2, vtipo1, vtipo0 : bit_vector (1 downto 0) := "00";

begin

--processo de "empurrar" o numero para o display da frente.
if pwm2='0' and pwm2'event then

vnum0 := vnum1;
vnum1 := vnum2;
vnum2 := vnum3;
vnum3 := vnum4;
vnum4 := vnum5;
vnum5 := vnum6;
vnum6 := vnum7;
vnum7 := estado;

vtipo0 := vtipo1;
vtipo1 := vtipo2;
vtipo2 := vtipo3;
vtipo3 := vtipo4;
vtipo4 := vtipo5;
vtipo5 := vtipo6;
vtipo6 := vtipo7;
vtipo7 := tipo;

aux7 <= vnum7;
aux6 <= vnum6;
aux5 <= vnum5;
aux4 <= vnum4;
aux3 <= vnum3;
aux2 <= vnum2;
aux1 <= vnum1;
aux0 <= vnum0;

tipo7 <= vtipo7;
tipo6 <= vtipo6;
tipo5 <= vtipo5;
tipo4 <= vtipo4;
tipo3 <= vtipo3;
tipo2 <= vtipo2;
tipo1 <= vtipo1;
tipo0 <= vtipo0;

end if;
end process controlador;


end architecture c_controlador_display_new;