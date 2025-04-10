
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity edge_detector is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           pos_edge : out STD_LOGIC;
           neg_edge : out STD_LOGIC;
           sig1 : out STD_LOGIC;
           sig_delayed1 : out STD_LOGIC
           );
end edge_detector;


architecture behavioral of edge_detector is
    signal sig_delayed : std_logic := '0';
    signal sig : std_logic := '0';

begin
    -- Remember the previous value of a signal and generates single
    -- clock pulses for positive and negative edges of the signal.
    p_edge_detector : process (clk) is
    begin
        if rising_edge(clk) then
            sig_delayed <= sig;
            sig <= btn;
        end if;

        
    end process p_edge_detector;

    -- Assign output signals for edge detector
    pos_edge <= '1' when sig = '1' and sig_delayed = '0' else '0';
    neg_edge <= '1' when sig = '0' and sig_delayed = '1' else '0';

end architecture behavioral;
