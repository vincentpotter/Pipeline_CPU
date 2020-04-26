module MEM_WB(
    input clk,
    input [31:0] ReadData_,
    input [31:0] ALU_Result_,
    input [4:0] Write_Destination_,
    input [1:0] WB,
    output [31:0] ReadData,
    output [31:0] ALU_Result,
    output [4:0] Write_Destination,
    output PCSrc,
    output MemtoReg
    );
    reg [31:0] ReadData;
    reg [31:0] ALU_Result;
    reg [4:0] Write_Destination;
    reg RegWrite;
    reg MemtoReg;
    
    always @(posedge clk)
    begin
        ReadData <= ReadData_;
        ALU_Result <= ALU_Result_;
        Write_Destination <= Write_Destination_;
        PCSrc <= WB[0];
        MemtoReg <= WB[1];
    end
endmodule
