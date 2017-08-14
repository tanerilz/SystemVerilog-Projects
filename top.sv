module TestTop();
   import Environment_package::*;
   
   logic reset,clk;
   iface ifc(clk,reset);
   virtual iface viface = ifc;


   initial begin
      Environment env;
      env=new(viface);
      clk=0;
      reset=1; #1
	reset=0; #1
	  reset=1; #1
	    reset=0; #1
	      
	      #5 reset=1;
      
      
      env.run();
      $display("TOP initial end");
      
      #1000 $finish;
   end
   
   
   
   always
     #5 clk=~clk;

   
   
   FIFO fifo_dut(.write_req(ifc.write_req),
		 .write_data(ifc.write_data),
		 .FULL(ifc.FULL),
		 .read_req(ifc.read_req),
		 .read_data(ifc.read_data),
		 .EMP(ifc.EMP),
		 .clk(ifc.clk),
		 .clkr(),
		 .reset(ifc.reset)
		 );

   
endmodule // TestTop