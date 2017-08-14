class agent_cfg extends uvm_object;
   `uvm_object_utils(agent_cfg)
   bit is_active=1;
   virtual iface viface;

   function new(string name="");
      super.new(name);
   endfunction // new

endclass // agent_cfg
