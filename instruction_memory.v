module instruction_memory(
	input rst,
	input [31:0] instruction_address,
	output [31:0] instruction);
	
	reg [31:0]ins[63:0];
	initial begin
    $readmemh("program.hex", ins);
	end
	
	assign instruction=ins[instruction_address[31:2]];
	
endmodule 
			