library ieee;
use ieee.std_logic_1164.all;

entity tb_uart_tx is
end tb_uart_tx;

architecture tb of tb_uart_tx is

    component uart_tx
        port (clk      : in std_logic;
              rst      : in std_logic;
              baud_en  : in std_logic;
              tx_start : in std_logic;
              data_in  : in std_logic_vector (7 downto 0);
              tx       : out std_logic;
              tx_done  : out std_logic);
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal baud_en  : std_logic;
    signal tx_start : std_logic;
    signal data_in  : std_logic_vector (7 downto 0);
    signal tx       : std_logic;
    signal tx_done  : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : uart_tx
    port map (clk      => clk,
              rst      => rst,
              baud_en  => baud_en,
              tx_start => tx_start,
              data_in  => data_in,
              tx       => tx,
              tx_done  => tx_done);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        rst <= '0';
        baud_en <= '0';
        tx_start <= '0';
        data_in <= (others => '1');

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_uart_tx of tb_uart_tx is
    for tb
    end for;
end cfg_tb_uart_tx;