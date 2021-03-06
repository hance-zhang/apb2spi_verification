
`ifndef RST_UVC_ITEM_SV
`define RST_UVC_ITEM_SV

class rst_uvc_item extends uvm_sequence_item;
  
  // item fields
  rand int rst_delay;
  rand int rst_duration;

  constraint duration_c {
    soft rst_duration >= 1; rst_duration < 20;
  }
  
  // registration macro    
  `uvm_object_utils_begin(rst_uvc_item)
    `uvm_field_int(rst_delay, UVM_ALL_ON)
    `uvm_field_int(rst_duration, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor  
  extern function new(string name = "rst_uvc_item");
  
endclass : rst_uvc_item

// constructor
function rst_uvc_item::new(string name = "rst_uvc_item");
  super.new(name);
endfunction : new

`endif // RST_UVC_ITEM_SV
