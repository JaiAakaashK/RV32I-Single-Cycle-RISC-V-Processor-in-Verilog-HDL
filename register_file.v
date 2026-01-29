module register_file(
	input [4:0] rs1,rs2,rd,
	input clk,rst,reg_write,
	input [31:0] write_data,
	output [31:0] read_data_1,
	output [31:0] read_data_2);
	
	reg [31:0]registers[31:0];
	assign read_data_1=(rs1==0)?0:registers[rs1];
	assign read_data_2=(rs2==0)?0:registers[rs2];
	
	integer i;
	always @(negedge clk) begin
		 if(rst) begin
			  for(i=0;i<32;i=i+1) begin
					registers[i]<=0;
			  end
		 end
	
		else if(reg_write && rd!=0) begin
			  registers[rd] <= write_data;
		 end
	end
endmodule
	
		