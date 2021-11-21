
/*
by liwei , mcupro@gmail.com
*/

module MULT_MACRO #(
parameter LATENCY  = 3,
parameter WIDTH_A =16,
parameter WIDTH_B =16
)  (
    input CE  ,  RST ,  CLK ,
    input [(WIDTH_A-1):0]A  ,
    input [(WIDTH_B-1):0]B  ,
    output reg  [(WIDTH_A+WIDTH_B-1):0] P  );
	 
	reg [(WIDTH_A+WIDTH_B-1):0] P0,P1  ;
	
	always @(posedge CLK ) if ( RST ) P0 <= 0 ; else if ( CE ) P0 <= A * B ; else P0 <= P0 ; 
	always @(posedge CLK ) P1<=P0;
	always @(posedge CLK ) P<=P1;

endmodule 
	

