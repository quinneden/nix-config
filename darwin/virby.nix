{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    cores = 8;
    debug = true;
    diskSize = "150GiB";
    memory = 8192;
    onDemand.enable = true;
    onDemand.ttl = 60;
    rosetta = false;
    supportDeterminateNix = true;
  };
}
