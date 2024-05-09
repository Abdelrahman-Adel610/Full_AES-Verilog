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
 
	for(k = 0; k < (Nk*(4 * (Nr + 1)/Nk)); k = k + 1) 
		begin : second_block
			assign full_key[((((Nk-1) - (k % Nk)) + Nk * (k / Nk)) * 32) +: 32] = full_keys[k];
		end
		
 endgenerate
 generate
 if( Nk == 6 || Nk == 8)
 begin
 assign full_key[((Nr + 1) * 128 - 1) -: 128] = {full_keys[(Nk*(4 * (Nr + 1)/Nk))],full_keys[(Nk*(4 * (Nr + 1)/Nk))+1],full_keys[(Nk*(4 * (Nr + 1)/Nk))+2],full_keys[(Nk*(4 * (Nr + 1)/Nk))]+3};
 end
 endgenerate
endmodule


