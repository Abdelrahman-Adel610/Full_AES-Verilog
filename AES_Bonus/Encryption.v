module Encryption(input [127:0] in, input [255:0] Key, input [5:0] counter, input clk, output [127:0] out, input [5:0] maxRound);

wire [127:0] inRound;
wire [127:0] inSub;
wire [127:0] inShift;
wire [127:0] inMix;
wire [127:0] outMix;
reg [127:0] stored;
wire [1407:0] full_key128;
wire [1663:0] full_key192;
wire [1919:0] full_key256;
wire [127:0] currentKey;

KeyExpansion #(10,4)kr1(Key[255 -: 128] , full_key128);
KeyExpansion #(12,6)kr2(Key[255 -: 192] , full_key192);
KeyExpansion #(14,8)kr3(Key , full_key256);

assign currentKey = (maxRound == 6'd10)? full_key128[((counter)*(128)+127)-:128] : ((maxRound == 6'd12)? full_key192[((counter)*(128)+127)-:128] : full_key256[((counter)*(128)+127)-:128]);
assign inRound = (counter == 0)? in : stored;
assign out = (counter == 0)? in : inSub;

AddRoundKey op4 (inRound, inSub, currentKey);
SubBytes  op1 (inSub, inShift);
ShiftRows  op2 (inShift, inMix);
MixColumns  op3 (inMix, outMix);

always@(posedge clk) begin
	if(counter < maxRound - 6'd1)
		stored <= outMix;
	else
		stored <= inMix;
end

endmodule