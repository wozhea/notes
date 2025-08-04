module seq_detect (
    input clk,
    input rst_n,
    input data,
    output seq_detected
);
parameter IDLE = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;
parameter S4 = 4;

reg [3:0] state;
reg [3:0] next_state;

/*
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        state <= IDLE;
    else begin
        case(state)
            IDLE:begin 
                if(data == 1) state<=S1;
                else state<=IDLE;
            end

            S1:begin 
                if(data == 0) state<=S2;
                else state<=IDLE;
            end

            S2:begin 
                if(data == 0) state<=S3;
                else state<=IDLE;
            end

            S3:begin 
                if(data == 1) state<=S4;
                else state<=IDLE;
            end

            S4:begin 
                if(data == 1) state<=S1;
                else state<=IDLE;
            end
            default:state<=IDLE;
                
        endcase
    end
end
*/

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        state <= IDLE;
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        IDLE:
            if(data == 1'b1)
                next_state = S1;
            else
                next_state = IDLE;
        S1:
            if(data == 1'b0)
                next_state = S2;
            else
                next_state = IDLE;
        S2:
            if(data == 1'b0)
                next_state = S3;
            else
                next_state = S2;
        S3:
            if(data == 1'b1)
                next_state = S4;
            else
                next_state = IDLE;
        S4:
            if(data == 1'b1)
                next_state = S1;
            else
                next_state = IDLE;
        default:
                next_state = IDLE;
    endcase
end








assign seq_detected = state==S4? 1:0;

endmodule