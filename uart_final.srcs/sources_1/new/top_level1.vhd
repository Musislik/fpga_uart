library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity top_level1 is

    Port ( CLK100MHZ : in STD_LOGIC;
           UART_TXD_IN : in STD_LOGIC;
           UART_RXD_OUT : out STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           LED16_B : out STD_LOGIC;
           LED16_R : out STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (11 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0)
           );

end top_level1;

architecture Behavioral of top_level1 is

component uart_reciver is
    Port ( clk : in STD_LOGIC;
           txd_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           rx_done : out STD_LOGIC;
           paralel_data_out : out STD_LOGIC_VECTOR(7 downto 0);
           switches : in STD_LOGIC_VECTOR (3 downto 0)
           );
end component;

component uart_transmitter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           send : in STD_LOGIC;
           set_baud : in STD_LOGIC_VECTOR (1 downto 0);
           set_data : in STD_LOGIC_VECTOR (1 downto 0);
           data : in STD_LOGIC_VECTOR (7 downto 0);
           rxd_out : out STD_LOGIC;
           tx_done : out STD_LOGIC
           );
end component;


component data_seg is
    port(
        paralel_data_bits : in  STD_LOGIC_VECTOR (7 downto 0);
        segments          : out STD_LOGIC_VECTOR (7 downto 0);
        anody             : out std_logic_vector (7 downto 0);
        rx_done           : in std_logic;
        clk               : in std_logic
        );
end component;

signal paralel_data : std_logic_vector (7 downto 0);
signal rx_done      : std_logic;

begin

LED16_B <= rx_done;

uart_r : uart_reciver
    port map(
        clk => CLK100MHZ,
        txd_in => UART_TXD_IN,
        switches => SW(3 downto 0),
        rx_done => rx_done,
        rst => BTNC,
        paralel_data_out => paralel_data
        );

uart_t : uart_transmitter
    port map( 
        clk => CLK100MHZ,
        rst => BTNC,
        rxd_out => UART_RXD_OUT,
        send => BTNU,
        set_baud => SW(1 downto 0),
        set_data => SW(3 downto 2),
        data     => SW(11 downto 4),
        tx_done => LED16_R
        
           );

seg : data_seg
    port map(
        segments(0) => CA,
        segments(1) => CB,
        segments(2) => CC,
        segments(3) => CD,
        segments(4) => CE,
        segments(5) => CF,
        segments(6) => CG,
        segments(7) => DP,
        anody => AN,
        rx_done => rx_done,
        clk => CLK100MHZ,
        paralel_data_bits => paralel_data
        );
        

end Behavioral;
