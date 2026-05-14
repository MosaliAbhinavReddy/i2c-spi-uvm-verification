class i2c_sequence extends uvm_sequence #(i2c_seq_item);
 
  `uvm_object_utils(i2c_sequence)
 
  function new(string name = "i2c_sequence");
    super.new(name);
  endfunction
 
  task body();
 
    i2c_seq_item req;
    req = i2c_seq_item::type_id::create("req");

      //START
      start_item(req);
      req.cmd = START;
      assert(req.randomize() with {cmd == START;}) else `uvm_fatal("SEQ", "Randomization failed start");
      finish_item(req);

      //DATA
      start_item(req);
      req.cmd = DATA;
      assert(req.randomize() with {cmd == DATA; addr== 7'h3c; rw == 0; reg_addr == 8'h00; data == 8'hAB;}) else `uvm_fatal("SEQ", "RANDOMIZATION FAILED WITH DATA");
      finish_item(req);

      // STOP
      start_item(req);
      req.cmd = STOP;
      assert(req.randomize() with {cmd == STOP;})  else `uvm_fatal("SEQ", "Randomization failed stop");
      finish_item(req);

    // start_item(req);
 
    // assert(req.randomize());
    // finish_item(req);
 
  endtask
 
endclass
