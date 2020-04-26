module DM(
    input [11:2] addr,           //输入地址
    input [31:0] din,            //输入数据
    input        MemRead,        //是否读取内存
    input        we,             //是否存储数据
    input        clk,            //时钟信号
    output [31:0] dout           //输出信号
);
    reg [31:0] dm[1023:0];       //4k 数据内存
    reg [31:0] dout;
    reg [3:0] i;
    
    initial                      //读取数据到DM中，但是本次实验MIPS中已经自动生成数据，此部分没有影响
    begin
	    $readmemh("D:/File_coding/Vivado/project_1/project_1.srcs/sources_1/new/data.txt",dm);
	    for(i = 0; i <= 7 ;i=i+1)
	    $display("memory[%d] = %h",i,dm[i]);
    end 
    
    
    always @(negedge clk)        //时钟信号下降沿触发
        if(MemRead)              //读取数据
            dout <= dm[addr];    //根据输入的地址，提取出相应的数据
        else if(we)              //存储数据
            dm[addr] <= din;     //将数据存取在对应的内存的地址中
        else 
            dout <= 32'b0;        //溢出的情况，输出0
    
endmodule