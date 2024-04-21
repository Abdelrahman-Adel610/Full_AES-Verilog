`include "SubWord.v"
module KeyExpansion (initial_key,full_keys);

input [127:0] initial_key;
output [1407:0] full_keys;

function [31:0] RotWord (input [31:0] Word);
    RotWord = {Word[23:0],Word[31:24]};
  endfunction
  
endmodule