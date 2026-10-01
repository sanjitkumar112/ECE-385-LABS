vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/blk_mem_gen_v8_4_5
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap blk_mem_gen_v8_4_5 questa_lib/msim/blk_mem_gen_v8_4_5
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv \
"/home/user/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/home/user/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_5 -64 -incr -mfcu  \
"../simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../lab 5/lab 5.gen/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv \
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

