vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/blk_mem_gen_v8_4_5
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap blk_mem_gen_v8_4_5 activehdl/blk_mem_gen_v8_4_5
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 \
"/home/user/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"/home/user/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_5  -v2k5 \
"../simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../lab 5/lab 5.gen/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \

vlog -work xil_defaultlib  -sv2k12 \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/control.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/cpu.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/cpu_to_io.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/hex_driver.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/types.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/instantiate_ram.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/load_reg.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/memory.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/slc3.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/sync.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/processor_top.sv" \
"../../lab 5/lab 5.srcs/sources_1/imports/srcs/test_memory.sv" \
"../../lab 5/lab 5.srcs/sim_1/new/testbench.sv" \

vlog -work xil_defaultlib \
"glbl.v"

