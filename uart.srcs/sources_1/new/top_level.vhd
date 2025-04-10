library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           UART_RXD_OUT : out STD_LOGIC;
           LED16_B : out STD_LOGIC
           );
end top_level;

architecture Behavioral of top_level is

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
    
   component uart_tx is
       port(
            clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           tx_start : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_length : in std_logic_vector (1 downto 0);
           tx : out STD_LOGIC;
           tx_done : out STD_LOGIC
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
    signal start_edge : std_logic;
        
begin

    clock_en : clock_enable
        generic map(
            N_Periods => 1
        )
        port map(
            clk => CLK100MHZ,
            rst => BTNC,
            pulse => sig_baud         
        );
        
   uart : uart_tx
       port map(
           
           clk => CLK100MHZ,
           rst => BTNC,
           baud_en => sig_baud,
           tx_start => start_edge,
           data_in => SW(7 downto 0),
           tx => UART_RXD_OUT,
           tx_done => LED16_B,
           data_length => SW(15 downto 14)
           );
           
    edge_detect : edge_detector
        port map(
            clk => CLK100MHZ,
            btn => BTNU,
            pos_edge => start_edge
           );

end Behavioral;
