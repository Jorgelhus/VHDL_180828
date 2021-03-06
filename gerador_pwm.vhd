--gerador de clock multiplo. Clocks com tempos diferentes para diferentes necessidades.
--No caso desta operaçao, apenas dois clocks serao usados.
entity gerador_pwm is
port (
signal clock_in : in bit;
--entrada do clock inicial, que e determinado pelo usuario/pela fpga

signal pwm1, pwm2, pwm3 : out bit
--saida dos diferentes clocks de operaçao

);
end entity gerador_pwm;


architecture c_gerador_pwm of gerador_pwm is

signal aux1, aux2, aux3 : bit :='1';

begin

pwm1<=aux1;
pwm2<=aux2;
pwm3<=aux3;

pwm: process (clock_in)

variable contador : integer range 0 to 10 := 0;

begin
	if clock_in='0' and clock_in'event then
		if contador<9 then
			contador:=contador+1;
			
			if contador=2 then aux1<='0'; end if;
			if contador=4 then aux2<='0'; end if;
			if contador=6 then aux3<='0'; end if;
--clocks com intervalos de inicio definidos em 2, 4 e 6.
		else
			contador:=0;
			aux1<='1';
			aux2<='1';
			aux3<='1';
--gerar o contador de valor

		end if;
	end if;
end process pwm;


end architecture c_gerador_pwm;