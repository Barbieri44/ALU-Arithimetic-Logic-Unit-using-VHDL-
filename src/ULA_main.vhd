library ieee;
use ieee.std_logic_1164.all;
use work.package_ULA.all;

entity ULA is

	port (
      A, B : in std_logic_vector(3 downto 0);     -- Entradas de dados de 4 bits
      ALUOp : in std_logic_vector(2 downto 0);    -- Opcodes para selecionar a operação
      Result : out std_logic_vector(3 downto 0);  -- Saída de resultado de 4 bits
      Zero : out std_logic;                       -- Flag indicando resultado = 0
      Overflow : out std_logic;                   -- Flag indicando que houve overflow
      CarryOut : out std_logic;                   -- Flag indicando que houve carry out (para operações de adição e subtração)
      igual: out std_logic;                       -- Flag indicando A = B
		  maior: out std_logic;                       -- Flag indicando A > B  
		  menor : out std_logic);                     -- Flag indicando A < B
	
end ULA;

Architecture codigo of ULA is

  signal adder_s : std_logic_vector(3 downto 0);          -- Resultado do somador (ADD/SUB)
  signal adder_cout, adder_ov : std_logic;                -- Flags do somador
  signal mult_p : std_logic_vector(3 downto 0);           -- Resultado do multiplicador (MUL)  
  signal comp_igual, comp_maior, comp_menor : std_logic;  -- Flags do comparador (COMP)
  signal bx : std_logic_vector(3 downto 0);               -- Vetor B modificado para ADD/SUB
  signal cin_s : std_logic;                               -- Vem-um do somador controlado pelo Opcode
  
begin
  -- SUB preparação: tem que ser em complemento de 2
  -- Se ALUOp(0) for '1' (Operação 101 - SUB), cin_s recebe '1' e bx inverte os bits de B.
  cin_s <= ALUOp(0);
  bx <= B xor "1111" when ALUOp(0) = '1' else B;
  
  -- Instanciando componentes para o Somador/subtrator de 4 bits
  U_ADD: Somador_4bits port map (
    A => A, 
    B => bx, 
    Cin => cin_s,
    S => adder_s, 
    Cout => adder_cout,
    Overflow => adder_ov
  );
  
  -- Instanciando componente para o Multiplicador de 2 bits
  U_MULT: Multiplicador_2bits port map (
    A => A(1 downto 0),
    B => B(1 downto 0),
    P => mult_p
  );
  
  -- Instanciando componente para o Comparador de 4 bits
  U_COMP: Comparador port map (
    A => A,
    B => B,
    igual => comp_igual,
    maior => comp_maior,
    menor => comp_menor
  );
  
  -- Multiplexador para os resultados: Seleciona o Result com base no ALUOp
  with ALUOp select Result <=
    "0000"      when "000",  -- NOP: Result obrigatoriamente 0000
    (A and B)   when "001",  -- AND
    (A OR B)    when "010",  -- OR
    (not B)     when "011",  -- NOT
    adder_s     when "100",  -- ADD
    adder_s     when "101",  -- SUB
    mult_p      when "110",  -- MUL
    "0000"      when "111";  -- COMP: Força zero no Result, o que importa são as flags
    
  -- Flags de Comparação: só devem ligar quando a operação for COMP (111)
  -- Isso garante automaticamente que fiquem em 0 durante o NOP (000)
  igual <= comp_igual when (ALUOp = "111") else '0';
  maior <= comp_maior when (ALUOp = "111") else '0';
  menor <= comp_menor when (ALUOp = "111") else '0';
  
  -- Flags Aritméticas: só funcionam em ADD (100) e SUB (101)
  CarryOut <= adder_cout when (ALUOp(2 downto 1) = "10") else '0'; 
  Overflow <= adder_ov   when (ALUOp(2 downto 1) = "10") else '0'; -- Corrigido de "00" para "10"
  
  -- Flag Zero: 1 quando Result for 0000, EXCETO no NOP onde deve ser 0
  Zero <= '1' when (Result = "0000" and ALUOp /= "000") else '0';
      
end codigo;