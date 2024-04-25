`include "InvShiftRows.v"
`include "InvSubBytes.v"
`include "Inv_MixColumns.v"
`include "AddRoundKey.v"
module DecryptionRound(
    input wire [127:0] instate,
    input wire [127:0] roundKey,	
    output wire [127:0] outstate
);
wire [127:0] InvSubBytes_outstate;
wire [127:0] InvShiftRows_outstate;
wire [127:0] Inv_MixColumns_outstate;
wire [127:0] AddRoundKey_outstate;



AddRoundKey op3 (instate,AddRoundKey_outstate,roundKey);
Inv_MixColumns  op4 (AddRoundKey_outstate,Inv_MixColumns_outstate);
InvShiftRows  op2 (Inv_MixColumns_outstate,InvShiftRows_outstate);
InvSubBytes  op1 (InvShiftRows_outstate,InvSubBytes_outstate);
assign outstate=InvSubBytes_outstate;

endmodule
