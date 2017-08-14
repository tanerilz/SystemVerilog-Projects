class Scoreboard;
   Transaction trans;
   mailbox #(Transaction) mon2scb;
   logic [7:0] Q[$:255];
   bit 	       full,empty;
   logic [7:0] read_data2;
   int 	       errors;
   
   
   function new(mailbox #(Transaction) mon2scb);
      this.mon2scb=mon2scb;
      trans=new();
   endfunction // new

   task run();
      forever begin
	 mon2scb.get(trans); 
	 Checker();
	 Results();
      end
   endtask // run

   
   task Checker();       
      if(trans.write_req==1)begin
	 Q.push_back(trans.write_data); end     
      if(trans.read_req==1) begin 
	 read_data2=Q.pop_front();
      end     
      if(trans.read_data != read_data2) begin 
	 $error("error");
	 errors++;
      end            
      if(Q.size()==256) begin 
	 full=1;
      end      
      if(full!=trans.FULL) begin 
	 $error("error");
	 errors++;	 
      end      
      else full=0;       
      if(Q.size()==0) begin 
	 empty=1;
      end      
      if(empty!=trans.EMP) begin 
	 $error("error");
	 errors++;	 
      end
      else empty=0;      
   endtask

   task Results(); 
      $display("%t, FULL: %d , EMPTY: %d , errors=%d",$realtime,full,empty,errors);     
   endtask // Results
   
endclass // Scoreboard
