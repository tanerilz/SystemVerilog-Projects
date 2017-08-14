class my_transaction extends uvm_sequence_item;
   `uvm_object_utils(my_transaction)
   rand bit s1,s2;
   bit light;
   bit full,empty;
   rand bit [1:0] x;

 /*  constraint in {
      x dist {
	      0:=1,
	      1:=0,
	      2:=0,
	      3:=0
	      };}
   constraint out {
      x dist {
	      0:=0,
	      1:=0,
	      2:=0,
	      3:=1
	      };}
*/ 
  
   function new(string name="");
      super.new(name);
   endfunction // new
   
endclass
