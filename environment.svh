class my_env extends uvm_env;
   `uvm_component_utils(my_env)
   virtual iface viface;
   my_agent my_agent_h;
   my_scoreboard my_scoreboard_h;
   env_cfg env_cfg_h;

   
   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg_neno",env_cfg_h))
	$error("can't get env_cfg_h");
      if(env_cfg_h.has_agent)
	begin
	   uvm_config_db #(agent_cfg)::set(this,"*","agent_cfg_h",env_cfg_h.agent_cfg_h);
	   my_agent_h=my_agent::type_id::create("my_agent_h",this);
	end
      my_scoreboard_h=my_scoreboard::type_id::create("my_scoreboard_h",this);
   endfunction // build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      my_agent_h.my_monitor_h.aport.connect(my_scoreboard_h.ap_fifo.analysis_export);
   endfunction // connect_phase
   

endclass // my_env
