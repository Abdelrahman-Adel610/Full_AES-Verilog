module ShiftRows(instate, outstate);

input [127 : 0] instate;
output reg [127 : 0] outstate;

always@(instate)
begin
//first row
 outstate[127 -: 8] = instate[127 -: 8];
 outstate[95 -: 8] = instate[95 -: 8];
 outstate[63 -: 8] = instate[63 -: 8];
 outstate[31 -: 8] = instate[31 -: 8];

//second row
 outstate[119 -: 8] = instate[87 -: 8];
 outstate[87 -: 8] = instate[55 -: 8];
 outstate[55 -: 8] = instate[23 -: 8];
 outstate[23 -: 8] = instate[119 -: 8];

//third row
 outstate[111 -: 8] = instate[47 -: 8];
 outstate[79 -: 8] = instate[15 -: 8];
 outstate[47 -: 8] = instate[111 -: 8];
 outstate[15 -: 8] = instate[79 -: 8];

//fourth row
 outstate[103 -: 8] = instate[7 -: 8];
 outstate[71 -: 8] = instate[103 -: 8];
 outstate[39 -: 8] = instate[71 -: 8];
 outstate[7 -: 8] = instate[39 -: 8];
end

endmodule

 