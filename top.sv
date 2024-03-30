module top;

import uvm_pkg::*;
`include "uvm_macros.svh"

import dut_pkg::*;

bfm _if();

apb_ram DUT(.presetn(_if.presetn), .pclk(_if.pclk), .psel(_if.psel), .penable(_if.penable), .pwrite(_if.pwrite), .paddr(_if.paddr), .pwdata(_if.pwdata), .prdata(_if.prdata), .pready(_if.pready), .pslverr(_if.pslverr) );


initial begin
  	uvm_config_db #(virtual bfm)::set(null, "*", "_if", _if);
  	run_test();
end

endmodule : top
