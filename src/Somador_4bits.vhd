library IEEE;
use IEEE.std_logic_1164.all;
use work.fulladd_package.all;

entity Somador_4bits is
  port (
    A, B : in std_logic_vector(3 downto 0);
    Cin : in std_logic;
    S : out std_logic_vector(3 downto 0);
    Cout, Overflow : out std_logic
  );
end Somador_4bits;

architecture codigo of Somador_4bits is
  signal c : std_logic_vector(4 downto 0);  -- carries
begin
  c(0) <= Cin;
  FA0: fulladd port map (x => A(0), y => B(0), Cin => c(0), s => S(0), Cout => c(1));
  FA1: fulladd port map (x => A(1), y => B(1), Cin => c(1), s => S(1), Cout => c(2));
  FA2: fulladd port map (x => A(2), y => B(2), Cin => c(2), s => S(2), Cout => c(3));
  FA3: fulladd port map (x => A(3), y => B(3), Cin => c(3), s => S(3), Cout => c(4));
  Cout <= c(4);
  Overflow <= c(3) xor c(4);
  
end codigo;

