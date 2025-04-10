library IEEE;
use ieee.std_logic_1164.all;

entity tb_uart_reciver is
end tb_uart_reciver;

architecture tb of tb_uart_reciver is

    component uart_reciver
        port (CLK100MHZ        : in std_logic;
              UART_TXD_IN      : in std_logic;
              LED16_B          : out std_logic;
              DISP_OUTPUT_TEST : out std_logic_vector (7 downto 0);
              SW               : in  std_logic_vector(15 downto 0);
              BTNC             : in std_logic
              );
    end component;

    signal CLK100MHZ        : std_logic;
    signal UART_TXD_IN      : std_logic;
    signal BTNC             : std_logic;
    signal LED16_B          : std_logic;
    signal DISP_OUTPUT_TEST : std_logic_vector (7 downto 0);
    signal SW               : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 1 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : uart_reciver
    port map (CLK100MHZ        => CLK100MHZ,
              UART_TXD_IN      => UART_TXD_IN,
              BTNC             => BTNC,
              LED16_B          => LED16_B,
              DISP_OUTPUT_TEST => DISP_OUTPUT_TEST,
              SW               => SW
              );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        UART_TXD_IN <= '1';
        BTNC <= '1';
        wait for 15 ns;
        SW(15 downto 14) <= "11";
        BTNC <= '0';
        wait for 15 ns;
        UART_TXD_IN <= '0'; --start
        wait for 15 ns;
        UART_TXD_IN <= '1'; --1
        wait for 15 ns;
        UART_TXD_IN <= '0'; --2
        wait for 15 ns;
        UART_TXD_IN <= '1'; --3
        wait for 15 ns;
        UART_TXD_IN <= '0'; --4
        wait for 15 ns;
        UART_TXD_IN <= '1'; --5
        wait for 15 ns;
        UART_TXD_IN <= '0'; --6
        wait for 15 ns;
        UART_TXD_IN <= '1'; --7
        wait for 15 ns;
        UART_TXD_IN <= '0'; --8
        wait for 15 ns;
        UART_TXD_IN <= '1'; --stop
        
        wait for 100 ns;
        
        UART_TXD_IN <= '0'; --start
        wait for 15 ns;
        UART_TXD_IN <= '1'; --1
        wait for 15 ns;
        UART_TXD_IN <= '0'; --2
        wait for 15 ns;
        UART_TXD_IN <= '1'; --3
        wait for 15 ns;
        UART_TXD_IN <= '0'; --4
        wait for 15 ns;
        UART_TXD_IN <= '1'; --5
        wait for 15 ns;
        UART_TXD_IN <= '0'; --6
        wait for 15 ns;
        UART_TXD_IN <= '1'; --7
        wait for 15 ns;
        UART_TXD_IN <= '0'; --8
        wait for 15 ns;
        UART_TXD_IN <= '1'; --stop

        wait for 100 ns;
        
        UART_TXD_IN <= '0'; --start
        wait for 15 ns;
        UART_TXD_IN <= '1'; --1
        wait for 15 ns;
        UART_TXD_IN <= '0'; --2
        wait for 15 ns;
        UART_TXD_IN <= '1'; --3
        wait for 15 ns;
        UART_TXD_IN <= '0'; --4
        wait for 15 ns;
        UART_TXD_IN <= '1'; --5
        wait for 15 ns;
        UART_TXD_IN <= '0'; --6
        wait for 15 ns;
        UART_TXD_IN <= '1'; --7
        wait for 15 ns;
        UART_TXD_IN <= '0'; --8
        wait for 15 ns;
        UART_TXD_IN <= '1'; --stop
        
        wait for 100 ns;
        
        UART_TXD_IN <= '0'; --start
        wait for 15 ns;
        UART_TXD_IN <= '1'; --1
        wait for 15 ns;
        UART_TXD_IN <= '0'; --2
        wait for 15 ns;
        UART_TXD_IN <= '1'; --3
        wait for 15 ns;
        UART_TXD_IN <= '0'; --4
        wait for 15 ns;
        UART_TXD_IN <= '1'; --5
        wait for 15 ns;
        UART_TXD_IN <= '0'; --6
        wait for 15 ns;
        UART_TXD_IN <= '1'; --7
        wait for 15 ns;
        UART_TXD_IN <= '0'; --8
        wait for 15 ns;
        UART_TXD_IN <= '1'; --stop



        
        wait for 10000 ns;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_uart_reciver of tb_uart_reciver is
    for tb
    end for;
end cfg_tb_uart_reciver;