module alberto(
	input clk,
	input rst,
	input frame_tick,
	input [9:0] x_coord,
	input [9:0] y_coord,
	input move_left,
	input move_right,
	input jump,
	input [2:0] S,
	output reg [9:0] char_x,
	output reg [9:0] char_y,
	output reg in_char,
	output reg on_platform,
	output reg in_lava
	//output reg [7:0] red,
	//output reg [7:0] green,
	//output reg [7:0] blue
	//output reg [23:0] bkg_rgb
	);

parameter 
			GAME_MENU = 3'b000,
			GAME_ON = 3'b001,
			GAME_LOSE = 3'b010,
			GAME_WIN = 3'b011;

			
parameter
			CHAR_HEIGHT = 6,
			CHAR_WIDTH = 6,
			SPEED = 2,
			JUMP_HEIGHT = -8,
			GRAVITY = 1,
			WIDTH = 640,
			HEIGHT = 480,
			START_Y = 419,
			START_X = 100;
			
reg [9:0] vel_y;
reg is_jump;
reg [9:0] jump_time;

parameter PLATFORM_COUNT = 3;
wire [9:0] platf_x_start [0:PLATFORM_COUNT - 1];
wire [9:0] platf_x_end [0:PLATFORM_COUNT - 1];
wire [9:0] platf_y [0:PLATFORM_COUNT - 1];

assign platf_x_start[0] = 50;
assign platf_x_end[0] = 200;
assign platf_y[0] = 425;

assign platf_x_start[1] = 250;
assign platf_x_end[1] = 350;
assign platf_y[1] = 375;

assign platf_x_start[2] = 400;
assign platf_x_end[2] = 550;
assign platf_y[0] = 425;

parameter LAVA_LVL = 440;			

integer i;
			
always @(posedge clk or negedge rst)
	if (rst == 1'b0) begin
		char_x <= START_X;
		char_y <= START_Y;
		vel_y <= 0;
		is_jump <= 0;
		jump_time<= 0;
	end else begin
			if (frame_tick) begin
				if(~move_left && char_x > 0)	char_x <= char_x - SPEED;
				else if(~move_right && char_x + CHAR_WIDTH < WIDTH + 1)	char_x <= char_x + SPEED;

				//if(move_left == 1'b0) begin // A KEY is active low
					//if(char_x > 0) begin
					//	char_x <= 0;
					//end else begin
						//char_x <= char_x - SPEED;
					//end
				
				//end else if (move_right == 1'b0) begin	// A KEY is active low
					//if (char_x <= (WIDTH - CHAR_WIDTH)) begin
						//char_x <= CHAR_WIDTH;
					//end else begin
						//char_x <= char_x + SPEED;
					//end
				//end
				
				if (jump == 1'b0) begin
					if (is_jump == 1'b0) begin
						if (on_platform == 1'b1) begin
							is_jump <= 1;
							vel_y <= JUMP_HEIGHT;
							jump_time <= 0;
						end
					end
				end
				
				if (is_jump == 1'b1) begin
					char_y <= char_y + JUMP_HEIGHT;
					vel_y <= vel_y + GRAVITY;
					jump_time <= jump_time + 1;
						
						if ((char_y <= 0) || (jump_time > 30)) begin
							is_jump <= 0;
							vel_y <= 0;
						end
				
				
				on_platform <= 0;
				for (i = 0; i < PLATFORM_COUNT; i = i + 1) begin
					if (((char_x + CHAR_WIDTH) > platf_x_start[i]) && (char_x < platf_x_end[i]) && ((char_y + CHAR_HEIGHT) >= (platf_y[i] - 1)) 
						&& ((char_y + CHAR_HEIGHT) <= (platf_y[i] + 5)) && (vel_y >= 0)) begin
							char_y <= (platf_y[i] - CHAR_HEIGHT);
							is_jump <= 0;
							vel_y <= 0;
							on_platform <= 1;
					end
				end
				
				//in_char <= (((x_coord >= char_x) && 
								//(x_coord < char_x + CHAR_WIDTH)) && 
								//((y_coord < char_y + CHAR_HEIGHT) && 
								//(y_coord >= char_y)));
				
			 end
	end
end


	
always @(*)
	begin
		case(S)
			
			GAME_MENU:
				begin
				 in_char = 0;
				end
			
			GAME_ON:
				begin
					in_char = (((x_coord >= char_x) && 
								(x_coord < char_x + CHAR_WIDTH)) && 
								((y_coord < char_y + CHAR_HEIGHT) && 
								(y_coord >= char_y)));
				end
			
			GAME_LOSE:
				begin
				 in_char = 0;
				end
				
			GAME_WIN:
				begin
				 in_char = 0;
				end
		endcase
end 

endmodule

