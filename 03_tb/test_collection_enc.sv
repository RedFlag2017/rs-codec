`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

  endfunction: build_phase

  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    if (uvm_report_enabled(UVM_MEDIUM, UVM_INFO, "TOPOLOGY")) begin
      uvm_root::get().print_topology();
    end

    if (uvm_report_enabled(UVM_MEDIUM, UVM_INFO, "FACTORY")) begin
      uvm_factory::get().print();
    end
  endfunction: final_phase
endclass: test_base

class case1 extends test_base;
  `uvm_component_utils(case1)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    `uvm_info("TRACE", "case1 running", UVM_NONE);

  endfunction: build_phase

  task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  fork
    harness_enc.u_dut_if.random_gen();
    harness_enc.u_dut_if.rs_enc_check();
  join
  //harness.u_add4_46_if.random_gen();
  //#125;
  `uvm_info("TRACE", "Simulation Done!", UVM_NONE);
  phase.drop_objection(this);
  endtask: run_phase  
  
  
endclass: case1
