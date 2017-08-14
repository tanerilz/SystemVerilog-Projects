module fifo_dut(write_req,read_req,write_data,read_data,full,empty,clk,reset);
   input write_req,read_req,clk,reset;
   input [7:0] write_data;
   output      full,empty;
   output [7:0] read_data;
   reg 		write_req,read_req,clk,reset;
   reg [7:0] 	write_data,read_data;
   reg [8:0] 	write_pointer,read_pointer;
   reg [7:0] 	memory[256];

   always@(posedge clk or negedge reset)
     begin
	if(~reset)
	  write_pointer<=0;
	if(write_req)
	  write_pointer<=write_pointer+1;
     end

   always@(posedge clk or negedge reset)
     begin
	if(~reset)
	  read_pointer<=0;
	if(read_req)
	  read_pointer<=read_pointer+1;
     end

   always@(posedge clk)
     begin
	if(write_req)
	  memory[write_pointer[7:0]]<=write_data;
     end

   always@(posedge clk)
     begin
     if(read_req)
       read_data<=memory[read_pointer[7:0]];
     end
   
 //  assign read_data=memory[read_pointer[7:0]];

   assign full=((write_pointer[7:0]==read_pointer[7:0]) && (write_pointer[8]!=read_pointer[8]));

   assign empty=((write_pointer[7:0]==read_pointer[7:0]) && (write_pointer [8]==read_pointer[8]));


endmodule