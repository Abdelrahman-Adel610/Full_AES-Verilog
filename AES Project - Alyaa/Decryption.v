module Decryption(input [127:0] in, input [127:0] Key, input [5:0] counter, input clk, output [127:0] out);

wire [127:0] inRound;
wire [127:0] inMix;
wire [127:0] outMix;
wire [127:0] inShift;
wire [127:0] inSub;
wire [127:0] outSub;
wire [1407:0] full_key;
reg [127:0] stored;

KeyExpansion kr(Key,  full_key);

assign inRound = (counter == 6'd10)? in : stored;
assign inShift = (counter == 6'd10)? inMix : outMix;
assign out = (counter == 6'd10)? in : ((counter == 6'd19)? outMix : inMix);

AddRoundKey op1 (inRound, inMix, full_key[((counter - 6'd10)*(-128) + 1407) -: 128]);
Inv_MixColumns op2 (inMix, outMix);
InvShiftRows op3 (inShift, inSub);
InvSubBytes op4 (inSub, outSub);

always@(posedge clk) begin
	if(counter < 20)
		stored <= outSub;
end

endmodule