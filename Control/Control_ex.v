`include "instruction.v"
module Control(
    input [31:26] Instruction,
    input RegDst,
    input ALUSrc,
    input ALUOp
);
    reg RegDst;
    reg ALUOp;
    reg ALUSrc;

    always @(*)
        begin
            case(Instruction)
            R_:
            begin
                RegDst = 1b'1;
                ALUOp = 2'b10;
                // RegWrite = 1'b1; 在 WB 阶段再赋值
            end
            Addi_:
            begin
                ALUSrc = 1'b1;
                // RegWrite = 1'b1;             -> WB
            end
            Addiu_: // addiu
            begin
                ALUSrc = 1'b1;   //使用立即数
                //RegWrite = 1'b1;              ->WB
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
                ALUSrc = 1'b1;    //立即数
                //MemToReg = 1'b1;  //读取内存 ->WB
                //RegWrite = 1'b1;  //写寄存器 ->WB
                //MemRead = 1'b1;             ->MEM
            end
            Sw_:   //SW Instructions
            begin
                ALUSrc = 1'b1;
                //MemWrite = 1'b1;              ->MEM
            end
            Branch_:   // Branch Instructions
            begin
                //Branch = 1'b1;                ->MEM
                ALUOp = 2'b01;
            end
        /*    Jump_:   //Jump Instructions
            begin 
                Jump = 1'b1;
            end*/
            Ori_:    // ori
            begin
                ALUSrc = 1'b1;
                ALUOp = 2'b11;
                //RegWrite = 1'b1;              ->WB
            end
            endcase
        end
endmodule