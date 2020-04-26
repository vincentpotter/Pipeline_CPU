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
    wire [1:0] EXTOp;  //符号位扩展方式

    DataPath datapath(.RegDst(RegDst), .Jump(Jump), .Branch(Branch), .MemRead(MemRead), .MemToReg(MemToReg), .ALUCtrl(ALUCtrl), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .EXTOp(EXTOp),
     .CLK(clk), .RST(rst), .Instruction(Instruction), .offset(offset));
    
    Controller controller(.Instruction(Instruction), .RegDst(RegDst), .Jump(Jump), .Branch(Branch), .MemRead(MemRead), .MemToReg(MemToReg),
     .ALUCtrl(ALUCtrl), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .EXTOp(EXTOp));