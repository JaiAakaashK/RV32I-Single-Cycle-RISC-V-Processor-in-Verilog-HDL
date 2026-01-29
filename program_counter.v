module Program_counter(
	input clk,rst,
	input [31:0] pc_next,
	output reg [31:0] pc_current);
	
	always @(posedge clk)begin
		if(rst)begin
			pc_current<=0;
		end
		else begin
			pc_current<=pc_next;
		end
	end
endmodule 
