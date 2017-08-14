class Environment;
   Agent agnt;
   Scoreboard scbd;
   mailbox #(Transaction) mon2scb;
   virtual iface viface;

   function  new(virtual iface viface);
      mon2scb=new(); 
      agnt=new(viface,mon2scb);
      scbd=new(mon2scb);    
   endfunction // new
   
   task run();     
      agnt.build();     
      fork
	 agnt.run();
	 scbd.run();
      join                  
   endtask // run
endclass // Environment
