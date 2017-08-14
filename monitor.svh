class my_monitor extends uvm_monitor;
   `uvm_component_utils(my_monitor);
   uvm_analysis_port #(my_transaction) aport;
   virtual iface viface;
   
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      aport=new("aport",this);
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      forever
	begin
	   my_transaction tx;
	   tx=my_transaction::type_id::create("tx");
	   @(posedge viface.clock);
    	   tx.read_req=viface.read_req;
	   tx.write_req=viface.write_req;
	   tx.write_data=viface.write_data;
	   tx.read_data=viface.read_data;
	   aport.write(tx);
	end
      
   endtask // run_phase
endclass // my_monitor

