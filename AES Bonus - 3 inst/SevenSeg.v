module seven_seg(input [3:0] in, output reg [6:0] HEX0);

always@(*) begin

if(in == 4'b0000)
    HEX0 = 7'b1000000;

else if(in == 4'b0001)
    HEX0 = 7'b1111001;

 else if(in == 4'b0010)
    HEX0 = 7'b0100100;

 else if(in == 4'b0011)
    HEX0 = 7'b0110000;

 else if(in == 4'b0100)
    HEX0 = 7'b0011001;

else if(in == 4'b0101)
    HEX0 = 7'b0010010;

else if(in == 4'b0110)
    HEX0 = 7'b0000010;

else if(in == 4'b0111)
    HEX0 = 7'b1111000;

else if(in == 4'b1000)
    HEX0 = 7'b0000000;

else if(in == 4'b1001)
    HEX0 = 7'b0010000;

else
    HEX0 = 7'b1111111;

end

endmodule