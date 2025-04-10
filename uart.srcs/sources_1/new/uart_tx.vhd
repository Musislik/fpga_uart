
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity uart_tx is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           tx_start : in STD_LOGIC;
           tx : out STD_LOGIC;
           tx_done : out STD_LOGIC;
           data_length : in std_logic_vector (1 downto 0);
           data_in : in STD_LOGIC_VECTOR (7 downto 0)
           );
end uart_tx;

architecture Behavioral of uart_tx is

    -- FSM States
    type   state_type is (IDLE, START, DATA, PARITY ,STOP);
    signal state : state_type;

    -- Transmission Registers
    signal sig_count : integer := 0;
    signal sig_reg   : std_logic_vector(7 downto 0);

begin

p_uart_tx : process (clk) is

    variable ones : integer range 0 to 8 := 0;
    
    begin

        if rising_edge(clk) then
            if (rst = '1') then
                state <= IDLE;
                tx <= '1';
                sig_count <= 0;
                tx_done <= '0';

            elsif (state = IDLE and tx_start = '1') then
                state <= START;

            elsif (baud_en = '1') then  -- Use clock enable signal

                case state is

                    when START =>
                        tx        <= '0';      -- Start bit (LOW)
                        sig_reg   <= data_in;  -- Load data
                        sig_count <= 0;
                        tx_done   <= '0';
                        state     <= DATA;

                    when DATA =>
                        tx      <=  sig_reg(0); -- Transmit LSB first
                        
                        if(sig_reg(0) = '1') then
                            ones := ones + 1;
                        end if;
                        
                        sig_reg <= '0' & sig_reg(7 downto 1); -- Shift register to right
                        if (sig_count = (TO_INTEGER (unsigned(data_length)) + 4)) then
                            state <= PARITY;
                        else
                            sig_count <= sig_count + 1;
                        end if;
                        
                    when PARITY =>
                        if(ones mod 2 = 0) then
                            tx <= '1';
                        else    
                            tx <= '0';
                        end if;
                        ones := 0;
                        state <= STOP;
                        
                    when STOP =>
                        tx <= '1';
                        tx_done <= '1';
                        state <= IDLE;
                    when IDLE =>
                        tx <= '1';
                        tx_done <= '0';
                        
                        

                    when others =>
                        state <= IDLE;

                end case;

            end if;
        end if;

    end process p_uart_tx;

end Behavioral;
