# From the Vivado welcome screen: source {absolute/path/to/build.tcl}
set src [file dirname [file normalize [info script]]]
set work [file join $src build_microblaze]
set proj [file join $work QuickDraw.xpr]
if {[llength [get_projects -quiet]]} {
    if {[file normalize [get_property DIRECTORY [current_project]]] ne [file normalize $work]} {
        error "Close the other Vivado project, then source this script again."
    }
} elseif {[file exists $proj]} {
    open_project $proj
} else {
    create_project QuickDraw $work -part xc7s50csga324-1
    add_files -norecurse [glob -directory [file join $src rtl] *.sv]
    set_property file_type SystemVerilog [get_files *.sv]
    create_ip -name microblaze_mcs -vendor xilinx.com -library ip -module_name quickdraw_mcs
    set cpu [get_ips quickdraw_mcs]
    foreach {name value} {MEMSIZE 16384 USE_IO_BUS 1} {
        set prop [lsearch -inline -nocase [list_property $cpu] CONFIG.C_$name]
        if {$prop eq ""} {set prop CONFIG.$name}
        set_property $prop $value $cpu
    }
    generate_target all $cpu
    set constraints [file join $work urbana.xdc]
    set f [open $constraints w]
    puts $f {set_property CFGBVS VCCO [current_design]}
    puts $f {set_property CONFIG_VOLTAGE 3.3 [current_design]}
    puts $f {create_clock -period 10.000 [get_ports clk]}
    foreach {port pin standard} {
        clk           N15  LVCMOS33
        reset         J2   LVCMOS25
        uart_tx       B16  LVCMOS33
        usb_reset_n   V13  LVCMOS33
        usb_miso      U12  LVCMOS33
        usb_mosi      V15  LVCMOS33
        usb_sclk      V14  LVCMOS33
        usb_ss_n      T12  LVCMOS33
        hdmi_clk_p    U16  TMDS_33
        hdmi_clk_n    V17  TMDS_33
        hdmi_p[0]     U17  TMDS_33
        hdmi_n[0]     U18  TMDS_33
        hdmi_p[1]     R16  TMDS_33
        hdmi_n[1]     R17  TMDS_33
        hdmi_p[2]     R14  TMDS_33
        hdmi_n[2]     T14  TMDS_33
        sw[0]         G1   LVCMOS25
        sw[1]         F2   LVCMOS25
        sw[2]         F1   LVCMOS25
        sw[3]         E2   LVCMOS25
        btn[0]        J1   LVCMOS25
        btn[1]        G2   LVCMOS25
        btn[2]        H2   LVCMOS25
        led[0]        C13  LVCMOS33
        led[1]        C14  LVCMOS33
        led[2]        D14  LVCMOS33
        led[3]        D15  LVCMOS33
    } {
        puts $f [format {set_property -dict {PACKAGE_PIN %s IOSTANDARD %s} [get_ports {%s}]} $pin $standard $port]
    }
    close $f
    add_files -fileset constrs_1 -norecurse $constraints
    add_files -fileset sim_1 -norecurse [file join $src sim systolic_array_tb.sv]
    set_property top quick_draw_top [get_filesets sources_1]
    set_property top systolic_array_tb [get_filesets sim_1]
    update_compile_order -fileset sources_1
}
if {[get_property PROGRESS [get_runs impl_1]] ne "100%" || ![file exists [file join $work QuickDraw.runs impl_1 quick_draw_top.bit]]} {
    launch_runs impl_1 -to_step write_bitstream -jobs 4
    wait_on_run impl_1
}
set bit [file join $work QuickDraw.runs impl_1 quick_draw_top.bit]
if {![file exists $bit]} {error "Bitstream missing. Inspect synthesis/implementation logs in $work/QuickDraw.runs."}
open_run impl_1
report_timing_summary -file [file join $work timing.rpt]
report_utilization -file [file join $work utilization.rpt]
# Read the real implemented processor path from Vivado's memory map.
set mmi [file join $work quickdraw.mmi]
write_mem_info -force $mmi
set f [open $mmi]; set xml [read $f]; close $f
if {![regexp {<Processor[^>]*InstPath="([^"]+)"} $xml -> cpu_path]} {
    error "The implemented MMI does not contain a processor memory map: $mmi"
}
set final_bit [file join $work QuickDraw_MicroBlaze.bit]
set updater [auto_execok updatemem]
if {$updater eq "" && [info exists ::env(XILINX_VIVADO)]} {
    foreach name {updatemem updatemem.bat} {
        set path [file join $::env(XILINX_VIVADO) bin $name]
        if {[file exists $path]} {set updater [auto_execok $path];break}
    }
}
if {$updater eq ""} {error "Run inside the Vivado tools environment so updatemem is on PATH."}
exec {*}$updater -force -meminfo $mmi -data [file join $src firmware quickdraw.elf] -bit $bit -proc $cpu_path -out $final_bit >@stdout 2>@stderr
if {![file exists $final_bit]} {error "MicroBlaze firmware merge failed."}
puts "Program the Urbana board with $final_bit"
