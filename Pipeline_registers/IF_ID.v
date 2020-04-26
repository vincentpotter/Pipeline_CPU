module IF_ID(
    input clk,
    input [31:2] PC_4_,
    input [31:0] Instructions_OUT_,
    output [31:2] PC_4,
    output [31:0] Instructions_OUT
    );
    reg [31:2] PC_4;
    reg [31:0] Instructions_OUT;
    always @(posedge clk)
    begin
        PC_4 <= PC_4_;
        Instructions_OUT <= Instructions_OUT_;
    end
endmodule
