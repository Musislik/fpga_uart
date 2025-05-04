library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_enable_set is
    Port (
           set   : in std_logic_vector(1 downto 0);
           clk   : in STD_LOGIC;
           rst   : in STD_LOGIC;
           pulse : out STD_LOGIC);
end clock_enable_set;

architecture Behavioral of clock_enable_set is
    signal N_periods   : positive range 1 to 20833;
    signal sig_counter : positive range 1 to 20833;

begin
    process(clk) begin
        if rising_edge(clk) then
            pulse <= '0';
            
            case set is
                when "00" =>
                    N_periods <= 20833; --4800baud
                when "01" =>
                    N_periods <= 10417; --9600baud
                when "10" =>
                    N_periods <= 1736; --57600baud
                when "11" =>
                    N_periods <= 868; --115200baud
                when others =>
                    N_periods <= 10417;
            end case;
                     
            if rst = '1' then
                sig_counter <= 1;
            else
                if sig_counter >= N_PERIODS then
                    pulse <= '1';
                    sig_counter <= 1;
                else
                    sig_counter <= sig_counter + 1;
                end if;
             end if;
        end if;
    end process;
end Behavioral;
