interface iface(input logic PCLK,input logic PRESETn);
   bit 	       PSEL,PENABLE,PADDR,PWRITE;
   bit [7:0]   PWDATA;
   logic [7:0] PRDATA;
   logic       PREADY;
   bit 	       PSLVERR;    

endinterface // iface

