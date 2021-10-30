# set voltage configurations
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# set clock pin and IO standard
set_property PACKAGE_PIN H4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clock -waveform {0 5} [get_ports clk]

# set led pins and IO standard
set_property PACKAGE_PIN K17 [get_ports {leds[0]}]
set_property PACKAGE_PIN J17 [get_ports {leds[1]}]
set_property PACKAGE_PIN L14 [get_ports {leds[2]}]
set_property PACKAGE_PIN L15 [get_ports {leds[3]}]
set_property PACKAGE_PIN L16 [get_ports {leds[4]}]
set_property PACKAGE_PIN K16 [get_ports {leds[5]}]
set_property PACKAGE_PIN M15 [get_ports {leds[6]}]
set_property PACKAGE_PIN M16 [get_ports {leds[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

# set button pins, IO standard, and pullup
set_property PACKAGE_PIN N17 [get_ports upBtn]
set_property PACKAGE_PIN P20 [get_ports leftBtn]
set_property PACKAGE_PIN P19 [get_ports downBtn]
set_property PACKAGE_PIN P17 [get_ports rightBtn]
set_property PACKAGE_PIN M2  [get_ports resetBtn]

set_property IOSTANDARD LVCMOS33 [get_ports upBtn]
set_property IOSTANDARD LVCMOS33 [get_ports leftBtn]
set_property IOSTANDARD LVCMOS33 [get_ports downBtn]
set_property IOSTANDARD LVCMOS33 [get_ports rightBtn]
set_property IOSTANDARD LVCMOS33 [get_ports resetBtn]

set_property PULLUP true [get_ports upBtn]
set_property PULLUP true [get_ports leftBtn]
set_property PULLUP true [get_ports downBtn]
set_property PULLUP true [get_ports rightBtn]
set_property PULLDOWN true [get_ports resetBtn] 

# set 7 segment display enable pins and IO standard
set_property PACKAGE_PIN L4 [get_ports {ssd_en[0]}]
set_property PACKAGE_PIN P1 [get_ports {ssd_en[1]}]
set_property PACKAGE_PIN R1 [get_ports {ssd_en[2]}]
set_property PACKAGE_PIN N3 [get_ports {ssd_en[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ssd_en[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_en[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_en[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_en[3]}]

# set 7 segment display data output pins and IO standard
set_property PACKAGE_PIN P4 [get_ports {ssd_out[0]}]
set_property PACKAGE_PIN N4 [get_ports {ssd_out[1]}]
set_property PACKAGE_PIN M3 [get_ports {ssd_out[2]}]
set_property PACKAGE_PIN M5 [get_ports {ssd_out[3]}]
set_property PACKAGE_PIN L5 [get_ports {ssd_out[4]}]
set_property PACKAGE_PIN L6 [get_ports {ssd_out[5]}]
set_property PACKAGE_PIN M6 [get_ports {ssd_out[6]}]
set_property PACKAGE_PIN P5 [get_ports {ssd_out[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_out[0]}]

