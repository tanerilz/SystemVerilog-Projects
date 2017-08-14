class my_transaction extends uvm_sequence_item;
   `uvm_object_utils(my_transaction)
   rand bit write_req,read_req;
   rand bit [7:0] write_data;
   logic [7:0] read_data;
   logic       full,emp;
   
   constraint req_c { 
      write_req dist {1:=60, 0:=40};
   }
 
   function new(string name = "");
      super.new(name);
   endfunction // new

endclass // my_transaction
