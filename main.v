`include "ShiftRows.v"
`include "SubBytes.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "InvShiftRows.v"
`include "InvSubBytes.v"
`include "Inv_MixColumns.v"
module EncryptionRound(
    input wire [127:0] instate,
    output wire [127:0] outstate
);
wire [127:0] ShiftRows_instate;
wire [127:0] MixColumns_instate;
wire [127:0] SubBytes_outstate;
wire [127:0] ShiftRows_outstate;
wire [127:0] MixColumns_outstate;
assign instate=128'h193de3bea0f4e22b9ac68d2aeaf84808;
SubBytes  op1 (instate,SubBytes_outstate);
assign ShiftRows_instate=SubBytes_outstate;
ShiftRows  op2 (ShiftRows_instate,ShiftRows_outstate);
assign MixColumns_instate=ShiftRows_outstate;
MixColumns  op3 (MixColumns_instate,MixColumns_outstate);
endmodule