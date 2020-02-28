module aescontrol(clk,rst,load,address,keyexp,staenc,stadec,keyexprdy,encdecrdy,keysel,rndkren,wrrndkrf,krfaddr,rconen,wrsben,wrsbaddr,keyadsel,mixsel,reginsel,wrregen,wrpckreg);

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


`timescale 1ns / 1ns
module aescontrol_tb;
wire  keyexprdy,encdecrdy,keysel,rndkren,wrrndkrf,rconen;
wire  wrsben,mixsel,reginsel,wrregen,wrpckreg;
wire  [1:0] keyadsel;
wire  [3:0] krfaddr,wrsbaddr;
reg   clk,rst,load,keyexp,staenc,stadec;
reg   [4:0] address;

aescontrol  aescontrol(clk,rst,load,address,keyexp,staenc,stadec,keyexprdy,encdecrdy,keysel,rndkren,wrrndkrf,krfaddr,rconen,wrsben,wrsbaddr,keyadsel,mixsel,reginsel,wrregen,wrpckreg);

//clock generation				   
initial clk = 1;
always #50 clk = ~clk;

initial 
	begin 
		#20  rst=1;//test reset.
		     load=0;
		     address=5'd0;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
		#200 rst=0;
		     load=1; //test load data.
		     address=5'd0;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
		#100 rst=0;
		     load=1;
		     address=5'd1;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
		#100 rst=0;
		     load=1;
		     address=5'd2;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
		#100 rst=0;
		     load=1;
		     address=5'd3;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
		#100 rst=0;
		     load=1;
		     address=5'd4;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
		#100 rst=0;
		     load=1;
		     address=5'd5;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		
     #100  rst=0;
		     load=1;
		     address=5'd6;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd7;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd8;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd9;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd10;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd11;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd12;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd13;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd14;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd15;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd16;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd17;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd18;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		        
      #100 rst=0;
		     load=1;
		     address=5'd19;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd20;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd21;
		     keyexp=0;
		     staenc=0;
		     stadec=0;
		     
	  #100  rst=0;
		     load=1;
		     address=5'd22;
		     keyexp=0;
		     staenc=0;
		     stadec=0;
     #100  rst=0;
		     load=1;
		     address=5'd23;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd24;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd25;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd26;
		     keyexp=0;
		     staenc=0;
		     stadec=0;
     #100  rst=0;
		     load=1;
		     address=5'd27;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd28;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd29;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd30;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=1;
		     address=5'd31;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=0;
		     address=5'd0;
		     keyexp=1;//test cipher key expansion.
		     staenc=0;
		     stadec=0;		     
	  #100  rst=0;
		     load=0;
		     address=5'd1;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #1200 rst=0;
		     load=0;
		     address=5'd2;
		     keyexp=0;
		     staenc=1;//test start encryption.
		     stadec=0;		     
	  #100  rst=0;
		     load=0;
		     address=5'd3;
		     keyexp=0;
		     staenc=0;
		     stadec=0;		     
	  #1200 rst=0;
		     load=0;
		     address=5'd16;
		     keyexp=0;
		     staenc=0;
		     stadec=1;//tset start decryption.		     
	  #100  rst=0;
		     load=0;
		     address=5'd17;
		     keyexp=0;
		     staenc=0;
		     stadec=0;
	  #1200 $stop;		  
	end					
endmodule
