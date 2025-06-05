vlib work
vlib activehdl

vlib activehdl/xlslice_v1_0_2
vlib activehdl/xil_defaultlib

vmap xlslice_v1_0_2 activehdl/xlslice_v1_0_2
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xlslice_v1_0_2  -v2k5 \
"../../../ipstatic/ipshared/11d0/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../src/div_gen_xlslice_0_0/sim/div_gen_xlslice_0_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

