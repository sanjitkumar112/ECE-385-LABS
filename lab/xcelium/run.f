-makelib xcelium_lib/xpm -sv \
  "/home/user/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/home/user/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_5 \
  "../simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../lab 5/lab 5.gen/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
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
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

