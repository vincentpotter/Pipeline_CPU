module Extender(
    input [15:0]  shortNum,               //16位符号位的数字
    input [1:0]   EXTOp,                  //符号扩展方式的选择
    output [31:0] result                  //输出扩展后的32位
    );
    reg [31:0] result;
    
    always@(*)
        if(EXTOp == 2'b00)                  //无符号扩展
            result = {16'b0 , shortNum};
        else if(EXTOp == 2'b10)             //有符号扩展
            result = {{16{shortNum[15]}},shortNum};
        else if(EXTOp == 2'b01)            //高符号位扩展
            result = {shortNum,16'b0};
endmodule
