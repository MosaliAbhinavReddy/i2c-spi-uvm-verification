class i2c_test extends uvm_test;
 
  `uvm_component_utils(i2c_test)
 
  i2c_environment env;
 
  function new(string name = "i2c_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = i2c_environment::type_id::create("env", this);
  endfunction
 
  task run_phase(uvm_phase phase);
 
    i2c_sequence seq;
 
    phase.raise_objection(this);
 
    seq = i2c_sequence::type_id::create("seq");
    seq.start(env.agent.sequencer);
 
    #100;
 
    phase.drop_objection(this);
 
  endtask
 
endclass
