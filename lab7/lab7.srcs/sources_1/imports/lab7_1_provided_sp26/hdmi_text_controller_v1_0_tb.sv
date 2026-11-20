//HDMI Text Controller Example Testbench for ECE 385
//Spring 2026 Distribution

//Modified 3/29/26 by Zuofu
//
//Based on Realdigital documentation on simulating AXI Bus
//as well as BMP writing code from @BrianHGinc
//
//Used for simulation of AXI4-Lite bus as well as generating
//simulation video image for testing

`define SIM_VIDEO //Comment out to simulate AXI bus only
                    //Uncomment to simulate entire screen and write BMP (slow)

module hdmi_text_controller_tb();

	//clock and reset_n signals
	logic aclk =1'b0;
	logic arstn = 1'b0;
	
	//Write Address channel (AW)
	logic [31:0] write_addr =32'd0;	//Master write address
	logic [2:0] write_prot = 3'd0;	//type of write(leave at 0)
	logic write_addr_valid = 1'b0;	//master indicating address is valid
	logic write_addr_ready;		    //slave ready to receive address

	//Write Data Channel (W)
	logic [31:0] write_data = 32'd0;	//Master write data
	logic [3:0] write_strb = 4'd0;	    //Master byte-wise write strobe
	logic write_data_valid = 1'b0;	    //Master indicating write data is valid
	logic write_data_ready;		        //slave ready to receive data

	//Write Response Channel (WR)
	logic write_resp_ready = 1'b0;	//Master ready to receive write response
	logic [1:0] write_resp;		    //slave write response
	logic write_resp_valid;		    //slave response valid
	
	//Read Address channel (AR)
	logic [31:0] read_addr = 32'd0;	//Master read address
	logic [2:0] read_prot =3'd0;	//type of read(leave at 0)
	logic read_addr_valid = 1'b0;	//Master indicating address is valid
	logic read_addr_ready;		    //slave ready to receive address

	//Read Data Channel (R)
	logic read_data_ready = 1'b0;	//Master indicating ready to receive data
	logic [31:0] read_data;		    //slave read data
	logic [1:0] read_resp;		    //slave read response
	logic read_data_valid;		    //slave indicating data in channel is valid

    //Although we can look at the HDMI signal, it is not particularly useful for debugging
    //Instead, simulate and record the pixel clock and the pixel RGB values to generate
    //a simulated image
    logic [3:0] pixel_rgb [3];
    logic pixel_clk, pixel_hs, pixel_vs, pixel_vde;
    logic [9:0] drawX, drawY;
    logic [31:0] tb_read;
    logic [31:0] expected_vram [0:1199];
    string display_text;

    localparam integer VRAM_WORDS = 1200; // 2400 character cells, two per 32-bit word
    localparam logic [31:0] PALETTE_BASE = 32'h0000_2000; // AXI word indices 0x800-0x807
    
    //BMP writer related signals    
    localparam BMP_WIDTH  = 800;
    localparam BMP_HEIGHT = 525;
    logic [23:0] bitmap [BMP_WIDTH][BMP_HEIGHT];

    integer i,j; //use integers for loop indices, etc

	//Instantiation of DUT (HDMI TEXT_CONTROLLER) IP
	hdmi_text_controller_v1_0 # (
		.C_AXI_DATA_WIDTH(32),
		.C_AXI_ADDR_WIDTH(16)
	) hdmi_text_controller_v1_0_inst (

		.axi_aclk(aclk),
		.axi_aresetn(arstn),

		.axi_awaddr(write_addr),
		.axi_awprot(write_prot),
		.axi_awvalid(write_addr_valid),
		.axi_awready(write_addr_ready),

		.axi_wdata(write_data),
		.axi_wstrb(write_strb),
		.axi_wvalid(write_data_valid),
		.axi_wready(write_data_ready),

		.axi_bresp(write_resp),
		.axi_bvalid(write_resp_valid),
		.axi_bready(write_resp_ready),

		.axi_araddr(read_addr),
		.axi_arprot(read_prot),
		.axi_arvalid(read_addr_valid),
		.axi_arready(read_addr_ready),

		.axi_rdata(read_data),
		.axi_rresp(read_resp),
		.axi_rvalid(read_data_valid),
		.axi_rready(read_data_ready)
	);
	
	initial begin: CLOCK_INITIALIZATION
	   aclk = 1'b1;
    end 
       
    always begin : CLOCK_GENERATION
        #5 aclk = ~aclk;
    end

    // Tap the internal pixel signals. Use the delayed RGB/timing/coordinates so
    // each captured color is stored at the matching screen location.
    assign pixel_rgb[0] = hdmi_text_controller_v1_0_inst.red;
    assign pixel_rgb[1] = hdmi_text_controller_v1_0_inst.green;
    assign pixel_rgb[2] = hdmi_text_controller_v1_0_inst.blue;
    assign pixel_clk    = hdmi_text_controller_v1_0_inst.clk_25MHz;
    assign pixel_hs     = hdmi_text_controller_v1_0_inst.hsync_d;
    assign pixel_vs     = hdmi_text_controller_v1_0_inst.vsync_d;
    assign pixel_vde    = hdmi_text_controller_v1_0_inst.vde_d;
    assign drawX        = hdmi_text_controller_v1_0_inst.drawX_d;
    assign drawY        = hdmi_text_controller_v1_0_inst.drawY_d;

    // Week 2 VRAM cell format: {inverse, 7-bit ASCII, 4-bit foreground
    // palette index, 4-bit background palette index}.
    function automatic logic [15:0] make_cell(
        input logic [7:0] character,
        input logic [3:0] foreground,
        input logic [3:0] background
    );
        make_cell = {1'b0, character[6:0], foreground, background};
    endfunction

    // Palette indices 6 and 7 are blue and orange. The remaining message
    // characters use white; index 0 is the black background.
    function automatic logic [3:0] foreground_for_position(input integer position);
        if ((position < 6) || ((position >= 11) && (position < 18)))
            foreground_for_position = 4'd6;
        else if (position >= 29)
            foreground_for_position = 4'd7;
        else
            foreground_for_position = 4'd1;
    endfunction


   
    // BMP writing task, based off work from @BrianHGinc:
    // https://github.com/BrianHGinc/SystemVerilog-TestBench-BPM-picture-generator
    task save_bmp(string bmp_file_name);
        begin
        
            integer unsigned        fout_bmp_pointer, BMP_file_size,BMP_row_size,r;
            logic   unsigned [31:0] BMP_header[0:12];
        
                                      BMP_row_size  = 32'(BMP_WIDTH) & 32'hFFFC;  // When saving a bitmap, the row size/width must be
        if ((BMP_WIDTH & 32'd3) !=0)  BMP_row_size  = BMP_row_size + 4;           // padded to chunks of 4 bytes.
        BMP_file_size = 54 + (BMP_row_size * BMP_HEIGHT * 3);
    
        fout_bmp_pointer= $fopen(bmp_file_name,"wb");
        if (fout_bmp_pointer==0) begin
            $display("Could not open file '%s' for writing",bmp_file_name);
            $stop;     
        end
        $display("Saving bitmap '%s'.",bmp_file_name);
       
        BMP_header[0:12] = '{BMP_file_size,0,0054,40,BMP_WIDTH,BMP_HEIGHT,{16'd24,16'd8},0,(BMP_row_size*BMP_HEIGHT*3),2835,2835,0,0};
        
        //Write header out      
        $fwrite(fout_bmp_pointer,"BM");
        for (int i =0 ; i <13 ; i++ ) $fwrite(fout_bmp_pointer,"%c%c%c%c",BMP_header[i][7 -:8],BMP_header[i][15 -:8],BMP_header[i][23 -:8],BMP_header[i][31 -:8]); // Better compatibility with Lattice Active_HDL.
        
        //Write image out (note that image is flipped in Y)
        for (int y=BMP_HEIGHT-1;y>=0;y--) begin
          for (int x=0;x<BMP_WIDTH;x++)
            $fwrite(fout_bmp_pointer,"%c%c%c",bitmap[x][y][23:16],bitmap[x][y][15:8],bitmap[x][y][7:0]) ;
        end
    
        $fclose(fout_bmp_pointer);
        end
    endtask
    
    // Always procedure to log RGB values into array to generate image
    always@(posedge pixel_clk)
        if (!arstn) begin
            for (j = 0; j < BMP_HEIGHT; j++)    //assign bitmap default to some light gray so we 
                for (i = 0; i < BMP_WIDTH; i++) //can tell the difference between drawn black
                    bitmap[i][j] <= 24'h0F0F0F; //and default color
        end
        else
            if (pixel_vde) //Only draw when not in the blanking interval, BMP24 is BGR format
                bitmap[drawX][drawY] <= {pixel_rgb[2], 4'h0, pixel_rgb[1], 4'h0, pixel_rgb[0], 4'h00};

    // Provided AXI write task, follow this example for AXI read below
    task axi_write (input logic [31:0] addr, input logic [31:0] data);
        begin
            #3 write_addr <= addr;	//Put write address on bus
            write_data <= data;	//put write data on bus
            write_addr_valid <= 1'b1;	//indicate address is valid
            write_data_valid <= 1'b1;	//indicate data is valid
            write_resp_ready <= 1'b1;	//indicate ready for a response
            write_strb <= 4'hF;		//writing all 4 bytes
    
            //wait for one slave ready signal or the other
            wait(write_data_ready || write_addr_ready);
                
            @(posedge aclk); //one or both signals and a positive edge
            if(write_data_ready&&write_addr_ready)//received both ready signals
            begin
                write_addr_valid<=0;
                write_data_valid<=0;
            end
            else    //wait for the other signal and a positive edge
            begin
                if(write_data_ready)    //case data handshake completed
                begin
                    write_data_valid<=0;
                    wait(write_addr_ready); //wait for address address ready
                end
                        else if(write_addr_ready)   //case address handshake completed
                        begin
                    write_addr_valid<=0;
                            wait(write_data_ready); //wait for data ready
                        end 
                @ (posedge aclk);// complete the second handshake
                write_addr_valid<=0; //make sure both valid signals are deasserted
                write_data_valid<=0;
            end
                
            //both handshakes have occured
            //deassert strobe
            write_strb<=0;
    
            //wait for valid response
            wait(write_resp_valid);
            
            //both handshake signals and rising edge
            @(posedge aclk);
    
            //deassert ready for response
            write_resp_ready<=0;
    
            //end of write transaction
        end
    endtask;

    task write_week2_text;
        logic [15:0] cell0, cell1;
        integer word_index;
        integer char0_position, char1_position;
        begin
            for (word_index = 0; word_index < VRAM_WORDS; word_index = word_index + 1) begin
                char0_position = 2 * word_index;
                char1_position = char0_position + 1;
                cell0 = make_cell(8'h20, 4'd1, 4'd0);
                cell1 = make_cell(8'h20, 4'd1, 4'd0);
                if (char0_position < display_text.len())
                    cell0 = make_cell(display_text[char0_position],
                                      foreground_for_position(char0_position), 4'd0);
                if (char1_position < display_text.len())
                    cell1 = make_cell(display_text[char1_position],
                                      foreground_for_position(char1_position), 4'd0);
                expected_vram[word_index] = {cell1, cell0};
                axi_write(4 * word_index, expected_vram[word_index]);
            end
        end
    endtask
    
    // AXI read task for the registered BRAM read path, similar to the provided example
    //of the AXI write above, follow the waveforms provided into the I.AMM manual
    //Note the read handshake process is simpler than the write
    task axi_read (input logic [31:0] addr, output logic [31:0] data);
        begin
            read_addr <= addr;
            read_addr_valid <= 1'b1;
            read_data_ready <= 1'b1;

            wait (read_addr_ready);
            @(posedge aclk);
            read_addr_valid <= 1'b0;

            wait (read_data_valid);
            data = read_data;
            @(posedge aclk);
            read_data_ready <= 1'b0;
        end
    endtask;
  
  
    // Initial block for Week 2 test vectors begins below
    initial begin: TEST_VECTORS
        arstn = 1'b0;
        repeat (4) @(posedge aclk);
        arstn <= 1'b1;

        // Two netids, blue (palette index 6), and the course label in orange
        // (palette index 7). Extra ! makes the string even-length for 32-bit writes.
        display_text = "amogk2 and sanjit3 completed ECE 385!!";
        if (display_text.len() != 38)
            $fatal(1, "Expected 38 characters, got %0d", display_text.len());

        // Each palette register stores two 12-bit RGB values:
        // even index in bits [11:0], odd index in bits [27:16].
        for (integer p = 0; p < 8; p = p + 1)
            axi_write(PALETTE_BASE + 4 * p, 32'd0);
        axi_write(PALETTE_BASE + 4 * 0, 32'h0FFF_0000); // index 0 black, index 1 white
        axi_write(PALETTE_BASE + 4 * 3, 32'h0E94_036B); // index 6 blue, index 7 orange

        // Initialize all 2400 character cells, including the unused screen area.
        write_week2_text();

        // Verify BRAM-backed VRAM readback through AXI.
        for (integer k = 0; k < VRAM_WORDS; k = k + 1) begin
            axi_read(4 * k, tb_read);
            assert (tb_read == expected_vram[k])
                else $error("VRAM mismatch at word %0d. Expected %08x, got %08x",
                            k, expected_vram[k], tb_read);
        end

        // Verify the two palette registers used by this image.
        axi_read(PALETTE_BASE, tb_read);
        assert (tb_read == 32'h0FFF_0000)
            else $error("Palette register 0 mismatch: %08x", tb_read);
        axi_read(PALETTE_BASE + 4 * 3, tb_read);
        assert (tb_read == 32'h0E94_036B)
            else $error("Palette register 3 mismatch: %08x", tb_read);

        `ifdef SIM_VIDEO
        // Let one complete frame pass after the writes, then save the captured image.
        @(negedge pixel_vs);
        @(negedge pixel_vs);
        save_bmp("lab7_2_sim.bmp");
        `endif
        $finish();
	end
    
endmodule	

	