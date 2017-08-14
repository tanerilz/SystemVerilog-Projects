class my_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(my_scoreboard)
   uvm_tlm_analysis_fifo #(my_transaction) ap_fifo;
   my_transaction tx;
   typedef enum logic [1:0] {IDLE,A,B} State;
   State cState=IDLE,nState=IDLE;
   logic 	light=0;
   logic [3:0] 	count=0;
   logic 	full,empty;
   
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
	 //--------CHECHKER START-----------\\
	 cState=nState;

	 $display("scb_light=%d,tx_light=%d",light,tx.light);
	 if(light!=tx.light)
	   `uvm_error("scb","light missmatch");

	 $display("scb full=%d,tx.full=%d",full,tx.full);
	 if(full!=tx.full)
	   `uvm_error("scb","full missmatch");

	 $display("scb empty=%d,tx empty=%d",empty,tx.empty);
	 if(empty!=tx.empty)
	   `uvm_error("scb","empty missmatch"); 
	 
	 case(cState)
	   IDLE:if(tx.s1) begin
	      nState=A;
	      $display("IDLE:(tx.s1)->A");
	   end
	   
	   else if(tx.s2)begin
	      $display("IDLE:(tx.s2)->B");
	      nState=B;
	   end
	   else begin
	      $display("IDLE:(else)->IDLE");
	      nState=IDLE;
	   end
	   A:if(tx.s1) begin
	      nState=IDLE;
	      $display("A:(tx.s1)->IDLE");
	   end
	   else if(tx.s2) 
	     begin
		$display("A:(tx.s2)->IDLE");
		$display("Increment count=%d",count);
		nState=IDLE;
		count++;
	     end
	   else begin
	      $display("A:(else)->A");
	      nState=A;
	   end
	   B:if(tx.s1)
	     begin
		$display("B:(tx.s1)->IDLE");
		$display("Decrement count=%d",count);
		nState=IDLE;
		count--;
	     end
	   else if(tx.s2) begin
	      nState=IDLE;
	      $display("B:(tx.s2)->IDLE");
	   end
	   else begin
	      nState=B;
	      $display("B:(else)->B");
	   end
	 endcase

	 if(count)
	   light=1;
	 else
	   light=0;

	 if(count>14)
	   full=1;
	 else
	   full=0;
	 if(count==0)
	   empty=1;
	 else
	   empty=0;
	 
	 $display("count=%d",count);
      end // forever begin
      
   endtask // run_phase
   
endclass // my_scoreboard

