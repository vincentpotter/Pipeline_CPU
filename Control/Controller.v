module Controller(
    input [31:0] Instruction,


);
    wire [1:0] ALUOp;
    reg [1:0] WB;
    reg [2:0] M;
    reg [2:0] EX;

    Control_id control_id(Instruction[31:26]);
    Control_ex control_ex(.Instruction(Instruction[31:26]), .RegDst(RegDst), .ALUSrc(ALUSrc), .ALUOp(ALUOp));
    Control_mem control

endmodule