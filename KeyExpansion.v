`include "SubWord.v"
module KeyExpansion (initial_key,full_key);
reg [31:0] Rcon [9:0];
input [127:0] initial_key;
wire [31:0] full_keys [43:0];
output [1407:0] full_key;
wire [31:0] temp2 [9:0];
genvar j;
function [31:0] RotWord (input [31:0] Word);
    RotWord = {Word[23:0],Word[31:24]};
  endfunction
 assign full_keys [0] = initial_key [127:96];
 assign full_keys [1] = initial_key [95:64];
 assign full_keys [2] = initial_key [63:32];
 assign full_keys [3] = initial_key [31:0];

 initial
    begin
      Rcon [0] = 32'h01000000;
      Rcon [1] = 32'h02000000;
      Rcon [2] = 32'h04000000;
      Rcon [3] = 32'h08000000;
      Rcon [4] = 32'h10000000;
      Rcon [5] = 32'h20000000;
      Rcon [6] = 32'h40000000;
      Rcon [7] = 32'h80000000;
      Rcon [8] = 32'h1b000000;
      Rcon [9] = 32'h36000000;
    end
  generate
    for(j=4;j<44;j=j+1) 
      begin : my_block
        if(j%4==0)
          begin
            SubWord sub(RotWord(full_keys[j-1]),temp2[(j-4)/4]);
            assign full_keys[j] = temp2[(j-4)/4] ^ Rcon [(j-4)/4] ^ full_keys[j-4];
          end
        else
          begin
            assign full_keys[j] = full_keys[j-4] ^ full_keys[j-1];
          end
      end 
  endgenerate
  genvar k;
  generate 
    for(k=0;k<44;k=k+1) 
      begin : second_block
        assign full_key[(((3-(k%4))+4*(k/4))*32)+:32] = full_keys[k];
      end
  endgenerate
  
endmodule

module Test_KeyExpansion();
reg [127:0] in ;
wire [1407:0] out;
initial begin
    in = 128'h2b7e151628aed2a6abf7158809cf4f3c;
end

KeyExpansion test(in, out);

endmodule