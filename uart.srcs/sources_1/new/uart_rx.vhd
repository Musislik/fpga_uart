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

    type   state_type is (IDLE, DATA, STOP);
    signal state : state_type := IDLE;


    signal counter : integer range 0 to 7 := 0;
    signal bits : integer range 0 to 8 := 8;
    signal paralel_data_reg: std_logic_vector (7 downto 0);
    
begin

p_uart_rx : process (clk) is
    
    begin
        
        if rising_edge(clk) then

            
            if (rst = '1') then
                paralel_data_reg <= "00000000";
                paralel_data     <= "00000000";
                state <= IDLE;          
                      
            elsif (state = IDLE and rx_start = '1') then
                bits <= TO_INTEGER (unsigned(data_length)) + 5;
                state <= DATA;         
                   
            elsif (baud_en = '1') then

                case state is
                    
                    when DATA =>
                        if (counter < bits) then
                            paralel_data_reg(bits - 1 - counter) <= rx; --lsb first
                            counter <= counter + 1;
                        else
                            state <= STOP;
                            
                        end if;
                    
                    when STOP =>
                        if (rx = '1') then
                            paralel_data <= paralel_data_reg;
                            rx_done <= '1';
                            
                            
                        end if;
                        
                        
                        counter <= 0;
                        state <= IDLE;    
                    
                    when IDLE =>
                    
                        rx_done <= '0';
                        bits    <= 0;
                        paralel_data_reg <= "00000000";
                        paralel_data     <= "00000000"; 
                            
                    when others =>
                        state <= IDLE;

                end case;
            else
            end if;
        end if;

    end process p_uart_rx;

end Behavioral;
