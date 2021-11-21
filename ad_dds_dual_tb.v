`timescale 1ns / 1ps

module top(input clk );

parameter DDS_P_DW =  24;
parameter DDS_D_DW =  24 ;
 
  reg        [DDS_P_DW-1:0]  angle  = 0 ; 
reg [31:0] c = 0 ; 
  
//always @ (posedge clk) angle <= angle+ ( 1024*1024 ) / 2 ;  //32周期出一个波�?
always @ (posedge clk) angle <= angle+ ( 1024*  512  ) ;  //32周期出一个波�?
 
wire [11:0] s12_sin ;  
wire [11:0] s12_cos ; 

  ILA_12x2 ILA_12x2_i  (
        .clk_0(clk),
        .probe0_0(s12_sin),
        .probe1_0(s12_cos)
        );
  
 dds_top dds_top(
.clk(clk ),
.angle(angle) ,
.dds_data_cos(s12_cos),
.dds_data_sin(s12_sin)
);
endmodule 


module dds_top(
input clk ,
input [23:0] angle ,
output reg  [11:0] dds_data_cos,dds_data_sin
);

wire [23:0] dds_data_sin_24 ;
wire [23:0] dds_data_cos_24 ;

ad_dds_dual #(.DDS_TYPE(1),.DDS_D_DW(24),.DDS_P_DW(24)) dds_dual (
.clk(clk), 
.angle(angle),
.scale(4),
.dds_data_sin(dds_data_sin_24) , 
.dds_data_cos(dds_data_cos_24) 
);   

always @ (posedge clk )  dds_data_sin <= dds_data_sin_24[11:0] ;
always @ (posedge clk )  dds_data_cos <= dds_data_cos_24[11:0] ;

endmodule 
  
  
