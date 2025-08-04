`timescale 1ns/1ps
module odd_divide_tb();

reg clk;
wire clk_out;
reg rst_n;


initial begin 
    clk = 0;
    rst_n = 1;
    #10 rst_n = 0;
    #26 rst_n = 1;
end
always #5 clk <=~clk;


odd_divide 
#( .N(5)

)
odd_divide_inst 
(
    .clk(clk),
    .rst_n(rst_n),
    .clk_out(clk_out)
);





endmodule


