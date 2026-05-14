typedef enum bit [1:0] {START, DATA, STOP, IDLE} i2c_cmd_e;
class i2c_seq_item extends uvm_sequence_item;
 
  rand bit sda;
  rand bit scl;
  rand i2c_cmd_e cmd;
  rand bit [6:0] addr;
  rand bit rw;
  rand bit [7:0] reg_addr;
  rand bit [7:0] data;


  constraint i2c_conditions
  {
    cmd == START -> (scl == 1'b1 && sda == 1'b0);
    cmd == STOP  -> (scl == 1'b1 && sda == 1'b1);
    cmd == DATA  -> (addr == 7'h3c);
  }

  `uvm_object_utils_begin(i2c_seq_item)
    `uvm_field_int(sda, UVM_ALL_ON)
    `uvm_field_int(scl, UVM_ALL_ON)
    `uvm_field_enum(i2c_cmd_e, cmd, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(rw, UVM_ALL_ON)
    `uvm_field_int(reg_addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end


  function new(string name = "i2c_seq_item");
    super.new(name);
  endfunction

                    //   `uvm_object_utils_end
                    //   `uvm_object_utils_begin(class_name)
                    //   `uvm_field_int(field_name, flags)
                    //   `uvm_field_enum(enum_type, field_name, flags)
                    // `uvm_object_utils_end
endclass
