`include "AES_Encryption.v"
`include "AES_Decryption.v"
module AES(input [127:0] instate , input clk , sw1 , sw2 , input [127:0] key );
wire [127:0] encryption_out;
wire [127:0] decryption_out;
wire decryp_Flag ;
wire encrp_Flag;
wire [127:0] exp_encryption_out;
assign instate=128'h00112233445566778899aabbccddeeff;
assign Key=128'h000102030405060708090a0b0c0d0e0f;
assign exp_encryption_out = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
AES_Encryption en(instate , encryption_out , key , clk); 
assign encrp_Flag = (encryption_out == exp_encryption_out)? 1'b1 : 1'b0;
AES_Decryption de(encryption_out , decryption_out , key , clk); 
assign decryp_Flag = (decryption_out == instate)? 1'b1 : 1'b0; 
endmodule
 