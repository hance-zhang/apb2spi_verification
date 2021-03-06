//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_default_config_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_CPSR_CONFIG_SEQ
`define APB2SPI_TOP_TEST_CPSR_CONFIG_SEQ

class apb2spi_top_test_cpsr_config_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_cpsr_config_seq)

  rand bit[7:0]  cpsr_SCDIV1;
  rand bit[7:0]  cpsr_SCDIV2;

  constraint cpsr_c {
     soft cpsr_SCDIV1 == 1;
     soft cpsr_SCDIV2 == 2;
  }
  
  // constructor
  extern function new(string name = "apb2spi_top_test_cpsr_config_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_cpsr_config_seq

// constructor
function apb2spi_top_test_cpsr_config_seq::new(string name = "apb2spi_top_test_cpsr_config_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_cpsr_config_seq::body();

  if(!apb_write_seq.randomize() with {
      paddr == SPI_CPSR_ADDR;
      pstrb  == 8'hf;
      pwdata == {8'b0, cpsr_SCDIV2, 8'b0, cpsr_SCDIV1};
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

endtask : body

`endif // APB2SPI_TOP_TEST_CPSR_CONFIG_SEQ
