--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 9.3 Revision 2 from HDL Works B.V.
--
-- Ease library  : Work
-- HDL library   : Work
-- Host name     : NB21-B0I-YME
-- User name     : yves.meyer
-- Time stamp    : Tue Jan  2 18:25:44 2024
--
-- Designed by   : M.Meyer/Y.Meyer
-- Company       : Haute Ecole Arc
-- Project info  : nanoProcesseur
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity Work.ALU
-- Last modified : Mon Dec 19 09:15:09 2016
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ALU is
  port (
    opcode_i    : in     std_logic_vector(5 downto 0);
    operande1_i : in     std_logic_vector(7 downto 0);
    operande2_i : in     std_logic_vector(7 downto 0);
    CCR_i       : in     std_logic_vector(3 downto 0);
    ALU_o       : out    std_logic_vector(7 downto 0);
    Z_C_V_N     : out    std_logic_vector(3 downto 0));
end entity ALU;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.ALU.Behavioral
-- Last modified : Mon Dec 19 09:15:09 2016
--------------------------------------------------------------------------------

architecture Behavioral of ALU is

  signal uALU_C     : std_logic_vector(8 DOWNTO 0);
  signal CCR_mask   : std_logic_vector(3 downto 0);
  signal flag_Z		: std_logic;
  signal flag_C		: std_logic;
  signal flag_V		: std_logic;
  signal flag_n		: std_logic;
  
begin

process(opcode_i, operande1_i, operande2_i,CCR_i)
begin

  uALU_C        <= (others => '0'); -- valeur par d�faut
  CCR_mask      <= (others => '0'); -- valeur par d�faut
  
  case opcode_i is
    when LOADconst | LOADaddr =>   
      uALU_C <= '0' & operande1_i;
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';
      
    when ORconst | ORaddr =>
      uALU_C <= ('0' & operande1_i) OR ('0' & operande2_i);
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';

    when ANDconst | ANDaddr =>
      uALU_C <= ('0' & operande1_i) AND ('0' & operande2_i);
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';

    when XORconst | XORaddr =>
      uALU_C <= ('0' & operande1_i) XOR ('0' & operande2_i);
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';
      
     when ROLaccu =>
      uALU_C <= operande1_i & CCR_i(Cidx);
      CCR_mask(Cidx) <= '1';
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';      

    when RORaccu =>
      uALU_C <= operande1_i(0) & CCR_i(Cidx) & operande1_i(7 downto 1);
      CCR_mask(Cidx) <= '1';
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';    
      
    when ADDconst | ADDaddr =>
      uALU_C   <= STD_LOGIC_VECTOR(UNSIGNED('0' & operande1_i) + UNSIGNED('0' & operande2_i));
      CCR_mask <= (others => '1');
      
    when ADCaddr | ADCconst =>
      if CCR_i(Cidx) = '1' then
        uALU_C   <= STD_LOGIC_VECTOR(UNSIGNED('0' & operande1_i) + UNSIGNED('0' & operande2_i) + 1);
      else
        uALU_C   <= STD_LOGIC_VECTOR(UNSIGNED('0' & operande1_i) + UNSIGNED('0' & operande2_i));
      end if;
      CCR_mask <= (others => '1');
      
    when NEGaccu | NEGconst | NEGaddr =>
      uALU_C <= STD_LOGIC_VECTOR('0' & (unsigned(operande1_i XOR "11111111") + 1));
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';
      
    when INCaccu  | INCaddr =>
      uALU_C <= STD_LOGIC_VECTOR(UNSIGNED('0' & operande1_i) + 1);
      CCR_mask(Cidx) <= '1';
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';      

    when DECaccu  | DECaddr =>
      uALU_C <= STD_LOGIC_VECTOR(UNSIGNED('0' & operande1_i) -1);
      CCR_mask(Cidx) <= '1';
      CCR_mask(Zidx) <= '1';
      CCR_mask(Nidx) <= '1';        

    when others =>
     null;         -- Les valeurs par d�faut sont mises avant le case
  end case;
end process;


	  
-- Branchement de la sortie
ALU_o <= uALU_C(7 DOWNTO 0);
	  
-- indicateur de contr�le
flag_Z <= 	CCR_i(Zidx) when CCR_mask(Zidx) = '0' else
      		'1'         when uALU_C(7 DOWNTO 0) = "00000000" else
      		'0';

flag_N <= 	CCR_i(Nidx) when CCR_mask(Nidx) = '0' else
       		uALU_C(7);

flag_V <= 	CCR_i(Vidx) when CCR_mask(Vidx) = '0' else
       		'0'         when operande1_i(7) /= operande2_i(7) else
       		'1'         when operande1_i(7) /= uALU_C(7) else
       		'0';

flag_C <= 	'0'         when opcode_i = CLRC      else
       		'1'         when opcode_i = SETC      else
       		CCR_i(Nidx) when opcode_i = TRFNC     else
       		CCR_i(Cidx) when CCR_mask(Cidx) = '0' else
       		uALU_C(8);

Z_C_V_N <= flag_Z & flag_C & flag_V & flag_N;

end architecture Behavioral ; -- of ALU
