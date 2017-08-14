class my_sequence extends uvm_sequence #(my_transaction);
   `uvm_object_utils(my_sequence)
   parameter COUNT=200;
   logic f,e;
   
   function new(string name = "");
      super.new(name);
   endfunction // new

   task body;
      repeat(COUNT)
	begin
	   my_transaction tx;
	   tx=my_transaction::type_id::create("tx");
	   start_item(tx);
	   if(f)begin
	      tx.write_data.rand_mode(0);
	      assert(tx.randomize() with {tx.write_req==0;});
	   end
	   else if(e)
	     assert(tx.randomize() with {tx.read_req==0;});
	     else
	       assert(tx.randomize());
	   finish_item(tx);
	   get_response(tx);
	   f=tx.full;
	   e=tx.emp;
	end
   endtask // body
   
endclass // my_sequence
