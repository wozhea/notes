module round_robin_arbiter(
	input clk,
	input rst_n,
	input [3:0] request,//��������
	output [3:0] grant//������ȼ�

);


//�洢������ȼ�λ��
reg [3:0] last_state;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		last_state <= 4'b0001;
	end else if(|request)
		last_state <= {grant[2],grant[1],grant[0],grant[3]};//������������ȼ�������1λ
	else
		last_state <= last_state;
end


//ֻ��������ѯ����չ
wire [7:0] grant_ext;
assign grant_ext = {request,request} & ~({request,request}-last_state);
assign grant = grant_ext[7:4] | grant_ext[3:0];
endmodule
