module AddRoundKey(instate, outstate, Key);

input [127 : 0] instate;
reg [127 : 0] out;
output [127 : 0] outstate;
input [127 : 0] Key;
integer i;

initial
	begin
		#1;
		for(i = 0; i < 128; i = i + 1)
			begin
				out[i] = instate[i] ^ Key[i];
			end
	end

assign outstate = out;
endmodule

module Test_AddRoundKey();

reg [127:0] in;
wire [127:0] out;
reg [127:0] key;
initial begin
    in = 128'h473794ed40d4e4a5a3703aa64c9f42bc;
    key = 128'hac7766f319fadc2128d12941575c006a;
end

AddRoundKey test(in, out, key);

endmodule