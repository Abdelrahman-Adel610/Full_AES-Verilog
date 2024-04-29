`include "ShiftRows.v"
`include "SubBytes.v"
`include "display.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "EncryptionRound.v"
`include "KeyExpansion.v"

module AES_Encryption(input [127:0] in , output reg [127:0] cipher , input [127:0] Key ,  output [11:0] state_disp,input clk);
reg[3:0] counter;

wire [1407:0] full_key;
reg [127:0] Current_key;
wire [127:0] Current_keywire;
wire [127:0] statewire;
reg [127:0]SubBytesIn;
reg [127:0]ShiftRowsIn;
reg [127:0]MixColumnsIn;
reg [127:0]AddRoundKeyIn;
wire [127:0]SubBytesOutwire;
wire [127:0]ShiftRowsOutwire;
wire [127:0]MixColwire;
wire [127:0]AddRoundKey_out;
/*
reg [127:0]AddRoundKey_outstate;
wire [127:0]AddRoundKeyoutstate;
wire [127:0]AddRoundKey_in;
*/
KeyExpansion kr(Key , full_key);
AddRoundKey o1 (in , statewire , full_key[127:0]);
initial
begin
counter=0;
end

always@(posedge clk)
begin

if(counter>10)
begin
  counter=12;
end
  if(counter<11)
  begin
counter=counter+1;
   // Current_key<= full_key[(counter*(128)+127)-:128];
    if(counter==1)
    begin
       Current_key<= full_key[(counter*(128)+127)-:128];
      	#5;
        SubBytesIn<=statewire;
        #5;
        ShiftRowsIn<=SubBytesOutwire;
        #5;
        MixColumnsIn<=ShiftRowsOutwire;
        #5;
        AddRoundKeyIn<=MixColwire;
        
    end
    if(counter==10)
    begin
      Current_key<= full_key[(counter*(128)+127)-:128];
      	#5;
        SubBytesIn<=AddRoundKey_out;
        #5;
        ShiftRowsIn<=SubBytesOutwire;
        // #5;
        // MixColumnsIn<=ShiftRowsOutwire;
        #5;
        AddRoundKeyIn<=ShiftRowsOutwire;
	#5;
        cipher<=AddRoundKey_out;
    end
    if(counter>1 && counter<10)
    begin
   Current_key<= full_key[(counter*(128)+127)-:128];
      	#5;
        SubBytesIn<=AddRoundKey_out;
        #5;
        ShiftRowsIn<=SubBytesOutwire;
        #5;
        MixColumnsIn<=ShiftRowsOutwire;
        #5;
        AddRoundKeyIn<=MixColwire;
    end
  end

end


wire[127:0] zz;
SubBytes su (SubBytesIn, SubBytesOutwire);
ShiftRows sr(ShiftRowsIn,ShiftRowsOutwire);
MixColumns mc(MixColumnsIn,MixColwire);
AddRoundKey AK (AddRoundKeyIn , AddRoundKey_out , Current_key);
binary_to_bcd DS(AddRoundKey_out[7:0],state_disp);
endmodule