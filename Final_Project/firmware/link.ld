ENTRY(_start)
SECTIONS {
 . = 0;
 .text : { KEEP(*(.text.boot)) *(.text*) }
 .rodata : { *(.srodata*) *(.rodata*) }
 .data : { *(.sdata*) *(.data*) }
 . = ALIGN(4);
 __bss = .;
 .bss : { *(.sbss*) *(.bss*) *(COMMON) }
 . = ALIGN(4);
 __end = .;
 __stack = 16384;
 ASSERT(__end < __stack - 2048, "Firmware exceeds memory budget")
}
