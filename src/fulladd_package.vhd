library IEEE;
use IEEE.std_logic_1164.all;


package fulladd_package is

    component fulladd 
        port (
            Cin, x, y : in std_logic;
            s, Cout : out std_logic
        );
    end component;
end fulladd_package;