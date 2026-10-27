# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_2_system/_ide/scripts/systemdebugger_lab6_2_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_2_system/_ide/scripts/systemdebugger_lab6_2_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "RealDigital Boo 8874042400D7A" && level==0 && jtag_device_ctx=="jsn1-0362f093-0"}
fpga -file /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_2/_ide/bitstream/mb_usb_hdmi_top_1.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_platform/export/lab6_platform/hw/mb_usb_hdmi_top_1.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_2/Debug/lab6_2.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
