library IEEE;
use IEEE.std_logic_1164.all;

entity Multiplicador_2bits_tb is
end Multiplicador_2bits_tb;

architecture teste of Multiplicador_2bits_tb is

    component Multiplicador_2bits
        port (
            A, B : in  std_logic_vector(1 downto 0);
            P    : out std_logic_vector(3 downto 0)
        );
    end component;

    --  Sinais internos para conectar na UUT
    signal sig_A : std_logic_vector(1 downto 0) := "00";
    signal sig_B : std_logic_vector(1 downto 0) := "00";
    signal sig_P : std_logic_vector(3 downto 0);

begin

    -- Instanciação da UUT (conecta os sinais de teste ao teu multiplicador)
    UUT: Multiplicador_2bits 
        port map (
            A => sig_A,
            B => sig_B,
            P => sig_P
        );

    stim_proc: process
    begin
        -- Caso 1: 0 x 0 = 0
        sig_A <= "00"; sig_B <= "00";
        wait for 20 ns;
        
        -- Caso 2: 1 x 1 = 1
        sig_A <= "01"; sig_B <= "01";
        wait for 20 ns;
        
        -- Caso 3: 2 x 1 = 2
        sig_A <= "10"; sig_B <= "01";
        wait
      end process; 
      end teste;
          
