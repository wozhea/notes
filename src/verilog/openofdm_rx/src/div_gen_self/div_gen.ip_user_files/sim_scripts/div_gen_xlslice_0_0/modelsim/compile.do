vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xlslice_v1_0_2
vlib modelsim_lib/msim/xil_defaultlib

vmap xlslice_v1_0_2 modelsim_lib/msim/xlslice_v1_0_2
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xlslice_v1_0_2 -64 -incr -mfcu \
"../../../ipstatic/ipshared/11d0/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu \
"../../../src/div_gen_xlslice_0_0/sim/div_gen_xlslice_0_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

