#ifndef DEMO_PLATFORM_H
#define DEMO_PLATFORM_H
#include <stdint.h>
#ifdef TEST_IO
uint32_t io_read(unsigned reg);
void io_write(unsigned reg, uint32_t value);
#else
static inline uint32_t io_read(unsigned reg) {
    return *(volatile uint32_t *)(0xc0000000u + 4u * reg);
}
static inline void io_write(unsigned reg, uint32_t value) {
    *(volatile uint32_t *)(0xc0000000u + 4u * reg) = value;
}
#endif
enum { CMD, REPLY, MS, LEDS, SWITCHES, SPI_CTL, SPI_BYTE, SPI_BUSY, SERIAL, TX_BUSY };
static inline unsigned now(void) {
    return io_read(MS);
}
static inline void wait_ms(unsigned n) {
    unsigned t = now();
    while (now() - t < n) {
    }
}
void logline(const char *s);
int mouse_connect(void);
int mouse_report(uint8_t *report);
unsigned mouse_interval(void);
#endif
