

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
generic (baud_rate: integer:= 256_000;
 stop_bit: integer:= 2;
 clk_freq: integer:=100_000_000);
 
  Port (clk: in std_logic;
        sw_input: in std_logic_vector(7 downto 0);
        button_c: in std_logic;
        tx_out: out std_logic;
        uart_rx_pin: in std_logic;             
        leds_out: out std_logic_vector(7 downto 0) );
end top_module;

architecture Behavioral of top_module is
signal data_received: std_logic;
    signal dout : std_logic_vector(7 downto 0);
    signal leds: std_logic_vector(7 downto 0):=(others => '0');
    signal rx_done_tick: std_logic := '0';
    component uart_rx is
    generic (baud_rate: integer:= 256000;
 clk_freq: integer:=100_000_000);
        Port ( clk : in std_logic;
               rx_in: in std_logic;
               rx_data_out: out std_logic_Vector(7 downto 0);
               rx_done: out std_logic
        );
end component;
component debounce is
generic (
c_clkfreq	: integer := 100_000_000;
c_debtime	: integer := 1000;
c_initval	: std_logic	:= '0'
);
port (
clk			: in std_logic;
signal_i	: in std_logic;
signal_o	: out std_logic
);
end component;

component uart_tx is
 
 generic (baud_rate: integer:= 256000;
 stop_bit: integer:= 2;
 clk_freq: integer:=100_000_000);
 
  Port ( clk : in std_logic;
        data_in: in std_logic_vector(7 downto 0);
        tx_start_in: in std_logic;
        tx_out: out std_logic;
        tx_done: out std_logic
    );
end component;

signal button_debt: std_logic := '0';
signal button_debt_next: std_logic := '0';
signal tx_start : std_logic := '0';
signal tx_d : std_logic := '0';
begin

btn_C: debounce
generic map(
c_clkfreq => clk_freq,	
c_debtime => 1000,
c_initval => '0')

port map (
clk => clk,
signal_i => button_c,
signal_o => button_debt);


i_uart_tx: uart_tx

generic map (baud_rate => baud_rate,
 stop_bit => stop_bit,
 clk_freq => clk_freq)
 
  Port map ( clk => clk,
        data_in => sw_input,
        tx_start_in => tx_start,
        tx_out => tx_out,
        tx_done => tx_d
    );

uart_instance: uart_rx
         generic map (baud_rate => baud_rate,
        clk_freq => clk_freq)
        Port map ( clk => clk,
               rx_in => uart_rx_pin,
               rx_data_out => dout,
               rx_done => rx_done_tick
        );

    
process(clk) begin
if (rising_edge(clk)) then
    button_debt_next <= button_debt;
    tx_start <= '0';
    leds(7 downto 0) <= dout;
    
    if (button_debt = '1' and button_debt_next = '0') then
        tx_start <= '1';
    
    
end if;
end if;
end process;
leds_out <= dout(7 downto 0);
end Behavioral;
