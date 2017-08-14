interface iface(input logic clk,input logic reset);
   logic write_req,read_req;
   logic [7:0] write_data;
   logic [7:0] read_data;
   logic       FULL,EMP;
endinterface // iface


   