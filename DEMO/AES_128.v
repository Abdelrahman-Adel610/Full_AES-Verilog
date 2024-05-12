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
rst=reset;   //assigning the input reset to a reg to use it 
  
  if(counter==1)  // in the first round the input is displayed
  begin
  displayOut<=in[7:0]; 
  end
  
  if(counter>1 && counter<nr+1)        //During the Encryption the output of AddRoundKey is being displayed																						   
  displayOut<=AddRoundKey_out[7:0];

  if(counter==nr+1)                   // The last round of Encryption   
  begin
    displayOut<=ShiftRowsOutwire^Current_key;  // we neglect the Mixcol Operation 
  end

  if(counter>nr+1&&counter<2*nr+1)    //During the Decryption the output of invMixColwire is being displayed
  begin 
  displayOut<=invMixColwire[7:0];
  end

  if(counter==2*nr+1)     		// The last round of Decryption         
  begin
  displayOut<=invAddRoundKey_out;
  cipher<=invAddRoundKey_out;           //setting the output of Decryption (it must be equal to the inital input)
  flag=(invAddRoundKey_out==in)?1'b1:1'b0; //This is responsible for setting the flag
  end

end

//The next always block is responsible for setting the proper input for each round [1-10]==>ENCRP [11-21]==>DECRP
always@(negedge clk)
begin
if(rst==1)   //if reset is on counter should be resetted to 1 
begin
counter<=1;
end
else
begin
		/******The next code segment is responsible for getting the proper key for each round*******/
if(counter>nr+1)  Current_key<=full_key [((counter+1-(nr+1))*(-128)+((nr+1)*128-1))-:128] ;
else             Current_key<= full_key[(counter*(128)+127)-:128]; 

 if(counter==1)
begin 
 SubBytesIn<=in^full_key[127:0];
end
else if(counter>1&&counter<=nr)          //during Encryption
begin 
   SubBytesIn<=AddRoundKey_out;
end

if(counter==nr+1)                          //The first round of Decryption
begin
  cipher<=ShiftRowsOutwire^Current_key;    //setting the Encryption output cipher 
  invShiftRowsIn<=ShiftRowsOutwire^full_key[((nr+1)*128-1)-:128]^Current_key; //starting the Decryption operation
  Current_key<=full_key [((counter+1-(nr+1))*(-128)+((nr+1)*128-1))-:128] ; //Setting the current_key with the first Decryption key
end
else if(counter>nr+1&&counter<2*nr+1)      //during Decryption
begin
  invShiftRowsIn<=invMixColwire;
end

if(counter<2*nr+2)  //to stop the counter after finishing the whole operation
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
