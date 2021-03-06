//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_tb_top.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_TB_TOP_SV
`define APB_UVC_TB_TOP_SV

// define timescale
`timescale 1ns/1ns

module apb_uvc_tb_top;
  
  `include "uvm_macros.svh"  
  import uvm_pkg::*;
  
  // import test package
  import apb_uvc_test_pkg::*;
      
  // signals
  reg reset_n;
  reg clock;
  reg [31:0] paddr_tb;
  reg pwrite_tb;
  reg [31:0] pwdata_tb;
  reg penable_tb;
  reg psel_tb;
  wire pready_tb;
  wire [31:0] prdata_tb;
  reg pstrb_tb;
  
  // UVC interface instance
  apb_uvc_if apb_uvc_if_inst(clock, reset_n);

  assign paddr_tb = apb_uvc_if_inst.PADDR;
  assign pwrite_tb = apb_uvc_if_inst.PWRITE;
  assign pwdata_tb = apb_uvc_if_inst.PWDATA;
  assign psel_tb = apb_uvc_if_inst.PSEL;
  assign penable_tb = apb_uvc_if_inst.PENABLE;
  assign pstrb_tb = apb_uvc_if_inst.PSTRB;

  assign apb_uvc_if_inst.PRDATA = prdata_tb;
  assign apb_uvc_if_inst.PREADY = pready_tb;
  
  // DUT instance
  //dut_dummy dut (
    //.reset_n(reset_n),
    //.clock(clock)
  //);
  
  // configure UVC's virtual interface in DB
  initial begin : config_if_block
    uvm_config_db#(virtual apb_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_apb_uvc_env_top.m_apb_uvc_env.m_master_agent", "m_vif", apb_uvc_if_inst);
    uvm_config_db#(virtual apb_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_apb_uvc_env_top.m_apb_uvc_env.m_slave_agent", "m_vif", apb_uvc_if_inst);
    uvm_config_db#(virtual apb_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_apb_uvc_env_top.m_apb_uvc_env", "m_vif", apb_uvc_if_inst);
  end
    
  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    reset_n <= 1'b0;
    clock <= 1'b1;
    #501 reset_n <= 1'b1;
  end
  
  // generate clock
  always begin : clock_gen_block
    #50 clock <= ~clock;
  end
  
  // run test
  initial begin : run_test_block
    run_test();
  end
  
endmodule : apb_uvc_tb_top

`endif // APB_UVC_TB_TOP_SV
