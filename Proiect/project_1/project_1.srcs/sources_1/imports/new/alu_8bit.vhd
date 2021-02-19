library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit is
    --generic (n : natural := 8);
    port(
        clk: in std_logic;
        x: in std_logic_vector(7 downto 0);
        y: in std_logic_vector(7 downto 0);
        selectie: in std_logic_vector(2 downto 0);
        rezultat: out std_logic_vector(7 downto 0));
end alu_8bit;

architecture Behavioral of alu_8bit is

component sumator8biti is
   Port ( x: in std_logic_vector (7 downto 0);
        y: in std_logic_vector (7 downto 0);
        Tin: in std_logic;
        s: out std_logic_Vector(7 downto 0);
        Tout: out std_logic );       
end component;

component scadere8biti is
    Port(x: in std_logic_vector(7 downto 0);
        y: in std_logic_vector(7 downto 0);
        diferenta: out std_logic_vector(7 downto 0));
end component;

component deplasariStangaDreapta8biti is
    Port(dataIn: in std_logic_vector(7 downto 0);
        selDeplasare: in std_logic;
        selPozitiiDeplasare: in std_logic_vector(1 downto 0);
        dataOut: out std_logic_vector(7 downto 0));
end component;

component mult_booth is
    Port (clk : in std_logic;
          rst : in std_logic;
          start : in std_logic;
          x : in std_logic_vector(7 downto 0);
          y : in std_logic_vector(7 downto 0);
          a : out std_logic_vector(7 downto 0);
          q : out std_logic_vector(7 downto 0);
          term : out std_logic);
end component;

component Division is
    PORT ( 
          clk       :  in  STD_LOGIC;
          Start     :  in  STD_LOGIC;
	      Divis     :  in  STD_LOGIC_VECTOR (3 downto 0);
		  Dividend  :  in  STD_LOGIC_VECTOR (7 downto 0);
		  Done      : out  STD_LOGIC;
          Remainder : out  STD_LOGIC_VECTOR (3 downto 0);
		  Quotient  : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component SSD is
    Port ( clk: in STD_LOGIC;
           digits: in STD_LOGIC_VECTOR(15 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           cat: out STD_LOGIC_VECTOR(6 downto 0));
end component;

--signal clk: std_logic:='0';
signal rst: std_logic:='0';
signal start: std_logic:='0';
signal a: std_logic_vector(7 downto 0):="00000000";
signal q: std_logic_vector(7 downto 0):="00000000";
signal term: std_logic:='0';
signal Tin: std_logic:='0';
signal Tout: std_logic;
signal selDeplasare: std_logic;
signal selPozitiiDeplasare: std_logic_vector(1 downto 0);
signal rezultatAdunare: std_logic_vector(7 downto 0):="00000000";
signal rezultatScadere: std_logic_vector(7 downto 0):="00000000";
signal rezultatDeplasare: std_logic_vector(7 downto 0):="00000000"; 
signal rezultatInmultireA: std_logic_vector(7 downto 0):="00000000";
signal rezultatInmultireQ: std_logic_vector(7 downto 0):="00000000";
signal dividend: std_logic_vector(7 downto 0):="00000000";
signal divis: std_logic_vector(3 downto 0):="0000";
signal remainder: std_logic_vector(3 downto 0):="0000";
signal quotient: std_logic_vector(3 downto 0):="0000";
signal startImpartire: std_logic:='1';
signal doneImpartire: std_logic:='0';

begin
    
    adunare: sumator8biti port map(x, y, Tin, rezultatAdunare, Tout);
    scadere: scadere8biti port map(x,y, rezultatScadere);
    deplasare: deplasariStangaDreapta8biti port map(x,selDeplasare,selPozitiiDeplasare,rezultatDeplasare);
    inmultire: mult_booth port map(clk,rst,start,x,y,rezultatInmultireA,rezultatInmultireQ,term);
    impartire: Division port map(clk,startImpartire,y(3 downto 0),x,doneImpartire,remainder,quotient);
    
    process(selectie,rezultatAdunare, rezultatScadere, rezultatDeplasare, rezultatInmultireA,rezultatInmultireQ,remainder,quotient)
    
    variable rez: std_logic_vector(7 downto 0);
    variable rezIn1: std_logic_vector(3 downto 0);
    variable rezIn2: std_logic_vector(7 downto 0);
    variable rezFin: std_logic_vector(7 downto 0);
    variable rezRemainder: std_logic_vector(3 downto 0);
    variable rezQuotient: std_logic_vector(3 downto 0);
    
    begin
            case selectie is
                when "000" => Tin <= '0';
                                rez := rezultatAdunare;
                            
                when "001" => Tin <= '1';
                                rez := rezultatAdunare;
                            
                when "010" => rez := rezultatScadere;
            
                when "011" => rez := rezultatDeplasare;
            
                when "100" => rezIn1:=rezultatInmultireA(3 downto 0);
                              rezIn2:=rezultatInmultireQ(7 downto 0);
                              --rezFin:= rezIn1 & rezIn2;
                when "101" => rezRemainder:=remainder;
                              rezQuotient:=quotient;
                when others => rez:= "00000000";
        end case;
        
        if(selectie="100") then
            rezultat<=rezIn2;
        elsif(selectie="101") then
            rezultat<=rezQuotient & rezRemainder;
        else        
            rezultat<=rez;
        end if;
    end process;

end Behavioral;
