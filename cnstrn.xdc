set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK
set_property IOSTANDARD LVCMOS33 [get_ports {clk}];

set_property PACKAGE_PIN P16 [get_ports {button_c}];  # "BTNC"
set_property IOSTANDARD LVCMOS33 [get_ports {button_c}];

set_property PACKAGE_PIN W11 [get_ports {tx_out}]; 
set_property IOSTANDARD LVCMOS33 [get_ports {tx_out}];

#set_property PACKAGE_PIN C14 [get_ports {RX_in}]; 
#set_property IOSTANDARD LVCMOS33 [get_ports {RX_in}];

set_property PACKAGE_PIN F22 [get_ports {sw_input[0]}];  # "SW0"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[0]}];

set_property PACKAGE_PIN G22 [get_ports {sw_input[1]}];  # "SW1"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[1]}];

set_property PACKAGE_PIN H22 [get_ports {sw_input[2]}];  # "SW2"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[2]}];

set_property PACKAGE_PIN F21 [get_ports {sw_input[3]}];  # "SW3"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[3]}];

set_property PACKAGE_PIN H19 [get_ports {sw_input[4]}];  # "SW4"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[4]}];

set_property PACKAGE_PIN H18 [get_ports {sw_input[5]}];  # "SW5"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[5]}];

set_property PACKAGE_PIN H17 [get_ports {sw_input[6]}];  # "SW6"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[6]}];

set_property PACKAGE_PIN M15 [get_ports {sw_input[7]}];  # "SW7"
set_property IOSTANDARD LVCMOS33 [get_ports {sw_input[7]}];

create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

set_property PACKAGE_PIN T22 [get_ports {leds_out[0]}];  # "LD0"
set_property PACKAGE_PIN T21 [get_ports {leds_out[1]}];  # "LD1"
set_property PACKAGE_PIN U22 [get_ports {leds_out[2]}];  # "LD2"
set_property PACKAGE_PIN U21 [get_ports {leds_out[3]}];  # "LD3"
set_property PACKAGE_PIN V22 [get_ports {leds_out[4]}];  # "LD4"
set_property PACKAGE_PIN W22 [get_ports {leds_out[5]}];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    # "LD5"
set_property PACKAGE_PIN U19 [get_ports {leds_out[6]}];  # "leds_out6"
set_property PACKAGE_PIN U14 [get_ports {leds_out[7]}];  # "leds_out7"

set_property PACKAGE_PIN W12 [get_ports {uart_rx_pin}]; 

set_property IOSTANDARD LVCMOS33 [get_ports {clk}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[0]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[1]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[2]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[3]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[4]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[5]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[6]}];
set_property IOSTANDARD LVCMOS33 [get_ports {leds_out[7]}];
set_property IOSTANDARD LVCMOS33 [get_ports {uart_rx_pin}];