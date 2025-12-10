module top(
		
		//////////// ADC //////////
	//output		          		ADC_CONVST,
	//output		          		ADC_DIN,
	//input 		          		ADC_DOUT,
	//output		          		ADC_SCLK,

	//////////// Audio //////////
	//input 		          		AUD_ADCDAT,
	//inout 		          		AUD_ADCLRCK,
	//inout 		          		AUD_BCLK,
	//output		          		AUD_DACDAT,
	//inout 		          		AUD_DACLRCK,
	//output		          		AUD_XCK,

	//////////// CLOCK //////////
	//input 		          		CLOCK2_50,
	//input 		          		CLOCK3_50,
	//input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	//output		    [12:0]		DRAM_ADDR,
	//output		     [1:0]		DRAM_BA,
	//output		          		DRAM_CAS_N,
	//output		          		DRAM_CKE,
	//output		          		DRAM_CLK,
	//output		          		DRAM_CS_N,
	//inout 		    [15:0]		DRAM_DQ,
	//output		          		DRAM_LDQM,
	//output		          		DRAM_RAS_N,
	//output		          		DRAM_UDQM,
	//output		          		DRAM_WE_N,

	//////////// I2C for Audio and Video-In //////////
	//output		          		FPGA_I2C_SCLK,
	//inout 		          		FPGA_I2C_SDAT,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// IR //////////
	//input 		          		IRDA_RXD,
	//output		          		IRDA_TXD,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// PS2 //////////
	//inout 		          		PS2_CLK,
	//inout 		          		PS2_CLK2,
	//inout 		          		PS2_DAT,
	//inout 		          		PS2_DAT2,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// Video-In //////////
	//input 		          		TD_CLK27,
	//input 		     [7:0]		TD_DATA,
	//input 		          		TD_HS,
	//output		          		TD_RESET_N,
	//input 		          		TD_VS,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	//inout 		    [35:0]		GPIO_0,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	//inout 		    [35:0]		GPIO_1
);

assign HEX0 = 7'h00;
assign HEX1 = 7'h00;
assign HEX2 = 7'h00;
assign HEX3 = 7'h00;

assign LEDR9 = 1'b1;

wire clk;
wire rst;

assign clk = CLOCK_50;
assign rst = SW[0];

assign LEDR[0] = video_on;

wire video_on;
wire frame_done;

wire[9:0] x_coord;
wire[9:0] y_coord;

vga vga_insta(.clk(clk),
				  .rst(rst),
				  .vga_clk(VGA_CLK),
				  .hsync(VGA_HS),
				  .vsync(VGA_VS),
				  .xPixel(x_coord),
				  .yPixel(y_coord),
				//.frame_done(frame_done),
				  .active_pixels(video_on),
				  .VGA_BLANK_N(VGA_BLANK_N),
				  .VGA_SYNC_N(VGA_SYNC_N)
				  );

wire [2:0] S;
wire [2:0] NS;

assign S = SW[3:1];
//wire [7:0] r_r;
//wire [7:0] r_r;
//wire [7:0] b_b;

wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;

assign VGA_R = red;
assign VGA_G = green;
assign VGA_B = blue;
 //Temporarily:
//assign VGA_R = 8'hFF;
//assign VGA_G = 8'h00;
//assign VGA_B = 8'h00;

wire btn_held;
wire btn_press;

assign LEDR[9] = btn_held;
assign LEDR[8] = btn_press;

assign LEDR[1] = VGA_HS;
assign LEDR[2] = VGA_VS;

background game_backgr(.clk(CLK_VGA),.rst(rst),.video_on(video_on),.y_coord(y_coord),.x_coord(x_coord),.red(red),.green(green),.blue(blue),.S(S));

//button key_1 (.clk(CLK_VGA),.rst(rst),.btn_raw(KEY[1]),.btn_down(btn_held),.btn_rise(btn_press));
//pixel_gen pix_gen_insta(.video_on(video_on),.x_coord(x_coord),.y_coord(y_coord),.state(state),.red(r_r),.green(g_g),.blue(b_b));
			
//always @(posedge clk or negedge rst)
	//begin
		//if(rst == 1'b0)
		//begin
				//red <= 8'hFF;
				//green <= 8'hFF;
				//blue <= 8'hFF;
		//end
		//else
		//begin
				//if (video_on == 1'b0)
				//begin
					//red <= 8'hFF;
					//green <= 8'h00;
					//blue <= 8'h00;
				//end
				//else if (video_on == 1'b1)
				//begin
					//red <= 8'h00;
					//green <= 8'hFF;
					//blue <= 8'h00;
				//end
		//end
//end


endmodule