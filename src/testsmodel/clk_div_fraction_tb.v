`timescale 1ns/1ps
module clk_div_fraction_tb();

reg clk;
wire clk_frac;
reg rst_n;


initial begin 
    clk = 0;
    rst_n = 1;
    #10 rst_n = 0;
    #26 rst_n = 1;
end
always #5 clk <=~clk;


clk_div_fraction  clk_div_fractioin_inst 
(
    .clk(clk),
    .rstn(rst_n),
    .clk_frac(clk_frac)
);


endmodule


