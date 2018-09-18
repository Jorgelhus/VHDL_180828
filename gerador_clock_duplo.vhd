--Para esta operaçao e necessario a existencia de dois clocks extras, chamados pisca1 e pisca2
--Estes clocks tem intervalo de operaçao de valor 2 e 4, de forma a gerar os pisca exigidos.
entity gerador_clock_duplo is
port (
	signal clock_in : in bit;
--entrada do clock inicial, que e determinado pelo usuario/pela fpga
	
	signal clock_out1 : out bit; --Pisca1
	signal clock_out2 : out bit --Pisca2
--saida dos clocks de pisca
	
);
end entity gerador_clock_duplo;

architecture c_gerador_clock of gerador_clock_duplo is

signal clk1, clk2 : bit := '0';

begin

clock_out1 <= clk1;
clock_out2 <= clk2;

clock: process (clock_in)

variable contador1 : integer range 0 to 10 := 0;
variable contador2 : integer range 0 to 10 := 0;

begin
	if clock_in='0' and clock_in'event then
	
		if contador1<1 then
			contador1:=contador1+1;
--clock em 2
		else
			contador1:=0;
			clk1<=not clk1;
		end if;
		
		if contador2<3 then
			contador2:=contador2+1;
--clock em 4
		else
			contador2:=0;
			clk2<=not clk2;
		end if;
		
		
	end if;
end process clock;


end;