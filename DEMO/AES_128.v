 `include "ShiftRows.v"
 `include "SubBytes.v"
 `include "InvShiftRows.v"
 `include "InvSubBytes.v"
 `include "Inv_MixColumns.v"
 `include "display.v"
 `include "MixColumns.v"
 `include "AddRoundKey.v"
 `include "KeyExpansion.v"

module AES #(parameter nr=10,parameter nw=4)(input[127:0] in,input[32*nw-1:0] Key, output reg flag,output wire [20:0] sevSeg,input clk,input reset);
reg[4:0] counter;
wire [11:0] bcd;
reg [127:0] cipher;
reg rst;
/*
wire [127:0] in;
wire [127:0] Key;
*/
wire [((nr + 1) * 128 - 1) : 0] full_key;

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
reg [7:0]displayOut;


KeyExpansion #(nr,nw)kr(Key , full_key);

initial
begin
 flag=0;
 counter<=1;
end


//The next always block is  responsible for getting the bits to be displayed each round
always@(*)
begin
rst=reset;
  
  if(counter==1)
  begin
  displayOut<=in[7:0]; 
  end
  
  if(counter>1 && counter<nr+1)        																							   
  displayOut<=AddRoundKey_out[7:0];

  if(counter==nr+1)
  begin
  displayOut<=ShiftRowsOutwire[7:0]^full_key[((nr+1)*128-121)-:8];/////////////////////
end

  if(counter>nr+1&&counter<2*nr+1)
  begin 
  displayOut<=invMixColwire[7:0];
  end

  if(counter==2*nr+1)
  begin
  displayOut<=invAddRoundKey_out;
  cipher<=invAddRoundKey_out;
  flag=(invAddRoundKey_out==in)?1'b1:1'b0;
  end

  //flag=(invAddRoundKey_out==in)?1'b1:1'b0;

end

//The next always block is responsible for setting the proper input for each round [1-10]==>ENCRP [11-21]==>DECRP
always@(negedge clk)
begin
if(rst==1)
begin
counter<=1;
end
else
begin
if(counter>nr+1)  Current_key<=full_key [((counter+1-(nr+1))*(-128)+((nr+1)*128-1))-:128] ;
else             Current_key<= full_key[(counter*(128)+127)-:128]; 

 if(counter==1)
begin
//   Current_key<= full_key[(counter*(128)+127)-:128]; 
 SubBytesIn<=in^full_key[127:0];
end
else if(counter>1&&counter<=nr)          //during Encryption
begin
  // Current_key<= full_key[(counter*(128)+127)-:128]; 
   SubBytesIn<=AddRoundKey_out;
end

if(counter==nr+1)                         //The first round of Decryption
begin
  cipher<=ShiftRowsOutwire^Current_key; //setting the Encryption output cipher 
  invShiftRowsIn<=ShiftRowsOutwire^full_key[((nr+1)*128-1)-:128]^Current_key;
  Current_key<=full_key [((counter+1-(nr+1))*(-128)+((nr+1)*128-1))-:128] ;
end
else if(counter>nr+1&&counter<2*nr+1)         //during Decryption
begin
  //Current_key<=full_key [((counter+1-(nr+1))*(-128)+(352*nw-1))-:128] ;
  invShiftRowsIn<=invMixColwire;
end
if(counter<2*nr+2)
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