class my_agent extends uvm_agent;
   `uvm_component_utils(my_agent)
   agent_cfg agent_cfg_h;
   my_sequencer my_sequencer_h;
   my_driver my_driver_h;
   my_monitor my_monitor_h;
   uvm_analysis_port #(my_transaction) aport;
   
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent_cfg_h=agent_cfg::type_id::create("agent_cfg");
   assert(uvm_config_db #(agent_cfg)::get(this,"","agent_cfg_h",agent_cfg_h));
      if(agent_cfg_h.is_active)
	begin
	   my_sequencer_h=my_sequencer::type_id::create("my_sequencer_h",this);
	   my_driver_h=my_driver::type_id::create("my_driver_h",this);
	end
      my_monitor_h=my_monitor::type_id::create("my_monitor_h",this);
      aport=new("aport",this);
   endfunction // build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      my_driver_h.seq_item_port.connect(my_sequencer_h.seq_item_export);
      my_driver_h.viface=agent_cfg_h.viface;
      my_monitor_h.viface=agent_cfg_h.viface;
   endfunction // connect_phase

endclass // my_agent
