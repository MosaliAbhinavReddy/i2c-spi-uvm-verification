class i2c_environment extends uvm_env;
 
  `uvm_component_utils(i2c_environment)
 
  i2c_agent      agent;
  i2c_scoreboard scoreboard;
 
  function new(string name = "i2c_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    agent      = i2c_agent     ::type_id::create("agent", this);
    scoreboard = i2c_scoreboard::type_id::create("scoreboard", this);
  endfunction
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
 
endclass
