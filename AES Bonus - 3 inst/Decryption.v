module Decryption#(parameter maxRound = 10 , parameter N = 1) (input [127:0] in,input [5:0] counter , input clk, output [127:0] out, input [(265* N + 1151 ):0] full_key);

wire [127:0] inRound;
wire [127:0] inMix;
wire [127:0] outMix;
wire [127:0] inShift;
wire [127:0] inSub;
wire [127:0] outSub;
reg [127:0] stored; 
wire [127:0] currentKey;

//In first round of decryption, input of addRoundKey is input, else, it's the output of invSubBytes
assign inRound = (counter == maxRound)? in : stored;

//In first round, input of invShiftRows is output of addRoundKey, else, it's the output of invMixColumns
assign inShift = (counter == maxRound)? inMix : outMix;

//Out in first round is the same as input, in last round is the output of addRoundKey, else it's output of invMixColumns
assign out = (counter == maxRound)? in : ((counter == (maxRound + maxRound - 6'd1))? outMix : inMix);
assign currentKey = (maxRound == 10)? full_key[((counter - 6'd10)*(-128) + 1407) -: 128] : ((maxRound == 12)? full_key[((counter - 6'd12)*(-128) + 1663) -: 128] : full_key[((counter - 6'd14)*(-128) + 1919) -: 128]);

AddRoundKey op1 (inRound, inMix, currentKey);
Inv_MixColumns op2 (inMix, outMix);
InvShiftRows op3 (inShift, inSub);
InvSubBytes op4 (inSub, outSub);

always@(posedge clk) begin
	  
	//Store output of invSubBytes to pass it to addRoundKey
	if(counter < maxRound * 2) begin
		stored <= outSub;
	end
 
end

endmodule