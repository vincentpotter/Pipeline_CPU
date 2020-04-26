module ALUControl(          //unchanged
    input [1:0] ALUop,
    input [5:0] funct,
    output[3:0] ALUCtrl
);
    reg [3:0] ALUCtrl;
    //codes of ALUOp
    parameter LW = 2'b00, Branch = 2'b01, R = 2'b10;
    //codes of ALUCtrl
    parameter And = 4'b0000,
            Or  = 4'b0001,
            Add = 4'b0010,
            Sub = 4'b0110,
            Slt = 4'b0111,
            Nor = 4'b1111,
            lui = 4'b1110;
    always @(*)
        begin
            if(ALUop == LW) //or sw
            begin
                if(funct[5:0] == 6'b100110) //xor 异或
                    ALUCtrl = Nor;
                else
                    ALUCtrl = Add;
            end 
            else if(ALUop == 2'b11) //ori
                ALUCtrl = Or;
            else if(ALUop == Branch)
                ALUCtrl = Sub;
            else if(ALUop == R)
            begin
                case(funct[3:0])
                4'b0000: ALUCtrl = Add;      //√
                4'b0010: ALUCtrl = Sub;      //√
                4'b0100: ALUCtrl = And;  //AND √
                4'b0101: ALUCtrl = Or;  //OR   √
                4'b1010: ALUCtrl = Slt;     // √
                endcase
            end
        end
endmodule
//看看教材的附录部分，有对应的机器码