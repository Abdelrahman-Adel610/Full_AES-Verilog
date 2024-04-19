module AddRoundKey(instate, outstate, Key);
input [127 : 0] instate;
output [127 : 0] outstate;
input [127 : 0] Key;
assign outstate = instate ^ Key;
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