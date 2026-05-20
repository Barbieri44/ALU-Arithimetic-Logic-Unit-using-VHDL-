# 🖥️ 4-Bit Arithmetic Logic Unit (ALU) in VHDL

![VHDL](https://img.shields.io/badge/Language-VHDL-orange?style=for-the-badge&logo=vhdl)
![Quartus Prime](https://img.shields.io/badge/Tools-Quartus%20Prime-blue?style=for-the-badge)
![ModelSim](https://img.shields.io/badge/Simulation-ModelSim-purple?style=for-the-badge)
![Academic](https://img.shields.io/badge/Institution-PUC--Campinas-red?style=for-the-badge)

Este repositório contém o desenvolvimento e a implementação de uma **Unidade Lógica e Aritmética (ULA)** de 4 bits projetada de forma estritamente estrutural (ao nível de portas lógicas) utilizando a linguagem VHDL. O projeto foi concebido como parte dos requisitos práticos da disciplina de **Projetos de Sistemas Digitais** sob a orientação do Prof. Leonardo Rezende Costa.

---

## 📌 Funcionalidades e Mapeamento de Opcodes

A ULA processa dois vetores de entrada de 4 bits ($A$ e $B$) com base num barramento de controlo de 3 bits (`ALUOp`), gerindo as operações de acordo com a seguinte tabela de controlo:

| ALUOp (`SW2` a `SW0`) | Operação | Descrição Técnica | Mapeamento no Display (`HEX6`) |
| :---: | :---: | :--- | :---: |
| `000` | **SOMA (ADD)** | $Result = A + B$ | `0` a `F` |
| `001` | **SUBTRAÇÃO (SUB)** | $Result = A - B$ (via Complemento de 2) | `0` a `F` (+ Sinal em display dedicado) |
| `010` | **AND** | Operação lógica AND bit a bit entre $A$ e $B$ | Resultado Lógico |
| `011` | **OR** | Operação lógica OR bit a bit entre $A$ e $B$ | Resultado Lógico |
| `100` | **MULTIPLICAÇÃO** | Multiplicação estrutural dos 2 LSBs de $A$ e $B$ | `0` a `9` |
| `101` | **INVERSÃO (NOT)**| Inversão lógica bit a bit do vetor de entrada $A$ | Resultado Invertido |
| `110` | **COMPARAÇÃO** | Ativação das flags de magnitude sem alterar o display | Mantém / Desliga |

---

## 🏗️ Arquitetura do Hardware

O projeto adota uma abordagem hierárquica dividindo o sistema em módulos independentes interconectados pelo ficheiro de topo (`ULA_main.vhd`):

* **`Somador_4bits.vhd` (Ripple Carry):** Interconexão em cascata de 4 somadores completos. Na subtração, o barramento $B$ é invertido via portas XOR controladas e o `CarryIn` inicial é forçado a `'1'`.
* **`Multiplicador_2bits.vhd`:** Desenvolvido puramente com portas AND (produtos parciais) e somadores estruturais (Half-Adders e Full-Adders) para calcular o produto dos 2 bits menos significativos de cada entrada.
* **`Comparador.vhd`:** Analisador de magnitude bit a bit que determina assincronamente as condições de Igual (`Equ`), Maior Que (`Grt`) e Menor Que (`Lst`).
* **Decodificadores de 7 Segmentos (`DeCod7Seg.vhd`):** Conversores BCD para displays de cátodo/ânodo comum para representação visual dos dados. Inclui lógica dedicada para deteção do bit de sinal em complemento de 2 para ativar o caractere negativo (`-`).

---

## 🗂️ Estrutura do Repositório

O repositório está organizado de forma a separar os ficheiros de produção das ferramentas de validação:

```text
├── src/                  # Códigos fonte de Hardware (VHDL)
│   ├── ULA_main.vhd      # Entidade Top-Level (Módulo Principal)
│   ├── Somador_4bits.vhd # Bloco de Soma/Subtração Ripple Carry
│   ├── Multiplicador.vhd # Multiplicador estrutural de 2 bits
│   ├── Comparador.vhd    # Módulo de comparação de magnitude
│   └── DeCod7Seg.vhd     # Decodificadores para os Displays
├── tb/                   # Ficheiros de Testbench para Simulação
│   └── ULA_tb.vhd        # Estímulos funcionais para o ModelSim
└── docs/                 # Relatório académico e especificações do projeto

