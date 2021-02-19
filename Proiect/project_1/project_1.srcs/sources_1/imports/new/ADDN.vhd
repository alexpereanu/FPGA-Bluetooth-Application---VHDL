library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity addn is
    generic (n : natural);
    Port (x : in std_logic_vector(n-1 downto 0);
          y : in std_logic_vector(n-1 downto 0);
          tin : in std_logic;
          s : out std_logic_vector(n-1 downto 0);
          tout : out std_logic;
          ovf : out std_logic);--se seteaza daca carry out de la ultimul e diferit de carry out de la penultimul
end addn;

architecture Behavioral of addn is
signal total_sum : std_logic_vector(n downto 0);
signal zeros : std_logic_vector(n-1 downto 0):= (others => '0');
begin
    
    total_sum <= x + y + (zeros & tin);
    s <= total_sum(n-1 downto 0);
    tout <= total_sum(n);
    ovf <= total_sum(n) xor (x(n-1) or y(n-1));

end Behavioral;
