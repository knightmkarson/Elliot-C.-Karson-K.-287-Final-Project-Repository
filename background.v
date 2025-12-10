module background(
	input clk,
	input rst,
	input video_on,
	input [9:0] y_coord,
	input [9:0] x_coord,
	output reg [7:0] red,
	output reg [7:0] green,
	output reg [7:0] blue,
	output reg [23:0] bkg_rgb,
	input [2:0] S

);



parameter 
			GAME_MENU = 3'b000,
			GAME_ON = 3'b001,
			GAME_LOSE = 3'b010,
			GAME_WIN = 3'b011;

always @(*)
begin
	if (video_on == 1'b0) begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'h00;
	end
	else
		case(S)
			GAME_MENU:
			begin
				red = 8'h00;
				green = 8'h00;
				blue = 8'hFF;
				bkg_rgb = 24'h0000FF;
			end
			
			GAME_ON:
				begin
					if(y_coord > 415) begin
						red = 8'hFF;
						green = 8'h00;
						blue = 8'h00;
						bkg_rgb = 24'hFF0000;
					end else begin
						if (y_coord <= 85) begin
							red = 8'h00;
							green = 8'h00;
							blue = 8'hFF;
							bkg_rgb = 24'h0000FF;
						end else begin
							red = 8'h00;
							green = 8'h00;
							blue = 8'h00;
							bkg_rgb = 24'h000000
						end
					end
				end
			
			GAME_LOSE:
				begin
				if ((((x_coord > 104) && (x_coord <= 120)) && ((y_coord > 124) && (y_coord <= 160))) || (((x_coord > 140) && (x_coord <= 155)) && ((y_coord > 124) && (y_coord <= 160)))||
					(((x_coord > 104) && (x_coord <= 155)) && ((y_coord > 149) && (y_coord <= 160))) || (((x_coord > 121) && (x_coord <= 137)) && ((y_coord > 159) && (y_coord <= 185)))|| // Y
					
					(((x_coord > 164) && (x_coord <= 215)) && ((y_coord > 175) && (y_coord <= 185))) || (((x_coord > 164) && (x_coord <= 215)) && ((y_coord > 124) && (y_coord <= 135)))||
					(((x_coord > 164) && (x_coord <= 175)) && ((y_coord > 124) && (y_coord <= 185))) || (((x_coord > 204) && (x_coord <= 215)) && ((y_coord > 124) && (y_coord <= 185)))|| // O
					
					(((x_coord > 224) && (x_coord <= 235)) && ((y_coord > 124) && (y_coord <= 185))) || (((x_coord > 264) && (x_coord <= 275)) && ((y_coord > 124) && (y_coord <= 185)))||
					(((x_coord > 224) && (x_coord <= 275)) && ((y_coord > 174) && (y_coord <= 185)))|| // U
					
					(((x_coord > 304) && (x_coord <= 315)) && ((y_coord > 124) && (y_coord <= 185))) || (((x_coord > 304) && (x_coord <= 335)) && ((y_coord > 124) && (y_coord <= 135)))||
					(((x_coord > 304) && (x_coord <= 335)) && ((y_coord > 174) && (y_coord <= 185))) || (((x_coord > 344) && (x_coord <= 355)) && ((y_coord > 144) && (y_coord <= 165)))|| 
					(((x_coord > 334) && (x_coord <= 345)) && ((y_coord > 164) && (y_coord <= 175))) || (((x_coord > 334) && (x_coord <= 345)) && ((y_coord > 134) && (y_coord <= 145)))|| // D
					
					(((x_coord > 369) && (x_coord <= 380)) && ((y_coord > 124) && (y_coord <= 185)))||	// I
					
					(((x_coord > 389) && (x_coord <= 440)) && ((y_coord > 124) && (y_coord <= 135))) || (((x_coord > 389) && (x_coord <= 400)) && ((y_coord > 124) && (y_coord <= 185)))||
					(((x_coord > 389) && (x_coord <= 440)) && ((y_coord > 174) && (y_coord <= 185))) || (((x_coord > 389) && (x_coord <= 415)) && ((y_coord > 150) && (y_coord <= 160)))|| // E
					
					(((x_coord > 449) && (x_coord <= 460)) && ((y_coord > 124) && (y_coord <= 185))) || (((x_coord > 449) && (x_coord <= 480)) && ((y_coord > 124) && (y_coord <= 135)))||
					(((x_coord > 449) && (x_coord <= 480)) && ((y_coord > 174) && (y_coord <= 185))) || (((x_coord > 489) && (x_coord <= 500)) && ((y_coord > 144) && (y_coord <= 165)))||
					(((x_coord > 479) && (x_coord <= 490)) && ((y_coord > 164) && (y_coord <= 175))) || (((x_coord > 479) && (x_coord <= 490)) && ((y_coord > 134) && (y_coord <= 145))))  // D
					begin
						red = 8'hFF;
						green = 8'hFF;
						blue = 8'hFF;
					end else begin
							red = 8'hFF;
							green = 8'h00;
							blue = 8'h00;
							bkg_rgb = 24'hFF0000;
						end
				end
			
			GAME_WIN:
				begin
					red = 8'hFF;
					green = 8'hEC;
					blue = 8'h00;
					bkg_rgb = 24'hFFEC00;
				end
				
		endcase
end
			//begin
				//red = 8'hFF;
				//green = 8'hB3;
				//blue = 8'h00;
				
		
		//end else
			//begin
				//red = 8'h00;
				//green = 8'h00;
				//blue = 8'h00;
				
	// 131,121 - 142,121 - 166,121 - 177,121   155,146   148,159 - 161,159    148,181 - 161,159
		//end
	//end
//end

endmodule