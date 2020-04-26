module Controller(
    input [31:0] Instruction,
    output [1:0] WB,
    output [2:0] M,
    output [3:0] EX,
    output [3:0] ALUCtrl，
    output [1:0] EXTOp
);
    wire [1:0] ALUOp;
    reg [1:0] WB;
    reg [2:0] M;
    reg [2:0] EX;

    Control_id control_id(Instruction[31:26], .WB(WB), .M(M), .EX(EX));
    Control_ex control_ex(.Instruction(Instruction[31:26]), .EX(EX));
    Control_mem control_mem(.Instruction(Instruction[31:26]), .M(M));
    Control_wb control_wb(.Instruction(Instruction[31:26]), .WB(WB));
    ALUControl ALUcontrol(.ALUOp(ALUOp),.Instruction(Instruction[5:0]),.ALUCtrl(ALUCtrl));

endmodule