// test_bench for SubBytes 
module SubBytes_DUT();
reg [127:0]instate;
wire [127:0]out;
wire [127:0]out2;
initial                                                 //expected output
begin //...xxxxx  22      e0       65       f2       0f   ===============>...xxxxx   93   e1  4d  89  76
instate=128'bx00100010_11100000_01100101_11110010_00001111;
end
SubBytes2 ss(instate,out);
endmodule