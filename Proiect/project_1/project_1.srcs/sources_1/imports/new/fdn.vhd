library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fdn is
    generic (n : natural);
    Port (clk : in std_logic;
          rst : in std_logic;
          ce : in std_logic;
          d : in std_logic_vector(n-1 downto 0);
          q : out std_logic_vector(n-1 downto 0));
end fdn;

architecture Behavioral of fdn is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                for i in n-1 downto 0 loop
                    q(i) <= '0';
                end loop;
            elsif ce = '1' then
                q <= d;
            end if;
        end if;
    end process;
end Behavioral;
