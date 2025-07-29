`timescale 1ns/1ps


module onebit_trans(
	input clka,
	input clkb,
	input rst_n,
	input bit_a,
	output bit_b
);
reg a_latch;
reg b_latch_r;
reg b_latch_2r;
reg ack_b;
reg ack_b_r;


always@(posedge clka or negedge rst_n)begin
	if(!rst_n)
		a_latch <=1'b0;
	else if(bit_a)
		a_latch <=1'b1;
	else if(ack_b_r)
		a_latch <=1'b0;
end

always@(posedge clkb or negedge rst_n)begin
	if(!rst_n)begin
		b_latch_r <=1'b0;
		b_latch_2r <=1'b0;
	end
	else begin
		b_latch_r <= a_latch;
		b_latch_2r <=b_latch_r;
	end
end

always@(posedge clka or negedge rst_n)begin
	if(!rst_n)begin
		ack_b<=1'b0;
		ack_b_r <=1'b0;
	end
	else begin
		ack_b <=b_latch_2r;
		ack_b_r<=ack_b;
	end
end
assign bit_b = !b_latch_2r & b_latch_r;





endmodule

