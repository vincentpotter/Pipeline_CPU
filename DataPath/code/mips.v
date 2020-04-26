module mips(
    input clk,
    input rst
    );
    wire [31:0] Instruction;
    wire [15:0] offset;
    wire RegDst;       //写寄存器目标
    wire Jump;         //是否j指令
    wire Branch;       //是否分支指令
    wire MemRead;      //是否lw指令
    wire MemToReg;     //写数据来源
    wire [3:0] ALUCtrl;//ALU控制信号
    wire MemWrite;     //是否sw指令
    wire ALUSrc;       //ALU数据来源
    wire RegWrite;     //是否写入寄存器
    wire [1:0] EXTOp;        //符号位扩展方式
    //例化 DATAPATH
    DataPath datapath(RegDst,Jump,Branch,MemRead,MemToReg,ALUCtrl,MemWrite,ALUSrc,RegWrite,EXTOp,Instruction,offset,clk,rst);
    //例化 CONTROLLER
    Controller controller(Instruction,RegDst,Jump,Branch,MemRead,MemToReg,ALUCtrl,MemWrite,ALUSrc,RegWrite,EXTOp);
   
    

endmodule
