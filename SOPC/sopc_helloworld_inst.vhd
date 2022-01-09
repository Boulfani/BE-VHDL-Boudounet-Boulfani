  --Example instantiation for system 'sopc_helloworld'
  sopc_helloworld_inst : sopc_helloworld
    port map(
      out_port_from_the_LEDS => out_port_from_the_LEDS,
      clk_1 => clk_1,
      in_port_to_the_SWITCH => in_port_to_the_SWITCH,
      reset_n => reset_n
    );


