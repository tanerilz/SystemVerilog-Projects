`include "dualportram2.v"
module FIFO(write_req,write_data,FULL,read_req,read_data,EMP,clk,clkr,reset);
   input write_req,read_req;
   input clk,clkr,reset;
   input [7:0] write_data;
   output      FULL,EMP;
   output [7:0] read_data;
   reg 		write_req,read_req,clk,clkr,FULL,EMP;
   reg [7:0] 	write_data;
   reg [8:0] 	write_pointer;
   reg [8:0]	read_pointer;
   reg 		reset;
   reg [7:0] 	read_data;

   
   
   
   
   DualportRam DP(.A1(write_pointer),.A2(read_pointer),.WD1(write_data),.WD2(),.WE1(write_req),.WE2(read_req),.DOUT1(),.DOUT2(read_data),.clk1(clk),.clk2(clk));
   
   
   
   
   always@(posedge clk or negedge reset) begin
      if(~reset) begin
	 write_pointer<=0;
      end
      else if(write_req)
	write_pointer<=write_pointer+1;
   end

   always@(posedge clk or negedge reset) begin
      if(~reset) begin
	 read_pointer<=0;
      end
      else if(read_req) 
	read_pointer<=read_pointer+1;
   end
   
   always@(*) begin
      if(write_pointer[7:0]==read_pointer[7:0] && write_pointer[8]!=read_pointer[8])
	FULL=1;
      else FULL=0;
      
      if(write_pointer[7:0]==read_pointer[7:0] && write_pointer [8]==read_pointer[8])
	EMP=1;
      else EMP=0;
      
   end
   

   
   
   
endmodule // FIFO






