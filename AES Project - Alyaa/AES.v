module AES(input clk, input rst, output [20:0] sevseg, output flag);
	
	reg [127:0] in;
	reg [127:0] Key;
	wire [127:0] enout;
	wire [127:0] deout;
	wire [20:0] ensevseg;
	wire [20:0] desevseg;
	reg [5:0] counter;

	Encryption en(in, Key, counter, clk, ensevseg, enout);
	Decryption de(enout, Key, counter, clk, desevseg, deout);

	assign sevseg = (counter <= 6'd10)? ensevseg : desevseg;
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