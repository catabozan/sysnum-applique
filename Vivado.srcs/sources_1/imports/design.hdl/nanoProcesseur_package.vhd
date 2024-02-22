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
-- Object        : Package Work.nanoProcesseur_package
-- Last modified : Tue Jan  2 18:22:48 2024
--------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
package nanoProcesseur_package is
  
 -- Taille des bus
  constant PC_BUS_WIDTH       : integer := 8;
  constant OPCODE_BUS_WIDTH   : integer := 6;
  constant OPERANDE_BUS_WIDTH : integer := 8;

  constant INSTR_BUS_WIDTH  : integer := OPCODE_BUS_WIDTH + OPERANDE_BUS_WIDTH;
  constant DATA_BUS_WIDTH   : integer := OPERANDE_BUS_WIDTH;
  constant ADDR_BUS_WIDTH   : integer := OPERANDE_BUS_WIDTH;
  
 -- Instructions
  constant STOREaddr  : std_logic_vector(5 downto 0) := "000001";
  constant LOADconst  : std_logic_vector(5 downto 0) := "000010";
  constant LOADaddr   : std_logic_vector(5 downto 0) := "000011";
  constant ANDconst   : std_logic_vector(5 downto 0) := "000100";
  constant ANDaddr    : std_logic_vector(5 downto 0) := "000101";
  constant ORconst    : std_logic_vector(5 downto 0) := "000110";
  constant ORaddr     : std_logic_vector(5 downto 0) := "000111";
  constant XORconst   : std_logic_vector(5 downto 0) := "001000";
  constant XORaddr    : std_logic_vector(5 downto 0) := "001001";
  constant ROLaccu    : std_logic_vector(5 downto 0) := "001010";
  constant RORaccu    : std_logic_vector(5 downto 0) := "001011";
  constant ADDconst   : std_logic_vector(5 downto 0) := "001100";
  constant ADDaddr    : std_logic_vector(5 downto 0) := "001101";
  constant ADCconst   : std_logic_vector(5 downto 0) := "001110";
  constant ADCaddr    : std_logic_vector(5 downto 0) := "001111";
  constant NEGaccu    : std_logic_vector(5 downto 0) := "010000";
  constant NEGconst   : std_logic_vector(5 downto 0) := "010001";
  constant NEGaddr    : std_logic_vector(5 downto 0) := "010010";
  constant INCaccu    : std_logic_vector(5 downto 0) := "010011";
  constant INCaddr    : std_logic_vector(5 downto 0) := "010100";
  constant DECaccu    : std_logic_vector(5 downto 0) := "010101";
  constant DECaddr    : std_logic_vector(5 downto 0) := "010110";
  constant SETC       : std_logic_vector(5 downto 0) := "010111";
  constant CLRC       : std_logic_vector(5 downto 0) := "011000";
  constant TRFNC      : std_logic_vector(5 downto 0) := "011001";
  constant BZ0        : std_logic_vector(5 downto 0) := "011010";
  constant BZ1        : std_logic_vector(5 downto 0) := "011011";
  constant BC0        : std_logic_vector(5 downto 0) := "011100";
  constant BC1        : std_logic_vector(5 downto 0) := "011101";
  constant BV0        : std_logic_vector(5 downto 0) := "011110";
  constant BV1        : std_logic_vector(5 downto 0) := "011111";       
  constant BN0        : std_logic_vector(5 downto 0) := "100000";       
  constant BN1        : std_logic_vector(5 downto 0) := "100001";       
  constant BRA        : std_logic_vector(5 downto 0) := "100010";  
  constant NOP        : std_logic_vector(5 downto 0) := "111111";

  -- Selection des opérandes
  constant MUX_ACCU          : std_logic_vector(2 downto 0) := "000";
  constant MUX_CONST         : std_logic_vector(2 downto 0) := "001";  
  constant MUX_DATA          : std_logic_vector(2 downto 0) := "010";  
  constant MUX_ACCU_CONST    : std_logic_vector(2 downto 0) := "101";
  constant MUX_ACCU_DATA     : std_logic_vector(2 downto 0) := "110";
  
  -- Index des indicateurs de controle
  constant Zidx : integer := 3;
  constant Cidx : integer := 2;
  constant Vidx : integer := 1;
  constant Nidx : integer := 0;


end package nanoProcesseur_package ;
package body nanoProcesseur_package is

end package body nanoProcesseur_package ;
