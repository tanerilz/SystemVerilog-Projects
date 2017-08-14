`include "fifo.v"
module apb(PRDATA,PRESETn,PCLK,PSEL,PENABLE,PADDR,PWRITE,PWDATA,PREADY,PSLVERR);
   input [7:0] PWDATA;
   input       PCLK,PRESETn;
   input       PSEL,PENABLE,PADDR,PWRITE;
   output [7:0] PRDATA;
   output 	PREADY;
   output 	PSLVERR;
   reg [7:0] 	PRDATA;
 //  reg [7:0] 	rdata;	
   reg  	sel,enable,addr,write;
   reg [7:0] 	wdata;
   reg  	PSLVERR;	
   reg 		write_r,read_r; 
   reg 		PREADY;
   reg 		full,empty;		
   
   fifo_dut fifo(
		 .read_data(PRDATA),
		 .reset(PRESETn),
		 .clk(PCLK),
		 .read_req(read_r),
		 .write_req(write_r),
		 .write_data(wdata),
		 .full(full),
		 .empty(empty)
		 );

   
   always@(posedge PCLK or negedge PRESETn)
     begin
	if(~PRESETn) 
	  begin
	     sel<=0;
	     enable<=0;
	     addr<=0;
	     write<=0;
	     wdata<=0;
	  //   rdata<=0;
	  end
	else
	  begin
	     sel<=PSEL;
	     enable<=PENABLE;
	     addr<=PADDR;
	     write<=PWRITE;
	     wdata<=PWDATA;
	   //  rdata<=PRDATA;
	  end
     end

   always@(*)
     begin
	if(sel && enable )
	  begin
	     if(write && !addr && !full)
	       begin
		  write_r=1;
		  read_r=0;
	       end
	     else if(!write && addr && !empty)
	       begin
		  read_r=1;
		  write_r=0;
	       end
	  end
	else
	  begin
	     write_r=0;
	     read_r=0;
	  end 	
     end // always@ (*)

   always@(*)
     begin
	if(PSEL && PENABLE)
	  begin
	     if(PWRITE && !PADDR)
	       begin
		  if(full)
		    PSLVERR=1;
		  PREADY=1;
	       end
	     else if(!PWRITE && PADDR)
	       begin
		  if(empty)
		    PSLVERR=1;
		  PREADY=1;
	       end
	     
	  end
	@(posedge PCLK);
	PREADY=0;
	PSLVERR=0;
     end // always@ (*)

   
endmodule