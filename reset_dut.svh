class reset_dut extends uvm_sequence#(sequence_item);

`uvm_object_utils(reset_dut);

function new(string name = "reset_dut");
	super.new(name);
endfunction : new

sequence_item sequence_item_h;

virtual task body();

	repeat (15) begin 

	sequence_item_h = sequence_item::type_id::create("sequence_item_h");
//	sequence_item_h.addr_c.constraint_mode(1);
//	sequence_item_h.addr_c_err.constraint_mode(0);
	start_item(sequence_item_h);
//	assert(sequence_item_h.randomize);
//	sequence_item_h.op = rst;
	sequence_item_h.sequence_no = 7;
	finish_item(sequence_item_h);

	end

endtask : body

endclass : reset_dut
