module rssi_shift #(
    parameter rssi_threshold4 = 2000,//24dB
    parameter rssi_threshold3 = 3100,//18dB
    parameter rssi_threshold2 = 4200,//12dB
    parameter rssi_threshold1 = 5300,//6dB
    parameter rssi_threshold0 = 6400,//0dB
) (
    input clk,//100Mhz
    input rst_n,
    input [15:0]rssi,
    output [2:0]num_shift,//0~4

);
    reg reset_delay1;
    reg reset_delay2;
    reg reset_delay3;
    reg reset_delay4;
    reg [26:0] clk_1s_count;//134,217,728-1 = 'h7FF FFFF
    reg avg_en;

mv_avg #(.DATA_WIDTH(16), .LOG2_AVG_LEN(4)) mag_sq_avg_inst (
    .clk(clk),
    .rstn(~(reset|reset_delay1|reset_delay2|reset_delay3|reset_delay4)),
    // .rstn(~reset),

    .data_in(rssi),
    .data_in_valid(avg_en),
    .data_out(rssi_avg),
    .data_out_valid(rssi_avg_valid)
);


always @(posedge clk or negedge rst_n) begin
    if (~rsn_n) begin
        clk_1s_count <= 0;
        num_shift <= 0;
        avg_en <= 0;
        reset_delay1 <= rsn_n;
        reset_delay2 <= rsn_n;
        reset_delay3 <= rsn_n;
        reset_delay4 <= rsn_n;

    end else begin
        reset_delay4 <= reset_delay3;
        reset_delay3 <= reset_delay2;
        reset_delay2 <= reset_delay1;
        reset_delay1 <= reset;

        clk_1s_count <= clk_1s_count +1;
        if(clk_1s_count == 'h7FFFFFF )
            avg_en <= 1;
            else avg_en <= 0;
        if(rssi_avg_valid == 1) begin
            if(rssi_avg < rssi_threshold4)
            num_shift <= 4;
            else if(rssi_avg < rssi_threshold3)
            num_shift <= 3;
            else if(rssi_avg < rssi_threshold2)
            num_shift <= 2;
            else if(rssi_avg < rssi_threshold1)
            num_shift <= 1;
            else if(rssi_avg < rssi_threshold0)
            num_shift <= 0;
            else 
            num_shift <= 0;           
        end
    end
end

endmodule