class env_cfg extends uvm_object;
   `uvm_object_utils(env_cfg)
   bit has_agent=1;
   agent_cfg agent_cfg_h;

   function new(string name="");
      super.new(name);
   endfunction // new


endclass // environment_cfg
