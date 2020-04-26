module PC(NPC,PC,CLK,RST);
	input [31:2] NPC;                 //next PC
	input        CLK;                 //时钟信号
	input        RST;                 //重置信号
	output [31:2] PC;                 //new PC

	reg [31:2] PC;                   //now PC

	always @(posedge CLK or posedge RST)     //时钟信号上升沿或重置信号到来时触发
	begin
		if(RST)                       //如果重置信号到来
			PC <= 30'h0c00;           //PC设置为0（30位的十六进制）
		else
			PC <= NPC;                //PC变化为NPC，进行下一步
	end
endmodule

