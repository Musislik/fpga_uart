library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity edge_detector is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           pos_edge : out STD_LOGIC;
           neg_edge : out STD_LOGIC;
           baud_en : in std_logic
           );
end edge_detector;


architecture behavioral of edge_detector is
    signal sig : std_logic_vector(1 downto 0);

begin
    p_edge_detector : process (clk) is
    begin
        if rising_edge(clk) then
                if (baud_en = '1') then
                    sig(1 downto 0) <= sig(0) & btn;
                end if;
        end if;

        
    end process p_edge_detector;

    -- Assign output signals for edge detector
    pos_edge <= '1' when sig(0) = '1' and sig(1) = '0' else '0';
    neg_edge <= '1' when sig(1) = '1' and sig(0) = '0' else '0';

end architecture behavioral;
