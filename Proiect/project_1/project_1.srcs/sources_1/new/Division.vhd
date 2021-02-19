LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Division IS
    PORT ( 
          clk       :  in  STD_LOGIC;
          Start     :  in  STD_LOGIC;
	      Divis     :  in  STD_LOGIC_VECTOR (3 downto 0);
		  Dividend  :  in  STD_LOGIC_VECTOR (7 downto 0);
		  Done      : out  STD_LOGIC;
          Remainder : out  STD_LOGIC_VECTOR (3 downto 0);
		  Quotient  : out  STD_LOGIC_VECTOR (3 downto 0)
			);
END Division;



ARCHITECTURE BehavioralDivision OF Division IS

SIGNAL DivBuf : STD_LOGIC_VECTOR (3 downto 0);
	
-- signal DivNeg: STD_LOGIC_VECTOR (3 downto 0);
	
SIGNAL Remaind : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL ACC     : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL sum     : STD_LOGIC_VECTOR (3 downto 0);

TYPE state IS (S0, S1, S2, S3, S4);
	
SIGNAL FSM_cur_state, FSM_nx_state : state;
SIGNAL FSM_Done                    : STD_LOGIC;
	
SIGNAL INC_CNT                     : STD_LOGIC;
SIGNAL LD_high                     : STD_LOGIC;
	
SIGNAL AccShift_left0              : STD_LOGIC;
SIGNAL AccShift_left1              : STD_LOGIC;
	
SIGNAL Counter                     : STD_LOGIC_VECTOR (2 downto 0);
	
--signal addd: STD_LOGIC;
--signal subb: STD_LOGIC;
--signal sum: STD_LOGIC_VECTOR(3 downto 0);


	BEGIN

		DivisorReg: PROCESS (clk, start)
		BEGIN
		
				IF clk'event AND clk = '1' THEN 
				
					IF start = '1' THEN
					
						DivBuf <= Divis;
						
					END IF;
					
				END IF;
				
		END PROCESS;


		ComboSum: PROCESS (DivBuf, ACC)
		BEGIN
		
				 sum <= ACC(7 downto 4) + (not(DivBuf) + 1);
				 
		END PROCESS;


		ACCReg: PROCESS (clk, start, Dividend, sum, AccShift_left0, AccShift_left1, LD_high)
		BEGIN
		
			IF clk'event and clk = '1' THEN
			
				IF start = '1' THEN
			  
					ACC             <= Dividend(6 downto 0)&'0';	
			  
				ELSIF  LD_high = '1' THEN 
			  
					ACC(7 downto 4) <= sum;
				  
				ELSIF AccShift_left0 = '1' THEN
			  
					ACC             <= ACC(6 downto 0) & '0';
					
				ELSIF AccShift_left1 = '1' THEN
				  
				  ACC              <= ACC(6 downto 0) & '1';
				  
				END IF;
				
			END IF;
			
		END PROCESS;


		-- output the results
		Result: PROCESS (ACC)
		BEGIN  
		
			 Quotient  <=     ACC(3 downto 0);	 
			 Remainder <= '0'&ACC(7 downto 5);
			 
		END PROCESS;


		-- Combo Control Output
		ComboFSMoutput: PROCESS(FSM_cur_State, start, sum, FSM_done)
		BEGIN
		
			INC_CNT <= '0';
			LD_high <= '0';
			
			AccShift_left0 <= '0';
			AccShift_left1 <= '0';
			
			CASE FSM_cur_State IS 
					WHEN S0 =>
								 IF start = '1' THEN 
								 
										FSM_nx_State <= S0;
									
								 ELSIF sum(3) = '0' THEN 
								 
										FSM_nx_State <= S1;
								 
								 ELSE 
								 
										FSM_nx_State <= S2;
								 
								 END IF;
								 
					WHEN S1 =>
								 LD_high      <= '1';
								 
								 FSM_nx_State <= S3;
									
					WHEN S2 =>
								AccShift_left0 <= '1';
								
								INC_CNT        <= '1';
								
								FSM_nx_State   <= S4;
								
					WHEN S3 => 
								AccShift_left1 <= '1';
								
								INC_CNT        <= '1';
								
								FSM_nx_State   <= S4;
								
					WHEN S4 =>
								IF FSM_done = '1' THEN 
								
									FSM_nx_State <= S4;
									
								ELSE
								
									FSM_nx_State <= S0;
								
								END IF;
			END CASE;
			
		END PROCESS;


		-- FSM next state register	  
		RegFSM_State: PROCESS (clk, FSM_nx_State, start)
		BEGIN
		
			 IF (clk'event AND clk = '1') THEN 
			 
				  IF start ='1' THEN 
				  
						FSM_Cur_State <=           S0;
				  
				  ELSE
				  
						FSM_Cur_State <= FSM_nx_State;
				  
				  END IF;
				  
			 END IF;
			 
		END PROCESS;


		-- Counter to control the iteration
		RegCounter: PROCESS(clk, start)
		BEGIN
		
			 IF clk'event AND clk = '1' THEN 
			 
				 IF start = '1' THEN
				 
						Counter <= (others => '0');
				 
				 ELSIF INC_CNT = '1' THEN
				 
						Counter <=     Counter + 1;
				 
				 END IF;
				 
			 END IF;
			 
		END PROCESS;

		-- update FSM_done
		ComboFSMdone: PROCESS(Counter)
		BEGIN
		
			FSM_done <= counter(2) AND (NOT(counter(1))) AND (NOT(counter(0)));
			
		END PROCESS;

		PROCESS(FSM_done)
		BEGIN 
		
				done <= FSM_done;
				
		END PROCESS;

END BehavioralDivision;