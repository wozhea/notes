module round_robin_arbiter(
	input clk,
	input rst_n,
	input [3:0] request,//输入请求
	output [3:0] grant//输出优先级

);


//存储最高优先级位置
reg [3:0] last_state;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		last_state <= 4'b0001;
	end else if(|request)
		last_state <= {grant[2],grant[1],grant[0],grant[3]};//有请求，最高优先级向左移1位
	else
		last_state <= last_state;
end


//只能向左轮询，扩展
wire [7:0] grant_ext;
assign grant_ext = {request,request} & ~({request,request}-last_state);
assign grant = grant_ext[7:4] | grant_ext[3:0];
endmodule
