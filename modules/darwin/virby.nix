{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.virby.darwinModules.default ];

  services.virby = {
    enable = true;
    debug = true;
    cores = 8;
    diskSize = "150GiB";
    memory = 8192;
    rosetta.enable = false;
    onDemand = {
      enable = true;
      ttl = 180;
    };
    extraConfig = {
      imports = [ inputs.lix-module.nixosModules.default ];

      nix = {
        optimise.automatic = true;
        settings = {
          inherit (config.nix.settings) access-tokens;
          max-free = lib.mkForce null;
          mix-free = lib.mkForce null;
        };
      };
    };
  };
}
