library ieee;
use ieee.std_logic_1164.all;

entity tb_uart_transmitter is
end tb_uart_transmitter;

architecture tb of tb_uart_transmitter is

    component uart_transmitter
        port (CLK100MHZ    : in std_logic;
              BTNC         : in std_logic;
              BTNU         : in std_logic;
              SW           : in std_logic_vector (15 downto 0);
              UART_RXD_OUT : out std_logic;
              LED16_B      : out std_logic);
    end component;

    signal CLK100MHZ    : std_logic;
    signal BTNC         : std_logic;
    signal BTNU         : std_logic;
    signal SW           : std_logic_vector (15 downto 0);
    signal UART_RXD_OUT : std_logic;
    signal LED16_B      : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : uart_transmitter
    port map (CLK100MHZ    => CLK100MHZ,
              BTNC         => BTNC,
              BTNU         => BTNU,
              SW           => SW,
              UART_RXD_OUT => UART_RXD_OUT,
              LED16_B      => LED16_B);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        BTNC <= '0';
        BTNU <= '0';
        
        SW <= (others => '0');
        SW(15 downto 14) <= "11";
        SW(7 downto 0) <= "00001101";
        wait for 200 ns;
        BTNU <= '1';
        wait for 20 ns;
        BTNU <= '0';
        wait for 100 ns;
        BTNU <= '1';
        
        
        wait for 1000*TbPeriod;
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_uart_transmitter of tb_uart_transmitter is
    for tb
    end for;
end cfg_tb_uart_transmitter;