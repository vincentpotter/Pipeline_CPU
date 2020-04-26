`include "instruction.v"
module Control_id(
    input [31:26] Instruction, // why so little 
    output [1:0] WB,
    output [2:0] M,
    output [2:0] EX
);
    reg [1:0] WB;
    reg [2:0] M;
    reg [2:0] EX;

    always @(*)
        begin
            WB <= 2'b00;
            M <= 2'b00;
            EX <= 2'b00;
        end
endmodule // 
// it does nothing just as a brother