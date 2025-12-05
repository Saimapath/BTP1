#!/bin/sh

design="final_project"
rm -rf ${design}_tb
echo "Testing:" ${design}
iverilog -o ${design}_tb  adder_18bit.v class1_top_channels.v class2_top_channels.v counter_gen.v mean_class_activity.v onset_detector.v channel_cal.v counter_32.v dual_thresholding.v mult10X8.v counter_8.v mac_shift_1mult.v mux8X1.v testbench_onset_detector.v  

#iverilog -o ${design}_tb ${design}.v counter_4bit.v counter_5bit_en.v add.v mult.v ${design}_tb.v
vvp ${design}_tb
