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
	   case(tx.x)
	     0: begin
		@(negedge viface.clock);
		viface.s1=1;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=1;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
	     end
	     1: begin
		@(negedge viface.clock);
		viface.s1=1;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=1;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
	     end
	     2: begin
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=1;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=1;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
	     end
	     3: begin
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=1;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=1;
		viface.s2=0;
		@(negedge viface.clock);
		viface.s1=0;
		viface.s2=0;
	     end
	   endcase // case (tx.x)
	   tx.full=viface.full;
	   tx.empty=viface.empty;
	   seq_item_port.item_done(tx);
	end // forever begin
   endtask // run_phase
endclass // my_driver
