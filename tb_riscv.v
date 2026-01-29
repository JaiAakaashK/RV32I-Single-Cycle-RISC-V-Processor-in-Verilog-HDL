`timescale 1ns/1ps

module tb_riscv;
    reg clk;
    reg rst;
    wire [31:0] alu_out;
    wire [3:0]  alu_op;
    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire        branch_en;
    wire [31:0] pc;

    RISCV dut (
        .clk(clk),
        .rst(rst),
        .dbg_alu_out(alu_out),
        .dbg_alu_op(alu_op),
        .dbg_alu_a(alu_a),
        .dbg_alu_b(alu_b),
        .dbg_branch_en(branch_en),
        .dbg_pc(pc)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;
        #200 $stop;
    end

    always @(posedge clk) begin  // ALU MONITOR
        if (!rst) begin
            $display(
              "PC=%h | ALU_A=%0d | ALU_B=%0d | OP=%0d | OUT=%0d | BR=%b",
              pc, alu_a, alu_b, alu_op, alu_out, branch_en
            );
        end
    end

endmodule