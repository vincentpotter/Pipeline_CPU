module DataPath(
    input RegDst,                //写寄存器目标
    input Jump,                  //j指令
    input Branch,                //beq指令
    input MemRead,               //lw指令
    input MemToReg,              //数据存到寄存器
    input [3:0] ALUCtrl,         //ALU控制信号
    input MemWrite,              //sw指令
    input ALUSrc,                //ALU数据来源
    input RegWrite,              //是否写入寄存器
    input [1:0] EXTOp,           //符号位扩展方式
    output [31:0] Instruction,   //生成controller
    output [15:0] offset,
    
    input CLK,
    input RST
    );
    
    //IF
    wire [31:2] PC;
    wire [31:2] NPC_if;
    wire [31:0] Instruction_if;
    wire [1:0] EXTOp;

    //ID 
    wire [31:2] NPC_id;
    wire [31:0] Instruction_id;
    wire [31:0] ReadData1_id;
    wire [31:0] ReadData1_id;
    wire [31:0] Bigoffset_id;
    wire [31:0] WriteData_id;
    wire [1:0] WB_id; //位数还没有确定
    wire [2:0] M_id;
    wire [2:0] EX_id;

    //EX
    wire [31:2] NPC_ex;
    wire [5:0] WriteRegister_ex;
    wire [31:0] ReadData2_ex;
    wire [31:0] ReadData2_ex;
    wire [31:0] Bigoffset_ex; 
    wire [1:0] WB_ex;
    wire [2:0] M_ex; 
    //          EX 在这个地方分成 3 根线
    wire RegDst;
    wire ALUSrc;
    wire ALUOp;
    wire ALUCtrl;
    wire Zero_ex;
    wire Zero_mem;
    wire [31:0] AlU_result_ex;
    wire [4:0] RegDst_1;
    wire [4:0] RegDst_2;
    //在下一个 ID 阶段进入 RegFile

    //MEM
    //    wire M_mem;
    wire [1:0] WB_mem;
    wire Branch;
    wire MemWrite;
    wire MemRead;
    wire [31:2] NPC_mem;
    wire [31:0] AlU_result_mem;
    wire [31:0] ReadData2_mem;
    wire [5:0] WriteRegister_mem;
    wire [31:0] outDM; 

    //WB
    wire [1:0] WB_wb;
    wire [31:0] ReadData1_wb;
    wire [31:0] AlU_result_wb;
    wire [31:0] WriteData1_wb;
    wire [31:0] WriteData2_wb;
    wire [31:0] ALUInput2;
    wire [5:0] WriteRegister_wb;
    wire PCSrc;
    wire MemtoReg;

   
    //-------------------------------------------------------------------------------------//
    //IF
    Mux mux_pc(.Input1(NPC_mem), .Input2(PC+4), .Ctrl(PCSrc), .Output(PC));
    PC pc(.NPC(NPC_if),.PC(PC),.CLK(CLK),.RST(RST));    //PC例化
    IM im(.addr(PC[11:2]),.dout(Instruction_if));    //Instruction memory例化
    
    IF_ID if_id(.clk(CLK), .PC_4_(NPC_if), .Instructions_OUT_(Instruction_if), .PC_4(NPC_id), .Instructions_OUT(Instruction_id));
    //ID
    RegFile regfile(.Rreg1(Instruction_id[25:21]), .Rreg2(Instruction_id[20:16], .Wreg(WriteRegister), .Wdata(WriteData_id), .Wenable(RegWrite), .clk(CLK), .rst(RST), .Rdata1(ReadData1_id), .Rdata2(ReadData2_id));
    
    Extender extender(.shortNum(Instruction_id[15:0]), .EXTOp(EXTOp), .result(Bigoffset_id));
    
    ID_EX id_ex(.clk(CLK), .PC_4_(NPC_id), .ReadData1_(ReadData1_id), .ReadData2_(ReadData2_id), .extender_offset_(Bigoffset_id), .WriteChoice1_(Instruction_id[20:16]), WriteChoice2_(Instruction_id[15:11]), .WB_(WB_id), .M_(M_id), .EX_(EX_id),
                        .PC_4(NPC_ex), .ReadData1(ReadData1_ex), .ReadData2(ReadData2_ex), .extender_offset(Bigoffset_ex), .WriteChoice1(RegDst_1), WriteChoice2(RegDst_2), .WB(WB_ex), .M(M_ex), .EX(EX_ex));
    //EX

    Mux mux_alu(.Input1(ReadData2_ex), .Input2(Bigoffset_ex), .Ctrl(ALUSrc), .Output(ALUInput2));
    ALU alu(.Input1(ReadData1_ex), .Input2(ALUInput2), .Ctrl(ALUCtrl), .Zero(Zero_ex), .result(AlU_result));

    Reg_Mux mux_regdst(.Input1(RegDst_1), .Input2(RegDst_2), .Ctrl(RegDst), .Output(RegDst_result));

    

    EX_MEM ex_mem(.clk(CLK), .PC_4(NPC_ex), .immediate(Bigoffset_ex), .Zero_(Zero_ex), .ALU_result_(AlU_result), .ReadData2_(ReadData2_ex), .Write_Destination(WriteRegister), .WB_(WB_ex), .M_(M_ex), 
    .Branch_dst(NPC_mem), .Zero(Zero_mem), .AlU_result(ALU_result_mem), .ReadData2(ReadData2_mem), .Write_Destination(WriteRegister_mem), .WB(WB_mem), .M(M_mem));
   
    //MEM
    DM dm(.addr(ALU_result_mem[11:2]), .din(ReadData2_mem), .MemRead(MemRead), .we(MemRead), .clk(CLK), .dout(outDM));
    MEM_WB mem_wb(.clk(CLK), .ReadData_(outDM), .ALU_result_(ALU_result_mem), .Write_Destination(WriteRegister_mem), .WB(WB_mem),
    ReadData(WriteData1_wb), .AlU_Result(WriteData2_wb), .Write_Destination(WriteRegister_wb), .PCSrc(PCSrc), .MemtoReg(MemtoReg));

    //WB
    Mux mux_writedata(.Input1(ReadData_wb), .Input2(ALU_result_wb), .Ctrl(MemtoReg), .Output(WriteData_id));
    //完成
endmodule
