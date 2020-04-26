module EX_MEM(
    input clk,
    input [31:2] PC_4,
    input [31:2] immediate,
    input Zero_,
    input [31:0] ALU_result_,
    input [31:0] ReadData2_,
    input [4:0] Write_Destination_,
    input [1:0] WB_,
    input [2:0] M_,
    output [31:2] Branch_dst,
    output Zero,
    output [31:0] ALU_result,
    output [31:0] ReadData2,
    output [4:0] Write_Destination,
    output [1:0] WB,
    output Branch,
    output MemWrite,
    output MemRead
);
    reg PC_4[31:2];
    reg [31:0] Branch_dst;
    reg [31:2] immediate;
    reg Zero;
    reg [31:0] ALU_result;
    reg [31:0] ReadData2;
    reg [4:0] Write_Destination;
    reg [1:0] WB;
    reg [2:0] M;
    reg Branch;
    reg MemRead;
    reg MemWrite;

    always @(posedge clk)
        begin
            Branch_dst = PC_4 + immediate;
            Zero <= Zero_;
            ALU_result <= ALU_result_;
            ReadData2 <= ReadData2_;
            Write_Destination <= Write_Destination_;
            WB <= WB_;
            Branch <= M_[0];
            MemRead <= M_[1];
            MemWrite <= M_[2];
        end
endmodule