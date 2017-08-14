interface iface(input logic clock,input logic reset);
   bit write_req,read_req;
   bit [7:0] write_data;
   logic [7:0] read_data;
   logic       full,emp;
endinterface // iface

