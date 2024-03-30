class sequence_item extends uvm_sequence_item;

`uvm_object_utils(sequence_item);

function new(string name = "sequence_item");
	super.new(name);
endfunction : new

	int sequence_no;

	  

//typedef enum bit [1:0]   {readd = 0, writed = 1, rst = 2} oper_mode;
  //  rand oper_mode   op;
     logic            	pwrite;
	rand logic [31 : 0]   	pwdata;
	rand logic [31 : 0]	paddr;
    // Output Signals of DUT for APB UART's transaction
	logic				    pready;
	logic 				    pslverr;
    logic [31: 0]		    prdata;
    logic presetn ;
    logic psel;
    logic penable;
    logic pclk;
 
constraint addr_c { paddr <= 31; }
  constraint addr_c_err { paddr > 31; }
endclass : sequence_item

