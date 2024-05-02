module DecryptionRound(input wire [127:0] instate ,input wire [127:0] roundKey ,output [127:0] outstate );
	wire [127:0] InvSubBytes_outstate;
	wire [127:0] InvShiftRows_outstate;
	wire [127:0] Inv_MixColumns_outstate;
	wire [127:0] AddRoundKey_outstate;

	InvShiftRows  op2 (instate,InvShiftRows_outstate);
	InvSubBytes  op1 (InvShiftRows_outstate,InvSubBytes_outstate);
	AddRoundKey op3 (InvSubBytes_outstate,AddRoundKey_outstate,roundKey);
	Inv_MixColumns  op4 (AddRoundKey_outstate,outstate);
endmodule