module Control_mem(
    input [31:26] Instruction,
    input Branch,
    input MemRead,
    input MemWrite
);
    reg Branch;
    reg MemRead;
    reg MemWrite;
    
    always @(*)
        begin
            case (Instruction)
                Lw_:  //LW Instructions
                begin
                    MemRead = 1'b1;            
                end
                Sw_:   //SW Instructions
                begin
                    MemWrite = 1'b1;             
                end
                Branch_:   // Branch Instructions
                begin
                    ALUOp = 2'b01;
                end
                default: 
            endcase
        end
endmodule