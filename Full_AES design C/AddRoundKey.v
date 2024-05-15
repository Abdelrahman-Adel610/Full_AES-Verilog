module AddRoundKey(instate, outstate, Key);
input [127 : 0] instate;
output  [127 : 0] outstate;
input [127 : 0] Key;
assign outstate = instate ^ Key;
endmodule
 