
`include "ShiftRows.v"
`include "SubBytes.v"
`include "InvShiftRows.v"
`include "InvSubBytes.v"
`include "Inv_MixColumns.v"
`include "display.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"

module AES_128( output wire flag,output wire [20:0] sevSeg,input clk);

reg[4:0] counter;
wire [11:0] bcd;
reg [127:0] cipher;
wire [127:0] in;
wire [127:0] Key;
wire [1407:0] full_key;
reg [127:0] initialstate;
reg [127:0] Current_key;
wire [127:0] Current_keywire;

reg [127:0]SubBytesIn;

wire [127:0]SubBytesOutwire;
wire [127:0]ShiftRowsOutwire;
wire [127:0]MixColwire;
wire [127:0]AddRoundKey_out;


reg [127:0]invShiftRowsIn;

wire [127:0]invSubBytesOutwire;
wire [127:0]invShiftRowsOutwire;
wire [127:0]invMixColwire;
wire [127:0]invAddRoundKey_out;
reg flg;
reg [7:0]displayOut;

assign in=128'h00112233445566778899aabbccddeeff;
assign Key=128'h000102030405060708090a0b0c0d0e0f;

KeyExpansion kr(Key , full_key);

assign flag=flg;
initial
begin
 counter<=1;
end


//The next always block is  responsible for getting the bits to be displayed each round
always@(*)
begin
  
  if(counter==1)
  begin
  displayOut<=in[7:0]; 
  end
  
  if(counter>1 && counter<11)        																							   
  displayOut<=AddRoundKey_out[7:0];

  if(counter==11)
  begin
  displayOut<=ShiftRowsOutwire[7:0]^full_key[1287:1280];
  end
  if(counter>11&&counter<21)
  begin 
  displayOut<=invMixColwire[7:0];
  end
  if(counter>11)
  begin
  
  cipher<=invAddRoundKey_out;
  flg=(invAddRoundKey_out==in)?1'b1:1'b0;
  end

if(counter==21)
begin
displayOut<=invAddRoundKey_out;
end
end

//The next always block is responsible for setting the proper input for each round [1-10]==>ENCRP [11-21]==>DECRP
always@(negedge clk)
begin

 if(counter==1)
begin
 Current_key<= full_key[(counter*(128)+127)-:128];
 SubBytesIn<=in^full_key[127:0];
 counter<=counter+1;
end
else if(counter>1&&counter<=10)
begin
   Current_key<= full_key[(counter*(128)+127)-:128];
   SubBytesIn<=AddRoundKey_out;
  
   counter<=counter+1;
end


if(counter==11)
begin
  
  cipher<=ShiftRowsOutwire^Current_key;
  invShiftRowsIn<=ShiftRowsOutwire^full_key[1407-:128]^Current_key;
  Current_key<=full_key [((counter+1-11)*(-128)+1407)-:128] ;
  counter<=counter+1;

end
else if(counter>11&&counter<21)
begin
   
     Current_key<=full_key [((counter+1-11)*(-128)+1407)-:128] ;
      invShiftRowsIn<=invMixColwire;
      counter<=counter+1;
end
if(counter==22)
begin
 
   counter<=counter+1;
end


end


SubBytes su (SubBytesIn, SubBytesOutwire);
ShiftRows sr(SubBytesOutwire,ShiftRowsOutwire);
MixColumns mc(ShiftRowsOutwire,MixColwire);
AddRoundKey AK (MixColwire , AddRoundKey_out , Current_key);



InvShiftRows  isr (invShiftRowsIn,invShiftRowsOutwire);
InvSubBytes  isb (invShiftRowsOutwire, invSubBytesOutwire);
AddRoundKey ark(invSubBytesOutwire , invAddRoundKey_out , Current_key);
Inv_MixColumns  imc (invAddRoundKey_out,invMixColwire);


binary_to_bcd DS(displayOut[7:0],bcd);
seven_seg seg1(bcd[11-:4],sevSeg[20-:7]);
seven_seg seg2(bcd[7-:4],sevSeg[13-:7]);
seven_seg seg3(bcd[3-:4],sevSeg[6-:7]);

endmodule
