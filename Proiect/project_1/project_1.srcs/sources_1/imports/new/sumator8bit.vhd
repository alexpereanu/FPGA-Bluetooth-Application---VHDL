library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumator8biti is
 Port ( x: in std_logic_vector (7 downto 0);
        y: in std_logic_vector (7 downto 0);
        Tin: in std_logic;
        s: out std_logic_Vector(7 downto 0);
        Tout: out std_logic );
end sumator8biti;

architecture Behavioral of sumator8biti is

signal P0, G0, P1, G1, P2, G2, P3, G3: std_logic;
signal T1, T2,T3: std_logic;

component sumator2biti is
  Port (x,y:in std_logic_vector(1 downto 0);
        tin:in std_logic;
        s:out std_logic_vector(1 downto 0);
        G,P:out std_logic);
end component;
begin

sum1: sumator2biti port map(x(1 downto 0), y(1 downto 0), Tin, s(1 downto 0), G0, P0);
sum2: sumator2biti port map(x(3 downto 2), y(3 downto 2), T1, s(3 downto 2), G1, P1);
sum3: sumator2biti port map(x(5 downto 4), y(5 downto 4), T2, s(5 downto 4), G2, P2);
sum4: sumator2biti port map(x(7 downto 6), y(7 downto 6), T3, s(7 downto 6), G3, P3);

T1<= G0 OR  (P0 and Tin);
T2<= G1 OR (P1 and T1);
T3<= G2 OR (P2 and T2);

Tout <= T3;

end Behavioral;
