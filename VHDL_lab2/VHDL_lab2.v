module keyexp(clk,rst,keysel,rndkren,wrrndkrf,addr,rconen,key,rndkrfout);
output[127:0] rndkrfout;
input clk,rst,keysel,rndkren,wrrndkrf,rconen;
input[3:0] addr;
input[127:0] key;
wire [127:0] rndkey,rndkrout,rndkrfout;
wire [31:0] w4,w5,w6,w7,rotword,subword,xorrcon;
wire [7:0] rconout;

assign rndkey=(keysel==0) ? key:{w4,w5,w6,w7};
reg_128 rndkreg(clk,rndkren,rndkey,rndkrout);
rndkrf rndkrf(clk,wrrndkrf,addr,rndkey,rndkrfout);

assign rotword={rndkrout[23:0],rndkrout[31:24]};
sbox_mux sbox0(rotword[31:24],subword[31:24]);
sbox_mux sbox1(rotword[23:16],subword[23:16]);
sbox_mux sbox2(rotword[15:8],subword[15:8]);
sbox_mux sbox3(rotword[7:0],subword[7:0]);

rcon rcon(clk,rst,rconen,rconout);
assign xorrcon=subword^{rconout,24'h000000};
assign w4=xorrcon^rndkrout[127:96];
assign w5=w4^rndkrout[95:64];
assign w6=w5^rndkrout[63:32];
assign w7=w6^rndkrout[31:0];
endmodule



module reg_128(clk,write,din,dout);
output [127:0] dout;
input  clk,write;
input  [127:0] din;
reg [127:0] dout;
always @ (posedge clk)
	begin
		  if(write)
			dout<=din;
		  else 
			dout<=dout;
	end
endmodule



module rcon(clk,rst,write,rconout);
output [7:0] rconout;
input  clk,rst,write;
reg [7:0] rconout;
always @ (posedge clk)
  begin
  if(rst)
    rconout<=8'h01;
  else if(write)
     rconout<=(rconout[7]==0)? (rconout<<1):((rconout<<1)^{8'h1b});
  else 
     rconout<=rconout;	
  end
endmodule 



module rndkrf(clk,wrrndkrf,addr,rndkey,rndkrfout);
input clk,wrrndkrf;	
input [3:0] addr;
input [127:0] rndkey;
output [127:0] rndkrfout;
reg [10:0] decout;
wire [10:0] write_reg;
wire [127:0] reg0out,reg1out,reg2out,reg3out,reg4out,reg5out,reg6out,reg7out,reg8out,reg9out,reg10out;
reg [127:0] rndkrfout;
always @ (addr)
  case(addr)
    4'd0: decout=11'b000_0000_0001;
    4'd1: decout=11'b000_0000_0010;
    4'd2: decout=11'b000_0000_0100;
    4'd3: decout=11'b000_0000_1000;
    4'd4: decout=11'b000_0001_0000;
    4'd5: decout=11'b000_0010_0000;
    4'd6: decout=11'b000_0100_0000;
    4'd7: decout=11'b000_1000_0000;
    4'd8: decout=11'b001_0000_0000;
    4'd9: decout=11'b010_0000_0000;
    4'd10: decout=11'b100_0000_0000;
    default: decout=11'b000_0000_0000;
  endcase
assign write_reg=decout & {wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf,wrrndkrf};
reg_128 reg0(clk,write_reg[0],rndkey,reg0out);
reg_128 reg1(clk,write_reg[1],rndkey,reg1out);
reg_128 reg2(clk,write_reg[2],rndkey,reg2out);
reg_128 reg3(clk,write_reg[3],rndkey,reg3out);
reg_128 reg4(clk,write_reg[4],rndkey,reg4out);
reg_128 reg5(clk,write_reg[5],rndkey,reg5out);
reg_128 reg6(clk,write_reg[6],rndkey,reg6out);
reg_128 reg7(clk,write_reg[7],rndkey,reg7out);
reg_128 reg8(clk,write_reg[8],rndkey,reg8out);
reg_128 reg9(clk,write_reg[9],rndkey,reg9out);
reg_128 reg10(clk,write_reg[10],rndkey,reg10out);
always @(addr or reg0out or reg1out or reg2out or reg3out or reg4out or reg5out or reg6out or reg7out or reg8out or reg9out or reg10out)
  case(addr)
    4'd0: rndkrfout=reg0out;
    4'd1: rndkrfout=reg1out;
    4'd2: rndkrfout=reg2out;
    4'd3: rndkrfout=reg3out;
    4'd4: rndkrfout=reg4out;
    4'd5: rndkrfout=reg5out;
    4'd6: rndkrfout=reg6out;
    4'd7: rndkrfout=reg7out;
    4'd8: rndkrfout=reg8out;
    4'd9: rndkrfout=reg9out;
    4'd10: rndkrfout=reg10out;
    default: rndkrfout=reg10out;
  endcase
endmodule 



module sbox_mux(in,out);
output[7:0] out;
input[7:0] in;
reg [7:0] out;
always@(in)
  case(in)
    8'h00: out=8'h63;
    8'h01: out=8'h7c;
    8'h02: out=8'h77;
    8'h03: out=8'h7b;
    8'h04: out=8'hf2;
    8'h05: out=8'h6b;
    8'h06: out=8'h6f;
    8'h07: out=8'hc5;
    8'h08: out=8'h30;
    8'h09: out=8'h01;
    8'h0a: out=8'h67;
    8'h0b: out=8'h2b;
    8'h0c: out=8'hfe;
    8'h0d: out=8'hd7;
    8'h0e: out=8'hab;
    8'h0f: out=8'h76;
    
    8'h10: out=8'hca;
    8'h11: out=8'h82;
    8'h12: out=8'hc9;
    8'h13: out=8'h7d;
    8'h14: out=8'hfa;
    8'h15: out=8'h59;
    8'h16: out=8'h47;
    8'h17: out=8'hf0;
    8'h18: out=8'had;
    8'h19: out=8'hd4;
    8'h1a: out=8'ha2;
    8'h1b: out=8'haf;
    8'h1c: out=8'h9c;
    8'h1d: out=8'ha4;
    8'h1e: out=8'h72;
    8'h1f: out=8'hc0;
    
    8'h20: out=8'hb7;
    8'h21: out=8'hfd;
    8'h22: out=8'h93;
    8'h23: out=8'h26;
    8'h24: out=8'h36;
    8'h25: out=8'h3f;
    8'h26: out=8'hf7;
    8'h27: out=8'hcc;
    8'h28: out=8'h34;
    8'h29: out=8'ha5;
    8'h2a: out=8'he5;
    8'h2b: out=8'hf1;
    8'h2c: out=8'h71;
    8'h2d: out=8'hd8;
    8'h2e: out=8'h31;
    8'h2f: out=8'h15;
    
    8'h30: out=8'h04;
    8'h31: out=8'hc7;
    8'h32: out=8'h23;
    8'h33: out=8'hc3;
    8'h34: out=8'h18;
    8'h35: out=8'h96;
    8'h36: out=8'h05;
    8'h37: out=8'h9a;
    8'h38: out=8'h07;
    8'h39: out=8'h12;
    8'h3a: out=8'h80;
    8'h3b: out=8'he2;
    8'h3c: out=8'heb;
    8'h3d: out=8'h27;
    8'h3e: out=8'hb2;
    8'h3f: out=8'h75;

    8'h40: out=8'h09;
    8'h41: out=8'h83;
    8'h42: out=8'h2c;
    8'h43: out=8'h1a;
    8'h44: out=8'h1b;
    8'h45: out=8'h6e;
    8'h46: out=8'h5a;
    8'h47: out=8'ha0;
    8'h48: out=8'h52;
    8'h49: out=8'h3b;
    8'h4a: out=8'hd6;
    8'h4b: out=8'hb3;
    8'h4c: out=8'h29;
    8'h4d: out=8'he3;
    8'h4e: out=8'h2f;
    8'h4f: out=8'h84;

    8'h50: out=8'h53;
    8'h51: out=8'hd1;
    8'h52: out=8'h00;
    8'h53: out=8'hed;
    8'h54: out=8'h20;
    8'h55: out=8'hfc;
    8'h56: out=8'hb1;
    8'h57: out=8'h5b;
    8'h58: out=8'h6a;
    8'h59: out=8'hcb;
    8'h5a: out=8'hbe;
    8'h5b: out=8'h39;
    8'h5c: out=8'h4a;
    8'h5d: out=8'h4c;
    8'h5e: out=8'h58;
    8'h5f: out=8'hcf;

    8'h60: out=8'hd0;
    8'h61: out=8'hef;
    8'h62: out=8'haa;
    8'h63: out=8'hfb;
    8'h64: out=8'h43;
    8'h65: out=8'h4d;
    8'h66: out=8'h33;
    8'h67: out=8'h85;
    8'h68: out=8'h45;
    8'h69: out=8'hf9;
    8'h6a: out=8'h02;
    8'h6b: out=8'h7f;
    8'h6c: out=8'h50;
    8'h6d: out=8'h3c;
    8'h6e: out=8'h9f;
    8'h6f: out=8'ha8;

    8'h70: out=8'h51;
    8'h71: out=8'ha3;
    8'h72: out=8'h40;
    8'h73: out=8'h8f;
    8'h74: out=8'h92;
    8'h75: out=8'h9d;
    8'h76: out=8'h38;
    8'h77: out=8'hf5;
    8'h78: out=8'hbc;
    8'h79: out=8'hb6;
    8'h7a: out=8'hda;
    8'h7b: out=8'h21;
    8'h7c: out=8'h10;
    8'h7d: out=8'hff;
    8'h7e: out=8'hf3;
    8'h7f: out=8'hd2;

    8'h80: out=8'hcd;
    8'h81: out=8'h0c;
    8'h82: out=8'h13;
    8'h83: out=8'hec;
    8'h84: out=8'h5f;
    8'h85: out=8'h97;
    8'h86: out=8'h44;
    8'h87: out=8'h17;
    8'h88: out=8'hc4;
    8'h89: out=8'ha7;
    8'h8a: out=8'h7e;
    8'h8b: out=8'h3d;
    8'h8c: out=8'h64;
    8'h8d: out=8'h5d;
    8'h8e: out=8'h19;
    8'h8f: out=8'h73;

    8'h90: out=8'h60;
    8'h91: out=8'h81;
    8'h92: out=8'h4f;
    8'h93: out=8'hdc;
    8'h94: out=8'h22;
    8'h95: out=8'h2a;
    8'h96: out=8'h90;
    8'h97: out=8'h88;
    8'h98: out=8'h46;
    8'h99: out=8'hee;
    8'h9a: out=8'hb8;
 	  8'h9b: out=8'h14;
    8'h9c: out=8'hde;
    8'h9d: out=8'h5e;
    8'h9e: out=8'h0b;
    8'h9f: out=8'hdb;

    8'ha0: out=8'he0;
    8'ha1: out=8'h32;
    8'ha2: out=8'h3a;
    8'ha3: out=8'h0a;
    8'ha4: out=8'h49;
    8'ha5: out=8'h06;
    8'ha6: out=8'h24;
    8'ha7: out=8'h5c;
    8'ha8: out=8'hc2;
    8'ha9: out=8'hd3;
    8'haa: out=8'hac;
    8'hab: out=8'h62;
    8'hac: out=8'h91;
    8'had: out=8'h95;
    8'hae: out=8'he4;
    8'haf: out=8'h79;

    8'hb0: out=8'he7;
    8'hb1: out=8'hc8;
    8'hb2: out=8'h37;
    8'hb3: out=8'h6d;
    8'hb4: out=8'h8d;
    8'hb5: out=8'hd5;
    8'hb6: out=8'h4e;
    8'hb7: out=8'ha9;
    8'hb8: out=8'h6c;
    8'hb9: out=8'h56;
    8'hba: out=8'hf4;
    8'hbb: out=8'hea;
    8'hbc: out=8'h65;
    8'hbd: out=8'h7a;
    8'hbe: out=8'hae;
    8'hbf: out=8'h08;

          8'hc0: out=8'hba;
          8'hc1: out=8'h78;
          8'hc2: out=8'h25;
          8'hc3: out=8'h2e;
          8'hc4: out=8'h1c;
          8'hc5: out=8'ha6;
          8'hc6: out=8'hb4;
          8'hc7: out=8'hc6;
          8'hc8: out=8'he8;
          8'hc9: out=8'hdd;
          8'hca: out=8'h74;
          8'hcb: out=8'h1f;
          8'hcc: out=8'h4b;
          8'hcd: out=8'hbd;
          8'hce: out=8'h8b;
          8'hcf: out=8'h8a;

          8'hd0: out=8'h70;
          8'hd1: out=8'h3e;
          8'hd2: out=8'hb5;
          8'hd3: out=8'h66;
          8'hd4: out=8'h48;
          8'hd5: out=8'h03;
          8'hd6: out=8'hf6;
          8'hd7: out=8'h0e;
          8'hd8: out=8'h61;
          8'hd9: out=8'h35;
          8'hda: out=8'h57;
          8'hdb: out=8'hb9;
          8'hdc: out=8'h86;
          8'hdd: out=8'hc1;
          8'hde: out=8'h1d;
          8'hdf: out=8'h9e;

          8'he0: out=8'he1;
          8'he1: out=8'hf8;
          8'he2: out=8'h98;
          8'he3: out=8'h11;
          8'he4: out=8'h69;
          8'he5: out=8'hd9;
          8'he6: out=8'h8e;
          8'he7: out=8'h94;
          8'he8: out=8'h9b;
          8'he9: out=8'h1e;
          8'hea: out=8'h87;
          8'heb: out=8'he9;
          8'hec: out=8'hce;
          8'hed: out=8'h55;
          8'hee: out=8'h28;
          8'hef: out=8'hdf;

          8'hf0: out=8'h8c;
          8'hf1: out=8'ha1;
          8'hf2: out=8'h89;
          8'hf3: out=8'h0d;
          8'hf4: out=8'hbf;
          8'hf5: out=8'he6;
          8'hf6: out=8'h42;
          8'hf7: out=8'h68;
          8'hf8: out=8'h41;
          8'hf9: out=8'h99;
          8'hfa: out=8'h2d;
          8'hfb: out=8'h0f;
          8'hfc: out=8'hb0;
          8'hfd: out=8'h54;
          8'hfe: out=8'hbb;
          8'hff: out=8'h16;
  endcase
endmodule 


`timescale 1ns / 1ns
module keyexp_tb;
wire[127:0] rndkrfout;
reg clk,rst,keysel,rndkren,wrrndkrf,rconen;
reg [3:0] addr;
reg [127:0] key;

keyexp  kexp(clk,rst,keysel,rndkren,wrrndkrf,addr,rconen,key,rndkrfout);

//clock generation				   
initial clk = 1;
always #50 clk = ~clk;
	
initial 
	begin 
		#20  rst=1;		
		#100 rst=0;
		     keysel=0;
		     rndkren=1;
		     wrrndkrf=1;
		     addr=4'd0;
		     rconen=0;
		     key=128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;                          
    #100 addr=4'd1;
		     rconen=1;
		     keysel=1;		                
    #100 addr=4'd2;		                
    #100 addr=4'd3;           
    #100 addr=4'd4;                      
    #100 addr=4'd5;      
    #100 addr=4'd6;
    #100 addr=4'd7;
    #100 addr=4'd8;
    #100 addr=4'd9;
    #100 addr=4'd10;   
            
    #100 rndkren=0;
		     wrrndkrf=0;
		     rconen=0;	
		 
		#100 addr=4'd0;
		#100 addr=4'd1;
		#100 addr=4'd2;
		#100 addr=4'd3;
		#100 addr=4'd4;
		#100 addr=4'd5;
		#100 addr=4'd6;
		#100 addr=4'd7;
		#100 addr=4'd8;
		#100 addr=4'd9;
		#100 addr=4'd10;
		
		
		
		#1020 rst=1;		
		#100 rst=0;
		     keysel=0;
		     rndkren=1;
		     wrrndkrf=1;
		     addr=4'd0;
		     rconen=0;
		     key=128'ha32bf2a3d443c60771230a2214575088;                          
    #100 addr=4'd1;
		     rconen=1;
		     keysel=1;		                
    #100 addr=4'd2;		                
    #100 addr=4'd3;           
    #100 addr=4'd4;                      
    #100 addr=4'd5;      
    #100 addr=4'd6;
    #100 addr=4'd7;
    #100 addr=4'd8;
    #100 addr=4'd9;
    #100 addr=4'd10;   
            
    #100 rndkren=0;
		     wrrndkrf=0;
		     rconen=0;	
		 
		#100 addr=4'd0;
		#100 addr=4'd1;
		#100 addr=4'd2;
		#100 addr=4'd3;
		#100 addr=4'd4;
		#100 addr=4'd5;
		#100 addr=4'd6;
		#100 addr=4'd7;
		#100 addr=4'd8;
		#100 addr=4'd9;
		#100 addr=4'd10;
		#200 $stop;
	end
endmodule

