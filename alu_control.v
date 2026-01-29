module alu_control (
    input [1:0] alu_op,      
    input [2:0] funct3,
    input branch,  
	 input funct7_5,
    output reg [3:0] alu_ctrl);

 always @(*) begin
   case(alu_op)
		2'b00:alu_ctrl=4'd0;
		2'b01:alu_ctrl=4'd10;
		2'b10:begin
			case (funct3)
				3'b000: begin
					 if (alu_op == 2'b10 && funct7_5 && !branch)
						  alu_ctrl = 4'd1; // SUB
					 else
						  alu_ctrl = 4'd0; // ADD
				end
				3'b111: alu_ctrl = 4'd2; // AND
				3'b110: alu_ctrl = 4'd3; // OR
				3'b100: alu_ctrl = 4'd4; // XOR
				3'b001: alu_ctrl = 4'd5; // SLL
				3'b101: alu_ctrl = (funct7_5) ? 4'd7 : 4'd6; // SRA / SRL
				3'b010: alu_ctrl = 4'd8; // SLT
				3'b011: alu_ctrl = 4'd9; // SLTU
				default: alu_ctrl = 4'd0;
			endcase
		end
		default: alu_ctrl=4'd0;
	endcase
 end

endmodule
