`timescale 1ns/1ps
module clk_divider(
	clk,
	rst_n,
	clk_out);
input clk;
input rst_n;
output reg clk_out;

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		clk_out<=1'b0;
	else 
		clk_out<=!clk_out;
end
endmodule
