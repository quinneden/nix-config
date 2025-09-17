{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    cores = 8;
    debug = true;
    memory = 16384;
    onDemand.enable = true;
    rosetta = true;
  };
}
