library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comand_unit is
    generic (n : natural);
    Port (clk : in std_logic;
          rst : in std_logic;
          start : in std_logic;
          q0qm1 : in std_logic_vector(1 downto 0);
          term : out std_logic;
          loadB : out std_logic;
          subB : out std_logic;
          rstA : out std_logic;
          loadA : out std_logic;
          sarAQ : out std_logic;
          loadQ : out std_logic;
          rstQm1 : out std_logic);
end comand_unit;

architecture Behavioral of comand_unit is
signal c : natural; 

type states is (idle, init, test, sub, add, shift, stop);
signal state : states;
begin
    process(clk)
    begin
        if rst = '1' then
            state <= idle;
        elsif rising_edge(clk) then
            case state is
                when idle => if start = '1' then
                                 state <= init;
                             end if;
                when init => state <= test;
                             c <= n;
                when test =>if c = 0 then
                                state <= stop;
                            elsif c > 0 then
                                 if q0qm1 = "10" then
                                     state <= sub;
                                 elsif q0qm1 = "01" then
                                     state <= add;
                                 elsif q0qm1 = "00" or q0qm1 = "11" then
                                     state <= shift;
                                 end if;
                            end if;
                when sub => state <= shift;
                when add => state <= shift;
                when shift => state <= test;
                              c <= c - 1;
                when stop => null;      
            end case;
        end if;
    end process;
    
    
    --outputs
    loadB <= '1' when state = init else '0';
    term <= '1' when state = stop else '0'; 
    subB <= '1' when state = sub else '0';
    rstA <= '1' when state = init else '0';
    loadA <= '1' when state = sub or state = add else '0';
    sarAQ <= '1' when state = shift else '0';
    loadQ <= '1' when state = init else '0';
    rstQm1 <= '1' when state = init else '0';
    
end Behavioral;
