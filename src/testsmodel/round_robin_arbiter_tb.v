`timescale 1ns / 1ps
module round_robin_arbiter_tb();

    reg       clk    ;
    reg       rst_n  ;
    reg [3:0] request;
    wire [3:0] grant  ;

    initial clk = 0;
    always #5 clk = !clk;

    initial begin
        rst_n= 0;
        request = 4'h0;
        #15 rst_n = 1;
        @(posedge clk) #0 request = 4'b1101;
        #50;
        @(posedge clk) #0 request = 4'b0101;
        @(posedge clk) #0 request = 4'b0010;
        @(posedge clk) #0 request = 4'b0000;
        #100;
        $stop;
    end

    round_robin_arbiter u0_round_robin_arbiter_inst
    (
        .clk        ( clk       ) ,
        .rst_n      ( rst_n     ) ,
        .request    ( request   ) ,
        .grant      ( grant     ) 
    );

endmodule
