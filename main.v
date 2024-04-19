`include "ShiftRows.v"
`include "SubBytes.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "InvShiftRows.v"
`include "InvSubBytes.v"
`include "Inv_MixColumns.v"

module EncryptionRound(
    input wire [127:0] instate,
    input wire [127:0] roundKey,	
    output wire [127:0] outstate
);
wire [127:0] SubBytes_outstate;
wire [127:0] ShiftRows_outstate;
wire [127:0] MixColumns_outstate;
wire [127:0] AddRoundKey_outstate;
assign instate=128'h193de3bea0f4e22b9ac68d2aeaf84808;
SubBytes  op1 (instate,SubBytes_outstate);
ShiftRows  op2 (SubBytes_outstate,ShiftRows_outstate);
MixColumns  op3 (ShiftRows_outstate,MixColumns_outstate);
AddRoundKey op4 (MixColumns_outstate,AddRoundKey_outstate, 128'hac7766f319fadc2128d12941575c006a);
assign outstate=AddRoundKey_outstate;
endmodule