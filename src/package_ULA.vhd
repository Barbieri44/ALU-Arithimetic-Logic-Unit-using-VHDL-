library ieee;
use ieee.std_logic_1164.all;

package package_ULA is
  component fulladd
    port ( Cin, x, y : in std_logic;
           s, Cout : out std_logic );
  end component;
  
  component Somador_4bits
    port ( A, B : in std_logic_vector(3 downto 0);
           Cin : in std_logic;
           S : out std_logic_vector(3 downto 0);
           Cout, Overflow : out std_logic );
  end component;
  
  component Multiplicador_2bits
    port ( A, B : in std_logic_vector(1 downto 0);
           P : out std_logic_vector(3 downto 0) );
  end component;
  
  component Comparador
    port ( A, B : in std_logic_vector(3 downto 0);
           igual, maior, menor : out std_logic );
  end component;
  
end package_ULA;

