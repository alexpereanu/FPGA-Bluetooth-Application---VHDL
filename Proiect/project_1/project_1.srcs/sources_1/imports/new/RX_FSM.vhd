library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RX_FSM is
  Port ( RX_RDY: out STD_LOGIC;
         RX_DATA: out STD_LOGIC_VECTOR(7 downto 0);
         BAUD_EN: in STD_LOGIC;
         RST: in STD_LOGIC;
         RX: in STD_LOGIC;
         clk: in STD_LOGIC);
end RX_FSM;

architecture Behavioral of RX_FSM is
type state_type is(s1,s2,s3,s4,s5);
signal state:state_type;
signal BAUD_CNT: STD_LOGIC_VECTOR(3 downto 0);
signal BIT_CNT: STD_LOGIC_VECTOR(2 downto 0);

begin
process(clk)
begin
    if rst = '1' then
        state<=s1;
        BAUD_CNT<="0000";
    else
        if rising_edge(clk) then
            if BAUD_EN = '1' then
                case state is
                    when s1 => if RX = '0' then
                                BAUD_CNT<="0000";
                                BIT_CNT<="000";
                                state<=s2;
                               end if;
                    when s2 => BAUD_CNT<=BAUD_CNT+1;
                                if BAUD_CNT = "0111" then
                                  if RX = '1' then
                                     state<=s1;
                                     BAUD_CNT<="0000";
                                  else
                                     BAUD_CNT<="0000";
                                     BIT_CNT<="000";
                                     state<=s3;
                                  end if;
                                end if;
                    when s3 =>  BAUD_CNT<=BAUD_CNT+1;
                                if BAUD_CNT = "1111" then
                                  RX_DATA(conv_integer(BIT_CNT))<=RX;
                                  BIT_CNT<=BIT_CNT+1;
                                  if BIT_CNT = "111" then
                                        state<=s4;
                                        BIT_CNT<="000";
                                        BAUD_CNT<="0000";
                                  else
                                        state<=s3;
                                        BAUD_CNT<="0000";
                                  end if;
                               end if;
                    when s4 => BAUD_CNT<=BAUD_CNT+1;
                               if BAUD_CNT = "1111" then
                                    state<=s5;
                                    BAUD_CNT<="0000";
                               end if;
                    when s5 => BAUD_CNT<=BAUD_CNT+1;
                                if BAUD_CNT = "0111" then
                                    BAUD_CNT<="0000";
                                    state<=s1;
                               end if; 
                end case;
            end if;
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if BAUD_EN = '1' then
            case state is 
                when s1 => RX_RDY<='0';
                when s2 => RX_RDY<='0';
                           
                when s3 => RX_RDY<='0';
                           
                when s4 => RX_RDY<='0';
                          
                when s5 => RX_RDY<='1';
                           
            end case;
        end if;
     end if;
end process;

end Behavioral;
