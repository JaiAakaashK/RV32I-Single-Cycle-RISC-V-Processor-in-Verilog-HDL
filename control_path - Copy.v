module control_path(
	input [6:0] optcode,
	output reg branch,mem_read,mem_to_reg,mem_write,alu_src,reg_write,
	output reg[1:0] alu_op);
	
		always @(*) begin	
				branch = 0;
				mem_read = 0;
				mem_to_reg= 0;
				mem_write = 0;
				alu_src = 0;
				reg_write = 0;
				alu_op=2'b00;
				case (optcode)
				7'b0110011:begin
					alu_op = 2'b10; // R-type
					reg_write=1;
				end
				7'b0010011:begin
					alu_op = 2'b10; // I-type arithmetic
					reg_write=1;
					alu_src=1;
				end
				7'b0000011:begin
					alu_op = 2'b00; // Load
					alu_src=1;
					mem_read=1;
					mem_to_reg=1;
					reg_write=1;
				end
				7'b0100011:begin
					alu_op = 2'b00; // Store
					alu_src=1;
					mem_write=1;
				end
				7'b1100011:begin
					alu_op = 2'b01; // Branch (BEQ)
					branch=1;
				end
				default:alu_op=2'b00;
				endcase
		end
endmodule
	 
				
			
		