vsim work.AES_Encryption
add wave -position insertpoint  \
sim:/AES_Encryption/Key \
sim:/AES_Encryption/SubBytesInwire \
sim:/AES_Encryption/SubBytesOut \
sim:/AES_Encryption/SubBytesOutwire \
sim:/AES_Encryption/clk
add wave -position insertpoint  \
sim:/AES_Encryption/su/instate \
sim:/AES_Encryption/su/outstate
force -freeze sim:/AES_Encryption/Key 00101011011111100001010100010110001010001010111011010010101001101010101111110111000101011000100000001001110011110100111100111100 0
force -freeze sim:/AES_Encryption/clk 1 0, 0 {50 ps} -r 100
add wave -position insertpoint  \
sim:/AES_Encryption/in
force -freeze sim:/AES_Encryption/in 00110010010000111111011010101000100010000101101000110000100011010011000100110001100110001010001011100000001101110000011100110100 0
add wave -position insertpoint  \
sim:/AES_Encryption/AddRoundKey_outstate
add wave -position insertpoint  \
sim:/AES_Encryption/AddRoundKey_in
add wave -position insertpoint  \
sim:/AES_Encryption/AddRoundKeyoutstate
add wave -position insertpoint /AES_Encryption/statewire`include "InvShiftRows.v"
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



AddRoundKey op1 (instate,AddRoundKey_outstate,roundKey);
Inv_MixColumns  op2 (AddRoundKey_outstate,Inv_MixColumns_outstate);
InvShiftRows  op3 (Inv_MixColumns_outstate,InvShiftRows_outstate);
InvSubBytes  op4 (InvShiftRows_outstate,InvSubBytes_outstate);

 assign outstate = InvSubBytes_outstate;

endmodule
