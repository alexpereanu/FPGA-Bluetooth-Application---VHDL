library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult_booth is
    generic (n : natural := 8);
    Port (clk : in std_logic;
          rst : in std_logic;
          start : in std_logic;
          x : in std_logic_vector(n-1 downto 0);
          y : in std_logic_vector(n-1 downto 0);
          a : out std_logic_vector(n-1 downto 0);
          q : out std_logic_vector(n-1 downto 0);
          term : out std_logic);
end mult_booth;

architecture Behavioral of mult_booth is
signal loadB : std_logic;
signal outB : std_logic_vector(n-1 downto 0);
signal subB : std_logic;
signal newB : std_logic_vector(n-1 downto 0);

signal inA : std_logic_vector(n-1 downto 0);
signal outA : std_logic_vector(n-1 downto 0);
signal loadA : std_logic;
signal sarAQ : std_logic;

signal loadQ : std_logic;
signal outQ : std_logic_vector(n-1 downto 0);
signal qm1 : std_logic;
signal q0qm1 : std_logic_vector(1 downto 0);

signal tout : std_logic;
signal ovf : std_logic;

signal rstA : std_logic;
signal rstqm1 : std_logic;


begin
    fdn_B: entity WORK.fdn generic map (n => 8) port map (clk => clk, 
                                                          rst => rst, 
                                                          ce => loadB, 
                                                          d => x, 
                                                          q => outB);

    xorgates: for i in n-1 downto 0 generate
        newB(i) <= subB xor outB(i); 
    end generate;

    srrn_A: entity WORK.srrn generic map (n => 8) port map (clk => clk, 
                                                            rst => rstA, 
                                                            ce => sarAQ, 
                                                            load => loadA, 
                                                            sri => outA(n-1), 
                                                            d => inA, 
                                                            q => outA);

    srrn_q: entity WORK.srrn generic map (n => 8) port map (clk => clk, 
                                                            rst => rst, 
                                                            ce => sarAQ, 
                                                            load => loadQ, 
                                                            sri => outA(0), 
                                                            d => y, 
                                                            q => outQ);

    fd_qm1: entity WORK.fd port map (clk => clk, 
                                     rst => rstqm1, 
                                     ce => sarAQ, 
                                     d => outQ(0), 
                                     q => qm1);
    
    addn: entity WORK.addn generic map (n => 8) port map (x => outA, 
                                                          y => newB, 
                                                          tin => subB, 
                                                          s => inA, 
                                                          tout => tout, 
                                                          ovf => ovf);
    q0qm1 <= outQ(0) & qm1;                                                       
    com_unit: entity WORK.comand_unit generic map (n => 8) port map (clk => clk,
                                                                     rst => rst,
                                                                     start => start,
                                                                     q0qm1 => q0qm1,
                                                                     term => term,
                                                                     loadB => loadB,
                                                                     subB => subB,
                                                                     rstA => rstA,
                                                                     loadA => loadA,
                                                                     sarAQ => sarAQ,
                                                                     loadQ => loadQ,
                                                                     rstqm1 => rstqm1);                                                          
    a <= outa;
    q <= outq;
end Behavioral;
