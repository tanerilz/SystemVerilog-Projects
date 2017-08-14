class my_transaction extends uvm_sequence_item;
   `uvm_object_utils(my_transaction)
   bit 	       PSEL,PENABLE,PADDR,PWRITE;
   rand bit [7:0]   PWDATA;
   logic [7:0] PRDATA;
   logic       PREADY;
   bit 	       PSLVERR;
   rand bit [1:0]   x;
   constraint c_x{x inside {[0:2]};}
   
   function new(string name = "");
      super.new(name);
   endfunction // new

endclass // my_transaction
