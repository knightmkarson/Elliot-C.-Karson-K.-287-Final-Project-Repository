module pixel_gen(
	input video_on,
	input [9:0] x_coord, // h_count as well
	input [9:0] y_coord, // v_count 
	input [1:0] state,
	output reg [7:0] red,
	output reg [7:0] green,
	output reg [7:0] blue
	);
	
	parameter
			GAME_MENU = 2'b00,
			GAME_ON = 2'b01,
			GAME_OVER = 2'b11;
			
	
	always @(*) begin
		if (!video_on) begin // if the video is not considered on, output white to check whether it works or not still
			red = 8'hF;
			green = 8'hF;
			blue = 8'hF;
		end
		
		else begin
		
			case(state)
			
						GAME_MENU: begin
							red = 8'h0;			// blue background
							green = 8'h0;
							blue = 8'hF;
							
								if (((x_coord > 160) && (x_coord < 480)) && 		//white box in the middle-ish
								((y_coord > 120) && (y_coord < 360))) begin
									red = 8'hF;
									green = 8'h0;
									blue = 8'h0;
								end
							end
							
						GAME_ON: begin
							red = 8'h0; // green background
							green = 8'hF;
							blue = 8'h0;
							
							if ((x_coord > 80) && (x_coord < 560)) begin //black strip in the middle of the screen
									red = 8'h0;
									green = 8'h0;
									blue = 8'h0;
								end
							end
			
						GAME_OVER: begin // red screen
							red = 8'hF;
							green = 8'h0;
							blue = 8'h0;
							end
							
						default: begin
							red = 8'h1;
							green = 8'h1;
							blue = 8'h1;
							end
					endcase
			end
		end
endmodule
		
		