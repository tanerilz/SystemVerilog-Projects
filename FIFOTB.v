module FIFO_TestBench();
   reg [7:0] RData;
   reg 		WRreq,RReq,clk,clkr,reset;
   reg [7:0] 	WRData;
   reg [7:0] 	Aw,Ar;
  
   
   
   FIFO fifo (.WRreq(WRreq),.WRData(WRData),.FULL(FULL),.RReq(RReq),.RData(RData),.EMP(EMP),.clk(clk),.clkr(clkr),.reset(reset));
   
   initial
     begin
	reset=1;
	clk=1;
	clkr=1;
	WRreq=1;
	RReq=0;
	#5 reset=0;
	#15 reset=1;
	WRData=2;
     end // initial begin

   always #5 begin
      
      clk=~clk;
      clkr=~clkr;

      
   end

   always #20 begin
      WRData=WRData+2;
   end
 

 initial begin
   
   repeat(15)
   #10  WRreq=~WRreq;

    repeat (15)
      #10 RReq=~RReq;

    repeat (7000)
      #10 WRreq=~WRreq;

    end
   
endmodule // FIFO_TestBench

