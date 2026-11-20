.section .text.boot,"ax"
.globl _start
_start:
    bri boot_main
    .balign 64
boot_main:
    addik r1,r0,__stack-32
    addik r3,r0,__bss
    addik r4,r0,__end
clear_loop:
    rsubk r5,r3,r4
    beqi r5,start_app
    swi r0,r3,0
    addik r3,r3,4
    bri clear_loop
start_app:
    brlid r15,main
    nop
halt:
    bri halt
