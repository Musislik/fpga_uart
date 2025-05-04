library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level1 is
end tb_top_level1;

architecture tb of tb_top_level1 is

    component top_level1
        port (CLK100MHZ    : in std_logic;
              UART_TXD_IN  : in std_logic;
              UART_RXD_OUT : out std_logic;
              BTNC         : in std_logic;
              BTNU         : in std_logic;
              LED16_B      : out std_logic;
              LED16_R      : out std_logic;
              SW           : in std_logic_vector (11 downto 0);
              CA           : out std_logic;
              CB           : out std_logic;
              CC           : out std_logic;
              CD           : out std_logic;
              CE           : out std_logic;
              CF           : out std_logic;
              CG           : out std_logic;
              DP           : out std_logic;
              AN           : out std_logic_vector (7 downto 0));
    end component;

    signal CLK100MHZ    : std_logic;
    signal UART_TXD_IN  : std_logic;
    signal UART_RXD_OUT : std_logic;
    signal BTNC         : std_logic;
    signal BTNU         : std_logic;
    signal LED16_B      : std_logic;
    signal LED16_R      : std_logic;
    signal SW           : std_logic_vector (11 downto 0);
    signal CA           : std_logic;
    signal CB           : std_logic;
    signal CC           : std_logic;
    signal CD           : std_logic;
    signal CE           : std_logic;
    signal CF           : std_logic;
    signal CG           : std_logic;
    signal DP           : std_logic;
    signal AN           : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_level1
    port map (CLK100MHZ    => CLK100MHZ,
              UART_TXD_IN  => UART_TXD_IN,
              UART_RXD_OUT => UART_RXD_OUT,
              BTNC         => BTNC,
              BTNU         => BTNU,
              LED16_B      => LED16_B,
              LED16_R      => LED16_R,
              SW           => SW,
              CA           => CA,
              CB           => CB,
              CC           => CC,
              CD           => CD,
              CE           => CE,
              CF           => CF,
              CG           => CG,
              DP           => DP,
              AN           => AN);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed

        UART_TXD_IN <= '1';
        BTNU <= '0';
        BTNC <= '1';
        wait for 100 ns;
        BTNC <= '0';
        wait for 100 ns;
        SW(1 downto 0) <= "11";
        SW(3 downto 2) <= "00"; --data
        
        SW(11 downto 4) <= "00001111";
        
        UART_TXD_IN <= '1'; --
        wait for 8680 ns;
        UART_TXD_IN <= '0'; --start
        wait for 8680 ns;
        UART_TXD_IN <= '1'; --1
        wait for 8680 ns;
        UART_TXD_IN <= '1'; --2
        wait for 8680 ns;
        UART_TXD_IN <= '1'; --3
        wait for 8680 ns;
        UART_TXD_IN <= '1'; --4
        wait for 8680 ns;
        UART_TXD_IN <= '0'; --5
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --6
--        wait for 8680 ns;
--        UART_TXD_IN <= '1'; --7
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --8
        wait for 8680 ns;
        UART_TXD_IN <= '0'; --parita
        wait for 8680 ns;
        UART_TXD_IN <= '1'; --stop
        
        BTNU <= '1';
        wait for 100ns;
        BTNU <= '0';
        
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --start
--        wait for 8680 ns;
--        UART_TXD_IN <= '1'; --1
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --2
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --3
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --4
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --5
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --6
--        wait for 8680 ns;
--        UART_TXD_IN <= '1'; --7
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --8
--        wait for 8680 ns;
--        UART_TXD_IN <= '0'; --parita
--        wait for 8680 ns;
--        UART_TXD_IN <= '1'; --stop

        wait for 10000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_top_level1 of tb_top_level1 is
    for tb
    end for;
end cfg_tb_top_level1;