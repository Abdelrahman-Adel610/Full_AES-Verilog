`include "ShiftRows.v"
`include "SubBytes.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "EncryptionRound.v"
`include "KeyExpansion.v"
module AES_Encryption(input [127:0] in , output [127:0] out , input [127:0] Key/* , input clk*/);
wire [1407:0] state;
wire [1407:0] full_key;
wire [127:0] SubBytes_out;
wire [127:0] ShiftRows_out;
wire [127:0] AddRoundKey_out;
KeyExpansion kr(Key , full_key);
AddRoundKey o1 (in , state[1407:1280] , full_key[127:0]);
genvar i;
generate
    for (i = 1 ; i < 10 ; i = i + 1 ) begin : encrption
     //   always@(clk)
        EncryptionRound er ( state[(i*(-128)+1535)-:128] , full_key[(i*(128)+127)-:128] ,state[(i*(-128)+1407)-:128]); // in , key , out
       // $monitor(“Time=%0d state[(i*(-128)+1535)-:128]=%b full_key [(i*(-128)+1407)-:128]=%b state[(i*(-128)+1407)-:128]=%b”, $time,state[(i*(-128)+1535)-:128],full_key [(i*(-128)+1407)-:128],state[(i*(-128)+1407)-:128]);
    end
endgenerate
//always@(clk) begin
    SubBytes su (state[255:128] , SubBytes_out);
    ShiftRows sh (SubBytes_out , ShiftRows_out);
    AddRoundKey ak (ShiftRows_out , state[127:0] , full_key[1407:1280]);
//end
assign out = state[127:0];

endmodule