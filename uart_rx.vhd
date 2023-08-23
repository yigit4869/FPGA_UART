library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_rx is
    generic (baud_rate: integer := 256000;
             clk_freq: integer := 100_000_000);
    Port ( clk : in std_logic;
           rx_in: in std_logic;
           rx_data_out: out std_logic_Vector(7 downto 0);
           rx_done: out std_logic
         );
end uart_rx;

architecture Behavioral of uart_rx is
    type state is (idle, start, data, stop);
    signal current_state: state := idle;

    constant clk_per_bit: integer := (clk_freq / (baud_rate )); -- 
    
    signal shift_reg: std_logic_Vector (7 downto 0) := (others => '0'); 
    signal clk_per_bit_timer: integer range 0 to clk_per_bit := 0;
    signal bit_counter: integer range 0 to 7 := 0;
   --type data_array is array (integer range 0 to 15)  of std_logic; --69s 12-bits-vectors 
    signal sample_counter: integer range 0 to 15:=0;
    signal one_bit_tick: std_logic;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            case current_state is 
                when idle =>
                    rx_done <= '0';
                    clk_per_bit_timer <= 0;
                    sample_counter <= 0;
                    if rx_in = '0' then
                        current_state <= start;
                    end if;
                when start =>
                    if clk_per_bit_timer = clk_per_bit/2-1 then          
                        current_state <= data;
                        clk_per_bit_timer <= 0;
                    else
                        clk_per_bit_timer <= clk_per_bit_timer + 1;
                    end if;
                
                when data =>
                                       
                    if clk_per_bit_timer = clk_per_bit-1 then
                        
                        if (sample_counter > 4) then
                            
                            shift_reg <= "1" & shift_reg(7 downto 1);
                        else
                            
                            shift_reg <= "0" & shift_reg(7 downto 1);
                        end if;
                        sample_counter <= 0; 
                
                    
                        if bit_counter = 7 then
                            sample_counter <= 0;
                            current_state <= stop;
                            bit_counter <= 0;
                        else
                            bit_counter <= bit_counter + 1;
                            sample_counter <= 0;
                        end if;
                
                        clk_per_bit_timer <= 0; 
                    else
                        for i in 8 to 15 loop
                            if clk_per_bit_timer = ((i * clk_per_bit) / 16) - 1 then
                                if rx_in = '1' then
                                    sample_counter <= sample_counter + 1;
                                end if;
                            
                            --if i = 8 then 
                                --one_bit_tick <= rx_in;   
                            --end if;    
                            end if;
                        end loop;   
                        clk_per_bit_timer <= clk_per_bit_timer + 1; 
                    end if;

                when stop =>
                    if clk_per_bit_timer = clk_per_bit-1 then
                        current_state <= idle;
                        clk_per_bit_timer <= 0;
                        rx_done <= '1';
                    else
                        clk_per_bit_timer <= clk_per_bit_timer + 1;
                    end if;
            end case;
        end if;
    end process;

    rx_data_out <= shift_reg;   
end Behavioral;
