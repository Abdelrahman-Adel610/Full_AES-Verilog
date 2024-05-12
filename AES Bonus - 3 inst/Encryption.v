module Encryption#(parameter maxRound = 10  , parameter N = 1) (input [127:0] in, input [5:0] counter ,input clk, output [127:0] out, input [(265* N + 1151 ):0] full_key);

wire [127:0] inRound;
wire [127:0] inSub;
wire [127:0] inShift;
wire [127:0] inMix;
wire [127:0] outMix;
reg [127:0] stored;
 
//If first round, input of addRoundKey is in, else, it's output of mixColumns stored
assign inRound = (counter == 0)? in : stored;

//If first round out = in, else, out is output of addRoundKey
assign out = (counter == 0)? in : inSub;

//                  . -> out
//in -> addRoundKey -> subBytes -> shiftRows -> mixColumns -> .
//   ^                                        |               |
//   |.................... <- stored <- .......................        

AddRoundKey op4 (inRound, inSub, full_key[((counter)*(128)+127)-:128]);
SubBytes  op1 (inSub, inShift);
ShiftRows  op2 (inShift, inMix);
MixColumns  op3 (inMix, outMix);

always@(posedge clk) begin
	 
	//Store the output of mixColumns to pass it to addRoundKey again
	if(counter + 1 < maxRound )
		stored <= outMix;
	else
		stored <= inMix;	//In last round skip mixColumns and pass output of shiftRows to addRoundKey
	 
	
end

endmodule
