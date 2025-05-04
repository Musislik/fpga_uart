library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity uart_reciver is
    Port ( clk : in STD_LOGIC;
           txd_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           rx_done : out STD_LOGIC;
           paralel_data_out : out STD_LOGIC_VECTOR(7 downto 0);
           switches : in STD_LOGIC_VECTOR (3 downto 0)
           );
end uart_reciver;

architecture Behavioral of uart_reciver is

    component clock_enable_set is
        port(
            clk : in std_logic;
            rst : in std_logic;
            pulse : out std_logic;
            set   : in  std_logic_vector(1 downto 0)
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
               baud_en : in std_logic
               );
   end component;
   
    signal sig_baud : std_logic;
    signal fall_edge : std_logic;
        
begin

    clock_en : clock_enable_set
        port map(
            clk => clk,
            rst => rst,
            pulse => sig_baud,
            set   => switches(1 downto 0)
        );
        
   uart : uart_rx
       port map(
           clk => clk,
           rst => rst,
           baud_en => sig_baud,
           rx_start => fall_edge,
           paralel_data => paralel_data_out,
           rx => txd_in,
           rx_done => rx_done,
           data_length => switches(3 downto 2)
           );
           
   edge : edge_detector
        port map(
           clk => clk,
           btn => txd_in,
           neg_edge => fall_edge,
           baud_en => sig_baud
           );
           
end Behavioral;
