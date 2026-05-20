library IEEE;
use IEEE.std_logic_1164.all;
use work.package_ULA.all;

entity ula_tb is
end ula_tb;

architecture behavioral of ula_tb is
  signal A_tb, B_tb, Result_tb : std_logic_vector(3 downto 0);
  signal ALUOp_tb : std_logic_vector(2 downto 0);
  signal Zero_tb, Ov_tb, Cout_tb, Equ_tb, Grt_tb, Lst_tb : std_logic;
  
  component ULA_main
    port (
      A, B : in std_logic_vector(3 downto 0);
      ALUOp : in std_logic_vector(2 downto 0);
      Result : out std_logic_vector(3 downto 0);
      Zero : out std_logic;
      Overflow : out std_logic;
      CarryOut : out std_logic;
      Equ, Grt, Lst : out std_logic
    );
  end component;
  
begin
  UUT: ULA_main port map (
    A => A_tb, B => B_tb, ALUOp => ALUOp_tb,
    Result => Result_tb, Zero => Zero_tb, Overflow => Ov_tb, CarryOut => Cout_tb,
    Equ => Equ_tb, Grt => Grt_tb, Lst => Lst_tb
  );
  

    stimulus: process
  begin
    -- Test NOP (000)
    A_tb <= "0000"; B_tb <= "0000"; ALUOp_tb <= "000"; wait for 10 ns;  -- Esperado: Result=0000, e todas as flags=0

    -- Test AND (001)
    A_tb <= "0011"; B_tb <= "0010"; ALUOp_tb <= "001"; wait for 10 ns;  -- Esperado: Result=0010

    -- Test OR (010)
    A_tb <= "0011"; B_tb <= "0010"; ALUOp_tb <= "010"; wait for 10 ns;  -- Esperado: Result=0011

    -- Test NOT (011) 
    A_tb <= "1010"; B_tb <= "1100"; ALUOp_tb <= "011"; wait for 10 ns;  -- Esperado: Result=0011 (Inverso de B)

    -- Test ADD (100)
    A_tb <= "0100"; B_tb <= "0011"; ALUOp_tb <= "100"; wait for 10 ns;  -- Esperado: Result=0111 (4+3=7)

    -- Test SUB (101)
    A_tb <= "0111"; B_tb <= "0010"; ALUOp_tb <= "101"; wait for 10 ns;  -- Esperado: Result=0101 (7-2=5)

    -- Test MUL (110)
    A_tb <= "0011"; B_tb <= "0010"; ALUOp_tb <= "110"; wait for 10 ns;  -- Esperado: Result=0110 (3*2=6)

    -- Test COMP (111)
    A_tb <= "0011"; B_tb <= "0011"; ALUOp_tb <= "111"; wait for 10 ns;  -- Esperado: Equ=1, Grt=0, Lst=0
    A_tb <= "0100"; B_tb <= "0011"; ALUOp_tb <= "111"; wait for 10 ns;  -- Esperado: Equ=0, Grt=1, Lst=0
    A_tb <= "0010"; B_tb <= "0111"; ALUOp_tb <= "111"; wait for 10 ns;  -- Esperado: Equ=0, Grt=0, Lst=1

    wait;
  end process;
end behavioral;

