//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_cfg.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------
/////////////////////////
`ifndef APB_UVC_CFG_SV
`define APB_UVC_CFG_SV

class apb_uvc_cfg extends uvm_object;
  
  // agents configurations
  apb_uvc_agent_cfg m_master_agent_cfg;
  apb_uvc_agent_cfg m_slave_agent_cfg;

  bit m_has_monitor;
  bit m_has_coverage;
  bit m_has_two_agents;
  
  // registration macro
  `uvm_object_utils_begin(apb_uvc_cfg)
    `uvm_field_object(m_master_agent_cfg, UVM_ALL_ON)
    `uvm_field_object(m_slave_agent_cfg, UVM_ALL_ON)
    `uvm_field_int(m_has_monitor, UVM_ALL_ON)
    `uvm_field_int(m_has_coverage, UVM_ALL_ON)
    `uvm_field_int(m_has_two_agents, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "apb_uvc_cfg");
    
endclass : apb_uvc_cfg

// constructor
function apb_uvc_cfg::new(string name = "apb_uvc_cfg");
  super.new(name);

  // default values
  m_has_monitor = 1;
  m_has_coverage = 1;
  m_has_two_agents = 0;

  // create agents configurations
  m_master_agent_cfg = apb_uvc_agent_cfg::type_id::create("m_master_agent_cfg");
  m_slave_agent_cfg = apb_uvc_agent_cfg::type_id::create("m_slave_agent_cfg");
endfunction : new

`endif // APB_UVC_CFG_SV
