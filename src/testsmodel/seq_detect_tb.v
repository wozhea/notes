`timescale 1ns/1ps
module seq_detect_tb();

    reg clk;
    reg rst_n;
    reg data;
    wire seq_detected;

seq_detect seq_detect_inst (
    .clk(clk),
    .rst_n(rst_n),
    .data(data),
    .seq_detected(seq_detected)
);



initial begin
    clk =0;
    data = 0;
    rst_n = 1;
    #10 rst_n =0;
    #20  rst_n =1;
end
always #5 clk =!clk;


initial begin
    #50 data =0;

    #10 data =1;
    #10 data =0;
    #10 data =0;
    #10 data =1;

    #10 data =1;
    #10 data =0;
    #10 data =0;
    #10 data =1;

    #10 data =0;
    #10 data =0;

    #10 data =1;
    #10 data =0;
    #10 data =0;
    #10 data =1;


    #10 data =1;
    #10 data =0;
    #10 data =0;
    #10 data =0;
end






endmodule
