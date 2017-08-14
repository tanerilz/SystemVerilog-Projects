module DualportRam(A1,A2,WD1,WD2,WE1,WE2,DOUT1,DOUT2,clk1,clk2);
   input WE1,WE2;
   input clk1,clk2;
   input [7:0] A1,A2,WD1,WD2;
   output [7:0] DOUT1,DOUT2;
   reg [7:0] 	WD1,WD2,DOUT1,DOUT2;
   reg [7:0] 	memory[256];
   reg [7:0] 	A1reg,A2reg,WD1reg,WD2reg;
   reg 		WE1,WE2,WE1reg,WE2reg;


   always@(posedge clk1 )begin
      
      WE1reg<=WE1;
      WD1reg<=WD1;
      A1reg<=A1;
      
   end
   always@(posedge clk2)begin
      WE2reg<=WE2;
   //   WD2reg<=WD2;
      A2reg<=A2;
   end
   
   always@(*) begin
      if(WE1reg)
        memory[A1reg]=WD1reg;
  
   end

 /*  always@(*) begin
      if(WE2reg)
	memory[A2reg]=WD2reg;
   end
*/
      
   assign DOUT1=memory[A1reg];
   assign DOUT2=memory[A2reg];
   
   
endmodule // DualportRam
/*

  module DualRam_TestBench(A1,A2,WD1,WD2,WE1,WE2,DOUT1,DOUT2,clk1,clk2);
   output WE1,WE2;
   output [7:0] A1,A2,WD1,WD2;
   output 	clk1,clk2;

   input [7:0] 	DOUT1,DOUT2;
   reg [7:0] 	A1,A2,WD1,WD2;
   reg 		clk1,clk2,WE1,WE2;
   DualportRam TestBench(A1,A2,WD1,WD2,WE1,WE2,DOUT1,DOUT2,clk1,clk2);
   
   always #5 begin
      clk1=~clk1;
      clk2=~clk2;
   end
   
   
   
   initial begin:Port1
      clk1=1;     
      WE1=1; 
      A1=8'b00000000;   
      WD1=8'b00000001;
     
      
   end

   initial begin:Port2
      clk2=1;    
      WE2=1;
      A2=8'b00000001;  

      WD2=8'
   end


endmodule
*/