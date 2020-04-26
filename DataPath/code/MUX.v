module Reg_Mux(                //IM和regfile之间的那个多路选择器MUX
	input [4:0]  R,            //输入端口一，对应IM输出指令的20-16位
	input [4:0]  W,            //输入端口二，对应IM输出指令的15-11位
	input        ctrl,         //多路选择器的控制信号，做标准化处理
	output [4:0] result        //多路选择器的输出信号
);
	reg [4:0] result;

	always @(*)                //根据多路选择器的控制信号进行选择不一样的信号
		if(ctrl == 0)          
			result = R;
		else if(ctrl == 1)
			result = W;
				
endmodule

module Mux(                    //两个32位输入，一个32位输出的多路选择器
	input [31:0]  Input1,      //32位的输入端口一
	input [31:0]  Input2,      //32位的输入端口二
	input         Ctrl,        //多路选择器的控制信号
	output [31:0] Output       //32位的输出端口
);
    reg [31:0] Output;
	always @(*)                ////根据多路选择器的控制信号进行选择不一样的信号
		if(Ctrl == 1'b0)
			Output = Input1;
		else 
			Output = Input2;
endmodule

