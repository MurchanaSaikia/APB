class command_monitor extends uvm_component;

`uvm_component_utils(command_monitor);



uvm_analysis_port #(sequence_item) ap;
virtual bfm _if;
sequence_item sequence_item_h;


function new(string name = "command_monitor", uvm_component parent);
	super.new(name , parent);
	ap = new("ap",this);
endfunction : new


function void build_phase(uvm_phase phase);

	if (!uvm_config_db #(virtual bfm)::get(null, "*", "_if", _if))
	`uvm_error("CMD_MTR", "failed to get interface");

	sequence_item_h = sequence_item::type_id::create("sequence_item_h", this);

endfunction : build_phase

function void connect_phase(uvm_phase phase);
	_if.cmd_mtr_h = this;
endfunction : connect_phase


task int_to_cmd_mtr(input logic [31:0] paddr_cmd,
		input	logic [31:0] pwdata_cmd,
		input	logic pwrite_cmd,
		input	int sequence_no_cmd
				   );

 	sequence_item_h.paddr  = paddr_cmd;
	sequence_item_h.pwdata = pwdata_cmd;
	sequence_item_h.pwrite = pwrite_cmd;
	sequence_item_h.sequence_no = sequence_no_cmd;
$display("rcvd from int in cmd mtr addr = %0d, data = %od, sequence_no = %0d",sequence_item_h.paddr, sequence_item_h.pwdata , sequence_item_h.sequence_no);
	ap.write(sequence_item_h);

endtask : int_to_cmd_mtr


endclass : command_monitor
