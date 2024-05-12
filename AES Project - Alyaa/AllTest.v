module AddRoundKey(instate, outstate, Key);
input [127 : 0] instate;
output  [127 : 0] outstate;
input [127 : 0] Key;
assign outstate = instate ^ Key;
endmodule



module SubBytes (instate,outstate);
input[127:0]instate;
output reg[127:0]outstate;

function [7:0] S_box(input [7:0] word); 
    case (word)
           8'h00: S_box=8'h63;
	   8'h01: S_box=8'h7c;
	   8'h02: S_box=8'h77;
	   8'h03: S_box=8'h7b;
	   8'h04: S_box=8'hf2;
	   8'h05: S_box=8'h6b;
	   8'h06: S_box=8'h6f;
	   8'h07: S_box=8'hc5;
	   8'h08: S_box=8'h30;
	   8'h09: S_box=8'h01;
	   8'h0a: S_box=8'h67;
	   8'h0b: S_box=8'h2b;
	   8'h0c: S_box=8'hfe;
	   8'h0d: S_box=8'hd7;
	   8'h0e: S_box=8'hab;
	   8'h0f: S_box=8'h76;
	   8'h10: S_box=8'hca;
	   8'h11: S_box=8'h82;
	   8'h12: S_box=8'hc9;
	   8'h13: S_box=8'h7d;
	   8'h14: S_box=8'hfa;
	   8'h15: S_box=8'h59;
	   8'h16: S_box=8'h47;
	   8'h17: S_box=8'hf0;
	   8'h18: S_box=8'had;
	   8'h19: S_box=8'hd4;
	   8'h1a: S_box=8'ha2;
	   8'h1b: S_box=8'haf;
	   8'h1c: S_box=8'h9c;
	   8'h1d: S_box=8'ha4;
	   8'h1e: S_box=8'h72;
	   8'h1f: S_box=8'hc0;
	   8'h20: S_box=8'hb7;
	   8'h21: S_box=8'hfd;
	   8'h22: S_box=8'h93;
	   8'h23: S_box=8'h26;
	   8'h24: S_box=8'h36;
	   8'h25: S_box=8'h3f;
	   8'h26: S_box=8'hf7;
	   8'h27: S_box=8'hcc;
	   8'h28: S_box=8'h34;
	   8'h29: S_box=8'ha5;
	   8'h2a: S_box=8'he5;
	   8'h2b: S_box=8'hf1;
	   8'h2c: S_box=8'h71;
	   8'h2d: S_box=8'hd8;
	   8'h2e: S_box=8'h31;
	   8'h2f: S_box=8'h15;
	   8'h30: S_box=8'h04;
	   8'h31: S_box=8'hc7;
	   8'h32: S_box=8'h23;
	   8'h33: S_box=8'hc3;
	   8'h34: S_box=8'h18;
	   8'h35: S_box=8'h96;
	   8'h36: S_box=8'h05;
	   8'h37: S_box=8'h9a;
	   8'h38: S_box=8'h07;
	   8'h39: S_box=8'h12;
	   8'h3a: S_box=8'h80;
	   8'h3b: S_box=8'he2;
	   8'h3c: S_box=8'heb;
	   8'h3d: S_box=8'h27;
	   8'h3e: S_box=8'hb2;
	   8'h3f: S_box=8'h75;
	   8'h40: S_box=8'h09;
	   8'h41: S_box=8'h83;
	   8'h42: S_box=8'h2c;
	   8'h43: S_box=8'h1a;
	   8'h44: S_box=8'h1b;
	   8'h45: S_box=8'h6e;
	   8'h46: S_box=8'h5a;
	   8'h47: S_box=8'ha0;
	   8'h48: S_box=8'h52;
	   8'h49: S_box=8'h3b;
	   8'h4a: S_box=8'hd6;
	   8'h4b: S_box=8'hb3;
	   8'h4c: S_box=8'h29;
	   8'h4d: S_box=8'he3;
	   8'h4e: S_box=8'h2f;
	   8'h4f: S_box=8'h84;
	   8'h50: S_box=8'h53;
	   8'h51: S_box=8'hd1;
	   8'h52: S_box=8'h00;
	   8'h53: S_box=8'hed;
	   8'h54: S_box=8'h20;
	   8'h55: S_box=8'hfc;
	   8'h56: S_box=8'hb1;
	   8'h57: S_box=8'h5b;
	   8'h58: S_box=8'h6a;
	   8'h59: S_box=8'hcb;
	   8'h5a: S_box=8'hbe;
	   8'h5b: S_box=8'h39;
	   8'h5c: S_box=8'h4a;
	   8'h5d: S_box=8'h4c;
	   8'h5e: S_box=8'h58;
	   8'h5f: S_box=8'hcf;
	   8'h60: S_box=8'hd0;
	   8'h61: S_box=8'hef;
	   8'h62: S_box=8'haa;
	   8'h63: S_box=8'hfb;
	   8'h64: S_box=8'h43;
	   8'h65: S_box=8'h4d;
	   8'h66: S_box=8'h33;
	   8'h67: S_box=8'h85;
	   8'h68: S_box=8'h45;
	   8'h69: S_box=8'hf9;
	   8'h6a: S_box=8'h02;
	   8'h6b: S_box=8'h7f;
	   8'h6c: S_box=8'h50;
	   8'h6d: S_box=8'h3c;
	   8'h6e: S_box=8'h9f;
	   8'h6f: S_box=8'ha8;
	   8'h70: S_box=8'h51;
	   8'h71: S_box=8'ha3;
	   8'h72: S_box=8'h40;
	   8'h73: S_box=8'h8f;
	   8'h74: S_box=8'h92;
	   8'h75: S_box=8'h9d;
	   8'h76: S_box=8'h38;
	   8'h77: S_box=8'hf5;
	   8'h78: S_box=8'hbc;
	   8'h79: S_box=8'hb6;
	   8'h7a: S_box=8'hda;
	   8'h7b: S_box=8'h21;
	   8'h7c: S_box=8'h10;
	   8'h7d: S_box=8'hff;
	   8'h7e: S_box=8'hf3;
	   8'h7f: S_box=8'hd2;
	   8'h80: S_box=8'hcd;
	   8'h81: S_box=8'h0c;
	   8'h82: S_box=8'h13;
	   8'h83: S_box=8'hec;
	   8'h84: S_box=8'h5f;
	   8'h85: S_box=8'h97;
	   8'h86: S_box=8'h44;
	   8'h87: S_box=8'h17;
	   8'h88: S_box=8'hc4;
	   8'h89: S_box=8'ha7;
	   8'h8a: S_box=8'h7e;
	   8'h8b: S_box=8'h3d;
	   8'h8c: S_box=8'h64;
	   8'h8d: S_box=8'h5d;
	   8'h8e: S_box=8'h19;
	   8'h8f: S_box=8'h73;
	   8'h90: S_box=8'h60;
	   8'h91: S_box=8'h81;
	   8'h92: S_box=8'h4f;
	   8'h93: S_box=8'hdc;
	   8'h94: S_box=8'h22;
	   8'h95: S_box=8'h2a;
	   8'h96: S_box=8'h90;
	   8'h97: S_box=8'h88;
	   8'h98: S_box=8'h46;
	   8'h99: S_box=8'hee;
	   8'h9a: S_box=8'hb8;
	   8'h9b: S_box=8'h14;
	   8'h9c: S_box=8'hde;
	   8'h9d: S_box=8'h5e;
	   8'h9e: S_box=8'h0b;
	   8'h9f: S_box=8'hdb;
	   8'ha0: S_box=8'he0;
	   8'ha1: S_box=8'h32;
	   8'ha2: S_box=8'h3a;
	   8'ha3: S_box=8'h0a;
	   8'ha4: S_box=8'h49;
	   8'ha5: S_box=8'h06;
	   8'ha6: S_box=8'h24;
	   8'ha7: S_box=8'h5c;
	   8'ha8: S_box=8'hc2;
	   8'ha9: S_box=8'hd3;
	   8'haa: S_box=8'hac;
	   8'hab: S_box=8'h62;
	   8'hac: S_box=8'h91;
	   8'had: S_box=8'h95;
	   8'hae: S_box=8'he4;
	   8'haf: S_box=8'h79;
	   8'hb0: S_box=8'he7;
	   8'hb1: S_box=8'hc8;
	   8'hb2: S_box=8'h37;
	   8'hb3: S_box=8'h6d;
	   8'hb4: S_box=8'h8d;
	   8'hb5: S_box=8'hd5;
	   8'hb6: S_box=8'h4e;
	   8'hb7: S_box=8'ha9;
	   8'hb8: S_box=8'h6c;
	   8'hb9: S_box=8'h56;
	   8'hba: S_box=8'hf4;
	   8'hbb: S_box=8'hea;
	   8'hbc: S_box=8'h65;
	   8'hbd: S_box=8'h7a;
	   8'hbe: S_box=8'hae;
	   8'hbf: S_box=8'h08;
	   8'hc0: S_box=8'hba;
	   8'hc1: S_box=8'h78;
	   8'hc2: S_box=8'h25;
	   8'hc3: S_box=8'h2e;
	   8'hc4: S_box=8'h1c;
	   8'hc5: S_box=8'ha6;
	   8'hc6: S_box=8'hb4;
	   8'hc7: S_box=8'hc6;
	   8'hc8: S_box=8'he8;
	   8'hc9: S_box=8'hdd;
	   8'hca: S_box=8'h74;
	   8'hcb: S_box=8'h1f;
	   8'hcc: S_box=8'h4b;
	   8'hcd: S_box=8'hbd;
	   8'hce: S_box=8'h8b;
	   8'hcf: S_box=8'h8a;
	   8'hd0: S_box=8'h70;
	   8'hd1: S_box=8'h3e;
	   8'hd2: S_box=8'hb5;
	   8'hd3: S_box=8'h66;
	   8'hd4: S_box=8'h48;
	   8'hd5: S_box=8'h03;
	   8'hd6: S_box=8'hf6;
	   8'hd7: S_box=8'h0e;
	   8'hd8: S_box=8'h61;
	   8'hd9: S_box=8'h35;
	   8'hda: S_box=8'h57;
	   8'hdb: S_box=8'hb9;
	   8'hdc: S_box=8'h86;
	   8'hdd: S_box=8'hc1;
	   8'hde: S_box=8'h1d;
	   8'hdf: S_box=8'h9e;
	   8'he0: S_box=8'he1;
	   8'he1: S_box=8'hf8;
	   8'he2: S_box=8'h98;
	   8'he3: S_box=8'h11;
	   8'he4: S_box=8'h69;
	   8'he5: S_box=8'hd9;
	   8'he6: S_box=8'h8e;
	   8'he7: S_box=8'h94;
	   8'he8: S_box=8'h9b;
	   8'he9: S_box=8'h1e;
	   8'hea: S_box=8'h87;
	   8'heb: S_box=8'he9;
	   8'hec: S_box=8'hce;
	   8'hed: S_box=8'h55;
	   8'hee: S_box=8'h28;
	   8'hef: S_box=8'hdf;
	   8'hf0: S_box=8'h8c;
	   8'hf1: S_box=8'ha1;
	   8'hf2: S_box=8'h89;
	   8'hf3: S_box=8'h0d;
	   8'hf4: S_box=8'hbf;
	   8'hf5: S_box=8'he6;
	   8'hf6: S_box=8'h42;
	   8'hf7: S_box=8'h68;
	   8'hf8: S_box=8'h41;
	   8'hf9: S_box=8'h99;
	   8'hfa: S_box=8'h2d;
	   8'hfb: S_box=8'h0f;
	   8'hfc: S_box=8'hb0;
	   8'hfd: S_box=8'h54;
	   8'hfe: S_box=8'hbb;
	   8'hff: S_box=8'h16;
    endcase

endfunction
integer i;        
always@(instate) 
begin      
for(i=0;i<128;i=i+8)
begin: SubBytes
outstate[i +: 8]=S_box(instate[(i+4)+:4]*16+instate[i+:4]);
end
end

endmodule



 module ShiftRows(instate, outstate);

input [127 : 0] instate;
output [127 : 0] outstate;



//first row
assign outstate[127 -: 8] = instate[127 -: 8];
assign outstate[95 -: 8] = instate[95 -: 8];
assign outstate[63 -: 8] = instate[63 -: 8];
assign outstate[31 -: 8] = instate[31 -: 8];

//second row
assign outstate[119 -: 8] = instate[87 -: 8];
assign outstate[87 -: 8] = instate[55 -: 8];
assign outstate[55 -: 8] = instate[23 -: 8];
assign outstate[23 -: 8] = instate[119 -: 8];

//third row
assign outstate[111 -: 8] = instate[47 -: 8];
assign outstate[79 -: 8] = instate[15 -: 8];
assign outstate[47 -: 8] = instate[111 -: 8];
assign outstate[15 -: 8] = instate[79 -: 8];

//fourth row
assign outstate[103 -: 8] = instate[7 -: 8];
assign outstate[71 -: 8] = instate[103 -: 8];
assign outstate[39 -: 8] = instate[71 -: 8];
assign outstate[7 -: 8] = instate[39 -: 8];


endmodule




 module MixColumns(input [127:0] in , output [127:0] out);

function [7:0] Mult2 (input [7:0] in1);
    Mult2 = in1[7] ? (( in1 << 1 ) ^ 8'h1b) : (in1 << 1);
endfunction

function [7:0] Mult3 (input [7:0] in2);
     Mult3 = in2 ^ Mult2(in2);
endfunction

genvar i;
generate 
for (i = 1 ; i < 5 ; i = i + 1) begin : mix
    assign out[(i*32-1)-:8] = Mult2(in[(i*32-1)-:8]) ^ Mult3(in[(i*32-9)-:8]) ^ in[(i*32-17)-:8] ^ in[(i*32-25)-:8];
    assign out[(i*32-9)-:8] = in[(i*32-1)-:8] ^ Mult2(in[(i*32-9)-:8]) ^ Mult3(in[(i*32-17)-:8]) ^ in[(i*32-25)-:8];
    assign out[(i*32-17)-:8] = in[(i*32-1)-:8] ^ in[(i*32-9)-:8] ^ Mult2(in[(i*32-17)-:8]) ^ Mult3(in[(i*32-25)-:8]);
    assign out[(i*32-25)-:8] = Mult3(in[(i*32-1)-:8]) ^ in[(i*32-9)-:8] ^ in[(i*32-17)-:8] ^ Mult2(in[(i*32-25)-:8]);
end
endgenerate
endmodule



module KeyExpansion #(parameter Nr=12,parameter Nk=6)(initial_key,full_key);

 reg [31 : 0] Rcon [9 : 0];
 input [(Nk * 32 - 1) : 0] initial_key;
 wire [31 : 0] full_keys [(4 * (Nr + 1)-1) : 0];
 output [((Nr + 1) * 128 - 1) : 0] full_key;
 genvar j,k,p;
 integer i;

 generate
	for(p = 0; p < Nk; p = p + 1)
	begin : initialize_block
	assign full_keys[p] = initial_key[((Nk - p) * 32 - 1) -: 32];
	end
 endgenerate
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

function [7:0] S_box(input [7:0] word);  
begin
    case (word)
     8'h00: S_box=8'h63;
	   8'h01: S_box=8'h7c;
	   8'h02: S_box=8'h77;
	   8'h03: S_box=8'h7b;
	   8'h04: S_box=8'hf2;
	   8'h05: S_box=8'h6b;
	   8'h06: S_box=8'h6f;
	   8'h07: S_box=8'hc5;
	   8'h08: S_box=8'h30;
	   8'h09: S_box=8'h01;
	   8'h0a: S_box=8'h67;
	   8'h0b: S_box=8'h2b;
	   8'h0c: S_box=8'hfe;
	   8'h0d: S_box=8'hd7;
	   8'h0e: S_box=8'hab;
	   8'h0f: S_box=8'h76;
	   8'h10: S_box=8'hca;
	   8'h11: S_box=8'h82;
	   8'h12: S_box=8'hc9;
	   8'h13: S_box=8'h7d;
	   8'h14: S_box=8'hfa;
	   8'h15: S_box=8'h59;
	   8'h16: S_box=8'h47;
	   8'h17: S_box=8'hf0;
	   8'h18: S_box=8'had;
	   8'h19: S_box=8'hd4;
	   8'h1a: S_box=8'ha2;
	   8'h1b: S_box=8'haf;
	   8'h1c: S_box=8'h9c;
	   8'h1d: S_box=8'ha4;
	   8'h1e: S_box=8'h72;
	   8'h1f: S_box=8'hc0;
	   8'h20: S_box=8'hb7;
	   8'h21: S_box=8'hfd;
	   8'h22: S_box=8'h93;
	   8'h23: S_box=8'h26;
	   8'h24: S_box=8'h36;
	   8'h25: S_box=8'h3f;
	   8'h26: S_box=8'hf7;
	   8'h27: S_box=8'hcc;
	   8'h28: S_box=8'h34;
	   8'h29: S_box=8'ha5;
	   8'h2a: S_box=8'he5;
	   8'h2b: S_box=8'hf1;
	   8'h2c: S_box=8'h71;
	   8'h2d: S_box=8'hd8;
	   8'h2e: S_box=8'h31;
	   8'h2f: S_box=8'h15;
	   8'h30: S_box=8'h04;
	   8'h31: S_box=8'hc7;
	   8'h32: S_box=8'h23;
	   8'h33: S_box=8'hc3;
	   8'h34: S_box=8'h18;
	   8'h35: S_box=8'h96;
	   8'h36: S_box=8'h05;
	   8'h37: S_box=8'h9a;
	   8'h38: S_box=8'h07;
	   8'h39: S_box=8'h12;
	   8'h3a: S_box=8'h80;
	   8'h3b: S_box=8'he2;
	   8'h3c: S_box=8'heb;
	   8'h3d: S_box=8'h27;
	   8'h3e: S_box=8'hb2;
	   8'h3f: S_box=8'h75;
	   8'h40: S_box=8'h09;
	   8'h41: S_box=8'h83;
	   8'h42: S_box=8'h2c;
	   8'h43: S_box=8'h1a;
	   8'h44: S_box=8'h1b;
	   8'h45: S_box=8'h6e;
	   8'h46: S_box=8'h5a;
	   8'h47: S_box=8'ha0;
	   8'h48: S_box=8'h52;
	   8'h49: S_box=8'h3b;
	   8'h4a: S_box=8'hd6;
	   8'h4b: S_box=8'hb3;
	   8'h4c: S_box=8'h29;
	   8'h4d: S_box=8'he3;
	   8'h4e: S_box=8'h2f;
	   8'h4f: S_box=8'h84;
	   8'h50: S_box=8'h53;
	   8'h51: S_box=8'hd1;
	   8'h52: S_box=8'h00;
	   8'h53: S_box=8'hed;
	   8'h54: S_box=8'h20;
	   8'h55: S_box=8'hfc;
	   8'h56: S_box=8'hb1;
	   8'h57: S_box=8'h5b;
	   8'h58: S_box=8'h6a;
	   8'h59: S_box=8'hcb;
	   8'h5a: S_box=8'hbe;
	   8'h5b: S_box=8'h39;
	   8'h5c: S_box=8'h4a;
	   8'h5d: S_box=8'h4c;
	   8'h5e: S_box=8'h58;
	   8'h5f: S_box=8'hcf;
	   8'h60: S_box=8'hd0;
	   8'h61: S_box=8'hef;
	   8'h62: S_box=8'haa;
	   8'h63: S_box=8'hfb;
	   8'h64: S_box=8'h43;
	   8'h65: S_box=8'h4d;
	   8'h66: S_box=8'h33;
	   8'h67: S_box=8'h85;
	   8'h68: S_box=8'h45;
	   8'h69: S_box=8'hf9;
	   8'h6a: S_box=8'h02;
	   8'h6b: S_box=8'h7f;
	   8'h6c: S_box=8'h50;
	   8'h6d: S_box=8'h3c;
	   8'h6e: S_box=8'h9f;
	   8'h6f: S_box=8'ha8;
	   8'h70: S_box=8'h51;
	   8'h71: S_box=8'ha3;
	   8'h72: S_box=8'h40;
	   8'h73: S_box=8'h8f;
	   8'h74: S_box=8'h92;
	   8'h75: S_box=8'h9d;
	   8'h76: S_box=8'h38;
	   8'h77: S_box=8'hf5;
	   8'h78: S_box=8'hbc;
	   8'h79: S_box=8'hb6;
	   8'h7a: S_box=8'hda;
	   8'h7b: S_box=8'h21;
	   8'h7c: S_box=8'h10;
	   8'h7d: S_box=8'hff;
	   8'h7e: S_box=8'hf3;
	   8'h7f: S_box=8'hd2;
	   8'h80: S_box=8'hcd;
	   8'h81: S_box=8'h0c;
	   8'h82: S_box=8'h13;
	   8'h83: S_box=8'hec;
	   8'h84: S_box=8'h5f;
	   8'h85: S_box=8'h97;
	   8'h86: S_box=8'h44;
	   8'h87: S_box=8'h17;
	   8'h88: S_box=8'hc4;
	   8'h89: S_box=8'ha7;
	   8'h8a: S_box=8'h7e;
	   8'h8b: S_box=8'h3d;
	   8'h8c: S_box=8'h64;
	   8'h8d: S_box=8'h5d;
	   8'h8e: S_box=8'h19;
	   8'h8f: S_box=8'h73;
	   8'h90: S_box=8'h60;
	   8'h91: S_box=8'h81;
	   8'h92: S_box=8'h4f;
	   8'h93: S_box=8'hdc;
	   8'h94: S_box=8'h22;
	   8'h95: S_box=8'h2a;
	   8'h96: S_box=8'h90;
	   8'h97: S_box=8'h88;
	   8'h98: S_box=8'h46;
	   8'h99: S_box=8'hee;
	   8'h9a: S_box=8'hb8;
	   8'h9b: S_box=8'h14;
	   8'h9c: S_box=8'hde;
	   8'h9d: S_box=8'h5e;
	   8'h9e: S_box=8'h0b;
	   8'h9f: S_box=8'hdb;
	   8'ha0: S_box=8'he0;
	   8'ha1: S_box=8'h32;
	   8'ha2: S_box=8'h3a;
	   8'ha3: S_box=8'h0a;
	   8'ha4: S_box=8'h49;
	   8'ha5: S_box=8'h06;
	   8'ha6: S_box=8'h24;
	   8'ha7: S_box=8'h5c;
	   8'ha8: S_box=8'hc2;
	   8'ha9: S_box=8'hd3;
	   8'haa: S_box=8'hac;
	   8'hab: S_box=8'h62;
	   8'hac: S_box=8'h91;
	   8'had: S_box=8'h95;
	   8'hae: S_box=8'he4;
	   8'haf: S_box=8'h79;
	   8'hb0: S_box=8'he7;
	   8'hb1: S_box=8'hc8;
	   8'hb2: S_box=8'h37;
	   8'hb3: S_box=8'h6d;
	   8'hb4: S_box=8'h8d;
	   8'hb5: S_box=8'hd5;
	   8'hb6: S_box=8'h4e;
	   8'hb7: S_box=8'ha9;
	   8'hb8: S_box=8'h6c;
	   8'hb9: S_box=8'h56;
	   8'hba: S_box=8'hf4;
	   8'hbb: S_box=8'hea;
	   8'hbc: S_box=8'h65;
	   8'hbd: S_box=8'h7a;
	   8'hbe: S_box=8'hae;
	   8'hbf: S_box=8'h08;
	   8'hc0: S_box=8'hba;
	   8'hc1: S_box=8'h78;
	   8'hc2: S_box=8'h25;
	   8'hc3: S_box=8'h2e;
	   8'hc4: S_box=8'h1c;
	   8'hc5: S_box=8'ha6;
	   8'hc6: S_box=8'hb4;
	   8'hc7: S_box=8'hc6;
	   8'hc8: S_box=8'he8;
	   8'hc9: S_box=8'hdd;
	   8'hca: S_box=8'h74;
	   8'hcb: S_box=8'h1f;
	   8'hcc: S_box=8'h4b;
	   8'hcd: S_box=8'hbd;
	   8'hce: S_box=8'h8b;
	   8'hcf: S_box=8'h8a;
	   8'hd0: S_box=8'h70;
	   8'hd1: S_box=8'h3e;
	   8'hd2: S_box=8'hb5;
	   8'hd3: S_box=8'h66;
	   8'hd4: S_box=8'h48;
	   8'hd5: S_box=8'h03;
	   8'hd6: S_box=8'hf6;
	   8'hd7: S_box=8'h0e;
	   8'hd8: S_box=8'h61;
	   8'hd9: S_box=8'h35;
	   8'hda: S_box=8'h57;
	   8'hdb: S_box=8'hb9;
	   8'hdc: S_box=8'h86;
	   8'hdd: S_box=8'hc1;
	   8'hde: S_box=8'h1d;
	   8'hdf: S_box=8'h9e;
	   8'he0: S_box=8'he1;
	   8'he1: S_box=8'hf8;
	   8'he2: S_box=8'h98;
	   8'he3: S_box=8'h11;
	   8'he4: S_box=8'h69;
	   8'he5: S_box=8'hd9;
	   8'he6: S_box=8'h8e;
	   8'he7: S_box=8'h94;
	   8'he8: S_box=8'h9b;
	   8'he9: S_box=8'h1e;
	   8'hea: S_box=8'h87;
	   8'heb: S_box=8'he9;
	   8'hec: S_box=8'hce;
	   8'hed: S_box=8'h55;
	   8'hee: S_box=8'h28;
	   8'hef: S_box=8'hdf;
	   8'hf0: S_box=8'h8c;
	   8'hf1: S_box=8'ha1;
	   8'hf2: S_box=8'h89;
	   8'hf3: S_box=8'h0d;
	   8'hf4: S_box=8'hbf;
	   8'hf5: S_box=8'he6;
	   8'hf6: S_box=8'h42;
	   8'hf7: S_box=8'h68;
	   8'hf8: S_box=8'h41;
	   8'hf9: S_box=8'h99;
	   8'hfa: S_box=8'h2d;
	   8'hfb: S_box=8'h0f;
	   8'hfc: S_box=8'hb0;
	   8'hfd: S_box=8'h54;
	   8'hfe: S_box=8'hbb;
	   8'hff: S_box=8'h16;
    endcase
end
endfunction
  function [31 : 0] SubWord (input [31 : 0] Word);                      
	for(i = 0; i < 32; i = i + 8)
		begin : sub_block
          SubWord[i +: 8] = S_box(Word[i +: 8]);
		end
 endfunction

 function [31 : 0] RotWord (input [31 : 0] Word);
    RotWord = {Word[23 : 0], Word[31 : 24]};
 endfunction
  
 generate
	for(j = Nk; j < (4 * (Nr + 1)); j = j + 1) 
		begin : my_block
			if(j % Nk == 0)
				begin
                  assign full_keys[j] = SubWord(RotWord(full_keys[j -1 ])) ^ Rcon [(j - Nk) / Nk] ^ full_keys[j - Nk];
				end
			else if((Nk == 8) && (j % 4 == 0))
		      begin
						assign full_keys[j] = SubWord(full_keys[j -1 ]) ^ full_keys[j - Nk];
				end
			else
				begin
					assign full_keys[j] = full_keys[j - Nk] ^ full_keys[j - 1];
				end
		end 
 endgenerate
 
 generate 
 
	for(k = 0; k < (Nr + 1); k = k + 1) 
		begin : second_block
			assign full_key[(k * 128) +: 128] = {full_keys[4 * k ],full_keys[4 * k + 1],full_keys[4 * k + 2],full_keys[4 * k + 3]};
		end
		
 endgenerate

endmodule






 
module Inv_MixColumns(input [127:0] in , output [127:0] out);
function [7:0] Mult2(input [7:0] in0);
    Mult2 = in0[7] ? (( in0 << 1 ) ^ 8'h1b) : (in0 << 1);
endfunction

function [7:0] Mult9(input [7:0] in1);
    Mult9 = (Mult2(Mult2(Mult2(in1)))) ^ in1;
endfunction 

function [7:0] Mult0e (input [7:0] in2);
    Mult0e = Mult2(Mult2(Mult2(in2)^in2)^in2);
endfunction

function [7:0] Mult0b (input [7:0] in3);
    Mult0b = (Mult2((Mult2(Mult2(in3)))^in3)) ^ in3;
endfunction

function [7:0] Mult0d (input [7:0] in4);
    Mult0d = (Mult2(Mult2(Mult2(in4)^in4))) ^ in4;
endfunction
genvar i;
generate
   for (i = 1 ; i < 5 ; i = i + 1) begin : invMix
    assign out[(i*32-1)-:8] = Mult0e(in[(i*32-1)-:8]) ^ Mult0b(in[(i*32-9)-:8]) ^ Mult0d(in[(i*32-17)-:8]) ^ Mult9(in[(i*32-25)-:8]);
   assign out[(i*32-9)-:8] = Mult9(in[(i*32-1)-:8]) ^ Mult0e(in[(i*32-9)-:8]) ^ Mult0b(in[(i*32-17)-:8]) ^ Mult0d(in[(i*32-25)-:8]);
   assign out[(i*32-17)-:8] = Mult0d(in[(i*32-1)-:8]) ^ Mult9(in[(i*32-9)-:8]) ^ Mult0e(in[(i*32-17)-:8]) ^ Mult0b(in[(i*32-25)-:8]);
   assign out[(i*32-25)-:8] = Mult0b(in[(i*32-1)-:8]) ^ Mult0d(in[(i*32-9)-:8]) ^ Mult9(in[(i*32-17)-:8]) ^ Mult0e(in[(i*32-25)-:8]);
end
endgenerate
endmodule



module InvShiftRows(instate, outstate);

input [127 : 0] instate;
output [127 : 0] outstate;



//first row
assign outstate[127 -: 8] = instate[127 -: 8];
assign outstate[95 -: 8] = instate[95 -: 8];
assign outstate[63 -: 8] = instate[63 -: 8];
assign outstate[31 -: 8] = instate[31 -: 8];

//second row
assign outstate[119 -: 8] = instate[23 -: 8];
assign outstate[87 -: 8] = instate[119 -: 8];
assign outstate[55 -: 8] = instate[87 -: 8];
assign outstate[23 -: 8] = instate[55 -: 8];

//third row
assign outstate[111 -: 8] = instate[47 -: 8];
assign outstate[79 -: 8] = instate[15 -: 8];
assign outstate[47 -: 8] = instate[111 -: 8];
assign outstate[15 -: 8] = instate[79 -: 8];

//fourth row
assign outstate[103 -: 8] = instate[71 -: 8];
assign outstate[71 -: 8] = instate[39 -: 8];
assign outstate[39 -: 8] = instate[7 -: 8];
assign outstate[7 -: 8] = instate[103 -: 8];

endmodule




module InvSubBytes (instate,outstate);
input[127:0]instate;
output[127:0]outstate;
genvar  i;
function [7:0] Inv_S_box(input [7:0]word);
begin
 case(word)
	
			       8'h00:Inv_S_box =8'h52;
				8'h01:Inv_S_box =8'h09;
				8'h02:Inv_S_box =8'h6a;
				8'h03:Inv_S_box =8'hd5;
				8'h04:Inv_S_box =8'h30;
				8'h05:Inv_S_box =8'h36;
				8'h06:Inv_S_box =8'ha5;
				8'h07:Inv_S_box =8'h38;
				8'h08:Inv_S_box =8'hbf;
				8'h09:Inv_S_box =8'h40;
				8'h0a:Inv_S_box =8'ha3;
				8'h0b:Inv_S_box =8'h9e;
				8'h0c:Inv_S_box =8'h81;
				8'h0d:Inv_S_box =8'hf3;
				8'h0e:Inv_S_box =8'hd7;
				8'h0f:Inv_S_box =8'hfb;
				8'h10:Inv_S_box =8'h7c;
				8'h11:Inv_S_box =8'he3;
				8'h12:Inv_S_box =8'h39;
				8'h13:Inv_S_box =8'h82;
				8'h14:Inv_S_box =8'h9b;
				8'h15:Inv_S_box =8'h2f;
				8'h16:Inv_S_box =8'hff;
				8'h17:Inv_S_box =8'h87;
				8'h18:Inv_S_box =8'h34;
				8'h19:Inv_S_box =8'h8e;
				8'h1a:Inv_S_box =8'h43;
				8'h1b:Inv_S_box =8'h44;
				8'h1c:Inv_S_box =8'hc4;
				8'h1d:Inv_S_box =8'hde;
				8'h1e:Inv_S_box =8'he9;
				8'h1f:Inv_S_box =8'hcb;
				8'h20:Inv_S_box =8'h54;
				8'h21:Inv_S_box =8'h7b;
				8'h22:Inv_S_box =8'h94;
				8'h23:Inv_S_box =8'h32;
				8'h24:Inv_S_box =8'ha6;
				8'h25:Inv_S_box =8'hc2;
				8'h26:Inv_S_box =8'h23;
				8'h27:Inv_S_box =8'h3d;
				8'h28:Inv_S_box =8'hee;
				8'h29:Inv_S_box =8'h4c;
				8'h2a:Inv_S_box =8'h95;
				8'h2b:Inv_S_box =8'h0b;
				8'h2c:Inv_S_box =8'h42;
				8'h2d:Inv_S_box =8'hfa;
				8'h2e:Inv_S_box =8'hc3;
				8'h2f:Inv_S_box =8'h4e;
				8'h30:Inv_S_box =8'h08;
				8'h31:Inv_S_box =8'h2e;
				8'h32:Inv_S_box =8'ha1;
				8'h33:Inv_S_box =8'h66;
				8'h34:Inv_S_box =8'h28;
				8'h35:Inv_S_box =8'hd9;
				8'h36:Inv_S_box =8'h24;
				8'h37:Inv_S_box =8'hb2;
				8'h38:Inv_S_box =8'h76;
				8'h39:Inv_S_box =8'h5b;
				8'h3a:Inv_S_box =8'ha2;
				8'h3b:Inv_S_box =8'h49;
				8'h3c:Inv_S_box =8'h6d;
				8'h3d:Inv_S_box =8'h8b;
				8'h3e:Inv_S_box =8'hd1;
				8'h3f:Inv_S_box =8'h25;
				8'h40:Inv_S_box =8'h72;
				8'h41:Inv_S_box =8'hf8;
				8'h42:Inv_S_box =8'hf6;
				8'h43:Inv_S_box =8'h64;
				8'h44:Inv_S_box =8'h86;
				8'h45:Inv_S_box =8'h68;
				8'h46:Inv_S_box =8'h98;
				8'h47:Inv_S_box =8'h16;
				8'h48:Inv_S_box =8'hd4;
				8'h49:Inv_S_box =8'ha4;
				8'h4a:Inv_S_box =8'h5c;
				8'h4b:Inv_S_box =8'hcc;
				8'h4c:Inv_S_box =8'h5d;
				8'h4d:Inv_S_box =8'h65;
				8'h4e:Inv_S_box =8'hb6;
				8'h4f:Inv_S_box =8'h92;
				8'h50:Inv_S_box =8'h6c;
				8'h51:Inv_S_box =8'h70;
				8'h52:Inv_S_box =8'h48;
				8'h53:Inv_S_box =8'h50;
				8'h54:Inv_S_box =8'hfd;
				8'h55:Inv_S_box =8'hed;
				8'h56:Inv_S_box =8'hb9;
				8'h57:Inv_S_box =8'hda;
				8'h58:Inv_S_box =8'h5e;
				8'h59:Inv_S_box =8'h15;
				8'h5a:Inv_S_box =8'h46;
				8'h5b:Inv_S_box =8'h57;
				8'h5c:Inv_S_box =8'ha7;
				8'h5d:Inv_S_box =8'h8d;
				8'h5e:Inv_S_box =8'h9d;
				8'h5f:Inv_S_box =8'h84;
				8'h60:Inv_S_box =8'h90;
				8'h61:Inv_S_box =8'hd8;
				8'h62:Inv_S_box =8'hab;
				8'h63:Inv_S_box =8'h00;
				8'h64:Inv_S_box =8'h8c;
				8'h65:Inv_S_box =8'hbc;
				8'h66:Inv_S_box =8'hd3;
				8'h67:Inv_S_box =8'h0a;
				8'h68:Inv_S_box =8'hf7;
				8'h69:Inv_S_box =8'he4;
				8'h6a:Inv_S_box =8'h58;
				8'h6b:Inv_S_box =8'h05;
				8'h6c:Inv_S_box =8'hb8;
				8'h6d:Inv_S_box =8'hb3;
				8'h6e:Inv_S_box =8'h45;
				8'h6f:Inv_S_box =8'h06;
				8'h70:Inv_S_box =8'hd0;
				8'h71:Inv_S_box =8'h2c;
				8'h72:Inv_S_box =8'h1e;
				8'h73:Inv_S_box =8'h8f;
				8'h74:Inv_S_box =8'hca;
				8'h75:Inv_S_box =8'h3f;
				8'h76:Inv_S_box =8'h0f;
				8'h77:Inv_S_box =8'h02;
				8'h78:Inv_S_box =8'hc1;
				8'h79:Inv_S_box =8'haf;
				8'h7a:Inv_S_box =8'hbd;
				8'h7b:Inv_S_box =8'h03;
				8'h7c:Inv_S_box =8'h01;
				8'h7d:Inv_S_box =8'h13;
				8'h7e:Inv_S_box =8'h8a;
				8'h7f:Inv_S_box =8'h6b;
				8'h80:Inv_S_box =8'h3a;
				8'h81:Inv_S_box =8'h91;
				8'h82:Inv_S_box =8'h11;
				8'h83:Inv_S_box =8'h41;
				8'h84:Inv_S_box =8'h4f;
				8'h85:Inv_S_box =8'h67;
				8'h86:Inv_S_box =8'hdc;
				8'h87:Inv_S_box =8'hea;
				8'h88:Inv_S_box =8'h97;
				8'h89:Inv_S_box =8'hf2;
				8'h8a:Inv_S_box =8'hcf;
				8'h8b:Inv_S_box =8'hce;
				8'h8c:Inv_S_box =8'hf0;
				8'h8d:Inv_S_box =8'hb4;
				8'h8e:Inv_S_box =8'he6;
				8'h8f:Inv_S_box =8'h73;
				8'h90:Inv_S_box =8'h96;
				8'h91:Inv_S_box =8'hac;
				8'h92:Inv_S_box =8'h74;
				8'h93:Inv_S_box =8'h22;
				8'h94:Inv_S_box =8'he7;
				8'h95:Inv_S_box =8'had;
				8'h96:Inv_S_box =8'h35;
				8'h97:Inv_S_box =8'h85;
				8'h98:Inv_S_box =8'he2;
				8'h99:Inv_S_box =8'hf9;
				8'h9a:Inv_S_box =8'h37;
				8'h9b:Inv_S_box =8'he8;
				8'h9c:Inv_S_box =8'h1c;
				8'h9d:Inv_S_box =8'h75;
				8'h9e:Inv_S_box =8'hdf;
				8'h9f:Inv_S_box =8'h6e;
				8'ha0:Inv_S_box =8'h47;
				8'ha1:Inv_S_box =8'hf1;
				8'ha2:Inv_S_box =8'h1a;
				8'ha3:Inv_S_box =8'h71;
				8'ha4:Inv_S_box =8'h1d;
				8'ha5:Inv_S_box =8'h29;
				8'ha6:Inv_S_box =8'hc5;
				8'ha7:Inv_S_box =8'h89;
				8'ha8:Inv_S_box =8'h6f;
				8'ha9:Inv_S_box =8'hb7;
				8'haa:Inv_S_box =8'h62;
				8'hab:Inv_S_box =8'h0e;
				8'hac:Inv_S_box =8'haa;
				8'had:Inv_S_box =8'h18;
				8'hae:Inv_S_box =8'hbe;
				8'haf:Inv_S_box =8'h1b;
				8'hb0:Inv_S_box =8'hfc;
				8'hb1:Inv_S_box =8'h56;
				8'hb2:Inv_S_box =8'h3e;
				8'hb3:Inv_S_box =8'h4b;
				8'hb4:Inv_S_box =8'hc6;
				8'hb5:Inv_S_box =8'hd2;
				8'hb6:Inv_S_box =8'h79;
				8'hb7:Inv_S_box =8'h20;
				8'hb8:Inv_S_box =8'h9a;
				8'hb9:Inv_S_box =8'hdb;
				8'hba:Inv_S_box =8'hc0;
				8'hbb:Inv_S_box =8'hfe;
				8'hbc:Inv_S_box =8'h78;
				8'hbd:Inv_S_box =8'hcd;
				8'hbe:Inv_S_box =8'h5a;
				8'hbf:Inv_S_box =8'hf4;
				8'hc0:Inv_S_box =8'h1f;
				8'hc1:Inv_S_box =8'hdd;
				8'hc2:Inv_S_box =8'ha8;
				8'hc3:Inv_S_box =8'h33;
				8'hc4:Inv_S_box =8'h88;
				8'hc5:Inv_S_box =8'h07;
				8'hc6:Inv_S_box =8'hc7;
				8'hc7:Inv_S_box =8'h31;
				8'hc8:Inv_S_box =8'hb1;
				8'hc9:Inv_S_box =8'h12;
				8'hca:Inv_S_box =8'h10;
				8'hcb:Inv_S_box =8'h59;
				8'hcc:Inv_S_box =8'h27;
				8'hcd:Inv_S_box =8'h80;
				8'hce:Inv_S_box =8'hec;
				8'hcf:Inv_S_box =8'h5f;
				8'hd0:Inv_S_box =8'h60;
				8'hd1:Inv_S_box =8'h51;
				8'hd2:Inv_S_box =8'h7f;
				8'hd3:Inv_S_box =8'ha9;
				8'hd4:Inv_S_box =8'h19;
				8'hd5:Inv_S_box =8'hb5;
				8'hd6:Inv_S_box =8'h4a;
				8'hd7:Inv_S_box =8'h0d;
				8'hd8:Inv_S_box =8'h2d;
				8'hd9:Inv_S_box =8'he5;
				8'hda:Inv_S_box =8'h7a;
				8'hdb:Inv_S_box =8'h9f;
				8'hdc:Inv_S_box =8'h93;
				8'hdd:Inv_S_box =8'hc9;
				8'hde:Inv_S_box =8'h9c;
				8'hdf:Inv_S_box =8'hef;
				8'he0:Inv_S_box =8'ha0;
				8'he1:Inv_S_box =8'he0;
				8'he2:Inv_S_box =8'h3b;
				8'he3:Inv_S_box =8'h4d;
				8'he4:Inv_S_box =8'hae;
				8'he5:Inv_S_box =8'h2a;
				8'he6:Inv_S_box =8'hf5;
				8'he7:Inv_S_box =8'hb0;
				8'he8:Inv_S_box =8'hc8;
				8'he9:Inv_S_box =8'heb;
				8'hea:Inv_S_box =8'hbb;
				8'heb:Inv_S_box =8'h3c;
				8'hec:Inv_S_box =8'h83;
				8'hed:Inv_S_box =8'h53;
				8'hee:Inv_S_box =8'h99;
				8'hef:Inv_S_box =8'h61;
				8'hf0:Inv_S_box =8'h17;
				8'hf1:Inv_S_box =8'h2b;
				8'hf2:Inv_S_box =8'h04;
				8'hf3:Inv_S_box =8'h7e;
				8'hf4:Inv_S_box =8'hba;
				8'hf5:Inv_S_box =8'h77;
				8'hf6:Inv_S_box =8'hd6;
				8'hf7:Inv_S_box =8'h26;
				8'hf8:Inv_S_box =8'he1;
				8'hf9:Inv_S_box =8'h69;
				8'hfa:Inv_S_box =8'h14;
				8'hfb:Inv_S_box =8'h63;
				8'hfc:Inv_S_box =8'h55;
				8'hfd:Inv_S_box =8'h21;
				8'hfe:Inv_S_box =8'h0c;
				8'hff:Inv_S_box =8'h7d;
				
				endcase 
end
endfunction
generate                         
for(i=0;i<128;i=i+8)
begin:inverseSubBytes
assign outstate[i +: 8]=Inv_S_box (instate[(i+4)+:4]*16+instate[i+:4]);
end
endgenerate
endmodule




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
 

module Decryption#(parameter maxRound = 10 , parameter N = 1) (input [127:0] in,input [5:0] counter , input clk, output [127:0] out, input [(265* N + 1151 ):0] full_key);

wire [127:0] inRound;
wire [127:0] inMix;
wire [127:0] outMix;
wire [127:0] inShift;
wire [127:0] inSub;
wire [127:0] outSub;
reg [127:0] stored; 
wire [127:0] currentKey;
 


assign inRound = (counter == maxRound)? in : stored;
assign inShift = (counter == maxRound)? inMix : outMix;
assign out = (counter == maxRound)? in : ((counter == (maxRound + maxRound - 6'd1))? outMix : inMix);
assign currentKey = (maxRound == 10)? full_key[((counter - 6'd10)*(-128) + 1407) -: 128] : ((maxRound == 12)? full_key[((counter - 6'd12)*(-128) + 1663) -: 128] : full_key[((counter - 6'd14)*(-128) + 1919) -: 128]);

AddRoundKey op1 (inRound, inMix, currentKey);
Inv_MixColumns op2 (inMix, outMix);
InvShiftRows op3 (inShift, inSub);
InvSubBytes op4 (inSub, outSub);

always@(posedge clk) begin
	  
	if(counter < maxRound + maxRound)
		stored <= outSub;
	 
 
end

endmodule


module Encryption#(parameter maxRound = 10  , parameter N = 1) (input [127:0] in, input [5:0] counter ,input clk, output [127:0] out, input [(265* N + 1151 ):0] full_key);

wire [127:0] inRound;
wire [127:0] inSub;
wire [127:0] inShift;
wire [127:0] inMix;
wire [127:0] outMix;
reg [127:0] stored;
 
 
 

//assign currentKey = (maxRound == 10)? full_key[((counter)*(128)+127)-:128] : ((maxRound == 12)? full_key[((counter)*(128)+127)-:128] : full_key[((counter)*(128)+127)-:128]);

assign inRound = (counter == 0)? in : stored;
assign out = (counter == 0)? in : inSub;

AddRoundKey op4 (inRound, inSub, full_key[((counter)*(128)+127)-:128]);
SubBytes  op1 (inSub, inShift);
ShiftRows  op2 (inShift, inMix);
MixColumns  op3 (inMix, outMix);

always@(posedge clk) begin
	 
	if(counter + 1 < maxRound )
		stored <= outMix;
	else
		stored <= inMix;
	 
	
end

endmodule


module AES(input clk, input rst, output [20:0] sevseg, output reg flag, input [1:0] sel);
	
	reg [127:0] in;
	reg [255:0] Key;
	wire [127:0] enout128;
	wire [127:0] enout192;
	wire [127:0] enout256;
	wire [127:0] deout128;
	wire [127:0] deout192;
	wire [127:0] deout256;
	reg [5:0] counter;
	reg [127:0] out;
	wire [11:0] bcd; 
	wire [1407:0] full_key128;
	wire [1663:0] full_key192;
	wire [1919:0] full_key256;

 
	KeyExpansion #(10,4)kr1(Key[255 -: 128] , full_key128);
	KeyExpansion #(12,6)kr2(Key[255 -: 192] , full_key192);
	KeyExpansion #(14,8)kr3(Key , full_key256);


	Encryption #(10,1) en128(in, counter, clk, enout128, full_key128);
	Encryption #(12,2) en192(in, counter, clk, enout192, full_key192);
	Encryption #(14,3) en256(in, counter, clk, enout256, full_key256);

	Decryption #(10,1) de128(enout128, counter, clk, deout128, full_key128);
	Decryption #(12,2) de192(enout192, counter, clk, deout192, full_key192);
	Decryption #(14,3) de256(enout256, counter, clk, deout256, full_key256);

	binary_to_bcd btb(out[7:0], bcd);
	seven_seg sevseg1(bcd[11 -: 4], sevseg[20 -: 7]);
	seven_seg sevseg2(bcd[7 -: 4], sevseg[13 -: 7]);
	seven_seg sevseg3(bcd[3 -: 4], sevseg[6 -: 7]);
    
	always@(*) begin  

	if (sel == 0) begin 
		  out = (counter <= 10)? enout128 : deout128;
		  flag = (in == deout128)? 1'b1 : 1'b0;
	end
	else if (sel == 1) begin 
		 
		  out = (counter <= 12)? enout192 : deout192;
		  flag = (in == deout192)? 1'b1 : 1'b0;
	end
	else begin 
		 
		  out = (counter <= 14)? enout256 : deout192;
		  flag = (in == deout256)? 1'b1 : 1'b0;
	end

	end 

 
       
	always@(posedge clk, posedge rst) begin

		if(rst) begin
			in <= 128'h00112233445566778899aabbccddeeff;
			Key <= 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
			counter <= 0;
		end

		else begin
			counter <= counter + 1;
		end

	end

endmodule