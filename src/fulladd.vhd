library IEEE;
use IEEE.std_logic_1164.all;

entity fulladd is
  port ( Cin, x, y : in std_logic;
			s, Cout : out std_logic);
			
end fulladd;

architecture behavioral of fulladd is
  signal xor1, and1, and2, xor2 : std_logic;
begin

  xor1 <= x xor y;  -- meio somador
  
  and1 <= x and y;  -- meio carry
  
  xor2 <= xor1 xor Cin;  -- Somador completo s
  
  s <= xor2;
  
  and2 <= Cin and xor1;
  
  Cout <= and1 or and2;
  
end behavioral;

