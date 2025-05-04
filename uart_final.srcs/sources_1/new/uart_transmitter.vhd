library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity uart_transmitter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           send : in STD_LOGIC;
           set_baud : in STD_LOGIC_VECTOR (1 downto 0);
           set_data : in STD_LOGIC_VECTOR (1 downto 0);
           data : in STD_LOGIC_VECTOR (7 downto 0);
           rxd_out : out STD_LOGIC;
           tx_done : out STD_LOGIC
           );
end uart_transmitter;

architecture Behavioral of uart_transmitter is

    component clock_enable_set is
        port(
            clk : in std_logic;
            rst : in std_logic;
            pulse : out std_logic;
            set   : in  std_logic_vector(1 downto 0)
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
   
  component edge_transmitter is
        port ( 
               clk : in STD_LOGIC;
               btn : in STD_LOGIC;
               pos_edge : out STD_LOGIC;
               neg_edge : out STD_LOGIC
               );
   end component;

    signal sig_baud : std_logic;
    signal start_edge : std_logic;
        
begin

    clock_en : clock_enable_set
        port map(
            clk => clk,
            rst => rst,
            pulse => sig_baud,
            set   => set_baud     
        );
        
   uart : uart_tx
       port map(
           
           clk => clk,
           rst => rst,
           baud_en => sig_baud,
           tx_start => start_edge,
           data_in => data,
           tx => rxd_out,
           tx_done => tx_done,
           data_length => set_data
           );
           
    edge_detect : edge_transmitter
        port map(
            clk => clk,
            btn => send,
            pos_edge => start_edge
           );

end Behavioral;
