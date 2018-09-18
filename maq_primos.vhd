entity maq_primos is
port (
	signal pwm1 : in bit;
	signal control: in bit;
	signal estado : out bit_vector (3 downto 0)
);
end entity maq_primos;

architecture c_maq_primos of maq_primos is

signal est_aux : bit_vector (3 downto 0) := "0000";

begin


primos: process (pwm1)

begin

if pwm1='0' and pwm1'event then
	if control = '0' then 
		case est_aux is
			when "0000" => est_aux <="0010";
			when "0001" => est_aux <="0010";
			when "0010" => est_aux <="0011";
			when "0011" => est_aux <="0101";
			when "0100" => est_aux <="0101";
			when "0101" => est_aux <="0111";
			when "0110" => est_aux <="0111";
			when "0111" => est_aux <="1011";
			when "1000" => est_aux <="1011";
			when "1001" => est_aux <="1011";
			when "1010" => est_aux <="1011";
			when "1011" => est_aux <="1101";
			when "1100" => est_aux <="1101";
			when "1101" => est_aux <="0010";
			when "1110" => est_aux <="0010";
			when "1111" => est_aux <="0010";
		end case;
	else
		case est_aux is
			when "0000" => est_aux <="0001";
			when "0001" => est_aux <="0100";
			when "0010" => est_aux <="0100";
			when "0011" => est_aux <="0100";
			when "0100" => est_aux <="0110";
			when "0101" => est_aux <="0110";
			when "0110" => est_aux <="1000";
			when "0111" => est_aux <="1000";
			when "1000" => est_aux <="1001";
			when "1001" => est_aux <="1010";
			when "1010" => est_aux <="1100";
			when "1011" => est_aux <="1100";
			when "1100" => est_aux <="1110";
			when "1101" => est_aux <="1110";
			when "1110" => est_aux <="1111";
			when "1111" => est_aux <="0000";
		end case;
	end if;	
end if;
end process primos;

estado <= est_aux;

end architecture c_maq_primos;