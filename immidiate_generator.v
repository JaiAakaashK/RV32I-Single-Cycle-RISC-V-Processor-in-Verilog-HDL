module immediate_generator(
	input [31:0] instruction,
	input[2:0] imm_sel,
	output reg [31:0] imm32);
	
	always @(*)begin
    case (imm_sel)
        3'b001: begin
            imm32 = 32'b0;
        end
        3'b010: begin
            imm32 = {{20{instruction[31]}}, instruction[31:20]};
        end
        3'b011: begin
            imm32 = {{20{instruction[31]}}, instruction[31:20]};
        end
        3'b100: begin
            imm32 = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
        end
        3'b101: begin
            imm32 = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],
         1'b0};
        end

        default: begin
            imm32 = 32'b0;
        end
    endcase
	end
endmodule
				
			
