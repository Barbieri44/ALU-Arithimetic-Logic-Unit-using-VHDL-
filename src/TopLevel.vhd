library IEEE;
use IEEE.std_logic_1164.all;

-- Arquivo para ligar todos os outros arquivos na Placa

entity TopLevel is
    port (
        SW   : in  std_logic_vector(10 downto 0); -- Chaves físicas
        LEDR : out std_logic_vector(5 downto 0);  -- LEDs físicos
        HEX0 : out std_logic_vector(6 downto 0);  -- Display do Opcode
        HEX2 : out std_logic_vector(6 downto 0);  -- Display do B
        HEX4 : out std_logic_vector(6 downto 0);  -- Display do A
        HEX6 : out std_logic_vector(6 downto 0)   -- Display do Resultado
    );
end TopLevel;

architecture codigo of TopLevel is

    -- Sinais internos para interligar os blocos
    signal res_internal : std_logic_vector(3 downto 0);
    signal op_extended  : std_logic_vector(3 downto 0);

    component ULA is
        port (
            A, B   : in  std_logic_vector(3 downto 0);
            ALUOp  : in  std_logic_vector(2 downto 0);
            Result : out std_logic_vector(3 downto 0);
            Zero, Overflow, CarryOut : out std_logic;
            igual, maior, menor      : out std_logic
        );
    end component;

    -- Componente do Decodificador
    component Display7Seg is
        port (
            digito    : in  std_logic_vector(3 downto 0);
            segmentos : out std_logic_vector(6 downto 0)
        );
    end component;

begin

    -- Extensão de 3 para 4 bits para o display do Opcode (injeta '0' na esquerda)
    op_extended <= '0' & SW(2 downto 0);

    -- Instanciação da ULA principal
    inst_ULA: ULA port map (
        A        => SW(10 downto 7),
        B        => SW(6 downto 3),
        ALUOp    => SW(2 downto 0),
        Result   => res_internal,
        CarryOut => LEDR(0),
        Zero     => LEDR(1),
        Overflow => LEDR(2),
        igual    => LEDR(3),
        maior    => LEDR(4),
        menor    => LEDR(5)
    );

    -- Instanciação dos Decodificadores para cada display exigido
    disp_Opcode: Display7Seg port map (digito => op_extended,       segmentos => HEX0);
    disp_B     : Display7Seg port map (digito => SW(6 downto 3),    segmentos => HEX2);
    disp_A     : Display7Seg port map (digito => SW(10 downto 7),   segmentos => HEX4);
    disp_Result: Display7Seg port map (digito => res_internal,      segmentos => HEX6);

end codigo;