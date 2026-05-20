library ieee;
use ieee.std_logic_1164.all;

entity somador_tb is
end somador_tb;

architecture teste of somador_tb is
    signal A_tb, B_tb : std_logic_vector(3 downto 0);
    signal Cin_tb : std_logic;
    signal S_tb : std_logic_vector(3 downto 0);
    signal Cout_tb, Ov_tb : std_logic;

    component Somador_4bits
        port(
            A, B : in std_logic_vector(3 downto 0);
            Cin : in std_logic;
            S : out std_logic_vector(3 downto 0);
            Cout, Overflow : out std_logic
        );
    end component;
    
begin
    -- Instanciação do somador conectado aos sinais simulados

    UUT: Somador_4bits port map( 
        A => A_tb,
        B => B_tb,
        Cin => Cin_tb,
        S => S_tb,
        Cout => Cout_tb,
        Overflow => Ov_tb
    );

    process
    begin
    
        -- TESTE 1: Soma simples sem transportes ou estouros
        -- A = "0011" (3 em decimal) | B = "0010" (2 em decimal) | Cin = '0'
        -- Esperado: S = "0101" (5 em decimal) | Cout = '0' | Overflow = '0'
        A_tb <= "0011"; B_tb <= "0010"; Cin_tb <= '0'; wait for 10 ns;

        -- TESTE 2: Geração de Carry Out (Estouro para números Não-Sinalizados)
        -- A = "1100" (12 em decimal) | B = "0101" (5 em decimal) | Cin = '0'
        -- Matematicamente 12 + 5 = 17. Como o limite de 4 bits é 15, o resultado
        -- estoura o espaço. 17 em binário puro é 1 0001.
        -- Esperado: S = "0001" (1) | Cout = '1' (indica o estouro) | Overflow = '0'
        A_tb <= "1100"; B_tb <= "0101"; Cin_tb <= '0'; wait for 10 ns;

        -- TESTE 3: Geração de Overflow Positivo (Estouro para números Sinalizados)
        -- A = "0111" (+7 sinalizado) | B = "0010" (+2 sinalizado) | Cin = '0'
        -- Matematicamente +7 + 2 = +9. No sistema sinalizado de 4 bits (Complemento de 2),
        -- o maior número positivo possível é +7. O valor +9 estoura e invade o bit de sinal.
        -- Esperado: S = "1001" (-7 em compl. de 2) | Cout = '0' | Overflow = '1' (Alerta o erro)
        A_tb <= "0111"; B_tb <= "0010"; Cin_tb <= '0'; wait for 10 ns;

        -- TESTE 4: Geração de Overflow Negativo (Soma de dois negativos)
        -- A = "1000" (-8 sinalizado) | B = "1111" (-1 sinalizado) | Cin = '0'
        -- Matematicamente -8 + (-1) = -9. O limite inferior sinalizado é -8. 
        -- Duas entradas negativas resultando em uma saída com bit de sinal positivo ("0111").
        -- Esperado: S = "0111" (+7) | Cout = '1' | Overflow = '1' (Alerta o erro)
        A_tb <= "1000"; B_tb <= "1111"; Cin_tb <= '0'; wait for 10 ns;

        -- TESTE 5: Simulação de Subtração (Lógica usada na ULA principal)
        -- Para subtrair A - B, a ULA faz A + (NOT B) + 1. Vamos testar 7 - 3 = 4:
        -- A = "0111" (7) | B = "1100" (Inverso de 3, pois NOT "0011" = "1100") | Cin = '1'
        -- Esperado: S = "0100" (4 em decimal) | Cout = '1' (normal em subtração) | Overflow = '0'
        A_tb <= "0111"; B_tb <= "1100"; Cin_tb <= '1'; wait for 10 ns;

        wait;
    end process;
    end teste;