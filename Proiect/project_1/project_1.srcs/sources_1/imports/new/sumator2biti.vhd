library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumator2biti is
  Port (x,y:in std_logic_vector(1 downto 0);
        tin:in std_logic;
        s:out std_logic_vector(1 downto 0);
        G,P:out std_logic);
end sumator2biti;

architecture Behavioral of sumator2biti is

signal t1 : std_logic;
signal g0, g1, p0, p1 : std_logic;

begin

-- Addere
    s(0) <= x(0) xor y(0) xor Tin;
    s(1) <= x(1) xor y(1) xor t1;  
   -- s <= x + y + Tin;
    --gps
    g0 <= x(0) and y(0);
    p0 <= x(0) or y(0);
    
    g1 <= x(1) and y(1);
    p1 <= x(1) or y(1); 
    --t1
    t1 <= g0 or (p0 and Tin); 
    
    P <= p1 and p0;
    G <= g1 or (p1 and g0);  

end Behavioral;
