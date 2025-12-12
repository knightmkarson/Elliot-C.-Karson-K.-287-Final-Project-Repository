module clock_div(
	input clk_50, // 50MHz clock input
	output reg clk_25); // 25 MHz output
	
	always @ (posedge clk_50) begin
		clk_25 <= ~clk_25;
	end
endmodule