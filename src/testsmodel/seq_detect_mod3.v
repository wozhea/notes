`timescale 1ns/1ps

module seq_detect_mod3
(
input                                   clk,
input                                   rst_n,

input                                   data,
output  reg                             success
);


reg [1:0] current_state;
reg [1:0] next_state;
 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) current_state <= 0;
    else current_state <= next_state;
  end

always@(*)begin
    next_state = 0;
    case(current_state)
    2'd0: if(data) next_state = 2'd1;
          else next_state = 2'd0;
    2'd1: if(data) next_state = 2'd0;
          else next_state = 2'd2;
    2'd2: if(data) next_state = 2'd2;
          else next_state = 2'd1;
    default: next_state = 0;
    endcase
  end

always@(posedge clk or negedge rst_n) begin
  if(!rst_n) success <= 0;
  else begin
    case(current_state)
    2'd0: if(data) success <= 0;
          else success <= 1;
    2'd1: if(data) success <= 1;
          else success <= 0;
    2'd2: if(data) success <= 0;
          else success <= 0;
    default: success <= 0;
    endcase
  end 
end


endmodule

