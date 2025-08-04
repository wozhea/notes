`timescale 1ns/1ps
module clk_div_fraction_5_tb();

reg clk;
wire clk_div3p5;
reg rst_n;


initial begin 
    clk = 0;
    rst_n = 1;
    #10 rst_n = 0;
    #26 rst_n = 1;
end
always #5 clk <=~clk;


clk_div_fractioin_5  clk_div_fractioin_5 
(
    .clk(clk),
    .rst_n(rst_n),
    .clk_div3p5(clk_div3p5)
);


endmodule


