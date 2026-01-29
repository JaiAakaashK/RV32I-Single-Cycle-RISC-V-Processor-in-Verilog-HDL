module RISCV(
	input clk,rst,
	output [31:0] dbg_alu_out,
   output [3:0]  dbg_alu_op,
   output [31:0] dbg_alu_a,
   output [31:0] dbg_alu_b,
   output dbg_branch_en,
   output [31:0] dbg_pc
	);
	
	reg [31:0]pc_in;
	wire [31:0] instruction_address;
	Program_counter a1(clk,rst,pc_in,instruction_address);//Program Counter block
	
	

	wire [31:0] instruction; // instruction memory block
   instruction_memory a2(rst,instruction_address,instruction);
	
	
	wire funct7_5;
	assign funct7_5 = instruction[30];
	wire [6:0]optcode;
	assign optcode=instruction[6:0];  // regsiter file requirement block
	wire [4:0]rs1,rs2,rd;
	assign rs1=instruction[19:15];
	assign rs2=instruction[24:20];
	assign rd=instruction[11:7];
	wire [2:0] func3;
	assign func3=instruction[14:12];
	reg [31:0] write_data;
	wire [31:0]read_data_1;
	wire [31:0] read_data_2;
	reg [2:0] imm_sel;
	
	always @(*) begin
		imm_sel=3'b000;
		case (optcode)
			7'b0110011: imm_sel=3'b001; // R-type
			7'b0010011: imm_sel=3'b010; // I-type (ADDI, etc.)
			7'b0000011: imm_sel=3'b011; // Load (LW)
			7'b0100011: imm_sel=3'b100; // Store (SW)
			7'b1100011: imm_sel=3'b101; // Branch (BEQ, etc.)
			default: imm_sel=3'b000;
		endcase
	end

	
	wire branch,mem_read,mem_to_reg,mem_write,alu_src,reg_write; // Register file block
	wire [1:0]alu_op;
	control_path c1 (optcode,branch,mem_read,mem_to_reg,mem_write,alu_src,reg_write,alu_op);
	register_file r2 (rs1,rs2,rd,clk,rst,reg_write,write_data,read_data_1,read_data_2);
	
	
	
	
	wire [31:0] immediate_value; // Immediate generator block
	immediate_generator i1(instruction,imm_sel,immediate_value);
	reg [31:0] rd_2;
	always @(*)begin
		case(alu_src)
			1'b0:rd_2=read_data_2;
			1'b1:rd_2=immediate_value;
			default:rd_2=0;
		endcase
	end
	
	
	wire [31:0] alu_out;
	wire [3:0] operation; //ALU control and operating block
	alu_control j1(alu_op,func3,branch,func7_5,operation);
	wire branch_en;
	alu a8(read_data_1,rd_2,operation,branch_en,alu_out);
	
	
	
	
	wire [31:0] temp_write;// Data memory Block
	data_memory d1(clk,rst,read_data_2,alu_out,mem_read,mem_write,temp_write);
	always @(*)begin
		case(mem_to_reg)
			1'b1:write_data=temp_write;
			1'b0:write_data=alu_out;
			default:write_data=32'd0;
		endcase
	end
	
	wire [31:0] pc_temp1,pc_temp2; // Program counter position calculation block
	assign pc_temp1=instruction_address+32'd4;
	wire pc_en;
	assign pc_en=branch_en&branch;
	
	assign pc_temp2=instruction_address+immediate_value;
	always @(*)begin
		case(pc_en)
			1'b0:pc_in=pc_temp1;
			1'b1:pc_in=pc_temp2;
			default:pc_in=pc_temp1;
		endcase
	end
	
	
	assign dbg_alu_out   = alu_out; // output waveform required signals
	assign dbg_alu_op    = operation;
	assign dbg_alu_a     = read_data_1;
	assign dbg_alu_b     = rd_2;
	assign dbg_branch_en = branch_en;
	assign dbg_pc        = instruction_address;
	
endmodule
	
	
	
			
	
	
	
	
	
			