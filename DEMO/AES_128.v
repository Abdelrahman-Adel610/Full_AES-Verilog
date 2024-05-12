//`include "ShiftRows.v"
`include "SubBytes.v"
`include "InvShiftRows.v"
`include "InvSubBytes.v"
`include "Inv_MixColumns.v"
`include "display.v"
`include "MixColumns.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"

module AES_128( output reg flag,output wire [20:0] sevSeg,input clk);
reg[4:0] counter;
wire [11:0] bcd;
reg [127:0] cipher;
reg [127:0] in;
reg [127:0] Key;
wire [1407:0] full_key;
reg [127:0] state;
reg [127:0] Current_key;
wire [127:0] Current_keywire;

reg [127:0]SubBytesIn;
reg [127:0]ShiftRowsIn;
reg [127:0]MixColumnsIn;
reg [127:0]AddRoundKeyIn;

wire [127:0]SubBytesOutwire;
wire [127:0]ShiftRowsOutwire;
wire [127:0]MixColwire;
wire [127:0]AddRoundKey_out;


reg [127:0]invSubBytesIn;
reg [127:0]invShiftRowsIn;
reg [127:0]invMixColumnsIn;
reg [127:0]invAddRoundKeyIn;

wire [127:0]invSubBytesOutwire;
wire [127:0]invShiftRowsOutwire;
wire [127:0]invMixColwire;
wire [127:0]invAddRoundKey_out;

reg [7:0]displayOut;


KeyExpansion kr(Key , full_key);


initial
begin
 in='h3243f6a8885a308d313198a2e0370734;
 Key='h2b7e151628aed2a6abf7158809cf4f3c;
 counter=-1;
 flag=1'b0;
#1;
state=in^full_key[127:0];
displayOut=state[7:0];
end


binary_to_bcd DS(AddRoundKey_out[7:0],bcd);
seven_seg seg1(bcd[11-:4],sevSeg[20-:7]);
seven_seg seg2(bcd[7-:4],sevSeg[13-:7]);
seven_seg seg3(bcd[3-:4],sevSeg[6-:7]);


always@(posedge clk)
begin

  counter=counter+1;

  if(counter<11 &&counter>0)
  begin

    if(counter==1)
    begin
      	#1;
         SubBytesIn<=state;
        #1;
        ShiftRowsIn<=SubBytesOutwire;
        #1;
        MixColumnsIn<=ShiftRowsOutwire;
        #1;
       Current_key<= full_key[(counter*(128)+127)-:128];
       AddRoundKeyIn<=MixColwire;
    end

   else if(counter==10)
    begin
      	#1;
        SubBytesIn<=AddRoundKey_out;
        #1;
        ShiftRowsIn<=SubBytesOutwire;
        // #1;
        // MixColumnsIn<=ShiftRowsOutwire;
        #1;
        Current_key<= full_key[(counter*(128)+127)-:128];
        AddRoundKeyIn<=ShiftRowsOutwire;
      	#1;
        cipher<=AddRoundKey_out;
        // #1;
        // displayOut=cipher[7:0];
    end

  else if(counter>1 && counter<10)
    begin
      	#1;
        SubBytesIn<=AddRoundKey_out;
        #1;
        ShiftRowsIn<=SubBytesOutwire;
        #1;
        MixColumnsIn<=ShiftRowsOutwire;
        #1;
        Current_key<= full_key[(counter*(128)+127)-:128];
        AddRoundKeyIn<=MixColwire;      
    end
   
   #1;
    displayOut=AddRoundKey_out[7:0];

  end

else if(counter>=11 && counter<21)
  begin 

  if(counter==11)
  begin 
    #1;
   Current_key=full_key[1407-:128];
   
   invAddRoundKeyIn<=AddRoundKey_out;
   #1;
   invShiftRowsIn<=invAddRoundKey_out;
   #1;
   invSubBytesIn<=invShiftRowsOutwire;
#1;
   displayOut<=invSubBytesOutwire[7:0];
  end

  else if(counter>11 && counter<21)
  begin
      Current_key<=full_key [((counter-11)*(-128)+1407)-:128] ;
      invAddRoundKeyIn<=invSubBytesOutwire;
      #1;
      invMixColumnsIn<=invAddRoundKey_out;
      #1;
      invShiftRowsIn<=invMixColwire;
      #1;
      invSubBytesIn<=invShiftRowsOutwire;
      #1;
  end
  if(counter>=11)
displayOut<=invSubBytesOutwire[7:0];
  end
  else if(counter==21)
  begin 
    cipher=invSubBytesOutwire^full_key[127:0];
    if(cipher==in)
      flag=1'b1;
    else
      flag=1'b0;
  end

else
begin

end

 

  end
 

SubBytes su (SubBytesIn, SubBytesOutwire);
ShiftRows sr(ShiftRowsIn,ShiftRowsOutwire);
MixColumns mc(MixColumnsIn,MixColwire);
AddRoundKey AK (AddRoundKeyIn , AddRoundKey_out , Current_key);





AddRoundKey op1(invAddRoundKeyIn , invAddRoundKey_out , Current_key);
Inv_MixColumns  op2 (invMixColumnsIn,invMixColwire);
InvShiftRows  op3 (invShiftRowsIn,invShiftRowsOutwire);
InvSubBytes  op4 (invSubBytesIn, invSubBytesOutwire);



endmodule