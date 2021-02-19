library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity deplasariStangaDreapta8biti is
    Port(dataIn: in std_logic_vector(7 downto 0);
        selDeplasare: in std_logic;
        selPozitiiDeplasare: in std_logic_vector(1 downto 0);
        dataOut: out std_logic_vector(7 downto 0));
end deplasariStangaDreapta8biti;

architecture Behavioral of deplasariStangaDreapta8biti is
 
begin

    process(selDeplasare)
    begin
        case selDeplasare is
        when '0' => if(selPozitiiDeplasare = "00") then
                        dataOut<= dataIn;
                    elsif (selPozitiiDeplasare="01") then
                        dataOut<= dataIn(6 downto 0) & '0';
                    elsif (selPozitiiDeplasare="10") then
                        dataOut<=dataIn(5 downto 0) & "00";
                    elsif (selPozitiiDeplasare="11") then
                        dataOut<=dataIn(4 downto 0) & "000";
                    end if;
        when '1' => if(selPozitiiDeplasare = "00") then
                        dataOut<= dataIn;
                    elsif (selPozitiiDeplasare="01") then
                        dataOut<= '0' & dataIn(7 downto 1);
                    elsif (selPozitiiDeplasare="10") then
                        dataOut<= "00" & dataIn(7 downto 2);
                    elsif (selPozitiiDeplasare="11") then
                        dataOut<= "000" & dataIn(7 downto 3);
                    end if;
        when others => dataOut<= dataIn;
       end case;
    end process;             
    
end Behavioral;
