library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestALU is
    Port(clk: in std_logic;
        sw: in std_logic_vector(2 downto 0);
        rezultat: out std_logic_vector(7 downto 0);
        an: out std_logic_vector(3 downto 0);
        cat: out std_logic_vector(6 downto 0));
end TestALU;

architecture Behavioral of TestALU is
    
component alu_8bit is
     port(
        clk: in std_logic;
        x: in std_logic_vector(7 downto 0);
        y: in std_logic_vector(7 downto 0);
        selectie: in std_logic_vector(2 downto 0);
        rezultat: out std_logic_vector(7 downto 0));
end component;

component SSD is
    Port ( clk: in STD_LOGIC;
           digits: in STD_LOGIC_VECTOR(15 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           cat: out STD_LOGIC_VECTOR(6 downto 0));
end component;

signal rezultatDisplay: std_logic_vector(15 downto 0):="0000000000000000";
signal rezultatOperatie: std_logic_vector(7 downto 0):="00000000";
signal x: std_logic_vector(7 downto 0):="00001000";
signal y: std_logic_vector(7 downto 0):="00000010";

begin
    
operatie: alu_8bit port map(clk,x,y,sw,rezultatOperatie);
display: SSD port map(clk,rezultatDisplay,an,cat);

rezultatDisplay<="00000000" & rezultatOperatie;
rezultat<=rezultatOperatie;

end Behavioral;
