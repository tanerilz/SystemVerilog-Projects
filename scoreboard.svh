class my_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(my_scoreboard)
   uvm_tlm_analysis_fifo #(my_transaction) ap_fifo;
   logic [7:0] qry[$:255];
   logic [7:0] write_data;
   logic       full,empty;
   int 	       errors,t;
   my_transaction tx;
   
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ap_fifo=new("ap_fifo",this);
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      
      forever begin
	 ap_fifo.get(tx);
	 /*	 a();
	  readcheck();
	  fullcheck();
	  emptycheck();
	  */
	 
	 t++;

	 	 if(tx.read_data != write_data)
	   begin
	      `uvm_error("scb",$sformatf("read_data %h mismatches written data %h",tx.read_data,write_data));
	      
	      errors++;
	   end          

	 
	 if(tx.write_req && !full)begin
	    $display("pushback");
	    $display("pre,querry size: %d",qry.size());
	    qry.push_back(tx.write_data);
	    $display("post,querry size: %d",qry.size());
	    
	 end      
	 if(tx.read_req && !empty)begin
	    $display("popfront      %p",write_data);
	    $display("pre,querry size: %d",qry.size());
	    $display("write_data: %d",write_data);
	    write_data=qry.pop_front();
	    $display("write_data: %d",write_data);
	    $display("post,querry size: %d",qry.size());
	    
	 end
	 

	 //	 $display("%t, read_data=%d,write_data=%d",$realtime,tx.read_data,write_data);


	 if(qry.size()==256)
	   full=1;
	 else
	   full=0;
	 if(full!=tx.full)
	   begin
	      `uvm_error("scb","full missmatch");
	      errors++;
	   end
	 if(qry.size==0)
	   empty=1;
	 else
	   empty=0;
	 if(empty!=tx.emp)
	   begin
	      `uvm_error("scb","empty missmatch");
	      errors++;
	   end
	 
	 Results();
      end
      
   endtask // run_phase
   
   function void readcheck();
      
      $display("%t, read_data=%d,write_data=%d",$realtime,tx.read_data,write_data);
      if(tx.read_data != write_data)
	begin
	   `uvm_error("scb","read_data missmatch");
	   errors++;
	end            
   endfunction // a
   
   function void a();
      t++;
      if(tx.write_req && !full)
	qry.push_back(tx.write_data);      
      if(tx.read_req && !empty) 
	write_data=qry.pop_front();  
      
   endfunction // Checker
   
   function void fullcheck();
      if(qry.size()==256)
	full=1;
      else
	full=0;
      if(full!=tx.full)
	begin
	   `uvm_error("scb","full missmatch");
	   errors++;
	end
   endfunction // fullcheck

   function void emptycheck();
      if(qry.size==0)
	empty=1;
      else
	empty=0;
      if(empty!=tx.emp)
	begin
	   `uvm_error("scb","empty missmatch");
	   errors++;
	end
   endfunction // emptycheck
   
   function void Results();
      $display("number of errors: %d, number of transactions",errors,t);
   endfunction // Results
   
endclass // my_scoreboard
