`include "InvShiftRows.v"
`include "InvSubBytes.v"
`include "Inv_MixColumns.v"
`include "AddRoundKey.v"
`include "DecryptionRound.v"
`include "KeyExpansion.v"
module AES_Decryption(input [127:0] in , output [127:0] out , input [127:0] Key/*, input clk*/);
wire [1407:0] state;
wire [1407:0] full_key;
wire [127:0] InvSubBytes_out;
wire [127:0] InvShiftRows_out;
KeyExpansion kr(Key , full_key);  
    
 AddRoundKey preak (in , InvSubBytes_out , full_key[1407-:128]);
 InvShiftRows preIsh (InvSubBytes_out , InvShiftRows_out);
 InvSubBytes preIsu (InvShiftRows_out , state[1279-:128]);


 //AddRoundKey preak (InvShiftRows_out , state[1279-:128] , full_key[1407-:128]);

genvar i;
generate
    for (i = 1 ; i < 10 ; i = i + 1 ) begin : decryp
      	//  always@(clk)
      	DecryptionRound dr (state[(i*(-128)+1407)-:128] , full_key [(i*(-128)+1407)-:128] ,state[(i*(-128)+1279)-:128]); // in , key , out
      	// $monitor(?Time=%0d state[(i*(-128)+1535)-:128]=%b full_key [(i*(-128)+1407)-:128]=%b state[(i*(-128)+1407)-:128]=%b?, $time,state[(i*(-128)+1535)-:128],full_key [(i*(-128)+1407)-:128],state[(i*(-128)+1407)-:128]);
    end
endgenerate
//always@(clk) begin
  AddRoundKey ak (state[127:0] , out , full_key[127:0]);
//end
assign out = state[127:0];
endmodule