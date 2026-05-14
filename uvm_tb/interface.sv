interface i2c_if;

  logic       clk;
  tri1       sda;        // wire for open-drain — DUT drives 1'b0 or 1'bz
  logic       scl;
  logic       rst;
  logic [7:0] myReg0;

  
  logic sda_drv = 1;      // TB master-side driver (1=release, 0=pull low)
  assign sda = sda_drv ? 1'bz : 1'b0;

endinterface
