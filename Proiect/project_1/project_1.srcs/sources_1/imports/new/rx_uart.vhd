library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rx_uart is
  Port (clk : in STD_LOGIC;
        rx : in std_logic;
        output: out std_logic_vector(7 downto 0));
        --an: out STD_LOGIC_VECTOR(3 downto 0);
        --cat: out STD_LOGIC_VECTOR(6 downto 0)
end rx_uart;

architecture Behavioral of rx_uart is

component SSD is
    Port ( clk: in STD_LOGIC;
           digits: in STD_LOGIC_VECTOR(15 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           cat: out STD_LOGIC_VECTOR(6 downto 0));
end component;

signal counterUart: integer := 0;
signal baudEn : std_logic := '0';
signal rx_rdy : std_logic;
signal rx_data: std_logic_vector(7 downto 0):="00000000";
signal rezultatDisplay: std_logic_vector(15 downto 0):="0000000000000000";

begin

baud_rate_generator:process(clk)
    begin
        if rising_edge(clk) then
            if counterUart < 651 then
                counterUart <= counterUart + 1;
                baudEn <= '0';
            elsif counterUart = 651 then 
                counterUart <= 0;
                baudEn <= '1';
            end if;    
        end if;
    end process;
    
fsm: entity work.rx_fsm port map(rx_rdy, rx_data, baudEn, '0', rx, clk);
--display: SSD port map(clk,rezultatDisplay,an,cat);
output<=rx_data;

--rezultatDisplay<="00000000" & rx_data;

end Behavioral;
