//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_env_top.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_ENV_TOP_SV
`define SPI_UVC_ENV_TOP_SV

class spi_uvc_env_top extends uvm_env;
  
  // registration macro
  `uvm_component_utils(spi_uvc_env_top)

  // configuration reference
  spi_uvc_cfg_top m_cfg;
    
  // component instance
  spi_uvc_env m_spi_uvc_env;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : spi_uvc_env_top

// constructor
function spi_uvc_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void spi_uvc_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if(!uvm_config_db #(spi_uvc_cfg_top)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set configuration
  uvm_config_db#(spi_uvc_cfg)::set(this, "m_spi_uvc_env", "m_cfg", m_cfg.m_spi_uvc_cfg);

  // create component
  m_spi_uvc_env = spi_uvc_env::type_id::create("m_spi_uvc_env", this);
endfunction : build_phase

`endif // SPI_UVC_ENV_TOP_SV
