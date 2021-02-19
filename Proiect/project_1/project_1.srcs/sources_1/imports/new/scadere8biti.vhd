library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity scadere8biti is
    Port(x: in std_logic_vector(7 downto 0);
        y: in std_logic_vector(7 downto 0);
        diferenta: out std_logic_vector(7 downto 0));
end scadere8biti;

architecture Behavioral of scadere8biti is

component sumator8biti is
   Port ( x: in std_logic_vector (7 downto 0);
        y: in std_logic_vector (7 downto 0);
        Tin: in std_logic;
        s: out std_logic_Vector(7 downto 0);
        Tout: out std_logic );       
end component;

signal Tin: std_logic:='0';
signal Tout: std_logic;
signal suma: std_logic_vector(7 downto 0);
signal y_complement: std_logic_vector(7 downto 0);

begin
    y_complement<=not(y) + "00000001";
    sumator: sumator8biti port map(x,y_complement,Tin,suma,Tout);
    diferenta<=suma;
end Behavioral;
