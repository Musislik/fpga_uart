library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_transmitter is
    generic(
        refresh_clocks : integer := 1000000  -- Po?et hodinových cykl? pro ?ekání (nap?. 10 ms p?i 50 MHz)
    );
    Port (
        clk      : in  STD_LOGIC;
        btn      : in  STD_LOGIC;
        pos_edge : out STD_LOGIC;
        neg_edge : out STD_LOGIC
    );
end edge_transmitter;

architecture behavioral of edge_transmitter is
    signal sig          : std_logic_vector(1 downto 0) := "00";
    signal refresh      : integer range 0 to refresh_clocks := 0;
    type   state_type   is (DETECT, WAIT_PERIODS);
    signal state        : state_type := DETECT;
begin

    p_edge_detector : process (clk) is
    begin
        if rising_edge(clk) then
            sig <= sig(0) & btn;

            case state is
                when DETECT =>
                    if sig(1) = '0' and sig(0) = '1' then
                        pos_edge <= '1';
                        state <= WAIT_PERIODS;
                    elsif sig(1) = '1' and sig(0) = '0' then
                        neg_edge <= '1';
                        state <= WAIT_PERIODS;
                    else
                        pos_edge <= '0';
                        neg_edge <= '0';
                    end if;

                when WAIT_PERIODS =>
                    pos_edge <= '0';
                    neg_edge <= '0';
                    if refresh < refresh_clocks - 1 then
                        refresh <= refresh + 1;
                    else
                        refresh <= 0;
                        state <= DETECT;
                    end if;
            end case;
        end if;
    end process p_edge_detector;

end architecture behavioral;