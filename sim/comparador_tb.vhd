library IEEE;
use IEEE.std_logic_1164.all;

entity Comparador_tb is
end Comparador_tb;

architecture teste of Comparador_tb is

    component Comparador
        port (
            A, B : in  std_logic_vector(3 downto 0);
            Equ  : out std_logic;
            Grt  : out std_logic;
            Lst  : out std_logic
        );
    end component;

    --Sinais de teste para conectar na UUT
    signal sig_A   : std_logic_vector(3 downto 0) := "0000";
    signal sig_B   : std_logic_vector(3 downto 0) := "0000";
    signal sig_Equ : std_logic;
    signal sig_Grt : std_logic;
    signal sig_Lst : std_logic;

begin

    -- Instanciação da Unidade Sob Teste (UUT)
    UUT: Comparador
        port map (
            A   => sig_A,
            B   => sig_B,
            Equ => sig_Equ,
            Grt => sig_Grt,
            Lst => sig_Lst
        );

    -- 4. Processo de Estímulos para gerar as ondas no ModelSim
    stim_proc: process
    begin
        -- CASOS DE IGUALDADE (A = B) -> Equ deve ser '1'
        sig_A <= "0000"; sig_B <= "0000"; -- 0 = 0
        wait for 20 ns;
        
        sig_A <= "0101"; sig_B <= "0101"; -- 5 = 5
        wait for 20 ns;
        
        sig_A <= "1111"; sig_B <= "1111"; -- 15 = 15
        wait for 20 ns;

        -- CASOS DE MAIOR QUE (A > B) -> Grt deve ser '1'
        sig_A <= "0100"; sig_B <= "0010"; -- 4 > 2
        wait for 20 ns;
        
        sig_A <= "1000"; sig_B <= "0001"; -- 8 > 1
        wait for 20 ns;
        
        sig_A <= "1110"; sig_B <= "0111"; -- 14 > 7
        wait for 20 ns;

        -- CASOS DE MENOR QUE (A < B) -> Lst deve ser '1'
        sig_A <= "0001"; sig_B <= "0011"; -- 1 < 3
        wait for 20 ns;
        
        sig_A <= "0010"; sig_B <= "1000"; -- 2 < 8
        wait for 20 ns;
        
        sig_A <= "0111"; sig_B <= "1111"; -- 7 < 15
        wait for 20 ns;

        -- Finaliza de forma limpa a simulação
        wait;
    end process;

end teste;
