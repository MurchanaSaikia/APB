class result_monitor extends uvm_component;

`uvm_component_utils(result_monitor);


uvm_analysis_port #(sequence_item) ap;
virtual bfm _if;
sequence_item sequence_item_h;


function new(string name = "result_monitor", uvm_component parent);
	super.new(name , parent);
	ap = new("ap",this);
endfunction : new


function void build_phase(uvm_phase phase);

	if(!uvm_config_db #(virtual bfm)::get(null, "*", "_if", _if))
	`uvm_error("RSLT_MTR","failed to get interface object");

	sequence_item_h = sequence_item::type_id::create("sequence_item_h", this);

endfunction : build_phase

function void connect_phase(uvm_phase phase);
	_if.rslt_mtr_h =  this;
endfunction : connect_phase


task  int_to_rslt_mtr(input logic [31:0] prdata_rslt,
			input	logic pslverr_rslt,
			input	int sequence_no_rslt);

		sequence_item_h.prdata  = prdata_rslt;
		sequence_item_h.pslverr = pslverr_rslt;
		sequence_item_h.sequence_no = sequence_no_rslt;


		ap.write(sequence_item_h);

endtask : int_to_rslt_mtr


endclass : result_monitor
