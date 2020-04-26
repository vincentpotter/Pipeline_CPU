`include "instruction.v"
module Control_wb(
    input [31:26] Instruction,
    input [1:0] WB
);
    reg RegWrite;
    reg MemtoReg;
    RegWrite = M[0];
    MemtoReg = M[1];

    always @(*)
        begin
            case (Instruction)
            R_:
            begin
                RegWrite = 1'b1; 
            end
            Addi_:
            begin
                RegWrite = 1'b1;         
            end
            Addiu_: // addiu
            begin
                RegWrite = 1'b1;      
            end
        /*    Lui_:  //lui
            begin
                ALUSrc = 1'b1;   //使用立即数
                EXTOp = 2'b10;   //展方式为高位扩展
                RegWrite = 1'b1;  //写寄存器*/
            //加法
            end
            Lw_:  //LW Instructions
            begin
                MemToReg = 1'b1;  //读取内存 ->WB
                RegWrite = 1'b1;  //写寄存器 ->WB
            end
            Branch_:   // Branch Instructions
            begin
                Branch = 1'b1;         
            end
        /*    Jump_:   //Jump Instructions
            begin 
                Jump = 1'b1;
            end*/
            Ori_:    // ori
            begin
                RegWrite = 1'b1;            
            end
            endcase
        end
endmodule