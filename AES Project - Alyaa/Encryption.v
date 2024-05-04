module Encryption(input [127:0] in, input [127:0] Key, input [5:0] counter, input clk, output [127:0] out);

wire [127:0] inRound;
wire [127:0] inSub;
wire [127:0] inShift;
wire [127:0] inMix;
wire [127:0] outMix;
reg [127:0] stored;
wire [1407:0] full_key;

KeyExpansion kr(Key,  full_key);

assign inRound = (counter == 0)? in : stored;
assign out = (counter == 0)? in : inSub;

AddRoundKey op4 (inRound, inSub, full_key[((counter)*(128)+127)-:128]);
SubBytes  op1 (inSub, inShift);
ShiftRows  op2 (inShift, inMix);
MixColumns  op3 (inMix, outMix);

always@(posedge clk) begin
	if(counter < 6'd9)
		stored <= outMix;
	else
		stored <= inMix;
end

endmodule