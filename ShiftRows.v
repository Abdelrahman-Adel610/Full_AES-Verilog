module ShiftRows(instate, outstate);

input [127 : 0] instate;
output [127 : 0] outstate;
reg [127 : 0] out;

initial begin
#1;
//first row
out[127 -: 8] = instate[127 -: 8];
out[95 -: 8] = instate[95 -: 8];
out[63 -: 8] = instate[63 -: 8];
out[31 -: 8] = instate[31 -: 8];

//second row
out[119 -: 8] = instate[87 -: 8];
out[87 -: 8] = instate[55 -: 8];
out[55 -: 8] = instate[23 -: 8];
out[23 -: 8] = instate[119 -: 8];

//third row
out[111 -: 8] = instate[47 -: 8];
out[79 -: 8] = instate[15 -: 8];
out[47 -: 8] = instate[111 -: 8];
out[15 -: 8] = instate[79 -: 8];

//fourth row
out[103 -: 8] = instate[7 -: 8];
out[71 -: 8] = instate[103 -: 8];
out[39 -: 8] = instate[71 -: 8];
out[7 -: 8] = instate[39 -: 8];

end    

assign outstate = out;

endmodule

//Testbench
module Test_ShiftRows();

reg [127:0] in;
wire [127:0] out;

initial begin
    in = 128'h3243f6a8885a308d313198a2e0370734;
end

ShiftRows test(in, out);

endmodule