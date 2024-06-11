`timescale 1ps/1ps


module dac_tm(clk,in,out);

	input clk;
	input reg[0:3] in;
	output real out;



	//reg[0:9] tape;
	

	parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
	reg[0:9] tape;

	reg [2:0] state;
	reg [2:0] next_state;
	integer p;
	integer res;

	always @(in) begin
	reg[0:9] temp;
	tape = 10'b0000000000;
	tape[3] = 'x;
		tape[4] = in[0];
		tape[5] = in[1];
		tape[6] = in[2];
		tape[7] = in[3];
		tape[8] = 'x;
		state <= s0;
		next_state <= s0;
		out <=0;
		res<=0;
		p<=0;
$display("tape = %b",tape);
	
	end

	always @(posedge clk, next_state)
		state<=next_state;
	always @(posedge clk) begin
	case(state)
	s0: begin
		res=res+p;
		p=0;
		if(tape[4]==0)begin
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
						tape[4]='x;
			tape =tape << 1;
			next_state=s0;
		end else if(tape[4]==1)begin
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
			tape[4]='x;
			tape =tape << 1;
			next_state = s1;
		end else begin
			next_state=s4;
		end

		out='x;
	end
	s1: begin
		p=1;
		if(tape[4]==0)begin
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
			tape =tape << 1;
			next_state=s2;
		end else if(tape[4]==1)begin
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);

			tape =tape << 1;
			next_state=s2;
		end else begin
			tape = tape >>1;
			next_state=s0;
		end
		out='x;	
	end
	s2: begin
		p=p*2;
		if(tape[4]==0)begin
			tape =tape << 1;
			next_state=s2;
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
		end else if(tape[4]==1)begin
			tape =tape << 1;
			next_state=s2;
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
		end else begin
			tape = tape >>1;
			next_state=s3;
		end

		out='x;
	
	end
	s3: begin
		if(tape[4]==0)begin
			tape =tape >> 1;
			next_state=s3;
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
		end else if(tape[4]==1)begin
			tape =tape >> 1;
			next_state=s3;
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
		end else begin
			tape = tape<<1;
			next_state=s0;
		end
		out='x;

	end
	s4: begin
		out = res*0.075;
		next_state = s4;
$display("state %d tape4 =%b, tape %b res = %d",state,tape[4],tape,res);
	end
	endcase
end

endmodule


module clk(out);
	output reg out;
	
	initial
 		out = 1'b0; 

	always
		#10 out =~out;
endmodule

module test;
wire out_clk;
clk clk1(out_clk);
reg [0:3] in_dac;
real out_dac;
dac_tm dac1(out_clk,in_dac,out_dac);
integer i;
initial begin 
      
        in_dac = 4'b0000;
        
        
        
        for (i = 1; i < 16; i = i + 1) begin
            #700;
            in_dac = i;
            //$display("in_dac = %b", in_dac);
        end   
#700 in_dac =0;   
    
#1200 $finish;
end
endmodule


