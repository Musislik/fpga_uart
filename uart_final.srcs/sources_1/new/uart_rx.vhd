library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity uart_rx is
    Port ( rx : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           paralel_data : out STD_LOGIC_VECTOR (7 downto 0);
           rx_start : in std_logic;
           rx_done : out std_logic;
           data_length : in std_logic_vector (1 downto 0)
           );
end uart_rx;

architecture Behavioral of uart_rx is

    type   state_type is (IDLE, DATA);
    signal state : state_type := IDLE;


    signal counter : integer range 0 to 8 := 0;
    signal bits : integer range 0 to 8 := 0;
    signal paralel_data_reg: std_logic_vector (7 downto 0);
    signal start_bit: std_logic := '0';
    signal ones : integer range 0 to 8 := 0;
    signal parity_bit : std_logic := '0';
    
    
begin
    

p_uart_rx : process (clk) is
    
    begin
        if rising_edge(clk) then

            
            if (rst = '1') then
                state <= IDLE;          
                      
            elsif (state = IDLE and rx_start = '1') then
                bits <= (TO_INTEGER (unsigned(data_length)) + 5);
                state <= DATA;
                
                if (rx = '0') then
                    start_bit <= '1';
                end if;
                
            else
                case state is
                    when DATA =>
                        if (baud_en = '1') then
                            if(start_bit = '0') then    --detekce start bitu
                                start_bit <= '1';       
                            else                   
                                if (counter < bits) then        
                                    paralel_data_reg(counter) <= rx; --lsb first
                                    if rx = '1' then
                                        ones <= ones + 1;
                                    end if;
                                    counter <= counter + 1;
                                    
                                elsif (counter = bits) then --detekce parity bitu
                                    parity_bit <= rx;
                                    counter    <=  bits + 1;
                                    
                                else
                                    if (rx = '1') and ((ones mod 2 = 0 and parity_bit = '0') or --detekce stop bitu a overeni parity
                                                      (ones mod 2 /= 0 and parity_bit = '1')) then
                                        paralel_data <= paralel_data_reg;
                                        rx_done <= '1';
                                    end if;
                                        state <= IDLE;
                                end if;
                            end if;
                        end if;
                    
                    when IDLE =>
                        start_bit <= '0';
                        counter <= 0;
                        rx_done   <= '0';
                        bits      <=   0;
                        ones      <=   0;
                        paralel_data_reg <= "00000000";
                        paralel_data     <= "00000000"; 
                            
                    when others =>
                        state <= IDLE;
    
                end case;
            
            end if;

        end if;

    end process p_uart_rx;

end Behavioral;
