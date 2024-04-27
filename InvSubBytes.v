
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


