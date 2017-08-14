class my_test extends uvm_test;
   `uvm_component_utils(my_test)
   my_env my_env_h;
   agent_cfg agent_cfg_h;
   env_cfg env_cfg_h;
   my_sequence seq;
   
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent_cfg_h=agent_cfg::type_id::create("agent_cfg_h");
      if(!(uvm_config_db #(virtual iface)::get(this,"","ifc",agent_cfg_h.viface)))
	$error();
      env_cfg_h=env_cfg::type_id::create("env_cfg_h");
      if(env_cfg_h==null)
	$error();
      env_cfg_h.agent_cfg_h=agent_cfg_h;     
      uvm_config_db #(env_cfg)::set(this,"*","env_cfg_neno",env_cfg_h);
       my_env_h=my_env::type_id::create("my_env_h",this);
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq=my_sequence::type_id::create("seq");
      seq.start(my_env_h.my_agent_h.my_sequencer_h);
      phase.drop_objection(this);
   endtask // run_phase
   
endclass // my_test
