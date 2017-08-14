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
	   wait(viface.reset);
	   @(posedge viface.clock);
	   viface.read_req=tx.read_req;
	   viface.write_req=tx.write_req;
	   viface.write_data=tx.write_data;
	   tx.full=viface.full;
	   tx.emp=viface.emp;
	   seq_item_port.item_done(tx);
	end
   endtask // run_phase

endclass

