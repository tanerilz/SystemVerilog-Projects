class my_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(my_scoreboard)
   uvm_tlm_analysis_fifo #(my_transaction) ap_fifo;
   logic [7:0] qry[$:255];
   logic [7:0] write_data;
   logic       full,empty;
   int 	       errors=0,t=0,f=0,e=1;
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
	 t++;
	 $display("PSLVERR: %d,%b",tx.PSLVERR,tx.PSLVERR);




	 
	 if(tx.PRDATA != write_data)
	   begin
	      $display("%t,rdata!=wdata",$realtime);
	      errors++;
	   end          

	 if(tx.PSEL && tx.PENABLE)
	   begin
	      if(tx.PWRITE && !tx.PADDR && !full)begin
		 qry.push_back(tx.PWDATA);
	      end      
	      else if(!tx.PWRITE && tx.PADDR && !empty)begin
		 write_data=qry.pop_front();
	      end
	   end


	 if(tx.PWRITE && !tx.PADDR && tx.PSEL && tx.PENABLE)
	   begin
	      if(tx.PSLVERR)
		f=1;
	      else if(tx.PREADY)
		f=0;
	   end
	 
	 if(!tx.PWRITE && tx.PADDR && tx.PSEL && tx.PENABLE)
	   begin
	      if(tx.PSLVERR)
		e=1;
	   end

	 if(!tx.PWRITE && tx.PADDR && tx.PSEL && tx.PENABLE)
	   if(tx.PREADY)
	     e=0;

	 
	 if(qry.size()==256)
	   full=1;
	 else
	   full=0;
	 if(qry.size==0)
	   empty=1;
	 else
	   empty=0;

	 
	 $display("empty:%d, e:%d",empty,e);
	 if(full!=f)
	   begin
	      `uvm_error("scb","full missmatch");
	      errors++;
	   end
	 
	 if(empty!=e)
	   begin
	      `uvm_error("scb","empty missmatch");
	      errors++;
	   end
//	 $display("scb_empty;%d, pslverr:%d",empty,tx.PSLVERR);
	 Results();
      end

      
   endtask // run_phase
   
   function void Results();
      $display("number of errors: %d, number of transactions",errors,t);
   endfunction // Results
   
endclass // my_scoreboard
