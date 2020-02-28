module aes(clk,rst,load,address,keyexpen,staenc,stadec,din,keyexprdy,encdecrdy,dout);
output [127:0] dout;
output keyexprdy,encdecrdy;
input  clk,rst,load,keyexpen,staenc,stadec;
input  [4:0] address;
input  [127:0] din;
wire  wrpckreg,keysel,rndkren,wrrndkrf,rconen,wrsben,mixsel,reginsel,wrregen;
wire [127:0] pckregout,roundkey;
wire [3:0] krfaddr,wrsbaddr;
wire [1:0] keyadsel;
reg_128     pckreg(clk,wrpckreg,din,pckregout);
aescontrol  control(clk,rst,load,address,keyexpen,staenc,stadec,
                    keyexprdy,encdecrdy,keysel,rndkren,wrrndkrf,
                    krfaddr,rconen,wrsben,wrsbaddr,keyadsel,mixsel,
                    reginsel,wrregen,wrpckreg);
keyexp  keyexp(clk,rst,keysel,rndkren,wrrndkrf,krfaddr,rconen,pckregout,roundkey);
crydap  crydap(clk,wrsben,wrsbaddr,din,keyadsel,mixsel,
              reginsel,wrregen,pckregout,roundkey,dout);
endmodule 


module aes(clk,rst,load,address,keyexpen,staenc,stadec,din,keyexprdy,encdecrdy,dout,shift);
output [15:0] dout;
output keyexprdy,encdecrdy;
input  clk,rst,load,keyexpen,staenc,stadec,shift;
input  [7:0] address;
input  [15:0] din;

wire  wrpckreg,keysel,rndkren,wrrndkrf,rconen,wrsben,mixsel,reginsel,wrregen;
wire [127:0] pckregout,roundkey;
wire [3:0] krfaddr;
wire [6:0] wrsbaddr;
wire [1:0] keyadsel;

inreg     pckreg(clk,wrpckreg,din,pckregout);
aescontrol  control(clk,rst,load,address,keyexpen,
                    staenc,stadec,keyexprdy,encdecrdy,
                    keysel,rndkren,wrrndkrf,krfaddr,rconen,
                    wrsben,wrsbaddr,keyadsel,mixsel,reginsel,
                    wrregen,wrpckreg);
keyexp  keyexp(clk,rst|keyexprdy,keysel,rndkren,wrrndkrf,krfaddr,rconen,pckregout,roundkey);
crydap  crydap(clk,wrsben,wrsbaddr,din,keyadsel,mixsel,
              reginsel,wrregen,pckregout,roundkey,dout,shift);
endmodule


module aescontrol(clk,rst,load,address,keyexp,staenc,stadec,keyexprdy,encdecrdy,
                  keysel,rndkren,wrrndkrf,krfaddr,rconen,
                  wrsben,wrsbaddr,keyadsel,mixsel,reginsel,wrregen,wrpckreg);
output keyexprdy,encdecrdy,keysel,rndkren,wrrndkrf,rconen;
output wrsben,mixsel,reginsel,wrregen,wrpckreg;
output [1:0] keyadsel;
output [3:0] krfaddr,wrsbaddr;
input clk,rst,load,keyexp,staenc,stadec;
input[4:0] address;
wire [3:0] wrkrfaddr,rdkrfaddre,rdkrfaddrd,encstate,decstate;
wire [1:0] keyadsele,keyadseld;
wire mixsele,reginsele,wrregene,encrdy,mixseld,reginseld,wrregend,decrdy;
assign krfaddr=(encstate != 4'd0)? rdkrfaddre:((decstate != 4'd0)?rdkrfaddrd:wrkrfaddr);
assign keyadsel=(encstate != 4'd0)? keyadsele:keyadseld;
assign mixsel=(encstate != 4'd0)? mixsele:mixseld;
assign reginsel=(encstate != 4'd0)? reginsele:reginseld;
assign wrregen=(encstate != 4'd0)? wrregene:wrregend;
assign encdecrdy=encrdy & decrdy;
keyexpfsm  keyexpfsm(clk,rst,keyexp,keysel,rndkren,wrrndkrf,wrkrfaddr,rconen,keyexprdy);
encryfsm   encryfsm(clk,rst,staenc,keyadsele,mixsele,reginsele,wrregene,rdkrfaddre,encrdy,encstate);
decryfsm   decryfsm(clk,rst,stadec,keyadseld,mixseld,reginseld,wrregend,rdkrfaddrd,decrdy,decstate);
assign wrsben=load & ~address[4];
assign wrsbaddr=address[3:0];
assign wrpckreg=load & address[4] & ~address[3] & ~address[2] & ~address[1] & ~address[0];
endmodule 


module keyexpfsm(clk,rst,keyexp,keysel,rndkren,wrrndkrf,wrkrfaddr,rconen,keyexprdy);
output keysel,rndkren,wrrndkrf,rconen,keyexprdy;
output [3:0] wrkrfaddr;
input clk,rst,keyexp;
reg [3:0] state,next_state,wrkrfaddr;
reg keysel,rndkren,keyexprdy;
always @(posedge clk)
	begin
		if(rst)
			state<=4'd0;
		else
			state<=next_state;									
	end
	
always @ (state or keyexp) 
		case(state)	
			  4'd0:	if(keyexp == 1) 
			           next_state = 4'd1;
		          else 
					       next_state = 4'd0;
			  4'd1: next_state = 4'd2;
			  4'd2: next_state = 4'd3;		
			  4'd3: next_state = 4'd4;
			  4'd4: next_state = 4'd5;
			  4'd5: next_state = 4'd6;						             
			  4'd6: next_state = 4'd7;
			  4'd7: next_state = 4'd8;
			  4'd8: next_state = 4'd9;
			  4'd9: next_state = 4'd10;
			  4'd10: next_state = 4'd11;	
			  4'd11: next_state = 4'd0;
			  default: next_state = 4'd0;	  	
		endcase		

always @ (state) 
		case(state)	
			  4'd0:	keysel=0;
			  4'd1:	keysel=0;
			  4'd2:	keysel=1;
			  4'd3:	keysel=1;
			  4'd4:	keysel=1;
			  4'd5:	keysel=1;
			  4'd6:	keysel=1;
			  4'd7:	keysel=1;
			  4'd8:	keysel=1;
			  4'd9:	keysel=1;
			  4'd10:	keysel=1;
			  4'd11:	keysel=1;			  			  
			  default: keysel=0;  
		endcase
		
always @ (state) 
		case(state)	
			  4'd0:	rndkren=0;
			  4'd1:	rndkren=1;
			  4'd2:	rndkren=1;
			  4'd3:	rndkren=1;
			  4'd4:	rndkren=1;
			  4'd5:	rndkren=1;
			  4'd6:	rndkren=1;
			  4'd7:	rndkren=1;
			  4'd8:	rndkren=1;
			  4'd9:	rndkren=1;
			  4'd10:	rndkren=1;
			  4'd11:	rndkren=1;			  			  
			  default: rndkren=0;  
		endcase
		
assign wrrndkrf=rndkren;		
always @ (state) 
		case(state)	
			  4'd0:	wrkrfaddr=4'd0;
			  4'd1:	wrkrfaddr=4'd0;
			  4'd2:	wrkrfaddr=4'd1;
			  4'd3:	wrkrfaddr=4'd2;
			  4'd4:	wrkrfaddr=4'd3;
			  4'd5:	wrkrfaddr=4'd4;
			  4'd6:	wrkrfaddr=4'd5;
			  4'd7:	wrkrfaddr=4'd6;
			  4'd8:	wrkrfaddr=4'd7;
			  4'd9:	wrkrfaddr=4'd8;
			  4'd10:	wrkrfaddr=4'd9;
			  4'd11:	wrkrfaddr=4'd10;			  			  
			  default: wrkrfaddr=4'd0;  
		endcase
		
assign rconen=keysel;
always @ (state) 
		case(state)	
			  4'd0:	keyexprdy=1;			  			  			  
			  default: keyexprdy=0;  
		endcase		
endmodule 


module encryfsm(clk,rst,staenc,keyadsel,mixsel,reginsel,wrregen,rdkrfaddr,encrdy,state);
output wrregen,mixsel,reginsel,encrdy,state;
output [1:0] keyadsel;
output [3:0] rdkrfaddr;
input clk,rst,staenc;
reg [3:0] state,next_state,rdkrfaddr;
reg wrregen,encrdy;
reg [1:0] keyadsel;
always @(posedge clk)
	begin
		if(rst)
			state<=4'd0;
		else
			state<=next_state;									
	end	
always @ (state or staenc) 
		case(state)	
			  4'd0:	if(staenc == 1) 
			           next_state = 4'd1;
			        else 
			           next_state = 4'd0;
			  4'd1: next_state = 4'd2;
			  4'd2: next_state = 4'd3;		
			  4'd3: next_state = 4'd4;
			  4'd4: next_state = 4'd5;
			  4'd5: next_state = 4'd6;						             	  
			  4'd6: next_state = 4'd7;
			  4'd7: next_state = 4'd8;
			  4'd8: next_state = 4'd9;
			  4'd9: next_state = 4'd10;
			  4'd10: next_state = 4'd11;	
			  4'd11: next_state = 4'd0;
			  default: next_state = 4'd0;	  	
		endcase
		
always @ (state) 
		case(state)	
			  4'd0:	wrregen=0;
			  4'd1:	wrregen=1;
			  4'd2:	wrregen=1;
			  4'd3:	wrregen=1;
			  4'd4:	wrregen=1;
			  4'd5:	wrregen=1;
			  4'd6:	wrregen=1;
			  4'd7:	wrregen=1;
			  4'd8:	wrregen=1;
			  4'd9:	wrregen=1;
			  4'd10:	wrregen=1;
			  4'd11:	wrregen=1;			  			  
			  default: wrregen=0;  
		endcase
		
assign mixsel=0;		
assign reginsel=0;
always @ (state) 
		case(state)	
			  4'd0:	keyadsel=2'b00;
			  4'd1:	keyadsel=2'b00;
			  4'd2:	keyadsel=2'b01;
			  4'd3:	keyadsel=2'b01;
			  4'd4:	keyadsel=2'b01;
			  4'd5:	keyadsel=2'b01;
			  4'd6:	keyadsel=2'b01;
			  4'd7:	keyadsel=2'b01;
			  4'd8:	keyadsel=2'b01;
			  4'd9:	keyadsel=2'b01;
			  4'd10:	keyadsel=2'b01;
			  4'd11:	keyadsel=2'b10;			  			  
			  default: keyadsel=2'b00;  
		endcase		
		
always @ (state) 
		case(state)	
			  4'd0:	rdkrfaddr=4'd0;
			  4'd1:	rdkrfaddr=4'd0;
			  4'd2:	rdkrfaddr=4'd1;
			  4'd3:	rdkrfaddr=4'd2;
			  4'd4:	rdkrfaddr=4'd3;
			  4'd5:	rdkrfaddr=4'd4;
			  4'd6:	rdkrfaddr=4'd5;
			  4'd7:	rdkrfaddr=4'd6;
			  4'd8:	rdkrfaddr=4'd7;
			  4'd9:	rdkrfaddr=4'd8;
			  4'd10:	rdkrfaddr=4'd9;
			  4'd11:	rdkrfaddr=4'd10;			  			  
			  default: rdkrfaddr=4'd0;  
		endcase
		
always @ (state) 
		case(state)	
			  4'd0: encrdy=1;			  			  			  
			  default: encrdy=0;  
		endcase		
endmodule 


module decryfsm(clk,rst,stadec,keyadsel,mixsel,reginsel,wrregen,rdkrfaddr,decrdy,state);
output wrregen,mixsel,reginsel,decrdy,state;
output [1:0] keyadsel;
output [3:0] rdkrfaddr;
input clk,rst,stadec;
reg [3:0] state,next_state,rdkrfaddr;
reg wrregen,decrdy,reginsel;
reg [1:0] keyadsel;
always @(posedge clk)
	begin
		if(rst)
			state<=4'd0;
		else
			state<=next_state;									
	end
always @ (state or stadec) 
		case(state)	
			  4'd0:	if(stadec == 1) 
			           next_state = 4'd1;
					    else 
					       next_state = 4'd0;
			  4'd1: next_state = 4'd2;
			  4'd2:	next_state = 4'd3;		
			  4'd3: next_state = 4'd4;
			  4'd4: next_state = 4'd5;
			  4'd5:	next_state = 4'd6;						             
			  4'd6: next_state = 4'd7;
			  4'd7:	next_state = 4'd8;
			  4'd8: next_state = 4'd9;
			  4'd9:	next_state = 4'd10;
			  4'd10: next_state = 4'd11;	
			  4'd11: next_state = 4'd0;
			  default: next_state = 4'd0;	  	
		endcase		
		
always @ (state) 
		case(state)	
			  4'd0:	wrregen=0;
			  4'd1:	wrregen=1;
			  4'd2:	wrregen=1;
			  4'd3:	wrregen=1;
			  4'd4:	wrregen=1;
			  4'd5:	wrregen=1;
			  4'd6:	wrregen=1;
			  4'd7:	wrregen=1;
			  4'd8:	wrregen=1;
			  4'd9:	wrregen=1;
			  4'd10:	wrregen=1;
			  4'd11:	wrregen=1;	  			  
			  default: wrregen=0;  
		endcase
		
always @ (state) 
		case(state)	
			  4'd0:	reginsel=0;
			  4'd1:	reginsel=0;
			  4'd2:	reginsel=1;
			  4'd3:	reginsel=1;
			  4'd4:	reginsel=1;
			  4'd5:	reginsel=1;
			  4'd6:	reginsel=1;
			  4'd7:	reginsel=1;
			  4'd8:	reginsel=1;
			  4'd9:	reginsel=1;
			  4'd10:	reginsel=1;
			  4'd11:	reginsel=0;	  			  
			  default: reginsel=0;  
		endcase
		
assign mixsel=reginsel;
always @ (state) 
		case(state)	
			  4'd0:	keyadsel=2'b00;
			  4'd1:	keyadsel=2'b00;
			  4'd2:	keyadsel=2'b11;
			  4'd3:	keyadsel=2'b11;
			  4'd4:	keyadsel=2'b11;
			  4'd5:	keyadsel=2'b11;
			  4'd6:	keyadsel=2'b11;
			  4'd7:	keyadsel=2'b11;
			  4'd8:	keyadsel=2'b11;
			  4'd9:	keyadsel=2'b11;
			  4'd10:	keyadsel=2'b11;
			  4'd11:	keyadsel=2'b11;	  			  
			  default: keyadsel=2'b00;  
		endcase
		
always @ (state) 
		case(state)	
			  4'd0:	rdkrfaddr=4'd0;
			  4'd1:	rdkrfaddr=4'd10;
			  4'd2:	rdkrfaddr=4'd9;
			  4'd3:	rdkrfaddr=4'd8;
			  4'd4:	rdkrfaddr=4'd7;
			  4'd5:	rdkrfaddr=4'd6;
			  4'd6:	rdkrfaddr=4'd5;
			  4'd7:	rdkrfaddr=4'd4;
			  4'd8:	rdkrfaddr=4'd3;
			  4'd9:	rdkrfaddr=4'd2;
			  4'd10:	rdkrfaddr=4'd1;
			  4'd11:	rdkrfaddr=4'd0;	  			  
			  default:    rdkrfaddr=4'd0;  
		endcase
		
always @ (state) 
		case(state)	
			  4'd0: decrdy=1;		  			  
			  default: decrdy=0;  
		endcase		
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
          8'h06: out=8'h7b;
          8'h07: out=8'h6f;
          8'h08: out=8'hc5;
          8'h09: out=8'h30;
          8'h0a: out=8'h01;
          8'h0b: out=8'h67;
          8'h0c: out=8'h2b;
          8'h0d: out=8'hfe;
          8'h0e: out=8'hd7;
          8'h0f: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'h03: out=8'h7b;
          8'hfa: out=8'h2d;
          8'hfb: out=8'h0f;
          8'hfc: out=8'hb0;
          8'hfd: out=8'h54;
          8'hfe: out=8'hbb;
          8'hff: out=8'h16;
      endcase
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


module crydap(clk,wrsben,wrsbaddr,sbdata,keyadsel,mixsel,reginsel,wrregen,intxt,roundkey,outtxt);
output [127:0] outtxt;
input clk,wrsben,wrregen,mixsel,reginsel;
input [1:0] keyadsel;
input [3:0] wrsbaddr;
input [127:0] sbdata,intxt,roundkey;
wire [7:0] sb0out,sb1out,sb2out,sb3out,sb4out,sb5out,sb6out,sb7out;
wire [7:0] sb8out,sb9out,sb10out,sb11out,sb12out,sb13out,sb14out,sb15out;
wire [7:0] a0,b0,c0,a1,b1,c1,a2,b2,c2,a3,b3,c3,a4,b4,c4,a5,b5,c5;
wire [7:0] a6,b6,c6,a7,b7,c7,a8,b8,c8,a9,b9,c9,a10,b10,c10,a11,b11,c11;
wire [7:0] a12,b12,c12,a13,b13,c13,a14,b14,c14,a15,b15,c15;
wire [7:0] d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15;
wire [7:0] e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15;
wire [7:0] f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15;
wire [7:0] g0,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15;
wire [7:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15;
wire [7:0] j0,j1,j2,j3,j4,j5,j6,j7,j8,j9,j10,j11,j12,j13,j14,j15;
wire [7:0] f002,f003,f009,f00b,f00d,f00e;
wire [7:0] f102,f103,f109,f10b,f10d,f10e;
??
wire [7:0] f1502,f1503,f1509,f150b,f150d,f150e;
wire [127:0] d,e,g,h;
sbox  sbox0(clk,wrsben,wrsbaddr,sbdata,outtxt[127:120],sb0out);
sbox  sbox1(clk,wrsben,wrsbaddr,sbdata,outtxt[119:112],sb1out);
??
sbox  sbox15(clk,wrsben,wrsbaddr,sbdata,outtxt[7:0],sb15out);
mux21_8  mux21_8_0(mixsel,sb0out,e0,f0);
mux21_8  mux21_8_1(mixsel,sb1out,e1,f1);
??
mux21_8  mux21_8_15(mixsel,sb15out,e15,f15);
byte0203 byte0203_0(f0,f002,f003);
byte0203 byte0203_1(f1,f102,f103);
??
byte0203 byte0203_15(f15,f1502,f1503);
byte9bde byte9bde_0(f0,f002,f003,f009,f00b,f00d,f00e);
byte9bde byte9bde_1(f1,f102,f103,f109,f10b,f10d,f10e);
??
byte9bde byte9bde_15(f15,f1502,f1503,f1509,f150b,f150d,f150e);
assign a0=f002^f503;
assign b0=sb10out^sb15out;
assign c0=a0^b0;
mux41_8  mux41_8_0(keyadsel,intxt[127:120],c0,sb0out,sb0out,d0);
assign a1=sb0out^f502;
assign b1=f1003^sb15out;
assign c1=a1^b1;
mux41_8  mux41_8_1(keyadsel,intxt[119:112],c1,sb5out,sb13out,d1);
     
assign a2=sb0out^sb5out;
assign b2=f1002^f1503;
assign c2=a2^b2;
mux41_8  mux41_8_2(keyadsel,intxt[111:104],c2,sb10out,sb10out,d2);
?????

assign a14=sb12out^sb1out;
assign b14=f602^f1103;
assign c14=a14^b14;
mux41_8  mux41_8_14(keyadsel,intxt[15:8],c14,sb6out,sb6out,d14);

assign a15=f1203^sb1out;
assign b15=sb6out^f1102;
assign c15=a15^b15;
mux41_8  mux41_8_15(keyadsel,intxt[7:0],c15,sb11out,sb3out,d15); 
assign d={d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15};
assign e={e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15};
assign g={g0,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15};   
assign {e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15}=d^roundkey;
assign i0=f00e^f10b;
assign j0=f20d^f309;
assign g0=i0^j0;
assign i1=f009^f10e;
assign j1=f20b^f30d;
assign g1=i1^j1;
?????. 
assign i14=f120d^f1309;
assign j14=f140e^f150b;
assign g14=i14^j14;
assign i15=f120b^f130d;
assign j15=f1409^f150e;
assign g15=i15^j15;
mux21_128  mux21_128_0(reginsel,e,g,h);
reg_128 resultreg(clk,wrregen,h,outtxt);   
endmodule 


module sbox(clk,write,wr_addr,din,rd_addr,dout);	
input clk;	
input write;
input [3:0] wr_addr;
input [127:0] din;
input [7:0] rd_addr;	
output [7:0] dout;
reg [15:0] decout;
wire [15:0] write_reg;
wire [127:0] reg0out,reg1out,reg2out,reg3out,??,reg15out;
reg [7:0] dout;
always @ (wr_addr)
case(wr_addr)
4'd0: decout=16'b0000_0000_0000_0001;
4'd1: decout=16'b0000_0000_0000_0010;
4'd2: decout=16'b0000_0000_0000_0100;
4'd3: decout=16'b0000_0000_0000_1000;
??????
4'd14: decout=16'b0100_0000_0000_0000;
4'd15: decout=16'b1000_0000_0000_0000;
endcase  
assign write_reg=decout & {write,write,write,write,write,write,write,write,write,write,write,write,write,write,write,write};
	
reg_128 reg0(clk,write_reg[0],din,reg0out);
reg_128 reg1(clk,write_reg[1],din,reg1out);
reg_128 reg2(clk,write_reg[2],din,reg2out);
reg_128 reg3(clk,write_reg[3],din,reg3out);
reg_128 reg4(clk,write_reg[4],din,reg4out);
reg_128 reg5(clk,write_reg[5],din,reg5out);
reg_128 reg6(clk,write_reg[6],din,reg6out);
reg_128 reg7(clk,write_reg[7],din,reg7out);
reg_128 reg8(clk,write_reg[8],din,reg8out);
reg_128 reg9(clk,write_reg[9],din,reg9out);
reg_128 reg10(clk,write_reg[10],din,reg10out);
reg_128 reg11(clk,write_reg[11],din,reg11out);
reg_128 reg12(clk,write_reg[12],din,reg12out);
reg_128 reg13(clk,write_reg[13],din,reg13out);
reg_128 reg14(clk,write_reg[14],din,reg14out);
reg_128 reg15(clk,write_reg[15],din,reg15out); 
always @(rd_addr or reg0out or reg1out or reg2out or reg3out or reg4out or reg5out or reg6out or reg7out or reg8out or reg9out or reg10out or reg11out or reg12out or reg13out or reg14out or reg15out)
case(rd_addr)
8'd0: dout=reg0out[127:120];
8'd1: dout=reg0out[119:112];
8'd2: dout=reg0out[111:104];
8'd3: dout=reg0out[103:96];
8'd4: dout=reg0out[95:88];
8'd5: dout=reg0out[87:80];
8'd6: dout=reg0out[79:72];
8'd7: dout=reg0out[71:64];
//.............................
8'd251: dout=reg15out[39:32];
8'd252: dout=reg15out[31:24];
8'd253: dout=reg15out[23:16];
8'd254: dout=reg15out[15:8];
8'd255: dout=reg15out[7:0];
endcase
endmodule 


module mux21_8(sel,a,b,c);
     output[7:0] c;
     input[7:0] a,b;
     input sel;
     reg [7:0] c;
     always@(sel or a or b)
        case(sel)
            1'b0: c=a;
            1'b1: c=b;          
        endcase
endmodule 


module byte0203(a,a02,a03);
     output[7:0] a02,a03;
     input[7:0] a;
     wire [7:0] b,c;
     assign b={a[6:0],1'b0};
     assign c=b^{8'h1b};aa
     assign a02=(a[7]==0)? b:c;
     assign a03=a02^a;
endmodule 


module byte9bde(a,a02,a03,a09,a0b,a0d,a0e);
     output[7:0] a09,a0b,a0d,a0e;
     input[7:0] a,a02,a03;
     wire [7:0] a04,a08,b,c;
     byte02  byte02_0(a02,a04);
     byte02  byte02_1(a04,a08);
     assign a09=a08^a;
     assign a0b=a08^a03;
     assign b=a04^a;
     assign c=a04^a02;
     assign a0d=a08^b;
     assign a0e=a08^c;
endmodule


module byte02(a,a02);
     output[7:0] a02;
     input[7:0] a;
     wire [7:0] b,c;
     assign b={a[6:0],1'b0};
     assign c=b^{8'h1b};
     assign a02=(a[7]==0)? b:c;
endmodule 


module mux41_8(sel,a,b,c,d,e);
     output[7:0] e;
     input[7:0] a,b,c,d;
     input [1:0] sel;
     reg [7:0] e;
     always@(sel or a or b or c or d)
        case(sel)
           2'b00: e=a;
           2'b01: e=b;
           2'b10: e=c;
           2'b11: e=d;
       endcase
endmodule 


module mux21_128(sel,a,b,c);
     output[127:0] c;
     input[127:0] a,b;
     input sel;
     reg [127:0] c;
     always@(sel or a or b)
         case(sel)
            1'b0: c=a;
            1'b1: c=b;          
         endcase
endmodule 
