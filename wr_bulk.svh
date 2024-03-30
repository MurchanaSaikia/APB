class wr_bulk extends uvm_sequence #(sequence_item);

`uvm_object_utils(wr_bulk);

function new(string name = "wr_bulk");
	super.new(name);
endfunction : new

sequence_item sequence_item_h;

virtual task body();



	repeat(500) begin 
		sequence_item_h = sequence_item::type_id::create("sequence_item_h");
		sequence_item_h.addr_c.constraint_mode(1);
		sequence_item_h.addr_c_err.constraint_mode(0);
		start_item(sequence_item_h);
		//assert(sequence_item_h.randomize());
		   sequence_item_h.pwrite =1'b1;
		sequence_item_h.presetn = 1'b1;
		sequence_item_h.psel = 1'b1;
		sequence_item_h.penable = 1'b1;

      sequence_item_h.randomize();
   
	//	sequence_item_h.op = writed;
		sequence_item_h.sequence_no = 1;		
		finish_item(sequence_item_h);
		$display("write at time %0t", $time);
	end


	repeat(500) begin 
		sequence_item_h = sequence_item::type_id::create("sequence_item_h");
		sequence_item_h.addr_c.constraint_mode(1);
		sequence_item_h.addr_c_err.constraint_mode(0);
		start_item(sequence_item_h);
	//	assert(sequence_item_h.randomize());
      sequence_item_h.pwrite =1'b0;
		sequence_item_h.presetn = 1'b1;
		sequence_item_h.psel = 1'b1;
		sequence_item_h.penable = 1'b1;

      sequence_item_h.randomize() with {sequence_item_h.pwdata == 1'b0;};
	//	sequence_item_h.op = readd;
		sequence_item_h.sequence_no = 2;		
		finish_item(sequence_item_h);
		$display("read at time %0t", $time);

	end



endtask : body 

endclass : wr_bulk
