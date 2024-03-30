class read_data extends uvm_sequence #(sequence_item);

`uvm_object_utils(read_data);

sequence_item sequence_item_h;

function new(string name = "read_data");
	super.new(name);
endfunction :new

virtual task body();

repeat(500) begin

	sequence_item_h = sequence_item::type_id::create("sequence_item_h");
	sequence_item_h.addr_c.constraint_mode(1);//enable 
        sequence_item_h.addr_c_err.constraint_mode(0);//disable
        start_item(sequence_item_h);
      //  assert(sequence_item_h.randomize());
		   sequence_item_h.pwrite =1'b0;
	//	sequence_item_h.pwdata = 1'b0;
		   sequence_item_h.presetn = 1'b1;
			sequence_item_h.psel = 1'b1;
		sequence_item_h.penable = 1'b1; 

      sequence_item_h.randomize() with {sequence_item_h.pwdata == 1'b0;} ;
      
       // sequence_item_h.op = readd;
	sequence_item_h.sequence_no = 2;	
        finish_item(sequence_item_h);

      end


endtask : body

endclass : read_data
