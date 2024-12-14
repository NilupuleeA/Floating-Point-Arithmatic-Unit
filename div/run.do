if { [file exists "work"] } { vdel -all }
vlib work

vlog -64 -incr -mfcu -sv *.sv

vopt -64 +acc=p fp_div_tb -o testbench_opt

vsim testbench_opt -wlf mywlf.wlf

# Add signals to the waveform window
add log sim:/fp_div_tb/dut/*

run -all

# Save the dataset for further analysis
dataset save

quit


