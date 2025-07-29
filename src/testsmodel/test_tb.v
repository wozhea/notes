module shift;
reg [4:0] a;
reg [4:0] b;
reg [4:0] result;
initial begin
	a = 4'b0000;
	b = 4'b1111;
	result = a-b;
$display("hello world");
$display("%b\n",result);
end

//$display("%d\n%d",start,result);


endmodule