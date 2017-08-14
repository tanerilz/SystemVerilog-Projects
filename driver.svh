class my_driver extends uvm_driver #(my_transaction);
   `uvm_component_utils(my_driver)
   virtual iface viface;
   
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      forever
	begin
	   
	   my_transaction tx;
	   tx=my_transaction::type_id::create("tx");
	   seq_item_port.get_next_item(tx);
	   wait(viface.PRESETn);
	   @(posedge viface.PCLK);
	   viface.PWDATA=tx.PWDATA;
	   viface.PSEL=tx.PSEL;
	   viface.PWRITE=tx.PWRITE;
	   viface.PADDR=tx.PADDR;
	   viface.PRDATA=tx.PRDATA;
	   @(posedge viface.PCLK);
	   viface.PENABLE=tx.PENABLE;
	   @(posedge viface.PCLK);
	   viface.PENABLE=0;
	   viface.PREADY=0;
	   viface.PSEL=0;
	   
	   
	   seq_item_port.item_done(tx);
	end
   endtask // run_phase

endclass

