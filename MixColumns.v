module MixColumns(input [127:0] in , output reg [127:0] out);

function [7:0] Mult2 (input [7:0] in1);
    Mult2 = in1[7] ? (( in1 << 1 ) ^ 8'h1b) : (in1 << 1);
endfunction

function [7:0] Mult3 (input [7:0] in2);
     Mult3 = in2 ^ Mult2(in2);
endfunction

integer i;
initial begin
for (i = 1 ; i < 5 ; i = i + 1) begin 
    out[(i*32-1)-:8] = Mult2(in[(i*32-1)-:8]) ^ Mult3(in[(i*32-9)-:8]) ^ in[(i*32-17)-:8] ^ in[(i*32-25)-:8];
    out[(i*32-9)-:8] = in[(i*32-1)-:8] ^ Mult2(in[(i*32-9)-:8]) ^ Mult3(in[(i*32-17)-:8]) ^ in[(i*32-25)-:8];
    out[(i*32-17)-:8] = in[(i*32-1)-:8] ^ in[(i*32-9)-:8] ^ Mult2(in[(i*32-17)-:8]) ^ Mult3(in[(i*32-25)-:8]);
    out[(i*32-25)-:8] = Mult3(in[(i*32-1)-:8]) ^ in[(i*32-9)-:8] ^ in[(i*32-17)-:8] ^ Mult2(in[(i*32-25)-:8]);
end
end
endmodule