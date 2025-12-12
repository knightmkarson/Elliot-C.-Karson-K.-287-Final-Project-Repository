module frame_tick_gen(
	input wire clk,
	input wire rst,
	output reg frame_tick
	);
	
localparam FRAME_COUNT = 800*525;

reg [18:0] counter = 0;

always @(posedge clk or negedge rst)begin
	if (rst == 1'b0) begin
		counter <= 0;
		frame_tick <= 0;
	end else begin
		if (counter == FRAME_COUNT - 1) begin
			counter <= 0;
			frame_tick <= 1;
		end else begin 
			counter <= counter + 1;
			frame_tick <= 0;
		end
	end
end

endmodule