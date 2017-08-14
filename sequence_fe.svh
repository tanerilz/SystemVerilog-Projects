class my_sequence2 extends uvm_sequence #(my_transaction);
   `uvm_object_utils(my_sequence2)
   parameter COUNT=600;
   logic f,e;
   logic c=0;
   
   function new(string name = "");
      super.new(name);
   endfunction // new

   task body;
      repeat(COUNT)
	begin
	   my_transaction tx;
	   tx=my_transaction::type_id::create("tx");
	   start_item(tx);
	   if(c==0) 
	      if(!f) begin
	   tx.write_req=1;
	   tx.read_req=0;
	   tx.write_data=$random;
	 end
	 if(c)
	    if(!e) begin
	    tx.write_req=0;
	    tx.read_req=1;
	    tx.write_data=$random;
	 end
	   
	   if(tx.full==1 || f==1)
	     c=1;
	   if(tx.emp==1 || e==1)
	     c=0;
	   finish_item(tx);
	   get_response(tx);
	   f=tx.full;
	   e=tx.emp;
	end
   endtask // body
   
endclass // my_sequence
