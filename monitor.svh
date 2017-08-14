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
	   @(posedge viface.PCLK);
	   $display("%t,INTERFACE:%p",$realtime,viface);
	  // #1;
	   tx.PWDATA=viface.PWDATA;
    	   tx.PENABLE=viface.PENABLE;
	   tx.PADDR=viface.PADDR;
	   tx.PWRITE=viface.PWRITE;
	   tx.PSEL=viface.PSEL;
	   tx.PRDATA=viface.PRDATA;
	   tx.PSLVERR=viface.PSLVERR;
	   tx.PREADY=viface.PREADY;
	   $display("%t,TRANSACTION:%p",$realtime,tx);
	   aport.write(tx);
	end
      
   endtask // run_phase
endclass // my_monitor

