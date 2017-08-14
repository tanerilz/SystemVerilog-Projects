class Generator;
   Transaction trans;
   mailbox #(Transaction) gen2driv;
   virtual iface viface;
   parameter COUNT=100;
   
   constraint req_dist {
      trans.write_req dist	{0:=30, 1:=70};
      // trans.write_req=0, weight 30/100
      // trans.write_req=1, weight 70/100

      trans.read_req dist {0:=80, 1:=20};
      // trans.read_req=0, weight 80/100
      // trans.read_req=1, weight 20/100
   }

   function new(mailbox #(Transaction) gen2driv,virtual iface viface);
      this.gen2driv=gen2driv;
      this.viface=viface;
   endfunction // new
   
   task run();      
      repeat(COUNT) begin	 
	 trans=new();
	 if(viface.FULL!=1) begin
	 trans.write_req=$urandom_range(1);
	 trans.write_data=$urandom();
	 end
	 if(viface.EMP!=1)
	 trans.read_req=$urandom_range(1);		 
	 gen2driv.put(trans);  
      end // repeat (30)
   endtask // run
endclass; // Generator
