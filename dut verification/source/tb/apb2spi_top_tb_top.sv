//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_tb_top.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TB_TOP_SV
`define APB2SPI_TOP_TB_TOP_SV

// define timescale
`timescale 1ns/1ns

module apb2spi_top_tb_top;
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // import test package
  import test_pkg::*;
 
  // signals
  wire reset_n;
  logic clock;

  wire[7:0] SSOE, SSOUT, SSIN;
  wire SCKOE, SCKOUT, SCKIN;
  wire MDOE, MDOUT, SDIN;
  wire SDOE, SDOUT, MDIN;
  
  // UVCs interfaces' instances
  apb_uvc_if apb_uvc_if_inst(clock, reset_n);
  spi_uvc_if spi_uvc_if_inst(clock, reset_n);
  rst_uvc_if rst_uvc_if_inst(clock);

  assign reset_n = rst_uvc_if_inst.RESET_N;

  assign spi_uvc_if_inst.MOSI = MDOE ? MDOUT : 1'bZ;
  assign SDIN = !MDOE ? spi_uvc_if_inst.MOSI : 1'bZ;
 
  assign spi_uvc_if_inst.SCK = SCKOE ? SCKOUT : 1'b0;
  assign SCKIN = !SCKOE ? spi_uvc_if_inst.SCK : 1'bZ;

  assign spi_uvc_if_inst.MISO = SDOE ? SDOUT : 1'bZ;
  assign MDIN = !SDOE ? spi_uvc_if_inst.MISO : 1'bZ;

  assign SSIN[0] = !SSOE[0] ? spi_uvc_if_inst.SS_N[0] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[0] = SSOE[0] ? SSOUT[0] : 1'b0;
  assign SSIN[1] = !SSOE[1] ? spi_uvc_if_inst.SS_N[1] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[1] = SSOE[1] ? SSOUT[1] : 1'b0;
  assign SSIN[2] = !SSOE[2] ? spi_uvc_if_inst.SS_N[2] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[2] = SSOE[2] ? SSOUT[2] : 1'b0;
  assign SSIN[3] = !SSOE[3] ? spi_uvc_if_inst.SS_N[3] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[3] = SSOE[3] ? SSOUT[3] : 1'b0;
  assign SSIN[4] = !SSOE[4] ? spi_uvc_if_inst.SS_N[4] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[4] = SSOE[4] ? SSOUT[4] : 1'b0;
  assign SSIN[5] = !SSOE[5] ? spi_uvc_if_inst.SS_N[5] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[5] = SSOE[5] ? SSOUT[5] : 1'b0;
  assign SSIN[6] = !SSOE[6] ? spi_uvc_if_inst.SS_N[6] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[6] = SSOE[6] ? SSOUT[6] : 1'b0;
  assign SSIN[7] = !SSOE[7] ? spi_uvc_if_inst.SS_N[7] : 1'bZ;
  assign spi_uvc_if_inst.SS_N[7] = SSOE[7] ? SSOUT[7] : 1'b0;
  
  // DUT instance
 spi dut (
    .pi_spi_rst_n(reset_n),
    .pi_spi_clk(clock),

    .pi_spi_apb_psel(apb_uvc_if_inst.PSEL),
    .pi_spi_apb_penable(apb_uvc_if_inst.PENABLE),
    .pi_spi_apb_pwrite(apb_uvc_if_inst.PWRITE),
    .pi_spi_apb_paddr(apb_uvc_if_inst.PADDR),
    .pi_spi_apb_pwdata(apb_uvc_if_inst.PWDATA),
    .pi_spi_apb_pstrb(apb_uvc_if_inst.PSTRB),

    .po_spi_apb_pslverr(apb_uvc_if_inst.PSLVERR),
    .po_spi_apb_prdata(apb_uvc_if_inst.PRDATA),
    .po_spi_apb_pready(apb_uvc_if_inst.PREADY),

    .po_spi_shift_mdout(MDOUT),
    .po_spi_shift_mdoe(MDOE),
    .pi_spi_shift_sdin(SDIN),

    .po_spi_shift_sdout(SDOUT),
    .po_spi_shift_sdoe(SDOE),
    .pi_spi_shift_mdin(MDIN),
 
    .po_spi_sck_sckout(SCKOUT),
    .po_spi_sck_sckoe(SCKOE),
    .pi_spi_sck_sckin(SCKIN),

    .po_spi_ss_ssout_n(SSOUT),
    .po_spi_ss_ssoe(SSOE),
    .pi_spi_ss_ssin_n(SSIN)
  );
///home/ELEA/amilakovic/projects/amilakovic/apb2spi/rtl/vhdl/*.vhd
/*  top dut (
      .pi_clk(clock),
      .pi_rst_n(reset_n),
      //APB Interface
      .pi_paddr(apb_uvc_if_inst.PADDR),
      .pi_psel(apb_uvc_if_inst.PSEL),
      .pi_penable(apb_uvc_if_inst.PENABLE),
      .pi_pwrite(apb_uvc_if_inst.PWRITE),
      .pi_pwdata(apb_uvc_if_inst.PWDATA),
      .pi_pstrb(apb_uvc_if_inst.PSTRB),
      .po_pready(apb_uvc_if_inst.PREADY),
      .po_prdata(apb_uvc_if_inst.PRDATA),
      .po_pslverr(apb_uvc_if_inst.PSLVERR),
      //SPI Interface
      .pi_ss(SSIN),
      .pi_sck(SCKIN),
      .pi_sd(SDIN),
      .pi_md(MDIN),
      .po_ss_oe(SSOE),
      .po_ss(SSOUT),
      .po_sck_oe(SCKOE),
      .po_sck(SCKOUT),
      .po_md_oe(MDOE),
      .po_md(MDOUT),
      .po_sd_oe(SDOE),
      .po_sd(SDOUT)
);*/
  
  // configure UVCs' virtual interfaces in DB
  initial begin : config_if_block
    uvm_config_db#(virtual apb_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_env.m_apb_uvc", "m_vif", apb_uvc_if_inst);
    uvm_config_db#(virtual apb_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_env.m_apb_uvc.*", "m_vif", apb_uvc_if_inst);
    uvm_config_db#(virtual spi_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_env.m_spi_uvc.*", "m_vif", spi_uvc_if_inst);
    uvm_config_db#(virtual rst_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_env.m_rst_uvc", "m_vif", rst_uvc_if_inst);
    uvm_config_db#(virtual rst_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_env.m_rst_uvc.*", "m_vif", rst_uvc_if_inst);
  end
  
  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    clock <= 1'b1;
  end
  
  // generate clock
  always begin : clock_gen_block
    #50 clock <= ~clock;
  end
  
  // run test
  initial begin : run_test_block
    run_test();
  end
    
endmodule : apb2spi_top_tb_top

`endif // APB2SPI_TOP_TB_TOP_SV
