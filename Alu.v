module alu(
	input[31:0]read_data_1,read_data_2,
	input [3:0] operation,
	output reg branch_en,
	output reg [31:0] result);
	
	always @(*)begin
		branch_en=0;
		result=0;
		case(operation)
			4'd0:result=read_data_1 + read_data_2;
			4'd1:result=read_data_1 - read_data_2;
			4'd2:result=read_data_1 & read_data_2;
			4'd3:result=read_data_1 | read_data_2;
			4'd4:result=read_data_1 ^ read_data_2;
			4'd5:result=read_data_1 << read_data_2[4:0];
			4'd6:result=read_data_1 >> read_data_2[4:0];
			4'd7: result = $signed(read_data_1) >>> read_data_2[4:0]; 
			4'd8: result = ($signed(read_data_1) < $signed(read_data_2)) ? 32'd1 : 32'd0; // SLT
			4'd9: result = (read_data_1 < read_data_2) ? 32'd1 : 32'd0;
			4'd10:begin
				result=0;
				branch_en=(read_data_1==read_data_2);
			end
			default:begin
				result=0;
				branch_en=0;
			end
		endcase
	end
endmodule
			