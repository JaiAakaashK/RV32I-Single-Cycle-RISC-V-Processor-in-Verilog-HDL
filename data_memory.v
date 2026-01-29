module data_memory(
	input clk,rst,
	input [31:0] data_in,
	input [31:0] address,
	input mem_read,mem_write,
	output reg [31:0] data_out);
	
	reg [31:0]mem[0:255];
	integer i ;
	wire [7:0] word_addr=address[9:2];
	
	always @(*)begin
		if(mem_read)begin
				data_out=mem[word_addr];
		end
		else begin
				data_out=32'd0;
		end
	end
		
	always @(posedge clk)begin
		if(rst)begin
			for(i=0;i<256;i=i+1)begin
				mem[i]<=32'd0;
			end
		end
		
		else if(mem_write)begin
			mem[word_addr]<=data_in;
	   end
	end
endmodule
	
	