{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  nix.linux-builder.enable = true;

  services.virby = {
    enable = true;
    cores = 8;
    debug = true;
    memory = 16384;
    onDemand.enable = true;
    rosetta = true;
  };
}
