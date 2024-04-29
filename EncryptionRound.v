`include "ShiftRows.v"
`include "SubBytes.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
module EncryptionRound(
    input wire [127:0] instate,
    input wire [127:0] roundKey,	
    output reg [127:0] outstate 
);
wire [127:0] SubBytes_outstate;
wire [127:0] ShiftRows_outstate;
wire [127:0] MixColumns_outstate;
wire [127:0] AddRoundKey_outstate;
reg clk;
reg[7:0]counter;
initial
counter=0;
SubBytes  op1 (instate,SubBytes_outstate,counter);
/*
ShiftRows  op2 (SubBytes_outstate,ShiftRows_outstate);
MixColumns  op3 (ShiftRows_outstate,MixColumns_outstate);
AddRoundKey op4 (MixColumns_outstate,AddRoundKey_outstate,roundKey);
*/
always@(posedge clk)
begin 
if(counter<10)
begin
counter=counter+1;
end
end
endmodule