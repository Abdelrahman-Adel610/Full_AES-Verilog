module AddRoundKey(instate, outstate, Key);
input [127 : 0] instate;
output reg [127 : 0] outstate;
input [127 : 0] Key;
always@(instate)
begin
outstate=instate ^ Key;
end
endmodule
 