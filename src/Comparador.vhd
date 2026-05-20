library IEEE;
use IEEE.std_logic_1164.all;

entity Comparador is
	port(a,b : in std_logic_vector(3 downto 0 );
			igual,maior,menor	: out std_logic);
end Comparador;

architecture codigo of Comparador is
	signal i: std_logic_vector(3 downto 0);
begin

 igual<= ( (a(3) xnor b(3)) AND (a(2) xnor b(2)) AND (a(1) xnor b(1)) AND (a(0) xnor b(0)) );
 i(1)<= (a(1) xnor b(1));
 i(2)<= (a(2) xnor b(2));
 i(3)<= (a(3) xnor b(3));
 
 maior<=  ( (a(3) and (not b(3))) OR 
											(a(2) and (not b(2)) and i(3)) or 
																				((a(1) and (not b(1)) and i(2)) and i(3)) or 
																																		(a(0) and (not b(0)) and i(1) and i(2) and i(3)) );

 menor <= (igual nor maior);
 
 end codigo;