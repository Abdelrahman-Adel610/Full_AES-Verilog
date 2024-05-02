module Decryption(input [127:0] in, input [127:0] Key, input [4:0] counter, input clk, output [20:0] seg_out, output [127:0] out);

wire [127:0] kr_out;
wire [127:0] instate;
wire [1407:0] full_key;
wire [127:0] SubBytes_out;
wire [127:0] ShiftRows_out;
wire [127:0] next_state;
reg [127:0] reg_instate;
wire [127:0] final_out;
wire [11:0] bcd;

KeyExpansion kr(Key,  full_key);
AddRoundKey o1 (in, kr_out, full_key[1407-:128]);

assign instate = reg_instate;

DecryptionRound dr(instate, full_key[((counter-6'd10)*(-128)+1407)-:128], next_state);

InvShiftRows sh (SubBytes_out , ShiftRows_out);
InvSubBytes su (instate, SubBytes_out);
AddRoundKey ak (ShiftRows_out ,final_out , full_key[127:0]);

assign out = (counter < 6'd20)? ((counter <= 10)? 127'b0 : next_state) : final_out;

binary_to_bcd btb(out, bcd);
seven_seg sevseg1(bcd[11 -: 4], seg_out[20 -: 7]);
seven_seg sevseg2(bcd[7 -: 4], seg_out[13 -: 7]);
seven_seg sevseg3(bcd[3 -: 4], seg_out[6 -: 7]);


always@(posedge clk) begin
  
    if(counter == 6'd10) begin
        reg_instate <= kr_out;
    end
	else if (counter < 20) begin
		reg_instate <= next_state;
	end

end
endmodule