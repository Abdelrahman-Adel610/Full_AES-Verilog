
module Inv_MixColumns(input [127:0] in , output [127:0] out);
function [7:0] Mult2(input [7:0] in0);
    Mult2 = in0[7] ? (( in0 << 1 ) ^ 8'h1b) : (in0 << 1);
endfunction

function [7:0] Mult9(input [7:0] in1);
    Mult9 = (Mult2(Mult2(Mult2(in1)))) ^ in1;
endfunction 

function [7:0] Mult0e (input [7:0] in2);
    Mult0e = Mult2(Mult2(Mult2(in2)^in2)^in2);
endfunction

function [7:0] Mult0b (input [7:0] in3);
    Mult0b = (Mult2((Mult2(Mult2(in3)))^in3)) ^ in3;
endfunction

function [7:0] Mult0d (input [7:0] in4);
    Mult0d = (Mult2(Mult2(Mult2(in4)^in4))) ^ in4;
endfunction
genvar i;
generate
   for (i = 1 ; i < 5 ; i = i + 1) begin 
    assign out[(i*32-1)-:8] = Mult0e(in[(i*32-1)-:8]) ^ Mult0b(in[(i*32-9)-:8]) ^ Mult0d(in[(i*32-17)-:8]) ^ Mult9(in[(i*32-25)-:8]);
   assign out[(i*32-9)-:8] = Mult9(in[(i*32-1)-:8]) ^ Mult0e(in[(i*32-9)-:8]) ^ Mult0b(in[(i*32-17)-:8]) ^ Mult0d(in[(i*32-25)-:8]);
   assign out[(i*32-17)-:8] = Mult0d(in[(i*32-1)-:8]) ^ Mult9(in[(i*32-9)-:8]) ^ Mult0e(in[(i*32-17)-:8]) ^ Mult0b(in[(i*32-25)-:8]);
   assign out[(i*32-25)-:8] = Mult0b(in[(i*32-1)-:8]) ^ Mult0d(in[(i*32-9)-:8]) ^ Mult9(in[(i*32-17)-:8]) ^ Mult0e(in[(i*32-25)-:8]);
end
endgenerate
endmodule