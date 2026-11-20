#include "platform.h"
#include <stddef.h>

typedef struct {
    int x, y;
    unsigned buttons;
} Pen;

static unsigned seq, led, variant;
static Pen pen;

static void putc_uart(char c) {
    while (io_read(TX_BUSY)) {
    }
    io_write(SERIAL, (unsigned char)c);
}

void logline(const char *s) {
    while (*s) {
        putc_uart(*s++);
    }
    putc_uart('\r');
    putc_uart('\n');
}

static void number(int n) {
    if (n < 0) {
        putc_uart('-');
        n = -n;
    }
    static const unsigned place[] = {100000, 10000, 1000, 100, 10, 1};
    unsigned v = (unsigned)n, seen = 0;
    for (unsigned i = 0; i < 6; i++) {
        unsigned digit = 0;
        while (v >= place[i]) {
            v -= place[i];
            digit++;
        }
        if (digit || seen || i == 5) {
            putc_uart((char)('0' + digit));
            seen = 1;
        }
    }
}

static int send_command(unsigned op, unsigned payload, int *res) {
    seq ^= 0x80000000u;
    io_write(CMD, seq | (op << 24) | payload);
    unsigned t = now();
    do {
        unsigned v = io_read(REPLY);
        if ((v & 0xff000000u) == (seq | 0x2d000000u)) {
            if (res) {
                *res = (int)(v & 0x7ffffu) - (int)(v & 0x80000u);
            }
            return 1;
        }
    } while (now() - t < 100);
    return 0;
}

static void report_sum(unsigned r, unsigned c, int ref, int got) {
    if (r == 0 && c == 0) {
        led = (led & 0xffffu) | ((unsigned)got << 16);
        io_write(LEDS, led);
    }
    putc_uart('[');
    number(r);
    putc_uart(',');
    number(c);
    putc_uart(']');
    putc_uart(' ');
    number(ref);
    putc_uart('/');
    number(got);
    logline("");
}

enum { MOVE = 1, LINE, CLEAR, LOAD_A, LOAD_B, RUN, READ_SUM, VERDICT };

static void center_pen(Pen *pen) {
    pen->x = 128;
    pen->y = 128;
    pen->buttons = 0;
}

static int clip(int v) {
    return v < 0 ? 0 : (v > 255 ? 255 : v);
}

static int update_pen(Pen *pen, int dx, int dy, unsigned buttons) {
    int x = clip(pen->x + dx), y = clip(pen->y + dy);
    if ((buttons & 2u) && !(pen->buttons & 2u)) {
        if (!send_command(CLEAR, 0, 0)) {
            return 0;
        }
    }
    /* Start a new stroke at the press location. */
    if ((buttons & 1u) && !(pen->buttons & 1u)) {
        if (!send_command(MOVE, (unsigned)((y << 8) | x), 0)) {
            return 0;
        }
    }
    if (!send_command((buttons & 1u) ? LINE : MOVE, (unsigned)((y << 8) | x), 0)) {
        return 0;
    }
    pen->x = x;
    pen->y = y;
    pen->buttons = buttons;
    return 1;
}

static int check_matrix(int alternate) {
    int8_t a[4][3] = {{1, 2, 3}, {-1, 0, 1}, {2, 2, 2}, {0, 0, 0}};
    const int8_t b[3][4] = {{1, 0, 2, -1}, {0, 1, 2, 1}, {-1, 0, 2, 0}};
    int pass = 1;
    if (alternate) {
        a[0][0] = -4;
    }
    if (!send_command(VERDICT, 0, 0)) {
        return -1;
    }
    for (unsigned r = 0; r < 4; r++) {
        for (unsigned k = 0; k < 3; k++) {
            if (!send_command(LOAD_A, (r << 10) | (k << 8) | (uint8_t)a[r][k], 0)) {
                return -1;
            }
        }
    }
    for (unsigned k = 0; k < 3; k++) {
        for (unsigned c = 0; c < 4; c++) {
            if (!send_command(LOAD_B, (k << 10) | (c << 8) | (uint8_t)b[k][c], 0)) {
                return -1;
            }
        }
    }
    if (!send_command(RUN, 0, 0)) {
        return -1;
    }
    for (unsigned r = 0; r < 4; r++) {
        for (unsigned c = 0; c < 4; c++) {
            int expected = 0, actual = 0;
            for (unsigned k = 0; k < 3; k++) {
                expected += a[r][k] * b[k][c];
            }
            if (!send_command(READ_SUM, (r << 2) | c, &actual)) {
                return -1;
            }
            if (actual != expected) {
                pass = 0;
            }
            report_sum(r, c, expected, actual);
        }
    }
    if (!send_command(VERDICT, pass ? 1u : 2u, 0)) {
        return -1;
    }
    return pass;
}

static void matrix(void) {
    int passed = check_matrix(variant);
    led = (led & ~3u) | (passed == 1 ? 1u : 2u);
    io_write(LEDS, led);
    logline(passed == 1 ? "Matrix PASS" : "Matrix FAIL");
}

enum {
    INK = 1, CLEAR_SWITCH = 2, MATRIX_SWITCH = 4, VERTICAL = 8,
    BACK = 16, FORWARD = 32, DOT = 64
};

static void board_input(unsigned switches, unsigned changed, int repeat_due) {
    if (changed & MATRIX_SWITCH) {
        variant ^= 1;
        matrix();
    }
    if (switches & changed & CLEAR_SWITCH) {
        send_command(CLEAR, 0, 0);
    }

    int step = !!(switches & FORWARD) - !!(switches & BACK);
    if (repeat_due && (step || (switches & DOT))) {
        int vertical = switches & VERTICAL;
        update_pen(&pen, vertical ? 0 : step, vertical ? step : 0,
                   !!(switches & (INK | DOT)));
    }
}

static unsigned poll_mouse(void) {
    static int attached;
    uint8_t report[64];

    if (!attached) {
        attached = mouse_connect();
        if (attached) {
            led |= 4;
            io_write(LEDS, led);
            pen.buttons = 0;
            logline("Boot mouse ready");
        }
    } else {
        int bytes = mouse_report(report);
        if (bytes < 0) {
            attached = 0;
            led &= ~4u;
            io_write(LEDS, led);
            pen.buttons = 0;
            logline("Mouse reconnect");
        } else if (bytes >= 3) {
            unsigned buttons = report[0];
            if ((buttons & 4) && !(pen.buttons & 4)) {
                variant ^= 1;
                matrix();
            }
            update_pen(&pen, (int8_t)report[1], (int8_t)report[2], buttons);
        }
    }
    return attached ? mouse_interval() : 300;
}

int main(void) {
    center_pen(&pen);
    send_command(CLEAR, 0, 0);
    matrix();

    unsigned next_key = now(), next_usb = now();
    unsigned previous = 0;
    for (;;) {
        unsigned t = now();
        unsigned switches = io_read(SWITCHES);
        int repeat_due = (int32_t)(t - next_key) >= 0;

        board_input(switches, switches ^ previous, repeat_due);
        previous = switches;
        if (repeat_due) {
            next_key = t + 12;
        }
        if ((int32_t)(t - next_usb) >= 0) {
            unsigned delay = poll_mouse();
            next_usb = now() + delay;
        }
    }
}

// Freestanding helpers for the area-optimized MicroBlaze (software multiply/divide).
void *memcpy(void *dst, const void *src, size_t n) {
    unsigned char *d = dst;
    const unsigned char *s = src;
    while (n--) {
        *d++ = *s++;
    }
    return dst;
}

unsigned __mulsi3(unsigned a, unsigned b) {
    unsigned n = 0;
    while (b) {
        if (b & 1) {
            n += a;
        }
        a += a;
        b >>= 1;
    }
    return n;
}
