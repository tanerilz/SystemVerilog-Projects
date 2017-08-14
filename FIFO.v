`include "DPR.v"
module FIFO(WRreq,WRData,FULL,RReq,RData,EMP,clk,clkr,reset);
   input WRreq,RReq;
   input clk,clkr,reset;
   input [7:0] WRData;
   output      FULL,EMP;
   output [7:0] RData;
   reg 		WRreq,RReq,clk,clkr,FULL,EMP;
   reg [7:0] 	WRData;
   reg [8:0] 	Aw;
   reg [8:0]	Ar;
   reg 		reset;
   reg [7:0] 	RData;

   
   
   
   
   DualRam DP(.A1(Aw),.A2(Ar),.WD1(WRData),.WD2(),.WE1(WRreq),.WE2(RReq),.DOUT1(),.DOUT2(RData),.clk1(clk),.clk2(clkr));
   
   
   
   
   always@(posedge clk or negedge reset)
     if(~reset) begin
       Aw<=0;
       FULL<=0;
     end
     else if(WRreq)
       Aw<=Aw+1;


   always@(posedge clkr or negedge reset)
     if(~reset) begin
       Ar<=0;
       EMP<=0;
     end
     else if(RReq) 
       Ar<=Ar+1;
   
   
   always@(*) begin
      if(Aw[7:0]==Ar[7:0] && Aw[8]!=Ar[8])
	FULL=1;
      else FULL=0;
      
      if(Aw[7:0]==Ar[7:0] && Aw[8]==Ar[8])
	EMP=1;
      else EMP=0;
      
   end
   

   
   
   
endmodule // FIFO






