class my_sequence extends uvm_sequence #(my_transaction);
   `uvm_object_utils(my_sequence)
   parameter COUNT=50;
 //  bit [7:0] counter=0;
   
   
   function new(string name = "");
      super.new(name);
   endfunction // new

   task body;
      repeat(COUNT)
	begin
	   my_transaction tx;
	   tx=my_transaction::type_id::create("tx");
	   start_item(tx);
	   tx.randomize();
	/*   if(!counter && tx.x==2)
	     tx.x=0;
	   else if(counter>255 && tx.x==1)
	     tx.x=0;   */
	   case(tx.x)
	     0:
	       begin
		  tx.PREADY=0;
		  tx.PSEL=0;
		  tx.PENABLE=0;
	       	  tx.PREADY=0;
	       end
	     1:
	       begin
		  tx.PSEL=1;
		  tx.PENABLE=1;
		  tx.PADDR=0;
		  tx.PWRITE=1;
		  tx.PREADY=1;
	//	  counter++;
	       end
	     2:
	       begin
		  tx.PSEL=1;
		  tx.PENABLE=1;
		  tx.PADDR=1;
		  tx.PWRITE=0;
		  tx.PREADY=1;
	//	  counter--;
		  end
	   endcase
	   finish_item(tx);
	   get_response(tx);
	  
	end
   endtask // body
   
endclass // my_sequence
