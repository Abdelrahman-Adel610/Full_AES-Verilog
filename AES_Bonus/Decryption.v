module Decryption(input [127:0] in, input [255:0] Key, input [5:0] counter, input clk, output [127:0] out, input [5:0] maxRound);

wire [127:0] inRound;
wire [127:0] inMix;
wire [127:0] outMix;
wire [127:0] inShift;
wire [127:0] inSub;
wire [127:0] outSub;
reg [127:0] stored;
wire [1407:0] full_key128;
wire [1663:0] full_key192;
wire [1919:0] full_key256;
wire [127:0] currentKey;

KeyExpansion #(10,4)kr1(Key[255 -: 128] , full_key128);
KeyExpansion #(12,6)kr2(Key[255 -: 192] , full_key192);
KeyExpansion #(14,8)kr3(Key , full_key256);

assign inRound = (counter == maxRound)? in : stored;
assign inShift = (counter == maxRound)? inMix : outMix;
assign out = (counter == maxRound)? in : ((counter == (maxRound + maxRound - 6'd1))? outMix : inMix);
assign currentKey = (maxRound == 6'd10)? full_key128[((counter - 6'd10)*(-128) + 1407) -: 128] : ((maxRound == 6'd12)? full_key192[((counter - 6'd12)*(-128) + 1663) -: 128] : full_key256[((counter - 6'd14)*(-128) + 1919) -: 128]);

AddRoundKey op1 (inRound, inMix, currentKey);
Inv_MixColumns op2 (inMix, outMix);
InvShiftRows op3 (inShift, inSub);
InvSubBytes op4 (inSub, outSub);

always@(posedge clk) begin
	if(counter < maxRound + maxRound)
		stored <= outSub;
end

endmodule