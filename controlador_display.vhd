entity controlador_display is
port (
signal clock : in bit;
signal num : in bit_vector(3 downto 0);
signal clock1, clock2 : in bit;
signal num7, num6, num5, num4, 
num3, num2, num1, num0 : out bit_vector (3 downto 0);
signal en0, en1, en2, en3, en4, en5, en6, en7 : out bit
);
end entity controlador_display;

architecture c_controlador_display of controlador_display is

signal aux7, aux6, aux5, aux4, aux3, 
        aux2, aux1, aux0 : bit_vector (3 downto 0) := "0000";
		  
signal xen0, xen1, xen2, xen3, xen4,
		  xen5, xen6, xen7 : bit;

signal controle: bit;
begin

num7 <= aux7;
num6 <= aux6;
num5 <= aux5;
num4 <= aux4;
num3 <= aux3;
num2 <= aux2;
num1 <= aux1;
num0 <= aux0;

en0 <= xen0;
en1 <= xen1;
en2 <= xen2;
en3 <= xen3;
en4 <= xen4;
en5 <= xen5;
en6 <= xen6;
en7 <= xen7;


controlador: process (clock)

variable vnum7, vnum6, vnum5, vnum4, vnum3, 
         vnum2, vnum1, vnum0 : bit_vector (3 downto 0) := "0000";

variable xen0,xen1, xen2,xen3,xen4,xen5,xen6,xen7 : bit := '0';
begin

if clock='0' and clock'event then

case num is	-- Multiplos de 5
		   when "0101" => controle <='1';
			when "1010" => controle <='1';
			when "1111" => controle <='1';
	-- Multiplos de 3
			when "0011" => controle <= clock1;
			when "0110" => controle <= clock1;
			when "1001" => controle <= clock1;
			when "1100" => controle <= clock1;
	 -- Multiplos de 7
			when "0111" => controle	<= clock2;
			when "1110" => controle <= clock2;
	 -- Outros casos
			when others => controle <='0'; 
		end case;
	end if;


vnum0 := vnum1;
vnum1 := vnum2;
vnum2 := vnum3;
vnum3 := vnum4;
vnum4 := vnum5;
vnum5 := vnum6;
vnum6 := vnum7;
vnum7 := num;

aux7 <= vnum7;
aux6 <= vnum6;
aux5 <= vnum5;
aux4 <= vnum4;
aux3 <= vnum3;
aux2 <= vnum2;
aux1 <= vnum1;
aux0 <= vnum0;


xen0 := xen1;
xen1 := xen2;
xen2 := xen3;
xen3 := xen4;
xen4 := xen5;
xen5 := xen6;
xen6 := xen7;
xen7 := Controle;


end process controlador;



end architecture c_controlador_display;