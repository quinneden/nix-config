{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    cores = 8;
    debug = true;
    memory = 16384;
    diskSize = "150GiB";
    onDemand.enable = true;
    rosetta = false;
    # supportDeterminateNix = true;
  };
}
