module RegFile(
    input [4:0] Rreg1,                //Read Register1，对应IM输出的25-21位
    input [4:0] Rreg2,                //Read Register2，对应IM输出的20-16位
    input [4:0] Wreg,                 //Write Register
    input [31:0] Wdata,               //Write data
    input Wenable,                    //Write Enable，使能端
    input clk,                        //时钟信号
    input rst,                        //重置信号
    output [31:0] Rdata1,             //Read data1
    output [31:0] Rdata2              //Read data2
    );
    reg [31:0] Registers[31:0];       //32个32位寄存器
    integer i;
    always @(posedge clk or posedge rst)    //在时钟周期上升沿或者重置信号的到来时触发
    begin
        if(rst)                         //重置信号到来
            for(i=0;i<32;i=i+1)         //重置信号到来，32个寄存器清空
                Registers[i] <= 32'b0;  
        else if(Wenable)                //使能信号为真，
            Registers[Wreg] <= Wdata;   //向寄存器中写数据
    end  
      
    assign Rdata1 = (Rreg1 != 0)? Registers[Rreg1] : 0;   //根据寄存器地址，将相应的数据输出（读数据操作）
    assign Rdata2 = (Rreg2 != 0)? Registers[Rreg2] : 0;   //根据寄存器地址，将相应的数据输出（读数据操作）
    
endmodule
