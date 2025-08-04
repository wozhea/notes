module round_robin_arbiter(
	input clk,
	input rst_n,
	input [3:0] request,//输入请求
	output [3:0] grant//输出优先级

);

//存储上一次最高优先级位置
reg [3:0] last_state;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		last_state <= 4'b0001;//默认值
	end else if(|request)
		last_state <= {grant[2],grant[1],grant[0],grant[3]};//有请求，输出后最高优先级向左移1位
	else
		last_state <= last_state;
end

//相减、取反、相与，只能处理请求位在优先级左侧的，需要扩展
wire [7:0] grant_ext;
assign grant_ext = {request,request} & ~({request,request}-last_state);

//请求位在最高优先级右侧，在扩展的高4bit中，相与
assign grant = grant_ext[7:4] | grant_ext[3:0];
endmodule
