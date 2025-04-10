-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 03 Apr 2025 08:09:55 GMT
-- Request id : cfwk-fed377c2-67ee425341be4

library ieee;
use ieee.std_logic_1164.all;

entity tb_edge_detector is
end tb_edge_detector;

architecture tb of tb_edge_detector is

    component edge_detector
        port (clk      : in std_logic;
              btn      : in std_logic;
              pos_edge : out std_logic;
              neg_edge : out std_logic;
              sig1 : out STD_LOGIC;
              sig_delayed1 : out STD_LOGIC);
    end component;

    signal clk      : std_logic;
    signal btn      : std_logic;
    signal pos_edge : std_logic;
    signal neg_edge : std_logic;
    signal sig1 : STD_LOGIC;
    signal sig_delayed1 : STD_LOGIC;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : edge_detector
    port map (clk      => clk,
              btn      => btn,
              pos_edge => pos_edge,
              neg_edge => neg_edge);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        btn <= '0';
        wait for 50ns;
        btn <= '1';
        wait for 50ns;
        btn <= '0';
        wait for 50ns;
        btn <= '1';
        wait for 50ns;
        btn <= '0';
        wait for 50ns;
        btn <= '1';
        wait for 50ns;
        btn <= '0';
        wait for 2000ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_edge_detector of tb_edge_detector is
    for tb
    end for;
end cfg_tb_edge_detector;