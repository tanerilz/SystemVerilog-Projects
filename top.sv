`include "uvm_macros.svh"
module top;
   import uvm_pkg::*;
   import test_package::*;
   logic clock,reset=0;
   iface ifc(clock,reset);
   virtual iface viface=ifc;
  

   fifo_dut fifo_dut_t(.write_req(ifc.write_req),
	    .read_req(ifc.read_req),
	    .write_data(ifc.write_data),
	    .read_data(ifc.read_data),
	    .full(ifc.full),
	    .empty(ifc.emp),
	    .clk(ifc.clock),
	    .reset(ifc.reset)
	    );
   
   initial
     begin
        uvm_config_db #(virtual iface)::set(null,"*","ifc",viface);
	clock=0;
        reset=0;
	run_test("my_test");	
     end

   initial #1 reset=1;
   
   always #10 clock=~clock;
   
endmodule