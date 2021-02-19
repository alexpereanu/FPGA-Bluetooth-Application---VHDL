library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity Main is
    Port(clk : in STD_LOGIC;
        rx : in std_logic;
        rezultat: out std_logic_vector(7 downto 0);
        sw: in std_logic_vector(2 downto 0);
        an: out STD_LOGIC_VECTOR(3 downto 0);
        cat: out STD_LOGIC_VECTOR(6 downto 0));
end Main;

architecture Behavioral of Main is

component alu_8bit is
    port(x: in std_logic_vector(7 downto 0);
        y: in std_logic_vector(7 downto 0);
        selectie: in std_logic_vector(2 downto 0);
        rezultat: out std_logic_vector(7 downto 0));
end component;

component rx_uart is
    Port (clk : in STD_LOGIC;
        rx : in std_logic;
        output: out std_logic_vector(7 downto 0));
end component;

component ConvertorHexaInteger is 
    port(dataIn: in std_logic_vector(7 downto 0);
        dataOut: out std_logic_vector(7 downto 0));
end component;

component SSD is
    Port ( clk: in STD_LOGIC;
           digits: in STD_LOGIC_VECTOR(15 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           cat: out STD_LOGIC_VECTOR(6 downto 0));
end component;

component MPG is
    Port ( en : out STD_LOGIC;
           input : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

signal primulTermen: std_logic_vector(7 downto 0):="00000000";
signal cifra: std_logic_vector(7 downto 0):="00000000";
signal rezultatDisplay: std_logic_vector(15 downto 0):="0000000000000000";
signal x: std_logic_vector(7 downto 0):="00000000";
signal y: std_logic_vector(7 downto 0):="00000111";
signal op: std_logic:='0';
signal rezultatOperatie: std_logic_vector(7 downto 0);
signal enableSSD: std_logic:='0';
signal reset: std_logic:='0';

begin

termen: rx_uart port map(clk, rx, primulTermen);
cifraApasata: ConvertorHexaInteger port map(primulTermen,cifra);
display: SSD port map(clk,rezultatDisplay,an,cat);
operatie: alu_8bit port map(x,y,sw,rezultatOperatie);

--butonOperatie: MPG port map(enableSSD, enable, clk);
--butonReset: MPG port map(reset, resetButon, clk);
x<=cifra;
rezultatDisplay<="00000000" & rezultatOperatie;
rezultat<=rezultatOperatie;

--nextResult:process(enableSSD,reset)
--        begin
--            if(enableSSD='1') then
--                x<=cifra;
--                rezultatDisplay<="00000000" & rezultatOperatie;
--            elsif(reset='1') then
--                x<="00000000";
--                rezultatDisplay<="0000000000000000";
--            end if; 
--        end process;
        
        
end Behavioral;