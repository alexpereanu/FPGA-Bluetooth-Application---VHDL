library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity srrn is
    generic (n : natural);
    Port (clk : in std_logic;
          rst : in std_logic;
          ce : in std_logic;
          load : in std_logic;
          sri : in std_logic;
          d : in std_logic_vector(n-1 downto 0);
          q : out std_logic_vector(n-1 downto 0));
end srrn;

architecture Behavioral of srrn is
signal temp : std_logic_vector(n-1 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                for i in n-1 downto 0 loop
                    temp(i) <= '0';
                end loop;
            elsif load = '1' then
                temp <= d;
            elsif ce = '1' then
                temp(n-2 downto 0) <= temp(n-1 downto 1);
                temp(n-1) <= sri;
            end if;
        end if;
    end process;
    q <= temp;
end Behavioral;
