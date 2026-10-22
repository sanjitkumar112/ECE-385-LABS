//mb_blink.c
//
//Provided boilerplate "LED Blink" code for ECE 385
//First released in ECE 385, Fall 2023 distribution
//
//Note: you will have to refer to the memory map of your MicroBlaze
//system to find the proper address for the LED GPIO peripheral.
//
//Modified on 7/25/23 Zuofu Cheng

#include <stdio.h>
#include <xparameters.h>
#include <xil_types.h>
#include <sleep.h>

#include "platform.h"

//volatile uint32_t* led_gpio_data = (uint32_t*)0x40000000;  //Hint: either find the manual address (via the memory map in the block diagram, or
															 //replace with the proper define in xparameters (part of the BSP). Either way
															 //this is the base address of the GPIO corresponding to your LEDs
															 //(similar to 0xFFFF from MEM2IO from previous labs).

volatile uint32_t* led_gpio_data  = (uint32_t*)0x40000000;
volatile uint32_t* sw_gpio_data   = (uint32_t*)0x40010000; // Or XPAR_AXI_GPIO_1_BASEADDR if switches are on GPIO 1
volatile uint32_t* btn_gpio_data  = (uint32_t*)0x40030000;

int main()
{
    init_platform();

    uint32_t accumulator = 0;
	uint32_t prev_btn_state = 0;

	*led_gpio_data = 0;
	xil_printf("Hello");

	while (1)
	{

		uint32_t switches = *sw_gpio_data & 0xFFFF; // 16-bit mask
		uint32_t buttons  = *btn_gpio_data & 0x0F;  // 4-bit mask

		uint32_t pressed_buttons = buttons & ~prev_btn_state;

		if (pressed_buttons & 0x02)
		{
			accumulator = 0;
		}

		if (pressed_buttons & 0x04)
		{
			if (accumulator + switches > 65535) {xil_printf("overflow");}
			accumulator += switches;
		}

		*led_gpio_data = accumulator;

		prev_btn_state = buttons;

		usleep(50000);
	}

    cleanup_platform();

    return 0;
}
