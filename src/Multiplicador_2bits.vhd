library IEEE;
use IEEE.std_logic_1164.all;

entity Multiplicador_2bits is
  port (
    A, B : in std_logic_vector(1 downto 0);
    P : out std_logic_vector(3 downto 0)
  );
end Multiplicador_2bits;

architecture structural of Multiplicador_2bits is
  signal p0, p1, p2, p3 : std_logic;
  signal c1, s1, c2, s2 : std_logic; 
begin

  p0 <= A(0) and B(0);
  p1 <= A(0) and B(1);
  p2 <= A(1) and B(0);
  p3 <= A(1) and B(1);
  
  -- Bit 0
  P(0) <= p0;
  
  -- Bit 1: HA p1 + p2
  s1 <= p1 xor p2;
  c1 <= p1 and p2;
  P(1) <= s1;
  
  -- Bit 2: p3 + c1  (HA)
  s2 <= p3 xor c1;
  c2 <= p3 and c1;
  P(2) <= s2;
  
  -- Bit 3: c2
  P(3) <= c2;
end structural;


-- O multiplicador funciona com a logica por tras da multiplicação comum
-- se temos 01 x 11 
-- sabendo que 01 representa a0 e a1 
-- e 11 repersenta b0 e b1
-- a multiplicação fica 
-- 
--
--			  01
--		    x11
--      -----------
--		     (b1*a0)(b1*a1)
--	 (b0*a0)(b0*a0)
-- ----------------------------
--  (b0*a0) (a0(b1+b0)) (b1*a1)
--  
--

