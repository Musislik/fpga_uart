library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity uart_reciver is
    Port ( CLK100MHZ : in STD_LOGIC;
           UART_TXD_IN : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           LED16_B : out STD_LOGIC;
           DISP_OUTPUT_TEST : out STD_LOGIC_VECTOR(7 downto 0);
           SW : in STD_LOGIC_VECTOR (15 downto 0)
           );
end uart_reciver;

architecture Behavioral of uart_reciver is

    component clock_enable is
        generic(
           N_periods : positive := 10
        );
        port(
            clk : in std_logic;
            rst : in std_logic;
            pulse : out std_logic
        );
    end component;
    
   component uart_rx is
       port(
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           rx_start : in STD_LOGIC;
           rx : in STD_LOGIC;
           paralel_data : out STD_LOGIC_VECTOR(7 downto 0);
           rx_done : out std_logic;
           data_length : in std_logic_vector (1 downto 0)
           );
   end component;
   
  component edge_detector is
        port ( 
               clk : in STD_LOGIC;
               btn : in STD_LOGIC;
               pos_edge : out STD_LOGIC;
               neg_edge : out STD_LOGIC;
               sig1 : out STD_LOGIC;
               sig_delayed1 : out STD_LOGIC
               );
   end component;
   
    signal sig_baud : std_logic;
    signal fall_edge : std_logic;
        
begin

    clock_en : clock_enable
        generic map(
            N_Periods => 15
        )
        port map(
            clk => CLK100MHZ,
            rst => BTNC,
            pulse => sig_baud         
        );
        
   uart : uart_rx
       port map(
           clk => CLK100MHZ,
           rst => BTNC,
           baud_en => sig_baud,
           rx_start => fall_edge,
           paralel_data => DISP_OUTPUT_TEST,
           rx => UART_TXD_IN,
           rx_done => LED16_B,
           data_length => SW(15 downto 14)
           );
           
   edge : edge_detector
        port map(
           clk => CLK100MHZ,
           btn => UART_TXD_IN,
           neg_edge => fall_edge
           );
           
end Behavioral;
