library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_seg is
    Port (
        paralel_data_bits : in  STD_LOGIC_VECTOR (7 downto 0);
        segments          : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
        anody             : out std_logic_vector (7 downto 0);
        rx_done           : in std_logic;
        clk               : in std_logic
    );
end data_seg;

architecture Behavioral of data_seg is
    constant seg_one  : std_logic_vector(7 downto 0) := "11111001";
    constant seg_zero : std_logic_vector(7 downto 0) := "11000000";
    signal anody_buffer  : std_logic_vector(7 downto 0) := "01111111";
    signal counter       : integer := 0;
    signal data          : std_logic_vector(7 downto 0) := "00000000";
    signal refresh       : integer := 1;
    
begin

    process (clk) is
        begin       
            if rising_edge(clk) then
                if rx_done = '1' then
                    data <= paralel_data_bits;
                    anody_buffer <= "11111110";
                    counter <= 0;
                end if;
            
                if refresh = 200000 then
                            refresh <= 1;
                            counter <= (counter + 1) mod 8;
                            anody_buffer(7 downto 0) <= anody_buffer(6 downto 0) & anody_buffer(7);
                            anody <= anody_buffer;
                            if data(counter) = '1' then
                                segments <= seg_one;
                            else
                                segments <= seg_zero;
                            end if;  
                else            
                    refresh <= refresh + 1;
                end if;
           end if;
    end process;
end Behavioral;