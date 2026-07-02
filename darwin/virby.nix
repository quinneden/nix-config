{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    cores = 8;
    debug = true;
    diskSize = "150GiB";
    driver = "vfkit";
    memory = 8192;
    nestedVirtualization = true;
    onDemand.enable = true;
    onDemand.ttl = 60;
    rosetta = false;
    supportDeterminateNix = true;
  };
}
