{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    # directBoot = true;
    # storeOnDisk = {
    #   enable = true;
    #   size = "30GiB";
    # };
    cores = 8;
    debug = true;
    memory = 8192;
    diskSize = "150GiB";
    onDemand.enable = true;
    rosetta = false;
    supportDeterminateNix = true;
  };
}
