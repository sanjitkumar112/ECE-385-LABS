module quick_draw_top (
    input  logic clk, reset, usb_miso,
    input  logic [2:0] btn,
    input  logic [3:0] sw,
    output logic uart_tx, usb_reset_n, usb_mosi, usb_sclk, usb_ss_n,
    output logic hdmi_clk_p, hdmi_clk_n,
    output logic [2:0] hdmi_p, hdmi_n,
    output logic [3:0] led
);
    logic pixel_clk, rst;
    logic [9:0] x, y;
    logic [3:0] red, green, blue;
    logic [15:0] matrix_result;

    logic request, read_enable, write_enable, ready;
    logic [31:0] address, write_data, read_data;
    logic [3:0] byte_enable;

    (* ASYNC_REG = "TRUE" *) logic [6:0] controls_meta, controls;
    always_ff @(posedge pixel_clk) begin
        controls_meta <= {btn, sw};
        controls <= controls_meta;
    end

    quickdraw_mcs u_cpu (
        .Clk(pixel_clk), .Reset(rst),
        .IO_addr_strobe(request), .IO_read_strobe(read_enable), .IO_write_strobe(write_enable),
        .IO_address(address), .IO_byte_enable(byte_enable), .IO_write_data(write_data),
        .IO_read_data(read_data), .IO_ready(ready)
    );

    demo_io peripherals (
        .clk(pixel_clk), .rst, .controls,
        .strobe(request), .rd(read_enable), .wstrobe(write_enable), .ready,
        .addr(address), .wdata(write_data), .io_q(read_data), .byte_enable,
        .miso(usb_miso), .mosi(usb_mosi), .sclk(usb_sclk), .cs_n(usb_ss_n), .usb_reset_n,
        .tx(uart_tx), .leds(led), .c00(matrix_result),
        .x, .y, .r(red), .g(green), .b(blue)
    );

    screen display (
        .clk, .reset, .pix(pixel_clk), .rst, .x, .y,
        .r(red), .g(green), .b(blue), .led, .result(matrix_result),
        .hdmi_clk_p, .hdmi_clk_n, .hdmi_p, .hdmi_n
    );
endmodule

// Registered one-cycle response on the MicroBlaze MCS I/O bus.
module demo_io #(
    parameter int CLOCKS_PER_MS = 25000,
    parameter int UART_DIV = 217
) (
    input logic clk,
    input logic rst,
    input logic [6:0] controls,
    input logic [9:0] x,
    input logic [9:0] y,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    input logic miso,
    output logic mosi,
    output logic sclk,
    output logic cs_n,
    output logic usb_reset_n,
    output logic tx,
    output logic [3:0] leds,
    output logic [15:0] c00,
    input logic strobe,
    input logic rd,
    input logic wstrobe,
    input logic [31:0] addr,
    input logic [31:0] wdata,
    input logic [3:0] byte_enable,
    output logic ready,
    output logic [31:0] io_q
);
    typedef enum logic [5:0] {
        COMMAND, RESPONSE, MILLISECONDS, STATUS, CONTROLS,
        SPI_CONTROL, SPI_DATA, SPI_BUSY, UART_DATA, UART_BUSY
    } register_t;

    logic mmio, wr;
    register_t reg_index;
    logic [31:0] command, response, ms, status_word;

    assign mmio = strobe && !rst && addr[31:8] == 24'hc00000;
    assign wr = mmio && wstrobe && (&byte_enable);
    assign reg_index = register_t'(addr[7:2]);
    assign leds = {1'b0, status_word[2:0]};
    assign c00 = status_word[31:16];

    drawing_engine canvas (
        .clk(clk),
        .reset(rst),
        .command(command),
        .response(response),
        .draw_x(x),
        .draw_y(y),
        .red(r),
        .green(g),
        .blue(b)
    );
    logic [15:0] ms_divider;
    logic [7:0] spi_shift, spi_rx;
    logic [2:0] spi_bit, spi_divider;
    logic spi_busy;
    logic [9:0] uart_shift;
    logic [3:0] uart_bits;
    logic [8:0] uart_divider;
    assign tx = uart_shift[0];
    always_ff @(posedge clk) begin
        ready <= !rst && strobe;
        if (mmio && rd) begin
            case (reg_index)
                RESPONSE:     io_q <= response;
                MILLISECONDS: io_q <= ms;
                STATUS:       io_q <= status_word;
                CONTROLS:     io_q <= {25'b0, controls};
                SPI_DATA:     io_q <= {24'b0, spi_rx};
                SPI_BUSY:     io_q <= {31'b0, spi_busy};
                UART_BUSY:    io_q <= {31'b0, |uart_bits};
                default:      io_q <= '0;
            endcase
        end
        if (rst) begin
            command <= '0;
            status_word <= '0;
        end else if (wr) begin
            case (reg_index)
                COMMAND: command <= wdata;
                STATUS:  status_word <= wdata;
                default: ;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            ms <= '0;
            ms_divider <= '0;
        end else if (ms_divider == CLOCKS_PER_MS - 1) begin
            ms <= ms + 1'b1;
            ms_divider <= '0;
        end else begin
            ms_divider <= ms_divider + 1'b1;
        end
    end

    // Mode 0: sample MISO on the rising edge and change MOSI on the falling edge.
    always_ff @(posedge clk) begin
        if (rst) begin
            cs_n <= 1'b1;
            usb_reset_n <= 1'b0;
            mosi <= 1'b0;
            sclk <= 1'b0;
            spi_busy <= 1'b0;
            spi_rx <= '0;
        end else begin
            if (wr && reg_index == SPI_CONTROL) begin
                cs_n <= wdata[0];
                usb_reset_n <= wdata[1];
            end
            if (wr && reg_index == SPI_DATA && !spi_busy) begin
                spi_shift <= wdata[7:0];
                mosi <= wdata[7];
                spi_bit <= 7;
                spi_divider <= 4;
                spi_busy <= 1'b1;
                sclk <= 1'b0;
            end else if (spi_busy) begin
                if (spi_divider == 0) begin
                    spi_divider <= 4;
                    sclk <= !sclk;
                    if (!sclk) begin
                        spi_rx <= {spi_rx[6:0], miso};
                    end else if (spi_bit == 0) begin
                        spi_busy <= 1'b0;
                    end else begin
                        spi_bit <= spi_bit - 1'b1;
                        spi_shift <= {spi_shift[6:0], 1'b0};
                        mosi <= spi_shift[6];
                    end
                end else begin
                    spi_divider <= spi_divider - 1'b1;
                end
            end
        end
    end

    // UART sends one start bit, eight data bits and one stop bit, least significant bit first.
    always_ff @(posedge clk) begin
        if (rst) begin
            uart_shift <= '1;
            uart_bits <= '0;
            uart_divider <= '0;
        end else if (wr && reg_index == UART_DATA && uart_bits == 0) begin
            uart_shift <= {1'b1, wdata[7:0], 1'b0};
            uart_bits <= 10;
            uart_divider <= UART_DIV - 1;
        end else if (uart_bits != 0) begin
            if (uart_divider == 0) begin
                uart_divider <= UART_DIV - 1;
                uart_bits <= uart_bits - 1'b1;
                uart_shift <= {1'b1, uart_shift[9:1]};
            end else begin
                uart_divider <= uart_divider - 1'b1;
            end
        end
    end
endmodule
