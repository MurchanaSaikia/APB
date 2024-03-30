class scoreboard extends uvm_subscriber #(sequence_item);

`uvm_component_utils(scoreboard);

function new (string name, uvm_component parent);
	super.new(name, parent);
endfunction : new

uvm_tlm_analysis_fifo #(sequence_item) cmd_f;

function void build_phase(uvm_phase phase);
	cmd_f = new("cmd_f", this);
endfunction : build_phase

  bit [31:0] arr[32] = '{default:0};
  bit [31:0] addr    = 0;
  bit [31:0] data_rd = 0;


virtual function void write(sequence_item t);

	sequence_item t1;

	if (!cmd_f.try_get(t1))
	`uvm_fatal("SCO","failed to get cmd_mtr obj");


	if ( t1.sequence_no == 1 || t1.sequence_no == 5 ) begin
		if (t.pslverr == 1) begin
		`uvm_error("SCO", "error due to slverr"); end
		else
		begin
			arr[t1.paddr] = t1.pwdata;
			$display("t1.pwdata = %0d at time %0t", arr[t1.paddr], $time);
		end
	end

	if ( t1.sequence_no == 2 || t1.sequence_no == 6 ) begin
		if (t.pslverr == 1) begin
		`uvm_error("SCO", "error due to slverr"); end
		else
		begin
		data_rd = arr[t1.paddr];
		$display("data_rd %0d and address = %0d and t.prdata = %0d at time %0t",data_rd, t1.paddr, t.prdata, $time );
		if (t.prdata == data_rd) begin 
		`uvm_info("SCO", "PASSED ", UVM_MEDIUM); end
		else begin 
		`uvm_error("SCO", "read write mismatch"); end

		end
	end


	if ( t1.sequence_no == 3 || t1.sequence_no == 4 ) begin
		if (t.pslverr == 1) begin
		`uvm_error("SCO", "error due to slverr"); end
		else
		begin
		arr[t1.paddr] = t1.pwdata;
			$display("t1.pwdata = %0d at time %0t", arr[t1.paddr], $time);

		data_rd = arr[t1.paddr];
		$display("data_rd %0d and address = %0d and t.prdata = %0d at time %0t",data_rd, t1.paddr, t.prdata, $time );

		if (t.prdata == data_rd) begin 
		`uvm_info("SCO", "PASSED ", UVM_MEDIUM); end
		else begin 
		`uvm_error("SCO", "read write mismatch"); end

		end
	end




endfunction : write

endclass : scoreboard
