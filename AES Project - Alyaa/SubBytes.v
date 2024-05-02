
module SubBytes (instate,outstate);
input[127:0]instate;
output[127:0]outstate;
genvar  i;
generate                         
for(i=0;i<128;i=i+8)
begin: SubBytes
Sand_Box z(instate[(i+4)+:4]*16+instate[i+:4],outstate[i +: 8]);
end
endgenerate
endmodule