# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.19-s055_1 on Sat Nov 29 10:55:28 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design mac_shift_1mult

create_clock -name "clk" -period 122.07031 -waveform {0.0 61.03516} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports in_ready]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports in_ready]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports in_ready]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Xut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {Sut[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports in_ready]
set_clock_uncertainty -setup 0.1 [get_clocks clk]
