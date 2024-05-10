`include "AES_128.v"
module Main(flag,clk,controller,sevenSeg,reset);
output reg [20:0] sevenSeg;
wire [20:0] seven_seg_128;
wire [20:0] seven_seg_192;
wire [20:0] seven_seg_256;
wire  flag_128;
wire  flag_192;
wire  flag_256;
output reg  flag;
wire [127:0]in;
wire [255:0]key;
input clk;
input reset;
input[1:0]controller;
assign in=128'h00112233445566778899aabbccddeeff;
assign key=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
always@(*)
begin
    if(controller==1)
    begin
        flag=flag_128;
        sevenSeg=seven_seg_128;
    end
    if(controller==2)
    begin
        flag=flag_192;
        sevenSeg=seven_seg_192;
    end
    if(controller==3)
    begin
        flag=flag_256;
        sevenSeg=seven_seg_256;
    end
end

AES#(10,4) AES128(in,key[255-:128],flag_128,seven_seg_128,clk,reset); 
AES#(12,6) AES192(in,key[255-:192],flag_192,seven_seg_192,clk,reset); 
AES#(14,8) AES256(in,key,flag_256,seven_seg_256,clk,reset); 


endmodule 