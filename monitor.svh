class Monitor;
   Transaction trans;
   virtual iface viface;
   mailbox #(Transaction) mon2scb;
   

   function new(mailbox #(Transaction) mon2scb, virtual iface viface);
      this.mon2scb=mon2scb;
      this.viface=viface;
   endfunction // new

   task run();
      
      forever   
	begin
	   trans=new();	
	   @(posedge viface.clk);
	   trans.write_data=viface.write_data; 
	   trans.write_req=viface.write_req;
	   trans.read_req=viface.read_req; 
	   trans.read_data=viface.read_data; 
	   mon2scb.put(trans);
	end
   endtask // run
   
endclass // Monitor

