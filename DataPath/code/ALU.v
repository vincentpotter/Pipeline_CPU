 module ALU(                             //算术逻辑单元
    input [31:0]  Input1,                //输入端口一
    input [31:0]  Input2,                //输入端口二
    input [3:0]   Ctrl,                  //ALUcontrol输出的控制信号
    output        Zero,                  //Zero标志位
    output [31:0] result                 //运算结果
    );
    reg [31:0] result;
    
   
    always @(*)
        case(Ctrl[3:0])
            4'b0000: result = Input1 & Input2;          //AND，与运算
            4'b0001: result = Input1 | Input2;          //OR，或运算
            4'b0010: result = Input1 + Input2;          //ADD，加法运算
            4'b0110: result = Input1 - Input2;          //SUB，减法运算
            4'b0111:                                    //slt运算
               begin
                   if(Input1 < Input2)                  //如果输入一 < 输入二
                      result = 1'b1;                    //结果为1
                  else result = 1'b0;                   //其他情况，结果为0
               end
            4'b1111:
                result = Input1 ^ Input2;               //异或运算        
            default: result = 32'b0;                    //溢出情况，输出结果为0
        endcase
        
    assign Zero = (result == 0);                        //Zero标志位，如果结果为0，标为1；不为0，标为0
 endmodule
