library ieee;
use ieee.std_logic_1164.all;

-- Entidade do Testbench para o Somador Completo de 1 bit
entity fulladd_tb is
end fulladd_tb;

architecture teste of fulladd_tb is
    signal Cin_tb, x_tb, y_tb : std_logic;
    signal s_tb, Cout_tb      : std_logic;

    -- Declaração do componente fulladd (Unidade Sob Teste)
    component fulladd
        port (
            Cin, x, y : in std_logic;
            s, Cout   : out std_logic
        );
    end component;

begin
    -- Instanciação do Somador Completo mapeando os sinais do simulador
    UUT: fulladd port map (
        Cin  => Cin_tb,
        x    => x_tb,
        y    => y_tb,
        s    => s_tb,
        Cout => Cout_tb
    );

    process
    begin
        -- Cenário 1: 0 + 0 + 0 (Cin) = 0, vai 0
        Cin_tb <= '0'; x_tb <= '0'; y_tb <= '0'; wait for 10 ns;
        
        -- Cenário 2: 0 + 1 + 0 (Cin) = 1, vai 0
        Cin_tb <= '0'; x_tb <= '0'; y_tb <= '1'; wait for 10 ns;
        
        -- Cenário 3: 1 + 0 + 0 (Cin) = 1, vai 0
        Cin_tb <= '0'; x_tb <= '1'; y_tb <= '0'; wait for 10 ns;
        
        -- Cenário 4: 1 + 1 + 0 (Cin) = 0, vai 1 (Gera Carry)
        Cin_tb <= '0'; x_tb <= '1'; y_tb <= '1'; wait for 10 ns;
        
        -- Cenário 5: 0 + 0 + 1 (Cin) = 1, vai 0
        Cin_tb <= '1'; x_tb <= '0'; y_tb <= '0'; wait for 10 ns;
        
        -- Cenário 6: 0 + 1 + 1 (Cin) = 0, vai 1 (Gera Carry)
        Cin_tb <= '1'; x_tb <= '0'; y_tb <= '1'; wait for 10 ns;
        
        -- Cenário 7: 1 + 0 + 1 (Cin) = 0, vai 1 (Gera Carry)
        Cin_tb <= '1'; x_tb <= '1'; y_tb <= '0'; wait for 10 ns;
        
        -- Cenário 8: 1 + 1 + 1 (Cin) = 1, vai 1 (Soma máxima)
        Cin_tb <= '1'; x_tb <= '1'; y_tb <= '1'; wait for 10 ns;

        wait; 
    end process;
end teste;