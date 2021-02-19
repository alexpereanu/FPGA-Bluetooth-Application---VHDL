library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ConvertorHexaInteger is
    port(dataIn: in std_logic_vector(7 downto 0);
        dataOut: out std_logic_vector(7 downto 0));
end ConvertorHexaInteger;

architecture Behavioral of ConvertorHexaInteger is

signal output: std_logic_vector(7 downto 0):="00000000";

begin
    process(dataIn)
    begin
        case dataIn is    
            when "00110000" => output<="00000000";
            when "00110001" => output<="00000001";
            when "00110010" => output<="00000010";
            when "00110011" => output<="00000011";
            when "00110100" => output<="00000100";
            when "00110101" => output<="00000101";
            when "00110110" => output<="00000110";
            when "00110111" => output<="00000111";
            when "00111000" => output<="00001000";
            when others => output<="00001001";
         end case;
    end process;        
    
    dataOut<=output;    
end Behavioral;