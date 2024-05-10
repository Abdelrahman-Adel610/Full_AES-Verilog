`include "AES_128.v"

module Main
(flag,clk,controller,sevenSeg,reset);
output reg [20:0] sevenSeg;
wire [20:0] seven_seg;
reg[4:0] counter;
output  flag;
wire [127:0]in;
wire [255:0]key;
input clk;
input reset;
reg[3:0]nr;
input[1:0]controller;
assign in=128'h00112233445566778899aabbccddeeff;
assign key=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
always@(*)
begin
    if(controller==1)
    begin
     nr=10;
     counter=1;
    end
    if(controller==2)
    begin
     nr=12;
     counter=1;
    end
    if(controller==3)
    begin
     nr=14;
     counter=1;
    end
end

AES AES_md(in,key,flag,seven_seg,clk,reset,nr,counter); 

endmodule 