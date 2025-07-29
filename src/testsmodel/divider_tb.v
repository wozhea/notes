`timescale 1ns/1ps
module clk_divider_tb;
    reg clk;
    reg rst_n;
    wire clk_out;
    clk_divider uut(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );
    
    initial begin
        clk = 0;
        rst_n = 0;
        #5 rst_n = 1; // Release reset after 5 time units
    end
    
    always #5 clk = ~clk; // Toggle clock every 5 time units

endmodule


