class coverage extends uvm_subscriber #(sequence_item);

`uvm_component_utils (coverage)


sequence_item sequence_item_h;

  logic       [31:0] paddr;
  logic       [31:0] pwdata;
  logic       [31:0] prdata;
  logic              pslverr;


covergroup inputs;
	coverpoint paddr{ 
		bins zeroes = {32'b0};
		bins ones = {32'b1};
		bins others = default;
			}
	coverpoint pwdata{ 
		bins zeroes=   {32'b0};
		bins ones= {32'b1};
		bins others = default;
			}
endgroup :inputs

covergroup outputs;

	coverpoint prdata{
		bins zeroes ={32'b0};
		bins ones ={32'b1};
		bins others = default;	
			}

	coverpoint pslverr{
		bins zeroes ={1'b0};
		bins ones ={1'b1};
		bins others = default;	
			}

endgroup : outputs

function new (string name, uvm_component parent);
	super.new(name, parent);
	inputs  = new();
	outputs = new();
endfunction : new


function void write (sequence_item t);

//	$display("coverage");


	paddr   = t.paddr;
	pwdata  = t.pwdata;
	prdata  = t.prdata;
	pslverr = t.pslverr;

	inputs.sample();
	outputs.sample();
endfunction : write

endclass : coverage
