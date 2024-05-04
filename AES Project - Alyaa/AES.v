module AES(input clk, input rst, output [20:0] sevseg, output flag);
	
	reg [127:0] in;
	reg [127:0] Key;
	wire [127:0] enout;
	wire [127:0] deout;
	reg [5:0] counter;
	wire [127:0] out;
	wire [11:0] bcd;

	Encryption en(in, Key, counter, clk, enout);
	Decryption de(enout, Key, counter, clk, deout);

	binary_to_bcd btb(out[7:0], bcd);
	seven_seg sevseg1(bcd[11 -: 4], sevseg[20 -: 7]);
	seven_seg sevseg2(bcd[7 -: 4], sevseg[13 -: 7]);
	seven_seg sevseg3(bcd[3 -: 4], sevseg[6 -: 7]);

	assign out = (counter <= 6'd10)? enout : deout;
	assign flag = (in == deout)? 1'b1 : 1'b0;

	always@(posedge clk, posedge rst) begin

		if(rst) begin
			in <= 128'h00112233445566778899aabbccddeeff;
			Key <= 128'h000102030405060708090a0b0c0d0e0f;
			counter <= 6'b0;
		end

		else if (counter < 20) begin
			counter <= counter + 6'd1;
		end

	end
endmodule