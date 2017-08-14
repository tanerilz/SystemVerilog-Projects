class my_sequence extends uvm_sequence #(my_transaction);
   `uvm_object_utils(my_sequence)
   bit f,e,y=1;
   function new(string name="");
      super.new(name);
   endfunction // new

   
   task body;
      repeat(400)
	begin
	   my_transaction tx;
	   tx=my_transaction::type_id::create("tx");
	   start_item(tx);	   
	   if(e) begin
	      y=1;
	      assert(tx.randomize() with {tx.x!=3;
		 tx.x dist {
			    0:=6,
			    1:=2,
			    2:=2,
			    3:=0};}); 
	   end
	   else if(f) begin
	      y=0;
	      assert(tx.randomize() with {tx.x!=0;
		 tx.x dist {
			    0:=0,
			    1:=2,
			    2:=2,
			    3:=6};});
	   end
	   else if(y)
	     assert(tx.randomize() with {
		tx.x dist {
			   0:=6,
			   1:=1,
			   2:=1,
			   3:=2};});
	     else
	       assert(tx.randomize() with {
		  tx.x dist {
			     0:=2,
			     1:=1,
			     2:=1,
			     3:=6};});
	   
	   finish_item(tx);
	   get_response(tx);
	   f=tx.full;
	   e=tx.empty;
	end
   endtask
endclass // my_sequence
