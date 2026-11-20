// Direct-attached USB HID boot mouse using the MAX3421E host serial interface.
#include "platform.h"
enum {
    RXFIFO = 0x08,
    SETUPFIFO = 0x20,
    RXCOUNT = 0x30,
    USBIRQ = 0x68,
    USBCTL = 0x78,
    PINCTL = 0x88,
    IOPINS1 = 0xa0,
    HIRQ = 0xc8,
    MODE = 0xd8,
    ADDRESS = 0xe0,
    HCTL = 0xe8,
    HXFR = 0xf0,
    HRSL = 0xf8
};
static unsigned endpoint, interval, ep0size, host_ready;
static uint8_t config[512];

static uint8_t spi(uint8_t v) {
    io_write(SPI_BYTE, v);
    while (io_read(SPI_BUSY)) {
    }
    return (uint8_t)io_read(SPI_BYTE);
}

static void write_n(unsigned reg, const uint8_t *buf, unsigned n) {
    io_write(SPI_CTL, 2);
    spi(reg | 2);
    for (unsigned i = 0; i < n; i++) {
        spi(buf[i]);
    }
    io_write(SPI_CTL, 3);
}

static void put(unsigned reg, uint8_t v) {
    write_n(reg, &v, 1);
}

static void read_n(unsigned reg, uint8_t *buf, unsigned n) {
    io_write(SPI_CTL, 2);
    spi(reg);
    for (unsigned i = 0; i < n; i++) {
        buf[i] = spi(0);
    }
    io_write(SPI_CTL, 3);
}

static uint8_t get(unsigned reg) {
    uint8_t v;
    read_n(reg, &v, 1);
    return v;
}

static int wait_bit(unsigned reg, unsigned mask, int set, unsigned ms) {
    unsigned t = now();
    do {
        if (!!(get(reg) & mask) == set) {
            return 1;
        }
    } while (now() - t < ms);
    return 0;
}

static int token(unsigned tok, int retry_nak) {
    unsigned t = now();
    do {
        put(HIRQ, 0x80);
        put(HXFR, tok);
        if (!wait_bit(HIRQ, 0x80, 1, 30)) {
            return 0x0e;
        }
        unsigned rc = get(HRSL) & 15;
        if (rc != 4 || !retry_nak) {
            return (int)rc;
        }
    } while (now() - t < 100);
    return 4;
}

static int packet(uint8_t *out, unsigned cap) {
    uint8_t tmp[64];
    if (!(get(HIRQ) & 4)) {
        return -1;
    }
    unsigned n = get(RXCOUNT);
    if (n > 64) {
        return -1;
    }
    read_n(RXFIFO, tmp, n);
    put(HIRQ, 4);
    if (n > cap) {
        return -1;
    }
    for (unsigned i = 0; i < n; i++) {
        out[i] = tmp[i];
    }
    return (int)n;
}

static int control(unsigned type, unsigned req, unsigned value, unsigned index, uint8_t *out,
                   unsigned len) {
    uint8_t setup[8] = {type, req, value, value >> 8, index, index >> 8, len, len >> 8};
    write_n(SETUPFIFO, setup, 8);
    if (token(0x10, 1)) {
        return -1;
    }
    unsigned used = 0;
    if (len) {
        put(HCTL, 0x20); // control read starts with DATA1; chip advances on ACK
        while (used < len) {
            if (token(0, 1)) {
                return -1;
            }
            int n = packet(out + used, len - used);
            if (n < 0) {
                return -1;
            }
            used += (unsigned)n;
            if ((unsigned)n < ep0size) {
                break;
            }
        }
    }
    if (token(len ? 0xa0 : 0x80, 1)) {
        return -1;
    }
    return (int)used;
}

static int select_interface(const uint8_t *d, unsigned len, unsigned *iface) {
    int matching = 0;
    for (unsigned i = 0; i + 2 <= len;) {
        unsigned n = d[i], kind = d[i + 1];
        if (n < 2 || n > len - i) {
            return 0;
        }
        if (kind == 4) {
            matching =
                n >= 9 && d[i + 3] == 0 && d[i + 5] == 3 && d[i + 6] == 1 && d[i + 7] == 2;
            if (matching) {
                *iface = d[i + 2];
            }
        } else if (kind == 5 && matching && n >= 7 && (d[i + 2] & 0x80) &&
                   (d[i + 3] & 3) == 3 && (d[i + 2] & 15)) {
            endpoint = d[i + 2] & 15;
            interval = d[i + 6] ? d[i + 6] : 10;
            return 1;
        }
        i += n;
    }
    return 0;
}

unsigned mouse_interval(void) {
    return interval;
}

int mouse_connect(void) {
    if (!host_ready) {
        io_write(SPI_CTL, 1);
        wait_ms(5);
        io_write(SPI_CTL, 3);
        wait_ms(5);
        put(PINCTL, 0x10);
        put(USBCTL, 0x20);
        put(USBCTL, 0);
        if (!wait_bit(USBIRQ, 1, 1, 100)) {
            return 0;
        }
        put(PINCTL, 0x10);
        put(IOPINS1, get(IOPINS1) | 1);
        host_ready = 1;
        wait_ms(100);
    }
    put(MODE, 0xc1);
    put(HCTL, 4);
    // SAMPLEBUS reads back set after the line sample is complete.
    if (!wait_bit(HCTL, 4, 1, 10)) {
        return 0;
    }
    unsigned state = get(HRSL) & 0xc0;
    if (state != 0x80 && state != 0x40) {
        return 0;
    }
    unsigned mode = state == 0x40 ? 0xc3 : 0xc1;
    wait_ms(100);
    put(MODE, mode);
    put(ADDRESS, 0);
    put(HCTL, 1);
    if (!wait_bit(HCTL, 1, 0, 100)) {
        return 0;
    }
    put(MODE, mode | 8);
    wait_ms(30);
    put(HIRQ, 0xff);
    ep0size = 8;
    uint8_t hdr[9];
    if (control(0x80, 6, 0x100, 0, hdr, 8) != 8) {
        return 0;
    }
    ep0size = hdr[7];
    if (ep0size != 8 && ep0size != 16 && ep0size != 32 && ep0size != 64) {
        return 0;
    }
    if (control(0, 5, 1, 0, 0, 0) < 0) {
        return 0;
    }
    wait_ms(5);
    put(ADDRESS, 1);
    if (control(0x80, 6, 0x200, 0, hdr, 9) != 9 || hdr[1] != 2) {
        return 0;
    }
    unsigned size = hdr[2] | ((unsigned)hdr[3] << 8), iface = 0;
    if (size < 9 || size > sizeof(config)) {
        return 0;
    }
    if (control(0x80, 6, 0x200, 0, config, size) != (int)size ||
        !select_interface(config, size, &iface)) {
        return 0;
    }
    if (control(0, 9, hdr[5], 0, 0, 0) < 0 || control(0x21, 11, 0, iface, 0, 0) < 0) {
        return 0;
    }
    put(HCTL, 0x10); // interrupt endpoint starts DATA0 after configuration
    put(HIRQ, 0x20);
    return 1;
}

int mouse_report(uint8_t *out) {
    if (get(HIRQ) & 0x20) {
        return -1;
    }
    int rc = token(endpoint, 0);
    if (rc == 4) {
        return 0; // NAK: no movement
    }
    if (rc) {
        return -1;
    }
    return packet(out, 64);
}
