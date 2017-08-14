class Agent;
   Generator gen;
   Driver drv;
   Monitor mon;
   mailbox #(Transaction) gen2driv;
   mailbox #(Transaction) mon2scb;
   virtual iface viface;
   
   
   function new(virtual iface viface,   mailbox #(Transaction) mon2scb);
      this.viface=viface;
      this.mon2scb=mon2scb;     
   endfunction // new

   task build();
      gen2driv=new();
    
      gen=new(gen2driv,viface);
      drv=new(gen2driv,viface);
      mon=new(mon2scb,viface);
   endtask // build

   task run();       	
      fork
	 gen.run();
	 wait(drv.transactions==gen.COUNT)  $finish;
	 drv.run();
	 mon.run();
      join_none
   endtask // run
   
endclass // Agent
