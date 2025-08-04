`timescale 1ns/1ps

module vending_machine_tb();

reg clk;
reg rst_n;
reg [1:0]coin;
wire drink;
wire change;

vending_machine vending_machine_inst(
    .clk(clk),
    .rst_n(rst_n),
    .coin(coin),
    .drink(drink),
    .change(change)
);


initial begin
    clk =0;
    rst_n = 1;
    #10 rst_n = 0;
    #20 rst_n = 1;
end


always #5 clk = !clk;
always #10 coin = {$random} % 3;





endmodule