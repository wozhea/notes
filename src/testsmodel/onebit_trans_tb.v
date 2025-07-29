
`timescale 1ns/1ps      //????
`define    Clock_a 10   //?????????????
`define    Clock_b 100  //?????????????
 
module onebit_trans_tb;
 
//========================< ?? >==========================================
reg                         clka                    ;
reg                         clkb                    ;
reg                         rst_n                   ;
reg                         bit_a                   ;
wire 			    bit_b;
//==========================================================================
//==    ????
//==========================================================================
onebit_trans onebit_trans_inst(
	.clka(clka),
	.clkb(clkb),
	.rst_n(rst_n),
	.bit_a(bit_a),
	.bit_b(bit_b)
);
//==========================================================================
//==    ?????????
//==========================================================================
initial begin
    clka = 1;
    forever
        #(`Clock_a/2) clka = ~clka;
end
 
initial begin
    clkb = 1;
    forever
        #(`Clock_b/2) clkb = ~clkb;
end
 
initial begin
    rst_n = 0; #(`Clock_a*2+1);
    rst_n = 1;
end
 
//==========================================================================
//==    ??????
//==========================================================================
initial begin
    bit_a = 0;
    #(`Clock_a*2+1); //?????
    bit_a = 1;
    #(`Clock_a);
    bit_a = 0;
    #(`Clock_b*100);
    $stop;
end
 
 
endmodule