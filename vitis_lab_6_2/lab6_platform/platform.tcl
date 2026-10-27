# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2/lab6_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {lab6_platform}\
-hw {/home/amogk/Vivado/ECE-385-LABS/lab6/mb_usb_hdmi_top.xsa}\
-proc {microblaze_0} -os {standalone} -out {/home/amogk/Vivado/ECE-385-LABS/vitis_lab_6_2}

platform write
platform generate -domains 
platform active {lab6_platform}
platform generate
platform clean
platform generate
platform active {lab6_platform}
platform active {lab6_platform}
platform config -updatehw {/home/amogk/Vivado/ECE-385-LABS/lab6/mb_usb_hdmi_top_1.xsa}
platform clean
platform generate
