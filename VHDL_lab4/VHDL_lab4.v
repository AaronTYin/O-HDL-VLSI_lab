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
wire [7:0] f202,f203,f209,f20b,f20d,f20e;
wire [7:0] f302,f303,f309,f30b,f30d,f30e;
wire [7:0] f402,f403,f409,f40b,f40d,f40e;
wire [7:0] f502,f503,f509,f50b,f50d,f50e;
wire [7:0] f602,f603,f609,f60b,f60d,f60e;
wire [7:0] f702,f703,f709,f70b,f70d,f70e;
wire [7:0] f802,f803,f809,f80b,f80d,f80e;
wire [7:0] f902,f903,f909,f90b,f90d,f90e;
wire [7:0] f1002,f1003,f1009,f100b,f100d,f100e;
wire [7:0] f1102,f1103,f1109,f110b,f110d,f110e;
wire [7:0] f1202,f1203,f1209,f120b,f120d,f120e;
wire [7:0] f1302,f1303,f1309,f130b,f130d,f130e;
wire [7:0] f1402,f1403,f1409,f140b,f140d,f140e;
wire [7:0] f1502,f1503,f1509,f150b,f150d,f150e;
wire [127:0] d,e,g,h;
sbox  sbox0(clk,wrsben,wrsbaddr,sbdata,outtxt[127:120],sb0out);
sbox  sbox1(clk,wrsben,wrsbaddr,sbdata,outtxt[119:112],sb1out);
sbox  sbox2(clk,wrsben,wrsbaddr,sbdata,outtxt[111:104],sb2out);
sbox  sbox3(clk,wrsben,wrsbaddr,sbdata,outtxt[103:96],sb3out);
sbox  sbox4(clk,wrsben,wrsbaddr,sbdata,outtxt[95:88],sb4out);
sbox  sbox5(clk,wrsben,wrsbaddr,sbdata,outtxt[87:80],sb5out);
sbox  sbox6(clk,wrsben,wrsbaddr,sbdata,outtxt[79:72],sb6out);
sbox  sbox7(clk,wrsben,wrsbaddr,sbdata,outtxt[71:64],sb7out);
sbox  sbox8(clk,wrsben,wrsbaddr,sbdata,outtxt[63:56],sb8out);
sbox  sbox9(clk,wrsben,wrsbaddr,sbdata,outtxt[55:48],sb9out);
sbox  sbox10(clk,wrsben,wrsbaddr,sbdata,outtxt[47:40],sb10out);
sbox  sbox11(clk,wrsben,wrsbaddr,sbdata,outtxt[39:32],sb11out);
sbox  sbox12(clk,wrsben,wrsbaddr,sbdata,outtxt[31:24],sb12out);
sbox  sbox13(clk,wrsben,wrsbaddr,sbdata,outtxt[23:16],sb13out);
sbox  sbox14(clk,wrsben,wrsbaddr,sbdata,outtxt[15:8],sb14out);
sbox  sbox15(clk,wrsben,wrsbaddr,sbdata,outtxt[7:0],sb15out);
mux21_8  mux21_8_0(mixsel,sb0out,e0,f0);
mux21_8  mux21_8_1(mixsel,sb1out,e1,f1);
mux21_8  mux21_8_2(mixsel,sb2out,e2,f2);
mux21_8  mux21_8_3(mixsel,sb3out,e3,f3);
mux21_8  mux21_8_4(mixsel,sb4out,e4,f4);
mux21_8  mux21_8_5(mixsel,sb5out,e5,f5);
mux21_8  mux21_8_6(mixsel,sb6out,e6,f6);
mux21_8  mux21_8_7(mixsel,sb7out,e7,f7);
mux21_8  mux21_8_8(mixsel,sb8out,e8,f8);
mux21_8  mux21_8_9(mixsel,sb9out,e9,f9);
mux21_8  mux21_8_10(mixsel,sb10out,e10,f10);
mux21_8  mux21_8_11(mixsel,sb11out,e11,f11);
mux21_8  mux21_8_12(mixsel,sb12out,e12,f12);
mux21_8  mux21_8_13(mixsel,sb13out,e13,f13);
mux21_8  mux21_8_14(mixsel,sb14out,e14,f14);
mux21_8  mux21_8_15(mixsel,sb15out,e15,f15);
byte0203 byte0203_0(f0,f002,f003);
byte0203 byte0203_1(f1,f102,f103);
byte0203 byte0203_2(f2,f202,f203);
byte0203 byte0203_3(f3,f302,f303);
byte0203 byte0203_4(f4,f402,f403);
byte0203 byte0203_5(f5,f502,f503);
byte0203 byte0203_6(f6,f602,f603);
byte0203 byte0203_7(f7,f702,f703);
byte0203 byte0203_8(f8,f802,f803);
byte0203 byte0203_9(f9,f902,f903);
byte0203 byte0203_10(f10,f1002,f1003);
byte0203 byte0203_11(f11,f1102,f1103);
byte0203 byte0203_12(f12,f1202,f1203);
byte0203 byte0203_13(f13,f1302,f1303);
byte0203 byte0203_14(f14,f1402,f1403);
byte0203 byte0203_15(f15,f1502,f1503);
byte9bde byte9bde_0(f0,f002,f003,f009,f00b,f00d,f00e);
byte9bde byte9bde_1(f1,f102,f103,f109,f10b,f10d,f10e);
byte9bde byte9bde_2(f2,f202,f203,f209,f20b,f20d,f20e);
byte9bde byte9bde_3(f3,f302,f303,f309,f30b,f30d,f30e);
byte9bde byte9bde_4(f4,f402,f403,f409,f40b,f40d,f40e);
byte9bde byte9bde_5(f5,f502,f503,f509,f50b,f50d,f50e);
byte9bde byte9bde_6(f6,f602,f603,f609,f60b,f60d,f60e);
byte9bde byte9bde_7(f7,f702,f703,f709,f70b,f70d,f70e);
byte9bde byte9bde_8(f8,f802,f803,f809,f80b,f80d,f80e);
byte9bde byte9bde_9(f9,f902,f903,f909,f90b,f90d,f90e);
byte9bde byte9bde_10(f10,f1002,f1003,f1009,f100b,f100d,f100e);
byte9bde byte9bde_11(f11,f1102,f1103,f1109,f110b,f110d,f110e);
byte9bde byte9bde_12(f12,f1202,f1203,f1209,f120b,f120d,f120e);
byte9bde byte9bde_13(f13,f1302,f1303,f1309,f130b,f130d,f130e);
byte9bde byte9bde_14(f14,f1402,f1403,f1409,f140b,f140d,f140e);
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
assign a3=f003^sb5out;
assign b3=sb10out^f1502;
assign c3=a3^b3;
mux41_8  mux41_8_3(keyadsel,intxt[103:96],c3,sb15out,sb7out,d3);
assign a4=f402^f903;
assign b4=sb14out^sb3out;
assign c4=a4^b4;
mux41_8  mux41_8_4(keyadsel,intxt[95:88],c4,sb4out,sb4out,d4);
assign a5=sb4out^f902;
assign b5=f1403^sb3out;
assign c5=a5^b5;
mux41_8  mux41_8_5(keyadsel,intxt[87:80],c5,sb9out,sb1out,d5);  
assign a6=sb4out^sb9out;
assign b6=f1402^f303;
assign c6=a6^b6;
mux41_8  mux41_8_6(keyadsel,intxt[79:72],c6,sb14out,sb14out,d6);
assign a7=f403^sb9out;
assign b7=sb14out^f302;
assign c7=a7^b7;
mux41_8  mux41_8_7(keyadsel,intxt[71:64],c7,sb3out,sb11out,d7);     
assign a8=f802^f1303;
assign b8=sb2out^sb7out;
assign c8=a8^b8;
mux41_8  mux41_8_8(keyadsel,intxt[63:56],c8,sb8out,sb8out,d8);     
assign a9=sb8out^f1302;
assign b9=f203^sb7out;
assign c9=a9^b9;
mux41_8  mux41_8_9(keyadsel,intxt[55:48],c9,sb13out,sb5out,d9);
assign a10=sb8out^sb13out;
assign b10=f202^f703;
assign c10=a10^b10;
mux41_8  mux41_8_10(keyadsel,intxt[47:40],c10,sb2out,sb2out,d10);
assign a11=f803^sb13out;
assign b11=sb2out^f702;
assign c11=a11^b11;
mux41_8  mux41_8_11(keyadsel,intxt[39:32],c11,sb7out,sb15out,d11);
assign a12=f1202^f103;
assign b12=sb6out^sb11out;
assign c12=a12^b12;
mux41_8  mux41_8_12(keyadsel,intxt[31:24],c12,sb12out,sb12out,d12);      
assign a13=sb12out^f102;
assign b13=f603^sb11out;
assign c13=a13^b13;
mux41_8  mux41_8_13(keyadsel,intxt[23:16],c13,sb1out,sb9out,d13);      
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
assign i2=f00d^f109;
assign j2=f20e^f30b;
assign g2=i2^j2;
assign i3=f00b^f10d;
assign j3=f209^f30e;
assign g3=i3^j3;
assign i4=f40e^f50b;
assign j4=f60d^f709;
assign g4=i4^j4;
assign i5=f409^f50e;
assign j5=f60b^f70d;
assign g5=i5^j5;
assign i6=f40d^f509;
assign j6=f60e^f70b;
assign g6=i6^j6;
assign i7=f40b^f50d;
assign j7=f609^f70e;
assign g7=i7^j7;

assign i8=f80e^f90b;
assign j8=f100d^f1109;
assign g8=i8^j8;
assign i9=f809^f90e;
assign j9=f100b^f110d;
assign g9=i9^j9;
assign i10=f80d^f909;
assign j10=f100e^f110b;
assign g10=i10^j10;
assign i11=f80b^f90d;
assign j11=f1009^f110e;
assign g11=i11^j11;
assign i12=f120e^f130b;
assign j12=f140d^f1509;
assign g12=i12^j12;
assign i13=f1209^f130e;
assign j13=f140b^f150d;
assign g13=i13^j13;
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
wire [127:0] reg0out,reg1out,reg2out,reg3out,reg4out,reg5out,reg6out,reg7out,reg8out,reg9out,reg10out,reg11out,reg12out,reg13out,reg14out,reg15out;
reg [7:0] dout;
always @ (wr_addr)
  case(wr_addr)
    4'd0: decout=16'b0000_0000_0000_0001;
    4'd1: decout=16'b0000_0000_0000_0010;
    4'd2: decout=16'b0000_0000_0000_0100;
    4'd3: decout=16'b0000_0000_0000_1000;
    4'd4: decout=16'b0000_0000_0001_0000;
    4'd5: decout=16'b0000_0000_0010_0000;
    4'd6: decout=16'b0000_0000_0100_0000;
    4'd7: decout=16'b0000_0000_1000_0000;
    4'd8: decout=16'b0000_0001_0000_0000;
    4'd9: decout=16'b0000_0010_0000_0000;
    4'd10: decout=16'b0000_0100_0000_0000;
    4'd11: decout=16'b0000_1000_0000_0000;
    4'd12: decout=16'b0001_0000_0000_0000;
    4'd13: decout=16'b0010_0000_0000_0000;
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
    8'd8: dout=reg0out[63:56];
    8'd9: dout=reg0out[55:48];
    8'd10: dout=reg0out[47:40];
    8'd11: dout=reg0out[39:32];
    8'd12: dout=reg0out[31:24];
    8'd13: dout=reg0out[23:16];
    8'd14: dout=reg0out[15:8];
    8'd15: dout=reg0out[7:0];
    
    8'd16: dout=reg1out[127:120];
    8'd17: dout=reg1out[119:112];
    8'd18: dout=reg1out[111:104];
    8'd19: dout=reg1out[103:96];
    8'd20: dout=reg1out[95:88];
    8'd21: dout=reg1out[87:80];
    8'd22: dout=reg1out[79:72];
    8'd23: dout=reg1out[71:64];
    8'd24: dout=reg1out[63:56];
    8'd25: dout=reg1out[55:48];
    8'd26: dout=reg1out[47:40];
    8'd27: dout=reg1out[39:32];
    8'd28: dout=reg1out[31:24];
    8'd29: dout=reg1out[23:16];
    8'd30: dout=reg1out[15:8];
    8'd31: dout=reg1out[7:0];
    
    8'd32: dout=reg2out[127:120];
    8'd33: dout=reg2out[119:112];
    8'd34: dout=reg2out[111:104];
    8'd35: dout=reg2out[103:96];
    8'd36: dout=reg2out[95:88];
    8'd37: dout=reg2out[87:80];
    8'd38: dout=reg2out[79:72];
    8'd39: dout=reg2out[71:64];
    8'd40: dout=reg2out[63:56];
    8'd41: dout=reg2out[55:48];
    8'd42: dout=reg2out[47:40];
    8'd43: dout=reg2out[39:32];
    8'd44: dout=reg2out[31:24];
    8'd45: dout=reg2out[23:16];
    8'd46: dout=reg2out[15:8];
    8'd47: dout=reg2out[7:0];
    
    8'd48: dout=reg3out[127:120];
    8'd49: dout=reg3out[119:112];
    8'd50: dout=reg3out[111:104];
    8'd51: dout=reg3out[103:96];
    8'd52: dout=reg3out[95:88];
    8'd53: dout=reg3out[87:80];
    8'd54: dout=reg3out[79:72];
    8'd55: dout=reg3out[71:64];
    8'd56: dout=reg3out[63:56];
    8'd57: dout=reg3out[55:48];
    8'd58: dout=reg3out[47:40];
    8'd59: dout=reg3out[39:32];
    8'd60: dout=reg3out[31:24];
    8'd61: dout=reg3out[23:16];
    8'd62: dout=reg3out[15:8];
    8'd63: dout=reg3out[7:0];
    
    8'd64: dout=reg4out[127:120];
    8'd65: dout=reg4out[119:112];
    8'd66: dout=reg4out[111:104];
    8'd67: dout=reg4out[103:96];
    8'd68: dout=reg4out[95:88];
    8'd69: dout=reg4out[87:80];
    8'd70: dout=reg4out[79:72];
    8'd71: dout=reg4out[71:64];
    8'd72: dout=reg4out[63:56];
    8'd73: dout=reg4out[55:48];
    8'd74: dout=reg4out[47:40];
    8'd75: dout=reg4out[39:32];
    8'd76: dout=reg4out[31:24];
    8'd77: dout=reg4out[23:16];
    8'd78: dout=reg4out[15:8];
    8'd79: dout=reg4out[7:0];
    
    8'd80: dout=reg5out[127:120];
    8'd81: dout=reg5out[119:112];
    8'd82: dout=reg5out[111:104];
    8'd83: dout=reg5out[103:96];
    8'd84: dout=reg5out[95:88];
    8'd85: dout=reg5out[87:80];
    8'd86: dout=reg5out[79:72];
    8'd87: dout=reg5out[71:64];
    8'd88: dout=reg5out[63:56];
    8'd89: dout=reg5out[55:48];
    8'd90: dout=reg5out[47:40];
    8'd91: dout=reg5out[39:32];
    8'd92: dout=reg5out[31:24];
    8'd93: dout=reg5out[23:16];
    8'd94: dout=reg5out[15:8];
    8'd95: dout=reg5out[7:0];
    
    8'd96: dout=reg6out[127:120];
    8'd97: dout=reg6out[119:112];
    8'd98: dout=reg6out[111:104];
    8'd99: dout=reg6out[103:96];
    8'd100: dout=reg6out[95:88];
    8'd101: dout=reg6out[87:80];
    8'd102: dout=reg6out[79:72];
    8'd103: dout=reg6out[71:64];
    8'd104: dout=reg6out[63:56];
    8'd105: dout=reg6out[55:48];
    8'd106: dout=reg6out[47:40];
    8'd107: dout=reg6out[39:32];
    8'd108: dout=reg6out[31:24];
    8'd109: dout=reg6out[23:16];
    8'd110: dout=reg6out[15:8];
    8'd111: dout=reg6out[7:0];
    
    8'd112: dout=reg7out[127:120];
    8'd113: dout=reg7out[119:112];
    8'd114: dout=reg7out[111:104];
    8'd115: dout=reg7out[103:96];
    8'd116: dout=reg7out[95:88];
    8'd117: dout=reg7out[87:80];
    8'd118: dout=reg7out[79:72];
    8'd119: dout=reg7out[71:64];
    8'd120: dout=reg7out[63:56];
    8'd121: dout=reg7out[55:48];
    8'd122: dout=reg7out[47:40];
    8'd123: dout=reg7out[39:32];
    8'd124: dout=reg7out[31:24];
    8'd125: dout=reg7out[23:16];
    8'd126: dout=reg7out[15:8];
    8'd127: dout=reg7out[7:0];
    
    8'd128: dout=reg8out[127:120];
    8'd129: dout=reg8out[119:112];
    8'd130: dout=reg8out[111:104];
    8'd131: dout=reg8out[103:96];
    8'd132: dout=reg8out[95:88];
    8'd133: dout=reg8out[87:80];
    8'd134: dout=reg8out[79:72];
    8'd135: dout=reg8out[71:64];
    8'd136: dout=reg8out[63:56];
    8'd137: dout=reg8out[55:48];
    8'd138: dout=reg8out[47:40];
    8'd139: dout=reg8out[39:32];
    8'd140: dout=reg8out[31:24];
    8'd141: dout=reg8out[23:16];
    8'd142: dout=reg8out[15:8];
    8'd143: dout=reg8out[7:0];
    
    8'd144: dout=reg9out[127:120];
    8'd145: dout=reg9out[119:112];
    8'd146: dout=reg9out[111:104];
    8'd147: dout=reg9out[103:96];
    8'd148: dout=reg9out[95:88];
    8'd149: dout=reg9out[87:80];
    8'd150: dout=reg9out[79:72];
    8'd151: dout=reg9out[71:64];
    8'd152: dout=reg9out[63:56];
    8'd153: dout=reg9out[55:48];
    8'd154: dout=reg9out[47:40];
    8'd155: dout=reg9out[39:32];
    8'd156: dout=reg9out[31:24];
    8'd157: dout=reg9out[23:16];
    8'd158: dout=reg9out[15:8];
    8'd159: dout=reg9out[7:0];
    
    8'd160: dout=reg10out[127:120];
    8'd161: dout=reg10out[119:112];
    8'd162: dout=reg10out[111:104];
    8'd163: dout=reg10out[103:96];
    8'd164: dout=reg10out[95:88];
    8'd165: dout=reg10out[87:80];
    8'd166: dout=reg10out[79:72];
    8'd167: dout=reg10out[71:64];
    8'd168: dout=reg10out[63:56];
    8'd169: dout=reg10out[55:48];
    8'd170: dout=reg10out[47:40];
    8'd171: dout=reg10out[39:32];
    8'd172: dout=reg10out[31:24];
    8'd173: dout=reg10out[23:16];
    8'd174: dout=reg10out[15:8];
    8'd175: dout=reg10out[7:0];
    
    8'd176: dout=reg11out[127:120];
    8'd177: dout=reg11out[119:112];
    8'd178: dout=reg11out[111:104];
    8'd179: dout=reg11out[103:96];
    8'd180: dout=reg11out[95:88];
    8'd181: dout=reg11out[87:80];
    8'd182: dout=reg11out[79:72];
    8'd183: dout=reg11out[71:64];
    8'd184: dout=reg11out[63:56];
    8'd185: dout=reg11out[55:48];
    8'd186: dout=reg11out[47:40];
    8'd187: dout=reg11out[39:32];
    8'd188: dout=reg11out[31:24];
    8'd189: dout=reg11out[23:16];
    8'd190: dout=reg11out[15:8];
    8'd191: dout=reg11out[7:0];
    
    8'd192: dout=reg12out[127:120];
    8'd193: dout=reg12out[119:112];
    8'd194: dout=reg12out[111:104];
    8'd195: dout=reg12out[103:96];
    8'd196: dout=reg12out[95:88];
    8'd197: dout=reg12out[87:80];
    8'd198: dout=reg12out[79:72];
    8'd199: dout=reg12out[71:64];
    8'd200: dout=reg12out[63:56];
    8'd201: dout=reg12out[55:48];
    8'd202: dout=reg12out[47:40];
    8'd203: dout=reg12out[39:32];
    8'd204: dout=reg12out[31:24];
    8'd205: dout=reg12out[23:16];
    8'd206: dout=reg12out[15:8];
    8'd207: dout=reg12out[7:0];
    
    8'd208: dout=reg13out[127:120];
    8'd209: dout=reg13out[119:112];
    8'd210: dout=reg13out[111:104];
    8'd211: dout=reg13out[103:96];
    8'd212: dout=reg13out[95:88];
    8'd213: dout=reg13out[87:80];
    8'd214: dout=reg13out[79:72];
    8'd215: dout=reg13out[71:64];
    8'd216: dout=reg13out[63:56];
    8'd217: dout=reg13out[55:48];
    8'd218: dout=reg13out[47:40];
    8'd219: dout=reg13out[39:32];
    8'd220: dout=reg13out[31:24];
    8'd221: dout=reg13out[23:16];
    8'd222: dout=reg13out[15:8];
    8'd223: dout=reg13out[7:0];
    
    8'd224: dout=reg14out[127:120];
    8'd225: dout=reg14out[119:112];
    8'd226: dout=reg14out[111:104];
    8'd227: dout=reg14out[103:96];
    8'd228: dout=reg14out[95:88];
    8'd229: dout=reg14out[87:80];
    8'd230: dout=reg14out[79:72];
    8'd231: dout=reg14out[71:64];
    8'd232: dout=reg14out[63:56];
    8'd233: dout=reg14out[55:48];
    8'd234: dout=reg14out[47:40];
    8'd235: dout=reg14out[39:32];
    8'd236: dout=reg14out[31:24];
    8'd237: dout=reg14out[23:16];
    8'd238: dout=reg14out[15:8];
    8'd239: dout=reg14out[7:0];
    
    8'd240: dout=reg15out[127:120];
    8'd241: dout=reg15out[119:112];
    8'd242: dout=reg15out[111:104];
    8'd243: dout=reg15out[103:96];
    8'd244: dout=reg15out[95:88];
    8'd245: dout=reg15out[87:80];
    8'd246: dout=reg15out[79:72];
    8'd247: dout=reg15out[71:64];
    8'd248: dout=reg15out[63:56];
    8'd249: dout=reg15out[55:48];
    8'd250: dout=reg15out[47:40];
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
assign c=b^{8'h1b};
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



`timescale 1ns / 1ns
module crydap_tb;
wire [127:0] outtxt;
reg clk,wrsben,wrregen,mixsel,reginsel;
reg [1:0] keyadsel;
reg [3:0] wrsbaddr;
reg [127:0] sbdata,intxt,roundkey;
crydap  crydap(clk,wrsben,wrsbaddr,sbdata,keyadsel,mixsel,reginsel,wrregen,
intxt,roundkey,outtxt);
//clock generation				   
initial clk = 1;
always #50 clk = ~clk;
initial 
	begin 
		//decryption sbox configuration.
		#20  wrsben=1;
		     wrsbaddr=4'd0;
		     sbdata=128'h52096ad53036a538bf40a39e81f3d7fb;
		#100 wrsben=1;
		     wrsbaddr=4'd1;
		     sbdata=128'h7ce339829b2fff87348e4344c4dee9cb;
		#100 wrsben=1;
		     wrsbaddr=4'd2;
		     sbdata=128'h547b9432a6c2233dee4c950b42fac34e;
		#100 wrsben=1;
		     wrsbaddr=4'd3;
		     sbdata=128'h082ea16628d924b2765ba2496d8bd125;
		#100 wrsben=1;
		     wrsbaddr=4'd4;
		     sbdata=128'h72f8f66486689816d4a45ccc5d65b692;
		#100 wrsben=1;
		     wrsbaddr=4'd5;
		     sbdata=128'h6c704850fdedb9da5e154657a78d9d84;
		#100 wrsben=1;
		     wrsbaddr=4'd6;
		     sbdata=128'h90d8ab008cbcd30af7e45805b8b34506;
		#100 wrsben=1;
		     wrsbaddr=4'd7;
		     sbdata=128'hd02c1e8fca3f0f02c1afbd0301138a6b;
		#100 wrsben=1;
		     wrsbaddr=4'd8;
		     sbdata=128'h3a9111414f67dcea97f2cfcef0b4e673;
		#100 wrsben=1;
		     wrsbaddr=4'd9;
		     sbdata=128'h96ac7422e7ad3585e2f937e81c75df6e;
		#100 wrsben=1;
		     wrsbaddr=4'd10;
		     sbdata=128'h47f11a711d29c5896fb7620eaa18be1b;
		#100 wrsben=1;
		     wrsbaddr=4'd11;
		     sbdata=128'hfc563e4bc6d279209adbc0fe78cd5af4;
		#100 wrsben=1;
		     wrsbaddr=4'd12;
		     sbdata=128'h1fdda8338807c731b11210592780ec5f;
		#100 wrsben=1;
		     wrsbaddr=4'd13;
		     sbdata=128'h60517fa919b54a0d2de57a9f93c99cef;
		#100 wrsben=1;
		     wrsbaddr=4'd14;
		     sbdata=128'ha0e03b4dae2af5b0c8ebbb3c83539961;
		#100 wrsben=1;
		     wrsbaddr=4'd15;
		     sbdata=128'h172b047eba77d626e169146355210c7d;
		#100 wrsben=0;		
		//decryption.
		#100 	
		     wrregen=1;
		     keyadsel=2'b00;
		     mixsel=0;
		     reginsel=0;
		     intxt=128'ha7409f43b025b25772e80f4569a61e4c;//3925841d_02dc09fb_dc118597_196a0b32;//
		     roundkey=128'hd014f9a8_c9ee2589_e13f0cc8_b6630ca6;		                      
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'hac7766f3_19fadc21_28d12941_575c006e;  
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'head27321_b58dbad2_312bf560_7f8d292f;    
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'h4e54f70e_5f5fc9f3_84a64fb2_4ea6dc4f; 
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'h6d88a37a_110b3efd_dbf98641_ca0093fd; 
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;		     
		     roundkey=128'hd4d1c6f8_7c839d87_caf2b8bc_11f915bc;      
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'hef44a541_a8525b7f_b671253b_db0bad00;
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'h3d80477d_4716fe3e_1e237e44_6d7a883b;
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'hf2c295f2_7a96b943_5935807a_7359f67f;
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=1;
		     reginsel=1;
		     roundkey=128'ha0fafe17_88542cb1_23a33939_2a6c7605;
      #100 
		     wrregen=1;
		     keyadsel=2'b11;
		     mixsel=0;
		     reginsel=0;
		     roundkey=128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;		                
      #100 wrregen=0;
      #200 $stop;		
	end
endmodule


