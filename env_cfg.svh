class env_cfg extends uvm_object;
   `uvm_object_utils(env_cfg)
   agent_cfg agent_cfg_h;
   bit has_agent=1;

   function new(string name="");
      super.new(name);
   endfunction // new

endclass // env_cfg
