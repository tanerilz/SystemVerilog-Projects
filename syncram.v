module syncram(adress,WD,WE,Q,clk);
   input WE;
   input clk;
   input [7:0] adress,WD;
   output   [7:0]   Q;
   reg [7:0]   WD,Q;
   reg [7:0]   memory[256];
   reg [7:0]   adressreg,WEreg,WDreg;
   reg 	       WE;


   always@(posedge clk )begin
      
	 WEreg<=WE;
	 WDreg<=WD;
	 adressreg<=adress;
	
      end 
     always@(*) begin
	if(WEreg)
         memory[adressreg]=WDreg;
   end
   assign Q=memory[adressreg];
   
  endmodule // syncram

module syncram_Test(adress,WD,WE,Q,clk);
   output WE;
   output [7:0] adress,WD;
   output 	clk;
   input [7:0] 	Q;
   reg [7:0] adress,WD;
   reg clk,WE;
   syncram Test(adress,WD,WE,Q,clk);
   
   always #5 clk=~clk;
   
	
   initial begin
      clk=1;
      WE=1;
      adress=8'b00000000;
      WD=8'b00000000;
      
   end

   always@(posedge clk) begin
     #1 adress<=adress+2'b01;
     #2 WD<=WD+2'b01;
     #15 WE<=~WE;
      
   end
   
   endmodule
     
      
   
   
   
