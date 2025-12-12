module background(
	input clk,
	input rst,
	input video_on,
	input [9:0] y_coord,
	input [9:0] x_coord,
	output reg [7:0] red,
	output reg [7:0] green,
	output reg [7:0] blue,
	//output reg [23:0] bkg_rgb,
	input [2:0] S,
	input in_char,
	input [9:0] char_x,
	input [9:0] char_y
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
			
parameter 
			LAVA_LVL = 440,
			PLATFORM1_X_START = 50,
			PLATFORM1_X_END = 200,
			PLATFORM1_Y = 425,
			
			PLATFORM2_X_START = 250,
			PLATFORM2_X_END = 350,
			PLATFORM2_Y = 375,
			
			PLATFORM3_X_START = 400,
			PLATFORM3_X_END = 550,
			PLATFORM3_Y = 425;
			
parameter SKY_BLUE = 24'h87CEEB;

always @(*)
begin
	if (video_on == 1'b0) begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'h00;
		//bkg_rgb = 24'h000000;
	end
		case(S)
			GAME_MENU:
				begin
					if ((((x_coord > 249) && (x_coord <= 255)) && ((y_coord > 124) && (y_coord <= 175)))||(((x_coord > 254) && (x_coord <= 265)) && ((y_coord > 124) && (y_coord <= 130)))||
						(((x_coord > 254) && (x_coord <= 265)) && ((y_coord > 144) && (y_coord <= 150)))||(((x_coord > 264) && (x_coord <= 270)) && ((y_coord > 129) && (y_coord <= 145)))||
						(((x_coord > 254) && (x_coord <= 258)) && ((y_coord > 149) && (y_coord <= 155)))||(((x_coord > 257) && (x_coord <= 261)) && ((y_coord > 154) && (y_coord <= 160)))||
						(((x_coord > 260) && (x_coord <= 264)) && ((y_coord > 159) && (y_coord <= 165)))||(((x_coord > 263) && (x_coord <= 267)) && ((y_coord > 164) && (y_coord <= 170)))||
						(((x_coord > 266) && (x_coord <= 270)) && ((y_coord > 169) && (y_coord <= 175)))|| // R
						
						(((x_coord > 274) && (x_coord <= 280)) && ((y_coord > 124) && (y_coord <= 175)))||(((x_coord > 289) && (x_coord <= 295)) && ((y_coord > 124) && (y_coord <= 175)))||
						(((x_coord > 274) && (x_coord <= 290)) && ((y_coord > 169) && (y_coord <= 175)))|| // U
						
						(((x_coord > 299) && (x_coord <= 305)) && ((y_coord > 129) && (y_coord <= 144)))||(((x_coord > 304) && (x_coord <= 320)) && ((y_coord > 124) && (y_coord <= 130)))||
						(((x_coord > 305) && (x_coord <= 315)) && ((y_coord > 143) && (y_coord <= 149)))||(((x_coord > 314) && (x_coord <= 320)) && ((y_coord > 148) && (y_coord <= 170)))||
						(((x_coord > 299) && (x_coord <= 315)) && ((y_coord > 170) && (y_coord <= 175)))|| // S
						
						(((x_coord > 324) && (x_coord <= 330)) && ((y_coord > 124) && (y_coord <= 175)))||(((x_coord > 339) && (x_coord <= 345)) && ((y_coord > 124) && (y_coord <= 175)))
						||(((x_coord > 329) && (x_coord <= 340)) && ((y_coord > 144) && (y_coord <= 150)))|| //H
						
						(((x_coord > 349) && (x_coord <= 355)) && ((y_coord > 124) && (y_coord <= 175)))||(((x_coord > 364) && (x_coord <= 370)) && ((y_coord > 124) && (y_coord <= 175)))
						||(((x_coord > 354) && (x_coord <= 365)) && ((y_coord > 144) && (y_coord <= 150)))|| //H
					
						(((x_coord > 374) && (x_coord <= 395)) && ((y_coord > 169) && (y_coord <= 175))) || (((x_coord > 374) && (x_coord <= 395)) && ((y_coord > 124) && (y_coord <= 130)))||
						(((x_coord > 389) && (x_coord <= 395)) && ((y_coord > 124) && (y_coord <= 175))) || (((x_coord > 374) && (x_coord <= 380)) && ((y_coord > 124) && (y_coord <= 175)))|| // O
						
						(((x_coord > 399) && (x_coord <= 405)) && ((y_coord > 124) && (y_coord <= 175)))||(((x_coord > 414) && (x_coord <= 420)) && ((y_coord > 124) && (y_coord <= 175)))||
						(((x_coord > 404) && (x_coord <= 415)) && ((y_coord > 169) && (y_coord <= 175)))|| // U
						
						(((x_coord > 424) && (x_coord <= 430)) && ((y_coord > 124) && (y_coord <= 175)))||(((x_coord > 429) && (x_coord <= 440)) && ((y_coord > 124) && (y_coord <= 130)))||
						(((x_coord > 429) && (x_coord <= 440)) && ((y_coord > 144) && (y_coord <= 150)))||(((x_coord > 439) && (x_coord <= 445)) && ((y_coord > 129) && (y_coord <= 145)))||
						(((x_coord > 429) && (x_coord <= 433)) && ((y_coord > 149) && (y_coord <= 155)))||(((x_coord > 432) && (x_coord <= 436)) && ((y_coord > 154) && (y_coord <= 160)))||
						(((x_coord > 435) && (x_coord <= 439)) && ((y_coord > 159) && (y_coord <= 165)))||(((x_coord > 438) && (x_coord <= 442)) && ((y_coord > 164) && (y_coord <= 170)))||
						(((x_coord > 441) && (x_coord <= 445)) && ((y_coord > 169) && (y_coord <= 175))) // R
						
						)begin
        
						red = 8'hFF;
						green = 8'hFF;
						blue = 8'hFF;
					end else begin
						// Menu background
						red = 8'h00;
						green = 8'h00;
						blue = 8'hFF;
					end
				end
					//red = 8'h00;
					//green = 8'h00;
					//blue = 8'hFF;
					//bkg_rgb = 24'h0000FF;
				//end
			
			GAME_ON: 
			begin
					if (in_char == 1'b1) begin
						//if (((x_coord < char_x)&&
							//(x_coord >= char_x + WIDTH))&&
							//((y_coord >= char_y + HEIGHT)&&
							//(y_coord < char_y))) begin
						red = 8'hFF;
						green = 8'h00;
						blue = 8'h00;
					end //else begin
					
					else if(y_coord >= LAVA_LVL) begin		
								if((x_coord[5:3] ^ y_coord[5:3]) % 2 == 0) begin
									red = 8'hFF;
									green = 8'h69;
									blue = 8'h00;
									//bkg_rgb = 24'hFF0000;
								end else begin
									red = 8'hFF;
									green = 8'h45;
									blue = 8'h00;
									//bkg_rgb = 24'h0000FF;
								end
							end
							
							else if ((y_coord >= PLATFORM1_Y && (y_coord < PLATFORM1_Y + 10)) && (x_coord >= PLATFORM1_X_START && x_coord < PLATFORM1_X_END)) begin
										red = 8'h8B;
										green = 8'h45;
										blue = 8'h13;
										//bkg_rgb = 24'h000000;
									end
									
							else if ((y_coord >= PLATFORM2_Y && (y_coord < PLATFORM2_Y + 10)) && (x_coord >= PLATFORM2_X_START && x_coord < PLATFORM2_X_END)) begin
										red = 8'h8B;
										green = 8'h45;
										blue = 8'h13;
									end
									
							else if ((y_coord >= PLATFORM3_Y && (y_coord < PLATFORM3_Y + 10)) && (x_coord >= PLATFORM3_X_START && x_coord < PLATFORM3_X_END)) begin
										red = 8'h8B;
										green = 8'h45;
										blue = 8'h13;
									end
							else begin
								red = 8'h87;
								green = 8'hCE;
								blue = 8'hEB;
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
							//bkg_rgb = 24'hFFFF00;
						end
				end
			
			GAME_WIN:
				begin
					if ((((x_coord > 104) && (x_coord <= 120)) && ((y_coord > 124) && (y_coord <= 160))) || (((x_coord > 140) && (x_coord <= 155)) && ((y_coord > 124) && (y_coord <= 160)))||
					(((x_coord > 104) && (x_coord <= 155)) && ((y_coord > 149) && (y_coord <= 160))) || (((x_coord > 121) && (x_coord <= 137)) && ((y_coord > 159) && (y_coord <= 185)))|| // Y
					
					(((x_coord > 164) && (x_coord <= 215)) && ((y_coord > 175) && (y_coord <= 185))) || (((x_coord > 164) && (x_coord <= 215)) && ((y_coord > 124) && (y_coord <= 135)))||
					(((x_coord > 164) && (x_coord <= 175)) && ((y_coord > 124) && (y_coord <= 185))) || (((x_coord > 204) && (x_coord <= 215)) && ((y_coord > 124) && (y_coord <= 185)))|| // O
					
					(((x_coord > 224) && (x_coord <= 235)) && ((y_coord > 124) && (y_coord <= 185))) || (((x_coord > 264) && (x_coord <= 275)) && ((y_coord > 124) && (y_coord <= 185)))||
					(((x_coord > 224) && (x_coord <= 275)) && ((y_coord > 174) && (y_coord <= 185)))|| // U
					
					(((x_coord > 294) && (x_coord <= 300)) && ((y_coord > 124) && (y_coord <= 155)))||(((x_coord > 299) && (x_coord <= 305)) && ((y_coord > 154) && (y_coord <= 185)))||
					(((x_coord > 304) && (x_coord <= 311)) && ((y_coord > 174) && (y_coord <= 185)))||(((x_coord > 310) && (x_coord <= 317)) && ((y_coord > 164) && (y_coord <= 175)))||
					(((x_coord > 316) && (x_coord <= 323)) && ((y_coord > 154) && (y_coord <= 165)))||(((x_coord > 322) && (x_coord <= 329)) && ((y_coord > 164) && (y_coord <= 175)))||
					(((x_coord > 328) && (x_coord <= 335)) && ((y_coord > 174) && (y_coord <= 185)))||(((x_coord > 334) && (x_coord <= 340)) && ((y_coord > 154) && (y_coord <= 185)))||
					(((x_coord > 339) && (x_coord <= 345)) && ((y_coord > 124) && (y_coord <= 155)))||//W
					
					(((x_coord > 354) && (x_coord <= 365)) && ((y_coord > 124) && (y_coord <= 185)))||	// I
					
					(((x_coord > 374) && (x_coord <= 385)) && ((y_coord > 124) && (y_coord <= 185)))||(((x_coord > 384) && (x_coord <= 390)) && ((y_coord > 124) && (y_coord <= 140)))||
					(((x_coord > 389) && (x_coord <= 395)) && ((y_coord > 139) && (y_coord <= 155)))||(((x_coord > 394) && (x_coord <= 400)) && ((y_coord > 154) && (y_coord <= 170)))||
					(((x_coord > 399) && (x_coord <= 405)) && ((y_coord > 169) && (y_coord <= 185)))||(((x_coord > 404) && (x_coord <= 415)) && ((y_coord > 124) && (y_coord <= 185)))) //N
					begin
						red = 8'hFF;
						green = 8'hFF;
						blue = 8'hFF;
					end else begin
						red = 8'h00;
						green = 8'hB2;
						blue = 8'h00;
						//bkg_rgb = 24'hFFEC00;
					end
				end
				
		default:
			begin
				red = 8'h00;
				green = 8'h00;
				blue = 8'h00;
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