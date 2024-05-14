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
wire [((nr + 1) * 128 - 1) : 0] full_key;

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
 counter<=5'b00001;   
end
/*
assign displayOut=(counter==5'b00001)?in[7:0]:(counter>5'b00001 && counter<nr+1'b1) ?AddRoundKey_out[7:0]:(counter==nr+1'b1)? ShiftRowsOutwire[7:0]^Current_key[7:0]:(counter>nr+1'b1&&counter<2*nr+1'b1)?invMixColwire[7:0]: invAddRoundKey_out[7:0];
*/
//The next always block is  responsible for getting the bits to be displayed each round
always@(*)
begin
 

  if(counter==5'b00001)	
begin  // in the first round the input is displayed and the flag is set initially 0
   displayOut<=in[7:0]; flag<=0;
end
  else if(counter>5'b00001 && counter<nr+1'b1)        //During the Encryption the output of AddRoundKey is being displayed																						   
  displayOut<=AddRoundKey_out[7:0];

  else if(counter==nr+1'b1)                   // The last round of Encryption   
  begin
    displayOut<=ShiftRowsOutwire[7:0]^Current_key[7:0];  // we neglect the Mixcol Operation 
  end

  else if(counter>nr+1'b1&&counter<2*nr+1'b1)    //During the Decryption the output of invMixColwire is being displayed
  begin 
  displayOut<=invMixColwire[7:0];
  end

  else if(counter==2*nr+1'b1)     		// The last round of Decryption         
  begin
  displayOut<=invAddRoundKey_out[7:0]; 
  flag<=(invAddRoundKey_out==in)?1'b1:1'b0; //the output of decryption at the last round (it must equal the input)
  
  end
end

//The next always block is responsible for setting the proper input for each round [1-10]==>ENCRP [11-21]==>DECRP

always@(negedge clk or posedge reset) //sensitive to reset and clock
begin

if(reset==1'b1)   //if reset is on ==> counter should be resetted ==> 1 
begin
counter<=5'b00001;
end
else

 begin		/******The next code segment is responsible for getting the proper key for each round*******/
if(counter>nr+1)  Current_key<=full_key [((counter+1-(nr+1))*(-128)+((nr+1)*128-1))-:128] ;
else              Current_key<= full_key[(counter*(128)+127)-:128];	 
				/*******************************************************************************************/
				
 if(counter==5'b00001)
begin
 SubBytesIn<=in^full_key[127:0];
end

else if(counter>5'b00001&&counter<=nr)          //during Encryption
begin 
   SubBytesIn<=AddRoundKey_out;
end
 
else if(counter==nr+1)                          //The first round of Decryption
begin
  invShiftRowsIn<=ShiftRowsOutwire^full_key[((nr+1)*128-1)-:128]^Current_key; //starting the Decryption operation
  Current_key<=full_key [((counter+1-(nr+1))*(-128)+((nr+1)*128-1))-:128] ; //Setting the current_key with the first Decryption key
end

else                               //Decryption Oreation
begin     

if(counter>nr+1&&counter<2*nr+1)      //during Decryption
begin
  invShiftRowsIn<=invMixColwire;
end

end



						/*******************Updating the counter********************/ 
if(counter<=2*nr+1)  //to stop the counter after finishing the whole operation
 counter<=counter+1'b1;
else counter<=counter;
					   /***********************************************************/ 
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

