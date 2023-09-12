
`include "uvm_macros.svh"
import uvm_pkg::*;
class fifo_sequence extends uvm_sequence;
 
  `uvm_object_utils(fifo_sequence)
  fifo_seq_item fifo;//creating handle for fifo_seq_item
  function new(string name = "fifo_sequence");

    super.new(name);

  endfunction
  task body();
    fifo=fifo_sequence::type_id::create("fifo_sequence");
    repeat(5)
    begin
      start_item(fifo);
      fifo.randomize();
      finish_item(fifo);
    end
  endtask
    endclass


