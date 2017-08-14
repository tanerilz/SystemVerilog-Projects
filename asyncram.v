module Asyncram(adress,WD,WE,Q);
   input WE;
   input [7:0] adress,WD;
   output   [7:0]   Q;
   reg [7:0]   Q;
   reg [7:0]   memory[256];

   always@(WE)begin
      memory[adress]=WD;
      assign Q=memory[adress];
      
   end
endmodule // Asyncram

module Asyncram_Test(adress,WD,WE,Q);
   output WE;
   output [7:0] adress,WD;
   input    [7:0]  Q;
   reg [7:0] adress,WD;
   reg WE;
   Asyncram TestBench(adress,WD,WE,Q);
   

   initial begin:bench
      adress=8'b00000001;
      WD=8'b00000010;
      #5 WE=1;
      #10 WE=~WE;
      #18 WD=8'b00001000;
      #15 WE=~WE;
      #25 WE=~WE;
      #30 disable bench;

   end
   endmodule
     
      
   
   
   
