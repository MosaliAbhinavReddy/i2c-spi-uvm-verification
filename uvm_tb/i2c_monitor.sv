class i2c_monitor extends uvm_monitor;
 
  `uvm_component_utils(i2c_monitor)
 
  virtual i2c_if vif;
 
  function new(string name = "i2c_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    if (!uvm_config_db #(virtual i2c_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MON", "Virtual interface not found")
    end
  endfunction
 
  task run_phase(uvm_phase phase);
 
    forever begin
      @(posedge vif.clk);
      `uvm_info("MON",
                $sformatf("Observed SDA=%0b SCL=%0b", vif.sda, vif.scl),
                UVM_MEDIUM)
    end
 
  endtask
 
endclass
