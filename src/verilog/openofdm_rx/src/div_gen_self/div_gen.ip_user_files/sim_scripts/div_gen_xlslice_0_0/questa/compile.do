vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xlslice_v1_0_2
vlib questa_lib/msim/xil_defaultlib

vmap xlslice_v1_0_2 questa_lib/msim/xlslice_v1_0_2
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xlslice_v1_0_2 -64 -incr -mfcu \
"../../../ipstatic/ipshared/11d0/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu \
"../../../src/div_gen_xlslice_0_0/sim/div_gen_xlslice_0_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

