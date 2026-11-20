# Quick Draw checkpoint

This Urbana board demo uses AMD MicroBlaze MCS to read a USB mouse and test a 4 × 4 systolic array. You can draw on the HDMI canvas and change a matrix operand while the board is running.

## Run it

1. Extract this folder to a fresh location. Start Vivado 2022.2 with Spartan-7 support.
2. In the Vivado Tcl Console run `source {C:/ECE385/Quick_Draw_Demo/build.tcl}`. Substitute the actual path on your machine. The script creates the project, generates MicroBlaze and embeds the supplied firmware in BRAM.
3. Connect the programming cable and HDMI monitor. Plug a basic wired USB boot mouse into the Urbana USB host port.
4. Open Hardware Manager, select the Urbana and program **build_microblaze/QuickDraw_MicroBlaze.bit**. This is the file that includes firmware. Press BTN0 to restart.

Once **USB MOUSE READY** appears, drag with the left button to draw and right-click to clear. **MATRIX PASS** means all sixteen hardware sums matched the C reference. Flip SW2 or click the middle mouse button to change A[0,0] from 1 to −4. C[0,0] changes from FFFE (−2) to FFF9 (−7). A serial terminal at 115200 8N1 shows the individual sums.

LED0 shows matrix pass, LED1 shows failure and LED2 shows mouse ready. For button input, BTN1 and BTN2 move backward and forward. SW3 selects horizontal or vertical movement, SW0 enables ink and raising SW1 clears the canvas. BTN3 draws a dot.

## Where to edit

Start with the first module in quick_draw_top.sv to see how the processor, peripherals and display connect. The board pin assignments are in build.tcl.

| File | Responsibility |
|---|---|
| rtl/quick_draw_top.sv | Board wiring and MicroBlaze instance first, followed by the peripheral registers, timer, SPI and UART |
| rtl/drawing_engine.sv | Cursor, stroke rasterization, canvas BRAM and accelerator commands |
| rtl/systolic_array.sv | Sixteen signed multiply-accumulate cells and their dataflow |
| rtl/hdmi.sv | Display clocks, screen timing, text overlay, TMDS encoder and video serializer |
| firmware/main.c | Mouse input handling, test matrices and comparison against hardware |
| firmware/mouse.c | MAX3421E initialization, USB enumeration and mouse reports |

The array multiplies a 4 × 3 matrix by a 3 × 4 matrix. Inputs move right and weights move down. Each cell accumulates three products. The last product reaches the bottom-right cell on the ninth clock. At this checkpoint the drawing and matrix test run independently. Sketch classification is a later milestone.

## Testing and firmware edits

For the Vivado simulation select **systolic_array_tb** under Simulation Sources, launch Behavioral Simulation and run all. The bench compares all sixteen outputs and checks the completion cycle. The package was also checked with firmware-to-RTL mouse and matrix regressions and an HDMI encoder test. The vendor IP build, firmware merge and physical board still need a lab check.

The supplied quickdraw.elf is compiled for little-endian MicroBlaze. Only after changing C code, rebuild it from the firmware directory using a MicroBlaze GCC toolchain:

```sh
mb-gcc -Os -mlittle-endian -mxl-soft-mul -mxl-soft-div -mno-xl-barrel-shift -mno-xl-pattern-compare -G0 -fno-pic -fno-pie -ffreestanding -fno-stack-protector -nostdlib -static -Wl,--build-id=none,-T,link.ld boot.S main.c mouse.c -o quickdraw.elf
```

Source build.tcl again to merge the updated ELF. After RTL edits, reset the synthesis and implementation runs first. For timing and resource use see the reports in build_microblaze.
