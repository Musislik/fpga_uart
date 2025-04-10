----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 09:25:52 AM
-- Design Name: 
-- Module Name: baud_rate - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity baud_rate is
generic(
N_PER : integer := 41667
);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           set_baud : in STD_LOGIC_VECTOR (2 downto 0);
           nper : out STD_LOGIC);
end baud_rate;

architecture Behavioral of baud_rate is
signal sig_cnt : integer range 0 to N_PER;
begin

process (clk)
    begin
        -- Synchronous proces
        if (rising_edge(clk)) then
            -- if high-active reset then
            if rst = '1' then
                -- Clear integer counter
                sig_cnt <= 0;
            -- elsif sig_count is less than N_PERIODS-1 then
        elsif sig_cnt <= N_PER then
        
                case set_baud is
                    --Baudrate 9600
                    when "00" =>
                    if sig_cnt = 10417 then
                    sig_cnt <= 0;
                    else 
                    sig_cnt <= sig_cnt+1; 
                    end if;
                    
                    --Baudrate 2400
                    when "01" =>
                    if sig_cnt = 41667 then
                    sig_cnt <= 0;
                    else 
                    sig_cnt <= sig_cnt+1; 
                    end if;
                    
                    --Baudrate 57600
                    when "10" =>
                    if sig_cnt = 1736 then
                    sig_cnt <= 0;
                    else 
                    sig_cnt <= sig_cnt+1; 
                    end if;
                    
                    --Baudrate 115200
                    when "11" =>
                    if sig_cnt = 868 then
                    sig_cnt <= 0;
                    else 
                    sig_cnt <= sig_cnt+1; 
                    end if;
                    
                    end case;
                    
        --Else condition
        else
            sig_cnt <=0;
            end if;
        end if;
end process;
end Behavioral;
