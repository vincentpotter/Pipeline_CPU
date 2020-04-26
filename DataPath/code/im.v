module IM(
    input [11:2] addr,          //PC里面指令的寻址
    output [31:0] dout          //根据输入地址，输出指令集里面的指令
    );   
    reg [31:0] im[1023:0];      //1024个32位的Intruction Memory
    wire [11:2] addr;           //
    initial
    begin
	    $readmemh("C:/Users/Hello Kiddy/Desktop/CPU/code/code.txt",im);//将16进制的指令文件存到Instruction Memory中
    end
    
    assign dout = im[addr];      //根据输入的地址找到对应的指令，并输出

endmodule
