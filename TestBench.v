`timescale 1ns / 10ps

module TestBench();
    reg clk;
    reg rst;
    mips MIPS(clk, rst);

    initial
        begin
            clk = 0;
            rst = 1;
            #1 rst = 0;

            // #12000 $stop
        end
    always #10
        clk = ~clk;
endmodule