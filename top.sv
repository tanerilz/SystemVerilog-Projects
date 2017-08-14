`include "uvm_macros.svh"
module top;
   import uvm_pkg::*;
   import test_package::*;
   logic clock,reset=0;
   iface ifc(clock,reset);
   virtual iface viface=ifc;
  

   apb apb_dut(
	       .PRDATA(ifc.PRDATA),
	       .PRESETn(ifc.PRESETn),
	       .PCLK(ifc.PCLK),
	       .PSEL(ifc.PSEL),
	       .PENABLE(ifc.PENABLE),
	       .PADDR(ifc.PADDR),
	       .PWRITE(ifc.PWRITE),
	       .PWDATA(ifc.PWDATA),
	       .PREADY(ifc.PREADY),
	       .PSLVERR(ifc.PSLVERR)
	       );
   
   initial
     begin
        uvm_config_db #(virtual iface)::set(null,"*","viface",viface);
	clock=0;
        reset=0;
	run_test("my_test");	
     end

   initial #1 reset=1;
   
   always #10 clock=~clock;
   
endmodule