--Maquina de primos, em que os valores a serem exibidos sao gerados.
--Na maquina de primos, tambem fazemos a separaçao dos grupos, e enviamos a informaçao pelo tipo

entity maq_primos is
port (
	signal pwm1 : in bit;
--entrada do clock gerado internamente, e determinado pelo gerador interno.

	signal control : in bit;
--entrada do clock de controle, que e determinado pelo usuario/pela fpga

	signal estado : out bit_vector (3 downto 0);
--saida do valor numerico gerado.
	
	signal tipo : out bit_vector (1 downto 0)
--saida do tipo de valor gerado, agrupando-o em um dos grupos.
	
);
end entity maq_primos;

architecture c_maq_primos of maq_primos is

signal est_aux : bit_vector (3 downto 0) := "0000";
signal tipo_aux : bit_vector (1 downto 0) := "00";


begin
tipo  <= tipo_aux;
estado <= est_aux;

primos: process (pwm1)

begin
--borda de descida
	if pwm1='0' and pwm1'event then
	   if control = '0' then 
		case est_aux is
			when "0000" => est_aux<="0010";
			               tipo_aux<="01";
			when "0001" => est_aux<="0010";
			               tipo_aux<="01";
			when "0010" => est_aux<="0011";
			               tipo_aux<="10";
			when "0011" => est_aux<="0101";
			               tipo_aux<="00";
			when "0100" => est_aux<="0101";
			               tipo_aux<="00";
			when "0101" => est_aux<="0111";
			               tipo_aux<="11";
			when "0110" => est_aux<="0111";
			               tipo_aux<="11";
			when "0111" => est_aux<="1011";
			               tipo_aux<="01";
			when "1000" => est_aux<="1011";
			               tipo_aux<="01";			
			when "1001" => est_aux<="1011";
			               tipo_aux<="01";
			when "1010" => est_aux<="1101";
			               tipo_aux<="01";
			when "1011" => est_aux<="1101";
			               tipo_aux<="01";
			when "1100" => est_aux<="1101";
			               tipo_aux<="01";		
			when "1101" => est_aux<="0010";
			               tipo_aux<="01";				
			when "1110" => est_aux<="0010";
			               tipo_aux<="01";	
			when "1111" => est_aux<="0010";
			               tipo_aux<="01";							
								
		end case;

      end if;		

--borda de subida
		if control = '1' then 
		case est_aux is
			when "0000" => est_aux<="0001";
			               tipo_aux<="01";
			when "0001" => est_aux<="0100";
			               tipo_aux<="01";
			when "0010" => est_aux<="0100";
			               tipo_aux<="01";
			when "0011" => est_aux<="0100";
			               tipo_aux<="01";
			when "0100" => est_aux<="0110";
			               tipo_aux<="10";
			when "0101" => est_aux<="0110";
			               tipo_aux<="10";
			when "0110" => est_aux<="1000";
			               tipo_aux<="01";
			when "0111" => est_aux<="1000";
			               tipo_aux<="01";
			when "1000" => est_aux<="1001";
			               tipo_aux<="10";			
			when "1001" => est_aux<="1010";
			               tipo_aux<="00";
			when "1010" => est_aux<="1100";
			               tipo_aux<="10";
			when "1011" => est_aux<="1100";
			               tipo_aux<="10";
			when "1100" => est_aux<="1110";
			               tipo_aux<="11";		
			when "1101" => est_aux<="1110";
			               tipo_aux<="11";				
			when "1110" => est_aux<="1111";
			               tipo_aux<="00";	
			when "1111" => est_aux<="0000";
			               tipo_aux<="01";	
		
		end case;
		end if;
	end if;
end process primos;

end architecture c_maq_primos;