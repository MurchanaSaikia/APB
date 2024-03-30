class env extends uvm_env;

`uvm_component_utils(env);

function new(string name = "env", uvm_component parent);
	super.new(name, parent);
endfunction : new

coverage coverage_h;
agent agent_h;
scoreboard scoreboard_h;

function void build_phase(uvm_phase phase);

	coverage_h   =  coverage::type_id::create("coverage_h", this);
	agent_h	     =  agent::type_id::create("agent_h", this);
	scoreboard_h =  scoreboard::type_id::create("scoreboard_h", this);

endfunction : build_phase

function void connect_phase(uvm_phase phase);

	agent_h.cmd_mtr_h.ap.connect(coverage_h.analysis_export);
	agent_h.cmd_mtr_h.ap.connect(scoreboard_h.cmd_f.analysis_export);
	agent_h.rslt_mtr_h.ap.connect(scoreboard_h.analysis_export);

endfunction : connect_phase


endclass : env
