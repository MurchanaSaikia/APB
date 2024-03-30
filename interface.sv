interface bfm;

import dut_pkg::*;

  logic              pclk;
  logic              presetn;
  logic       [31:0] paddr;
  logic              pwrite;
  logic       [31:0] pwdata;
  logic              penable;
  logic              psel;
  logic       [31:0] prdata;
  logic              pslverr;
  logic              pready;
  int		     sequence_no;




initial begin //clk_generation

pclk = 1'b0;
forever begin
#100;
pclk = ~pclk;

end
end



task reset();   //reset dut

	presetn = 1'b1;
	@(posedge pclk);
	@(posedge pclk);
	presetn= 1'b0;
 /*	paddr     <= 'h0;
        pwdata    <= 'h0;
        pwrite    <= 'b0;
        psel      <= 'b0;
        penable   <= 'b0; */
   //  `uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
   //  @(posedge pclk);

endtask : reset



task drv_to_int(input logic presetn_drv,
			input logic [31:0] paddr_drv,
			input logic [31:0] pwdata_drv,
			input  logic pwrite_drv,
			input  logic psel_drv,
			input logic  penable_drv,
			output logic [31:0] prdata,
			output logic pslverr,
			input int sequence_no_drv);

		presetn = presetn_drv;
		paddr 	= paddr_drv;
		pwdata  = pwdata_drv;
		pwrite	= pwrite_drv;
		psel	= psel_drv;
		sequence_no = sequence_no_drv;
		@(posedge pclk);
		penable = penable_drv;
                            @(negedge pready);
                            penable <= 1'b0;
			    prdata   = prdata;
                            pslverr  = pslverr;		
$display("driver to interface seq_no = %0d at time %0t ",  sequence_no, $time);
endtask : drv_to_int

command_monitor cmd_mtr_h;
result_monitor rslt_mtr_h;


//command_monitor

always @(posedge pclk) begin

	@(posedge pclk);
	@(posedge pclk);
//	@(posedge pclk);	
//	@(posedge pclk);

		cmd_mtr_h.int_to_cmd_mtr(paddr, pwdata,pwrite, sequence_no );


end


//result_monitor

always @(posedge pclk) begin


	@(negedge pclk);
	@(negedge pclk);
	@(negedge pclk);

		rslt_mtr_h.int_to_rslt_mtr(prdata, pslverr, sequence_no );


end

endinterface : bfm
