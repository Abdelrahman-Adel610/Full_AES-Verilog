// test_bench for SubBytes 
module InvSubBytes_DUT();
reg [127:0]instate;
wire [127:0]out;
initial                                                 //expected output
begin //...xxxxx  93      e1       4d       89       76   ===============>...xxxxx  22      e0       65       f2       0f
instate=128'bx10010011_11100001_01001101_10001001_01110110;
end
InvSubBytes ss(instate,out);
endmodule