`timescale 1ns/1ps
//auto vending machine,a bottle of drink is 1.5 dollar,1 coin 1 time, only 1 dollar or 0.5 dollar coin;

module vending_machine(
    input clk,
    input rst_n,
//硬币,高位表示1dollar，低位表示0.5dollar
    input [1:0] coin,
    output drink,
//找零
    output change
    
);
parameter IDLE = 0;
parameter S1_05 =1;
parameter S1_10 =2;
parameter S1_15 =3;
parameter S1_20 =4;
parameter S1_change =5;

reg [3:0] state;
reg [3:0] next_state;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        state <=0;
    else
        state <=next_state; 
end

always@(*)begin
    case(state)
    IDLE:   next_state = (coin==2'b10)?S1_10:
                                            ((coin==2'b01)?S1_05:IDLE);
    S1_05:  next_state = (coin==2'b10)?S1_15:
                                            ((coin==2'b01)?S1_10:S1_05);
    S1_10:  next_state = (coin==2'b10)?S1_20:
                                            ((coin==2'b01)?S1_15:S1_10);
    S1_15:  next_state = IDLE;
    S1_20:  next_state = IDLE;
    default: next_state = IDLE;
    endcase
end

assign drink = state==S1_15 || state==S1_20;
assign change = state==S1_20;


endmodule