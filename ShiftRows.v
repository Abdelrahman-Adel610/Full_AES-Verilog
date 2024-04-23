module ShiftRows(instate, outstate);

input [127 : 0] instate;
output [127 : 0] outstate;



//first row
assign outstate[127 -: 8] = instate[127 -: 8];
assign outstate[95 -: 8] = instate[95 -: 8];
assign outstate[63 -: 8] = instate[63 -: 8];
assign outstate[31 -: 8] = instate[31 -: 8];

//second row
assign outstate[119 -: 8] = instate[87 -: 8];
assign outstate[87 -: 8] = instate[55 -: 8];
assign outstate[55 -: 8] = instate[23 -: 8];
assign outstate[23 -: 8] = instate[119 -: 8];

//third row
assign outstate[111 -: 8] = instate[47 -: 8];
assign outstate[79 -: 8] = instate[15 -: 8];
assign outstate[47 -: 8] = instate[111 -: 8];
assign outstate[15 -: 8] = instate[79 -: 8];

//fourth row
assign outstate[103 -: 8] = instate[7 -: 8];
assign outstate[71 -: 8] = instate[103 -: 8];
assign outstate[39 -: 8] = instate[71 -: 8];
assign outstate[7 -: 8] = instate[39 -: 8];


endmodule

 