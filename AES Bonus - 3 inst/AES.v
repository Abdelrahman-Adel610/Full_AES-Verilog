module AES(input clk, input rst, output [20:0] sevseg, output flag, input [1:0] sel, output [6:0] sel_seg);
	
	reg [127:0] in;
	reg [255:0] Key;
	wire [127:0] enout128;
	wire [127:0] enout192;
	wire [127:0] enout256;
	wire [127:0] deout128;
	wire [127:0] deout192;
	wire [127:0] deout256;
	reg [5:0] counter128;
	reg [5:0] counter192;
	reg [5:0] counter256;
	reg [127:0] out;
	wire [11:0] bcd; 
	wire [1407:0] full_key128;
	wire [1663:0] full_key192;
	wire [1919:0] full_key256;
 
	//Generating full key expansion for each mode
	KeyExpansion #(10,4)kr1(Key[255 -: 128] , full_key128);
	KeyExpansion #(12,6)kr2(Key[255 -: 192] , full_key192);
	KeyExpansion #(14,8)kr3(Key , full_key256);

	//Encryption mode instantiations
	Encryption #(10,1) en128(in, counter128, clk, enout128, full_key128);
	Encryption #(12,2) en192(in, counter192, clk, enout192, full_key192);
	Encryption #(14,3) en256(in, counter256, clk, enout256, full_key256);

	//Decryption mode instantiations
	Decryption #(10,1) de128(enout128, counter128, clk, deout128, full_key128);
	Decryption #(12,2) de192(enout192, counter192, clk, deout192, full_key192);
	Decryption #(14,3) de256(enout256, counter256, clk, deout256, full_key256);

	//Displaying last byte on seven segment
	binary_to_bcd btb(out[7:0], bcd);						//Converting last 8 bits to bcd
	seven_seg sevseg1(bcd[11 -: 4], sevseg[20 -: 7]);		//first digit
	seven_seg sevseg2(bcd[7 -: 4], sevseg[13 -: 7]);		//second digit
	seven_seg sevseg3(bcd[3 -: 4], sevseg[6 -: 7]);			//third digit
	seven_seg sevseg4({2'b0, sel} ,sel_seg);				//selector
	
	always@(*) begin  

	//Choose what mode to display:
	if (sel == 0) begin 
		  out = (counter128 <= 10)? enout128 : deout128;		//If the first 10 rounds, out is encryption. else, decryption
	end
	else if (sel == 1) begin 
		 
		  out = (counter192 <= 12)? enout192 : deout192;
	end
	else begin 
		 
		  out = (counter256 <= 14)? enout256 : deout256;
	end

	end 

	//When input == output the flag lights up
	assign flag = (in == out && counter128 > 0)? 1'b1 : 1'b0;

	always@(posedge clk, posedge rst) begin

		//Reset input, key, counter
		if(rst) begin
			in <= 128'h00112233445566778899aabbccddeeff;
			Key <= 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
			counter128 <= 0;
			counter192 <= 0;
			counter256 <= 0;
		end

		//Increment counter (only if it's less than required range to save last output)
		else begin
			if(counter128 < 6'd20)
				counter128 <= counter128 + 1;
			
			if(counter192 < 6'd24)
				counter192 <= counter192 + 1;

			if(counter256 < 6'd28)
				counter256 <= counter256 + 1;

		end

	end

endmodule