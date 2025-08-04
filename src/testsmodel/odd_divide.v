module odd_divide
#(  parameter N = 5 //奇数分频倍数

)
(
    input clk,
    output clk_out,
    input rst_n
);
reg [$clog2(N):0] cnt1;//保证不溢出，确定分频倍数
reg [$clog2(N):0] cnt2;
reg clk1;
reg clk2;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cnt1 <= 0;
    else if (cnt1 == N-1)
        cnt1 <= 0;
    else 
        cnt1 <= cnt1 + 1;
end

always @(negedge clk or negedge rst_n)begin
    if(!rst_n)
        cnt2 <= 0;
    else if (cnt2 == N-1)
        cnt2 <= 0;
    else 
        cnt2 <= cnt2 + 1;
end
/*
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        clk_out <= 0;
    else if (cnt == 0 || cnt == 1)
        clk_out <= ~clk_out;
    else 
        clk_out <= clk_out;
end
*/
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        clk1 <= 0;
    else if (cnt1 == 0 || cnt1 == (N-1)/2)
        clk1 <= ~clk1;
    else 
        clk1 <= clk1;
end

always @(negedge clk or negedge rst_n)begin
    if(!rst_n)
        clk2 <= 0;
    else if (cnt2 == 0 || cnt2 == (N-1)/2)
        clk2 <= ~clk2;
    else 
        clk2 <= clk2;
end

assign clk_out = clk1 | clk2;




endmodule