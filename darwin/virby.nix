{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    # directBoot = {
    #   enable = true;
    #   storeOnDisk = {
    #     enable = true;
    #     size = "20GiB";
    #   };
    # };
    cores = 8;
    debug = true;
    memory = 16384;
    diskSize = "150GiB";
    onDemand.enable = true;
    rosetta = false;
    supportDeterminateNix = true;
  };
}
