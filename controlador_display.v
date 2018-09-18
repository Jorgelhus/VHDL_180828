entity controlador_display is
port (
signal clock : in bit;
signal num : in bit_vector(3 downto 0);
signal num7, num6, num5, num4, 
num3, num2, num1, num0 : out bit_vector (3 downto 0)
);
end entity controlador_display;

architecture c_controlador_display of controlador_display is

signal aux7, aux6, aux5, aux4, aux3, 
        aux2, aux1, aux0 : bit_vector (3 downto 0) := "0000";

begin

num7 <= aux7;
num6 <= aux6;
num5 <= aux5;
num4 <= aux4;
num3 <= aux3;
num2 <= aux2;
num1 <= aux1;
num0 <= aux0;


controlador: process (clock)

variable vnum7, vnum6, vnum5, vnum4, vnum3, 
         vnum2, vnum1, vnum0 : bit_vector (3 downto 0) := "0000";

begin

if clock='0' and clock'event then

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

end if;
end process controlador;


end architecture c_controlador_display;