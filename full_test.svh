class full_test extends uvm_test;

	`uvm_component_utils(full_test)

function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction : new

env         env_h;
write_data  write_data_h;
read_data   read_data_h;
write_read  write_read_h;
wr_bulk     wr_bulk_h;
write_err   write_err_h;
read_err    read_err_h;
reset_dut   reset_dut_h;


virtual function void build_phase(uvm_phase phase);

	env_h 		=	 env::type_id::create("env_h",this);
	write_data_h    =	 write_data::type_id::create("write_data_h", this);
	read_data_h     =	 read_data::type_id::create("read_data_h", this);
	write_read_h    =	 write_read::type_id::create("write_read_h", this);
	wr_bulk_h       =	 wr_bulk::type_id::create("write_data_h", this);
	write_err_h     =	 write_err::type_id::create("write_err_h", this);
	read_err_h      =	 read_err::type_id::create("read_err_h", this);
	reset_dut_h     =	 reset_dut::type_id::create("reset_dut_h", this);


endfunction : build_phase

virtual task run_phase(uvm_phase phase);
//$display("full_test");
	phase.raise_objection(this);

		reset_dut_h.start(env_h.agent_h.sequencer_h);
//		write_data_h.start(env_h.agent_h.sequencer_h);
//		read_data_h.start(env_h.agent_h.sequencer_h);
//		write_read_h.start(env_h.agent_h.sequencer_h);
//		wr_bulk_h.start(env_h.agent_h.sequencer_h);
		write_err_h.start(env_h.agent_h.sequencer_h);
//		read_err_h.start(env_h.agent_h.sequencer_h);

	phase.drop_objection(this);
$finish();
endtask : run_phase

endclass : full_test
