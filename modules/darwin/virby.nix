{ config, inputs, ... }:
{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = false;
    debug = true;
    cores = 8;
    diskSize = "150GiB";
    memory = 8192;
    allowUserSsh = false;
    # rosetta.enable = true;

    onDemand = {
      enable = true;
      ttl = 10;
    };

    # extraConfig = {
    #   nix.settings = { inherit (config.nix.settings) access-tokens; };
    # };
  };
}
