class Driver;
   Transaction trans;
   mailbox #(Transaction) gen2driv;
   virtual iface viface;
   int 	   transactions=0;
   
   function new(mailbox #(Transaction) gen2driv, virtual iface viface);      
      this.gen2driv=gen2driv;
      this.viface=viface;
   endfunction // new

   
   task run(); 	
      forever begin
	 gen2driv.get(trans);  
	 @(posedge viface.clk); 
	 viface.write_data<=trans.write_data;  
	 viface.write_req<=trans.write_req;
         viface.read_req<=trans.read_req;
	 transactions++;	 
      end // forever begin

   endtask // run
endclass // Driver

