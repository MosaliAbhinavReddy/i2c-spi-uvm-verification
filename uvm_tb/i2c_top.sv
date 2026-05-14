`timescale 1ns/1ps

`include "uvm_macros.svh"
`include "interface.sv"
`include "i2c_pkg.sv"

module i2c_top;

  import uvm_pkg::*;
  import i2c_pkg::*;

  logic clk;
  logic rst;

  i2c_if intf();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #20 rst = 0;
  end

  assign intf.clk = clk;
  assign intf.rst = rst;

  i2cSlaveTop dut (
    .clk    (intf.clk),
    .rst    (intf.rst),
    .sda    (intf.sda),
    .scl    (intf.scl),
    .myReg0 (intf.myReg0)
  );

  initial begin
    uvm_config_db #(virtual i2c_if)::set(null, "*", "vif", intf);
    run_test("i2c_test");
  end

endmodule
