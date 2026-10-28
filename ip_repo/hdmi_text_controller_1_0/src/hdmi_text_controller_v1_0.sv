//Provided HDMI_Text_controller_v1_0 for HDMI AXI4 IP 
//Fall 2024 Distribution

//Modified 3/10/24 by Zuofu
//Updated 11/18/24 by Zuofu


`timescale 1 ns / 1 ps

module hdmi_text_controller_v1_0 #
(
    // Parameters of Axi Slave Bus Interface S00_AXI
    // Modify parameters as necessary for access of full VRAM range

    parameter integer C_AXI_DATA_WIDTH	= 32,
    parameter integer C_AXI_ADDR_WIDTH	= 16 
)
(
    // Users to add ports here

    output logic hdmi_clk_n,
    output logic hdmi_clk_p,
    output logic [2:0] hdmi_tx_n,
    output logic [2:0] hdmi_tx_p,

    // User ports ends
    // Do not modify the ports beyond this line


    // Ports of Axi Slave Bus Interface AXI
    input logic  axi_aclk,
    input logic  axi_aresetn,
    input logic [C_AXI_ADDR_WIDTH-1 : 0] axi_awaddr,
    input logic [2 : 0] axi_awprot,
    input logic  axi_awvalid,
    output logic  axi_awready,
    input logic [C_AXI_DATA_WIDTH-1 : 0] axi_wdata,
    input logic [(C_AXI_DATA_WIDTH/8)-1 : 0] axi_wstrb,
    input logic  axi_wvalid,
    output logic  axi_wready,
    output logic [1 : 0] axi_bresp,
    output logic  axi_bvalid,
    input logic  axi_bready,
    input logic [C_AXI_ADDR_WIDTH-1 : 0] axi_araddr,
    input logic [2 : 0] axi_arprot,
    input logic  axi_arvalid,
    output logic  axi_arready,
    output logic [C_AXI_DATA_WIDTH-1 : 0] axi_rdata,
    output logic [1 : 0] axi_rresp,
    output logic  axi_rvalid,
    input logic  axi_rready
);

//additional logic variables as necessary to support VGA, and HDMI modules.
logic clk_25MHz, clk_125MHz, locked;
logic reset_ah;
logic hsync, vsync, vde;
logic [9:0] drawX, drawY;
logic [3:0] red, green, blue;

logic [31:0] vram [600];
logic [31:0] color_reg;
logic [31:0] frame_count;

assign reset_ah = ~axi_aresetn;
// Instantiation of Axi Bus Interface AXI
hdmi_text_controller_v1_0_AXI # ( 
    .C_S_AXI_DATA_WIDTH(C_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_AXI_ADDR_WIDTH)
) hdmi_text_controller_v1_0_AXI_inst (
    .frame_count(frame_count),
    .draw_x({22'd0, drawX}),
    .draw_y({22'd0, drawY}),
    .vram(vram),
    .color_reg(color_reg),
    .S_AXI_ACLK(axi_aclk),
    .S_AXI_ARESETN(axi_aresetn),
    .S_AXI_AWADDR(axi_awaddr),
    .S_AXI_AWPROT(axi_awprot),
    .S_AXI_AWVALID(axi_awvalid),
    .S_AXI_AWREADY(axi_awready),
    .S_AXI_WDATA(axi_wdata),
    .S_AXI_WSTRB(axi_wstrb),
    .S_AXI_WVALID(axi_wvalid),
    .S_AXI_WREADY(axi_wready),
    .S_AXI_BRESP(axi_bresp),
    .S_AXI_BVALID(axi_bvalid),
    .S_AXI_BREADY(axi_bready),
    .S_AXI_ARADDR(axi_araddr),
    .S_AXI_ARPROT(axi_arprot),
    .S_AXI_ARVALID(axi_arvalid),
    .S_AXI_ARREADY(axi_arready),
    .S_AXI_RDATA(axi_rdata),
    .S_AXI_RRESP(axi_rresp),
    .S_AXI_RVALID(axi_rvalid),
    .S_AXI_RREADY(axi_rready)
);


//Instiante clocking wizard, VGA sync generator modules, and VGA-HDMI IP here. For a hint, refer to the provided
clk_wiz_0 clk_wiz (
    .clk_out1(clk_25MHz),
    .clk_out2(clk_125MHz),
    .reset(reset_ah),
    .locked(locked),
    .clk_in1(axi_aclk)
);

vga_controller vga (
    .pixel_clk(clk_25MHz),
    .reset(reset_ah),
    .hs(hsync),
    .vs(vsync),
    .active_nblank(vde),
    .sync(),
    .drawX(drawX),
    .drawY(drawY)
);

hdmi_tx_0 vga_to_hdmi (
    .pix_clk(clk_25MHz),
    .pix_clkx5(clk_125MHz),
    .pix_clk_locked(locked),
    .rst(reset_ah),
    .red(red),
    .green(green),
    .blue(blue),
    .hsync(hsync),
    .vsync(vsync),
    .vde(vde),
    .aux0_din(4'b0),
    .aux1_din(4'b0),
    .aux2_din(4'b0),
    .ade(1'b0),
    .TMDS_CLK_P(hdmi_clk_p),
    .TMDS_CLK_N(hdmi_clk_n),
    .TMDS_DATA_P(hdmi_tx_p),
    .TMDS_DATA_N(hdmi_tx_n)
);

logic vsync_prev;
always_ff @(posedge clk_25MHz)
begin
    if (reset_ah) begin
        frame_count <= 32'd0;
        vsync_prev  <= 1'b1;
    end
    else begin
        vsync_prev <= vsync;
        if (vsync_prev && ~vsync)
            frame_count <= frame_count + 1;
    end
end
logic [6:0]  char_col;
logic [4:0]  char_row;
logic [11:0] char_index;
logic [9:0]  word_index;
logic [1:0]  byte_index;
logic [7:0]  char_byte;
logic [10:0] font_addr;
logic [7:0]  font_data;
logic        pixel_on;

assign char_col   = drawX[9:3];
assign char_row   = drawY[8:4];
assign char_index = char_row * 80 + char_col;
assign word_index = char_index[11:2];
assign byte_index = char_index[1:0];

always_comb
begin
    if (word_index < 600)
        char_byte = vram[word_index][byte_index*8 +: 8];
    else
        char_byte = 8'd0;
end

assign font_addr = {char_byte[6:0], drawY[3:0]};

font_rom font (
    .addr(font_addr),
    .data(font_data)
);

assign pixel_on = font_data[7 - drawX[2:0]] ^ char_byte[7];

always_comb
begin
    if (~vde) begin
        red = 4'h0; green = 4'h0; blue = 4'h0;
    end
    else if (pixel_on) begin
        red   = color_reg[27:24];
        green = color_reg[23:20];
        blue  = color_reg[19:16];
    end
    else begin
        red   = color_reg[11:8];
        green = color_reg[7:4];
        blue  = color_reg[3:0];
    end
end


//top-level from the previous lab. You should get the IP to generate a valid HDMI signal (e.g. blue screen or gradient)
//prior to working on the text drawing.

// User logic ends

endmodule
