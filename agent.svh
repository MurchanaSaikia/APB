class agent extends uvm_agent;

`uvm_component_utils(agent);

function new(string name = "agent", uvm_component parent);
	super.new(name, parent);
endfunction : new

driver driver_h;
command_monitor cmd_mtr_h;
result_monitor rslt_mtr_h;
uvm_sequencer #(sequence_item) sequencer_h;

virtual function void build_phase(uvm_phase phase);

	super.build_phase( phase);
	driver_h    = driver::type_id::create("driver_h" , this);
	cmd_mtr_h   = command_monitor::type_id::create("cmd_mtr_h" , this);
	rslt_mtr_h  = result_monitor::type_id::create("rslt_mtr_h" , this);
	sequencer_h = uvm_sequencer #(sequence_item)::type_id::create("sequencer_h", this);


endfunction : build_phase


virtual function void connect_phase(uvm_phase phase);

	super.connect_phase(phase);
	driver_h.seq_item_port.connect(sequencer_h.seq_item_export);

endfunction : connect_phase

endclass : agent
