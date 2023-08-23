

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;


entity uart_tx is
 
 generic (baud_rate: integer:= 256000;
 stop_bit: integer:= 2;
 clk_freq: integer:=100_000_000);
 
  Port ( clk : in std_logic;
        data_in: in std_logic_vector(7 downto 0);
        tx_start_in: in std_logic;
        tx_out: out std_logic;
        tx_done: out std_logic
    );
end uart_tx;

architecture Behavioral of uart_tx is

constant clk_per_bit: integer := clk_freq / baud_rate;
constant stop_bit_limit: integer:= clk_per_bit*stop_bit;

type state is (idle, start, data, stop);
signal current_state: state:= idle;
signal shift_reg: std_logic_Vector (7 downto 0):= (others => '0'); 
signal clk_per_bit_timer: integer range 0 to stop_bit_limit:= 0;
signal bit_counter: integer range 0 to 7:=0;

begin

main_p: process(clk) begin
if rising_edge(clk) then
                
        case current_state is 
            
            when idle =>
                tx_out <= '1';
                tx_done <= '0';
                bit_counter <= 0;
                
                if tx_start_in = '1' then
                    current_state <= start;
                    tx_out <= '0';
                    shift_reg <= data_in;
                end if; 
                    
            when start =>
                if (clk_per_bit_timer = clk_per_bit - 1) then
                    current_state <= data;
                    tx_out <= shift_reg(0);
                    shift_reg(6 downto 0) <= shift_reg(7 downto 1);
                    shift_reg(7) <= shift_reg(0);
                    clk_per_bit_timer <= 0;
                else
                    clk_per_bit_timer <= clk_per_bit_timer + 1;               
                end if;
            
            when data =>
                
                
                if bit_counter = 7 then
                    if (clk_per_bit_timer = clk_per_bit - 1) then
                        bit_counter <= 0;
                        current_state <= stop;
                        tx_out <= '1';
                        clk_per_bit_timer <= 0;  
                    else
                        clk_per_bit_timer <= clk_per_bit_timer + 1;      
                    end if;
                
                else    
                    if (clk_per_bit_timer = clk_per_bit - 1) then
                        shift_reg(6 downto 0) <= shift_reg(7 downto 1);
                        shift_reg(7) <= shift_reg(0);
                        tx_out <= shift_reg(0);
                        bit_counter <= bit_counter + 1;
                        clk_per_bit_timer <= 0;    
                    else
                        clk_per_bit_timer <= clk_per_bit_timer + 1;    
                    end if;
                      
                end if;
                            
            when stop =>
                    if (clk_per_bit_timer = stop_bit_limit - 1) then
                        current_state <= idle;            
                        tx_done <= '1';          
                        clk_per_bit_timer <= 0;                          
                    else
                        clk_per_bit_timer <= clk_per_bit_timer + 1;    
                    end if;
        
        
        end case;
end if;
end process;
end Behavioral;
















