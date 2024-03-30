class driver extends uvm_driver #(sequence_item);

`uvm_component_utils(driver);

function new(string name = "driver", uvm_component parent);
	super.new(name , parent);
endfunction : new

sequence_item sequence_item_h;

virtual bfm _if;

virtual function void build_phase(uvm_phase phase);

	if (! uvm_config_db #(virtual bfm)::get(null, "*", "_if", _if))
	`uvm_error("DRV", "failed to get BFM");

endfunction : build_phase


virtual task run_phase(uvm_phase phase);

	forever begin
		phase.raise_objection(this);
		seq_item_port.get_next_item(sequence_item_h);


			if (sequence_item_h.sequence_no == 7) begin
				@(posedge _if.pclk);
				_if.reset();
				@(posedge _if.pclk);
			end


			if (sequence_item_h.sequence_no == 1 || sequence_item_h.sequence_no == 5) begin
				@(posedge _if.pclk);
				_if.drv_to_int(sequence_item_h.presetn, sequence_item_h.paddr, sequence_item_h.pwdata, sequence_item_h.pwrite, sequence_item_h.psel, sequence_item_h.penable, sequence_item_h.prdata, sequence_item_h.pslverr, sequence_item_h.sequence_no  );
				@(posedge _if.pclk);
				@(posedge _if.pclk);

			end


			if (sequence_item_h.sequence_no == 2 || sequence_item_h.sequence_no == 6 ) begin
				@(posedge _if.pclk);
				_if.drv_to_int(sequence_item_h.presetn, sequence_item_h.paddr, sequence_item_h.pwdata, sequence_item_h.pwrite, sequence_item_h.psel, sequence_item_h.penable, sequence_item_h.prdata, sequence_item_h.pslverr, sequence_item_h.sequence_no  );

				@(posedge _if.pclk);
				@(posedge _if.pclk);

			end



		seq_item_port.item_done();
		phase.drop_objection(this);


	end


endtask : run_phase



endclass : driver
