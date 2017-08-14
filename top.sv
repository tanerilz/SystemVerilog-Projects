`include "uvm_macros.svh"
module fsm_light_top;
   import uvm_pkg::*;
   import test_package::*;
   logic clock,reset=0;
   iface ifc(clock,reset);
   virtual iface viface=ifc;

   fsm_light fsm_light_tb(.light(ifc.light),
			  .s1(ifc.s1),
			  .s2(ifc.s2),
			  .clock(ifc.clock),
			  .reset(ifc.reset),
			  .full(ifc.full),
			  .empty(ifc.empty)
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

endmodule // fsm_light_top
