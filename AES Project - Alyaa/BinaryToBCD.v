module binary_to_bcd(in, out);

input [7:0] in;
output reg [11:0] out;

integer i;

always @* begin
   
    out = 0;

    for (i=0; i<8; i = i + 1) begin	

    if (out[3:0] >= 5)
        out[3:0] = out[3:0] + 3;

	if (out[7:4] >= 5)
        out[7:4] = out[7:4] + 3;

	if (out[11:8] >= 5)
        out[11:8] = out[11:8] + 3;

	out = {out[10:0], in[7-i]};		//Shift one bit

    end
end
endmodule