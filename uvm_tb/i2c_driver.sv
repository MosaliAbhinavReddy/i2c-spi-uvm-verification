class i2c_driver extends uvm_driver #(i2c_seq_item);

  `uvm_component_utils(i2c_driver)

  virtual i2c_if vif;

  function new(string name = "i2c_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(virtual i2c_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "Virtual interface not found")
    end
  endfunction


  task run_phase(uvm_phase phase);

    i2c_seq_item req;

    vif.scl = 1;
    vif.sda_drv = 1;

    forever begin
      seq_item_port.get_next_item(req);

      case(req.cmd)
        START : drive_start();
        DATA  : drive_data(req);
        STOP  : drive_stop();
      endcase

      `uvm_info("DRV", $sformatf("CMD=%s", req.cmd.name()), UVM_MEDIUM)

      seq_item_port.item_done();

  
     /* @(posedge vif.clk);
    
     vif.sda_drv = req.sda;   // drive via sda_drv — open-drain resolved in interface
     vif.scl     = req.scl;

    `uvm_info("DRV",
       $sformatf("Driving SDA=%0b SCL=%0b", req.sda, req.scl),
       UVM_MEDIUM)
       seq_item_port.item_done(); */

    end

  endtask

  task drive_start();
    vif.scl = 1;
    vif.sda_drv = 1;
    @(posedge vif.clk);
    vif.sda_drv = 0;
    @(posedge vif.clk);
    vif.scl = 0;
    @(posedge vif.clk);
    `uvm_info("DRV", "START CONDITION DRIVEN", UVM_MEDIUM)
  endtask

  task drive_stop();
  vif.scl = 0;
  vif.sda_drv = 0;
  @(posedge vif.clk);
  vif.scl = 1;
  @(posedge vif.clk);
  vif.sda_drv = 1;
  @(posedge vif.clk);
  `uvm_info("DRV","STOP CONDITION DRIVEN", UVM_MEDIUM)
  endtask

  task drive_data(i2c_seq_item req);

    // SEND ADDRESS + RW BIT (8 BITS)
    for(int i = 7; i >=0;i--)
    begin
      vif.scl = 0;
      vif.sda_drv = {req.addr, req.rw}[i];
      @(posedge vif.clk);
      vif.scl = 1;
      @(posedge vif.clk);
    end
    vif.scl = 0;
    @(posedge vif.clk);
    // SEND REGISTER_ADDRESS (8 BITS)
    for(int i = 7; i >=0;i--)
    begin
      vif.scl = 0;
      vif.sda_drv = req.reg_addr[i];
      @(posedge vif.clk);
      vif.scl = 1;
      @(posedge vif.clk);
    end
    vif.scl = 0;
    @(posedge vif.clk);

    // SEND DATA (8 BITS)
    for(int i = 7; i >=0;i--)
    begin
      vif.scl = 0;
      vif.sda_drv = req.data[i];
      @(posedge vif.clk);
      vif.scl = 1;
      @(posedge vif.clk);
    end

    vif.scl = 0;
    @(posedge vif.clk);

    `uvm_info("DRV", $sformatf("DATA DRIVEN : ADDR = 0X%0h RW=%0b REG=0X%0h DATA=0x%0h", req.addr, req.rw, req.reg_addr, req.data), UVM_MEDIUM)

  endtask

endclass
