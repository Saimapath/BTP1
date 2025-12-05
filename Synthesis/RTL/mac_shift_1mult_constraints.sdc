# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.19-s055_1 on Fri Nov 28 04:57:46 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design mac_shift_1mult

set_clock_gating_check -setup 0.0 
