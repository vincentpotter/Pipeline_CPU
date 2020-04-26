
module ID_EX(
    input clk,
    input [31:2] PC_4_,
    input [31:0] ReadData1_,
    input [31:0] ReadData2_,
    input [31:0] extended_offset_,
    input [20:16] WriteChoice1_,
    input [15:11] WriteChoice2_,
    input [1:0] WB_,
    input [2:0] M_,
    input [2:0] EX_,
    
    output [31:2] PC_4,
    output [31:0] ReadData1,
    output [31:0] ReadData2,
    output [31:0] extended_offset,
    output [20:16] WriteChoice1,
    output [15:11] WriteChoice2,
    output [1:0] WB,
    output [2:0] M,
    wire RegDst;
    wire ALUSrc;
    wire ALUOp;
    );
    
    reg [31:2] PC_4;
    reg [31:0] ReadData1;
    reg [31:0] ReadData2;
    reg [31:0] extended_offset;
    reg [20:16] WriteChoice1;
    reg [15:11] WriteChoice2;
    reg [1;0] WB;
    reg [2:0] M;
    reg RegDst;
    reg ALUSrc;
    reg ALUOp;
    
    always@(posedge clk)
    begin
        PC_4 <=PC_4_;
        ReadData1 <= ReadData1_;
        ReadData2 <= ReadData2_;
        extended_offset <= extended_offset_;
        WriteChoice1 <= WriteChoice1_;
        WriteChoice2 <= WriteChoice2_;
        WB <= WB_;
        M <= M_;
        RegDst <= EX_[0];
        ALUSrc <= EX_[1];
        ALUOp <= EX_[2];
    end
endmodule
