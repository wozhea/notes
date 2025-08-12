//moving average module


module mv_avg
#(
    parameter DATA_WIDTH = 16,
    parameter LOG2_AVG_LEN = 5                  //average window,length = 2^LOG2_AVG_LEN
)
(
    input clk,
    input rstn,

    input signed [DATA_WIDTH-1:0] data_in,
    input data_in_valid,

    output wire signed [DATA_WIDTH-1:0] data_out,
    output wire data_out_valid
);

localparam FIFO_SIZE = 1<<LOG2_AVG_LEN;         //window length
localparam TOTAL_WIDTH = DATA_WIDTH + LOG2_AVG_LEN; //sum length

reg signed [(TOTAL_WIDTH-1):0] running_total;   //sum

reg  signed [DATA_WIDTH-1:0] data_in_reg; // to lock data_in by data_in_valid in case it changes in between two valid strobes
wire signed [DATA_WIDTH-1:0] data_in_old;   //delay FIFO_SIZE data

wire signed [TOTAL_WIDTH-1:0] ext_data_in_old = {{LOG2_AVG_LEN{data_in_old[DATA_WIDTH-1]}}, data_in_old};   //expand to sum length
wire signed [TOTAL_WIDTH-1:0] ext_data_in     = {{LOG2_AVG_LEN{data_in_reg[DATA_WIDTH-1]}}, data_in_reg};

reg rd_en, rd_en_start;
wire [LOG2_AVG_LEN:0] wr_data_count;
reg [LOG2_AVG_LEN:0]  wr_data_count_reg;
wire wr_complete_pulse;
reg  wr_complete_pulse_reg;

assign wr_complete_pulse = (wr_data_count > wr_data_count_reg);
assign data_out_valid = wr_complete_pulse_reg;
assign data_out = running_total[TOTAL_WIDTH-1:LOG2_AVG_LEN];

xpm_fifo_sync #(
    .DOUT_RESET_VALUE("0"),    // String
    .ECC_MODE("no_ecc"),       // String,error correcting code
    .FIFO_MEMORY_TYPE("auto"), // String
    .FIFO_READ_LATENCY(0),     // DECIMAL
    .FIFO_WRITE_DEPTH(FIFO_SIZE),   // DECIMAL minimum 16!
    .FULL_RESET_VALUE(0),      // DECIMAL
    .PROG_EMPTY_THRESH(10),    // DECIMAL,10 default
    .PROG_FULL_THRESH(10),     // DECIMAL
    .RD_DATA_COUNT_WIDTH(LOG2_AVG_LEN+1),   // DECIMAL
    .READ_DATA_WIDTH(DATA_WIDTH),      // DECIMAL
    .READ_MODE("fwft"),         // String,在读使能信号有效的第一个周期就能能读出第一个有效的数据
    .USE_ADV_FEATURES("0404"), // only enable rd_data_count and wr_data_count
// |   Setting USE_ADV_FEATURES[0] to 1 enables overflow flag; Default value of this bit is 1                            |
// |   Setting USE_ADV_FEATURES[1] to 1 enables prog_full flag; Default value of this bit is 1                           |
// |   Setting USE_ADV_FEATURES[2] to 1 enables wr_data_count; Default value of this bit is 1                            |
// |   Setting USE_ADV_FEATURES[3] to 1 enables almost_full flag; Default value of this bit is 0                         |
// |   Setting USE_ADV_FEATURES[4] to 1 enables wr_ack flag; Default value of this bit is 0                              |
// |   Setting USE_ADV_FEATURES[8] to 1 enables underflow flag; Default value of this bit is 1                           |
// |   Setting USE_ADV_FEATURES[9] to 1 enables prog_empty flag; Default value of this bit is 1                          |
// |   Setting USE_ADV_FEATURES[10] to 1 enables rd_data_count; Default value of this bit is 1                           |
// |   Setting USE_ADV_FEATURES[11] to 1 enables almost_empty flag; Default value of this bit is 0                       |
// |   Setting USE_ADV_FEATURES[12] to 1 enables data_valid flag; Default value of this bit is 0  
    .WAKEUP_TIME(0),           // DECIMAL
    .WRITE_DATA_WIDTH(DATA_WIDTH),     // DECIMAL
    .WR_DATA_COUNT_WIDTH(LOG2_AVG_LEN+1)    // DECIMAL
  ) fifo_1clk_for_mv_avg_i (data_in_old
    .almost_empty(),
    .almost_full(),
    .data_valid(),
    .dbiterr(),
    .dout(),
    .empty(empty),
    .full(full),
    .overflow(),
    .prog_empty(),
    .prog_full(),
    .rd_data_count(),
    .rd_rst_busy(),
    .sbiterr(),
    .underflow(),
    .wr_ack(),
    .wr_data_count(wr_data_count),
    .wr_rst_busy(),
    .din(data_in),
    .injectdbiterr(),
    .injectsbiterr(),
    .rd_en(rd_en),
    .rst(~rstn),
    .sleep(),
    .wr_clk(clk),
    .wr_en(data_in_valid)
  );

always @(posedge clk) begin
    if (~rstn) begin
        data_in_reg <= 0;
        wr_data_count_reg <= 0;
        running_total <= 0;
        rd_en <= 0;
        rd_en_start <= 0;
        wr_complete_pulse_reg <= 0;
    end else begin
        wr_complete_pulse_reg <= wr_complete_pulse;
        data_in_reg <= (data_in_valid?data_in:data_in_reg);
        wr_data_count_reg <= wr_data_count;
        rd_en_start <= ((wr_data_count == (FIFO_SIZE))?1:rd_en_start);
        rd_en <= (rd_en_start?wr_complete_pulse:rd_en);
        if (wr_complete_pulse) begin
            running_total <= running_total + ext_data_in - (rd_en_start?ext_data_in_old:0);
        end
    end
end

endmodule
